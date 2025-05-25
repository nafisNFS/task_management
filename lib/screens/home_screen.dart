import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';
import '../providers/task_provider.dart';
import '../widgets/task_tile.dart';
import 'add_edit_task_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Task Manager',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue[700],
        centerTitle: true,
        elevation: 2,
      ),

      body: taskProvider.tasks.isEmpty
          ? Center(
        child: Text(
          'No tasks to show',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.grey[600],
          ),
        ),
      )
          : ListView.builder(
        itemCount: taskProvider.tasks.length,
        itemBuilder: (_, index) {
          final task = taskProvider.tasks[index];
          return GestureDetector(
            onLongPress: () => _confirmDelete(context, taskProvider, task),
            child: TaskTile(task: task),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => AddEditTaskScreen())),
        child: Icon(Icons.add,color: Colors.white,),
        backgroundColor: Colors.blue[700],
      ),
    );
  }

  void _confirmDelete(BuildContext context, TaskProvider provider, Task task) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Delete Task?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
          TextButton(onPressed: () {
            provider.deleteTask(task);
            Navigator.pop(context);
          }, child: Text('Delete'))
        ],
      ),
    );
  }
}

