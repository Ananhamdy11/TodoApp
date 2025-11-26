import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/features/home/data/models/hive/todo_model.dart';

class HiveServices {
  final Box<TodoModelHive> box = Hive.box<TodoModelHive>("todos");

  Future<void> addTodoLocal(TodoModelHive todo) async {
    await box.put(todo.id, todo);
  }

  Future<void> updateTodoLocal(String id, TodoModelHive updatedTodo) async {
    await box.put(id, updatedTodo);
  }

  Future<void> deleteTodoLocal(String id) async {
    await box.delete(id);
  }

  TodoModelHive? getTodoById(String id) {
    return box.get(id);
  }

  List<TodoModelHive> getAllTodoLocal() {
    return box.values.toList();
  }
}
