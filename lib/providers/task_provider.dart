import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/task.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> _tasks = [];
  final String boxName = 'tasks';

  List<Task> get tasks => _tasks;

  Future<void> loadTasks() async {
    final box = await Hive.openBox<Task>(boxName);
    _tasks = box.values.toList();
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    final box = await Hive.openBox<Task>(boxName);
    await box.add(task);
    await loadTasks();
  }

  Future<void> updateTask(Task task) async {
    await task.save();
    await loadTasks();
  }

  Future<void> deleteTask(Task task) async {
    await task.delete();
    await loadTasks();
  }
}
