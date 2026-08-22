import 'package:flutter/material.dart';

void _onButtonPressed() {}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TaskFlow')),
      body: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Bem-vindo ao TaskFlow!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Organize suas tarefas de forma simples'),
            SizedBox(height: 24),
            ElevatedButton(onPressed: _onButtonPressed, child: Text('Começar')),
          ],
        ),
      ),
      floatingActionButton: const FloatingActionButton(
        onPressed: _onButtonPressed,
        tooltip: 'Adicionar tarefa',
        child: Icon(Icons.delete),
      ),
    );
  }
}
