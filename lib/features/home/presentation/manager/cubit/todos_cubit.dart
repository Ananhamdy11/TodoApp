import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/services/database_services.dart';
import 'package:todo_app/features/home/data/models/todo_model.dart';

part 'todos_state.dart';

class TodosCubit extends Cubit<TodosState> {
  TodosCubit(this.uid) : super(TodosInitial());

  final String uid;
  final DatabaseServices dbServices = DatabaseServices();
  List<TodoModel> allTodos = [];
  List<TodoModel> filteredTodos = [];

  void fetchTodos() {
    emit(TodosLoading());

    dbServices.todosStream(uid).listen((listOfMaps) {
      final todos = listOfMaps.map((e) => TodoModel.fromMap(e)).toList();

      allTodos = todos;
      filteredTodos = todos;

      emit(TodosSuccess(filteredTodos));
    });
  }

  void addTodo(TodoModel todo) async {
    await dbServices.addTodos(uid, todo.toMap());
  }

  void removeTodo(String todoId) async {
    await dbServices.removeTodo(uid, todoId);
  }

  void updateTodo(String todoId, Map<String, dynamic> updates) async {
    await dbServices.updateTodo(uid, todoId, updates);
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
