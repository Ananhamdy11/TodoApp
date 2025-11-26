import 'package:hive/hive.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 1)
class TodoModelHive extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String description;

  @HiveField(3)
  String date;

  @HiveField(4)
  String time;

  @HiveField(5)
  bool done;

  TodoModelHive({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    this.done = false,
  });
}
