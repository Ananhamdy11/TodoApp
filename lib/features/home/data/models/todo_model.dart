class TodoModel {
  String id;
  String title;
  String description;
  String date;
  String time;
  bool done;

  TodoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.done,
  });

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      date: map['date'] ?? '',
      time: map['time'] ?? '',
      done: map['done'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'time': time,
      'done': done,
    };
  }
}
