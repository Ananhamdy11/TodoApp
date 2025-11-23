import 'package:firebase_database/firebase_database.dart';

class DatabaseServices {
  final DatabaseReference db = FirebaseDatabase.instance.ref();

  Future<void> addTodos(String uid, Map<String, dynamic> todo) async {
    String id = db.child('users/$uid/todos').push().key!;
    todo['id'] = id;
    await db.child('users/$uid/todos/$id').set(todo);
  }

  Future<void> removeTodo(String uid, String todoId) async {
    await db.child('users/$uid/todos/$todoId').remove();
  }

  Future<void> updateTodo(
    String uid,
    String todoId,
    Map<String, dynamic> updates,
  ) async {
    await db.child('users/$uid/todos/$todoId').update(updates);
  }

  Stream<List<Map<String, dynamic>>> todosStream(String uid) {
    return db.child('users/$uid/todos').onValue.map((event) {
      final map = event.snapshot.value;
      if (map == null) return [];
      final entries = <Map<String, dynamic>>[];
      try {
        final m = Map<String, dynamic>.from(map as Map);
        m.forEach((k, v) {
          entries.add(Map<String, dynamic>.from(v as Map));
        });
      } catch (_) {}
      return entries;
    });
  }
}
