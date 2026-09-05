// Importa os widgets e recursos do Material Design do Flutter.
import 'package:flutter/material.dart';
// Importa a tela principal exibida ao iniciar o aplicativo.
import 'package:taskflow/ui/home/home_screen.dart';

// Define o ponto de entrada da aplicação Dart.
void main() {
  // Cria e exibe o widget raiz do TaskFlow.
  runApp(const TaskFlowApp());
} // Encerra a função principal.

// Declara o widget raiz imutável do aplicativo.
class TaskFlowApp extends StatelessWidget {
  // Cria o widget raiz e permite o recebimento opcional de uma chave.
  const TaskFlowApp({super.key});

  // Constrói a interface do widget raiz.
  @override
  Widget build(BuildContext context) {
    // Configura o aplicativo Material com nome e tela inicial.
    return const MaterialApp(title: 'TaskFlow', home: HomeScreen());
  } // Encerra a construção da interface.
} // Encerra a declaração de TaskFlowApp.
