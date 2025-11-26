import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:todo_app/core/services/database_services.dart';
import 'package:todo_app/core/services/hive_services.dart';
import 'package:todo_app/core/services/notification_services.dart';
import 'package:todo_app/features/home/data/models/todo_model.dart';
import 'package:todo_app/features/home/data/models/hive/todo_model.dart';
part 'todos_state.dart';

class TodosCubit extends Cubit<TodosState> {
  TodosCubit(this.uid) : super(TodosInitial());

  final String uid;
  final DatabaseServices dbServices = DatabaseServices();
  final HiveServices hiveService = HiveServices();

  List<TodoModel> allTodos = [];
  List<TodoModel> filteredTodos = [];

  Future<bool> checkConnection() async {
    final result = await Connectivity().checkConnectivity();
    return result != ConnectivityResult.none;
  }

  void printHiveTodos() {
    final todos = hiveService.getAllTodoLocal();
    for (var todo in todos) {
      log('ID: ${todo.id}, Title: ${todo.title}, Done: ${todo.done}');
    }
  }

  void fetchTodos() async {
    emit(TodosLoading());

    final localTodos = hiveService.getAllTodoLocal();
    final offlineMapped = localTodos.map((todo) {
      return TodoModel(
        id: todo.id,
        title: todo.title,
        description: todo.description,
        date: todo.date,
        time: todo.time,
        done: todo.done,
      );
    }).toList();

    allTodos = offlineMapped;
    filteredTodos = offlineMapped;
    emit(TodosSuccess(filteredTodos));
    printHiveTodos();

    final connected = await checkConnection();
    if (connected) {
      dbServices.todosStream(uid).listen((listOfMaps) {
        final todos = listOfMaps.map((e) => TodoModel.fromMap(e)).toList();
        allTodos = todos;
        filteredTodos = todos;
        emit(TodosSuccess(filteredTodos));
      });
    }
  }

  void addTodo(TodoModel todo) async {
    final connected = await checkConnection();

    final id = todo.id.isEmpty
        ? DateTime.now().millisecondsSinceEpoch.toString()
        : todo.id;

    final hiveTodo = TodoModelHive(
      id: id,
      title: todo.title,
      description: todo.description,
      date: todo.date,
      time: todo.time,
      done: todo.done,
    );

    await hiveService.addTodoLocal(hiveTodo);
    printHiveTodos();

    if (connected) {
      await dbServices.addTodos(uid, {
        "id": id,
        "title": todo.title,
        "description": todo.description,
        "date": todo.date,
        "time": todo.time,
        "done": todo.done,
      });
    }
    final scheduledDateTime = DateTime(
      int.parse(todo.date.split('/')[2]),
      int.parse(todo.date.split('/')[1]),
      int.parse(todo.date.split('/')[0]),
      int.parse(todo.time.split(':')[0]),
      int.parse(todo.time.split(':')[1]),
    );

    await NotificationService.scheduleTodoNotification(
      id: id,
      title: todo.title,
      body: todo.description,
      scheduledTime: scheduledDateTime,
    );

    fetchTodos();
  }

  void removeTodo(String todoId) async {
    final connected = await checkConnection();

    await hiveService.deleteTodoLocal(todoId);

    if (connected) {
      await dbServices.removeTodo(uid, todoId);
    }
    await NotificationService.cancelNotification(todoId);

    fetchTodos();
  }

  void updateTodo(String todoId, Map<String, dynamic> updates) async {
    final connected = await checkConnection();

    final localTodo = hiveService.getTodoById(todoId);
    if (localTodo == null) {
      log("Todo not found in Hive: $todoId");
      printHiveTodos();
      return;
    }

    final updatedHive = TodoModelHive(
      id: localTodo.id,
      title: updates["title"] ?? localTodo.title,
      description: updates["description"] ?? localTodo.description,
      date: updates["date"] ?? localTodo.date,
      time: updates["time"] ?? localTodo.time,
      done: updates["done"] ?? localTodo.done,
    );

    await hiveService.updateTodoLocal(todoId, updatedHive);

    if (connected) {
      await dbServices.updateTodo(uid, todoId, updates);
    }
    await NotificationService.cancelNotification(todoId);

    if (updates.containsKey("date") || updates.containsKey("time")) {
      final date = updates["date"] ?? localTodo.date;
      final time = updates["time"] ?? localTodo.time;

      final scheduledDateTime = DateTime(
        int.parse(date.split('/')[2]),
        int.parse(date.split('/')[1]),
        int.parse(date.split('/')[0]),
        int.parse(time.split(':')[0]),
        int.parse(time.split(':')[1]),
      );

      await NotificationService.scheduleTodoNotification(
        id: todoId,
        title: updates["title"] ?? localTodo.title,
        body: updates["description"] ?? localTodo.description,
        scheduledTime: scheduledDateTime,
      );
    }

    fetchTodos();
  }

  void search(String text) {
    if (text.isEmpty) {
      filteredTodos = allTodos;
    } else {
      filteredTodos = allTodos.where((todo) {
        return todo.title.toLowerCase().contains(text.toLowerCase()) ||
            todo.description.toLowerCase().contains(text.toLowerCase());
      }).toList();
    }

    emit(TodosSuccess(filteredTodos));
  }
}
