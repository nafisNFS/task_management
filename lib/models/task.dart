import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  @HiveField(2)
  DateTime dueDate;

  @HiveField(3)
  String status;

  Task({
    required this.title,
    this.description = '',
    required this.dueDate,
    this.status = 'Pending',
  });
}
