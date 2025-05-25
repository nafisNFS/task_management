import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';

class AddEditTaskScreen extends StatefulWidget {
  final Task? task;

  const AddEditTaskScreen({Key? key, this.task}) : super(key: key);

  @override
  _AddEditTaskScreenState createState() => _AddEditTaskScreenState();
}

class _AddEditTaskScreenState extends State<AddEditTaskScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  DateTime? _dueDate;
  String _status = 'Pending';

  @override
  void initState() {
    super.initState();

    if (widget.task != null) {
      _titleController = TextEditingController(text: widget.task!.title);
      _descriptionController = TextEditingController(text: widget.task!.description);
      _dueDate = widget.task!.dueDate;
      _status = widget.task!.status;
    } else {
      _titleController = TextEditingController();
      _descriptionController = TextEditingController();
      _dueDate = DateTime.now();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveTask() {
    if (_formKey.currentState!.validate()) {
      final provider = Provider.of<TaskProvider>(context, listen: false);

      if (widget.task == null) {
        final task = Task(
          title: _titleController.text,
          description: _descriptionController.text,
          dueDate: _dueDate ?? DateTime.now(),
          status: _status,
        );
        provider.addTask(task);
      } else {
        final updatedTask = widget.task!
          ..title = _titleController.text
          ..description = _descriptionController.text
          ..dueDate = _dueDate ?? DateTime.now()
          ..status = _status;

        provider.updateTask(updatedTask);
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          widget.task != null ? 'Edit Task' : 'Add Task',
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),
        ),
        centerTitle: true,
        elevation: 2,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Task Title',
                border: OutlineInputBorder(),
              ),
              validator: (value) =>
              value == null || value.isEmpty ? 'Title is required' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                'Due Date: ${_dueDate?.toLocal().toString().split(' ')[0]}',
                style: TextStyle(fontSize: 16),
              ),
              trailing: Icon(Icons.calendar_today, color: Colors.blue[700]),
              onTap: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: _dueDate ?? DateTime.now(),
                  firstDate: DateTime.now().subtract(Duration(days: 365)),
                  lastDate: DateTime.now().add(Duration(days: 365 * 5)),
                );
                if (picked != null) {
                  setState(() {
                    _dueDate = picked;
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _status,
              items: ['Pending', 'Completed']
                  .map((status) =>
                  DropdownMenuItem(value: status, child: Text(status)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _status = value!;
                });
              },
              decoration: InputDecoration(
                labelText: 'Status',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[700],
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: _saveTask,
                icon: Icon(Icons.save, color: Colors.white),
                label: Text(
                  'Save Task',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
