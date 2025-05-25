import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:task_management/providers/task_provider.dart';
import 'package:task_management/screens/home_screen.dart';

import 'models/task.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TaskProvider()..loadTasks(),
      child: MaterialApp(
        title: 'Task Manager',
        home: HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
