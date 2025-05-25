import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/task.dart';
import '../screens/add_edit_task_screen.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  TaskTile({required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        title: Text(task.title),
        subtitle: Text('Due: ${DateFormat.yMMMd().format(task.dueDate)}\nStatus: ${task.status}'),
        isThreeLine: true,
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => AddEditTaskScreen(task: task)),
        ),
      ),
    );
  }
}
