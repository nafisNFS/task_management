import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

import 'controllers/weather_controller.dart';
import 'providers/task_provider.dart';
import 'screens/home_screen.dart';
import 'models/task.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());


  Get.put(WeatherController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TaskProvider()..loadTasks(),
      child: GetMaterialApp( // Use GetMaterialApp for GetX features
        title: 'Task Manager',
        home: HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
