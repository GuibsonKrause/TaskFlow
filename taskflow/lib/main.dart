import 'package:flutter/material.dart';
import 'package:taskflow/ui/home/home_screen.dart';

void main() {
  runApp(const TaskFlowApp());
}

class TaskFlowApp extends StatelessWidget {
  const TaskFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'TaskFlow', home: HomeScreen());
  }
}
