import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/home_screen.dart';
import 'screens/add_edit_task_screen.dart';
import 'screens/settings_screen.dart';

void main() {
  runApp(ToDoApp());
}

class ToDoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
      routes: {
        '/addTask': (context) => AddEditTaskScreen(),
        '/editTask': (context) => AddEditTaskScreen(),
        '/settings': (context) => SettingsScreen(),
      },
    );
  }
}
