// Importa os widgets e recursos do Material Design do Flutter.
import 'package:flutter/material.dart';
// Importa a configuração compartilhada de navegação do aplicativo.
import 'package:taskflow/app/router.dart';

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
    // Configura o aplicativo Material usando o GoRouter compartilhado.
    return MaterialApp.router(title: 'TaskFlow', routerConfig: appRouter);
  } // Encerra a construção da interface.
} // Encerra a declaração de TaskFlowApp.
