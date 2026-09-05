import 'package:flutter/material.dart';
import 'package:taskflow/core/task_card.dart';
import 'package:taskflow/domain/task.dart';
import 'package:taskflow/ui/task_form/task_form_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Task> _tasks = [
    Task(
      id: '1',
      title: 'Planejar a semana',
      description: 'Definir as prioridades e os compromissos da semana.',
      isCompleted: true,
      createdAt: DateTime(2026, 8, 25),
    ),
    Task(
      id: '2',
      title: 'Estudar Flutter',
      description: 'Revisar widgets de layout e listas.',
      isCompleted: false,
      createdAt: DateTime(2026, 8, 26),
    ),
    Task(
      id: '3',
      title: 'Organizar materiais',
      description: 'Separar anotações e arquivos da disciplina.',
      isCompleted: false,
      createdAt: DateTime(2026, 8, 27),
    ),
  ];

  Future<void> _openTaskForm() async {
    final task = await Navigator.of(context).push<Task>(
      MaterialPageRoute(builder: (context) => const TaskFormScreen()),
    );

    if (task == null || !mounted) {
      return;
    }

    setState(() {
      _tasks.add(task);
    });

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(content: Text('Tarefa cadastrada com sucesso!')),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TaskFlow')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _tasks.length,
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemBuilder: (context, index) => TaskCard(task: _tasks[index]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openTaskForm,
        tooltip: 'Adicionar tarefa',
        child: const Icon(Icons.add),
      ),
    );
  }
}
