// Importa os widgets e recursos do Material Design do Flutter.
import 'package:flutter/material.dart';
// Importa os widgets usados para injetar repositório e ViewModel.
import 'package:provider/provider.dart';
// Importa a configuração compartilhada de navegação do aplicativo.
import 'package:taskflow/app/router.dart';
// Importa a implementação em memória do repositório de tarefas.
import 'package:taskflow/data/repositories/task_repository.dart';
// Importa o ViewModel que gerencia o estado das tarefas.
import 'package:taskflow/ui/tasks/task_view_model.dart';

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
    // Injeta as dependências uma única vez acima de todas as rotas.
    return MultiProvider(
      // Declara as dependências disponíveis para a árvore de widgets.
      providers: [
        // Cria uma única instância do repositório em memória.
        Provider<TaskRepository>(create: (context) => TaskRepository()),
        // Cria e gerencia o ciclo de vida do ViewModel com o repositório injetado.
        ChangeNotifierProvider<TaskViewModel>(
          // Obtém o repositório existente e o entrega ao ViewModel.
          create: (context) => TaskViewModel(context.read<TaskRepository>()),
        ), // Encerra a configuração do ChangeNotifierProvider.
      ], // Encerra a lista de dependências.
      // Configura o aplicativo Material usando o GoRouter compartilhado.
      child: MaterialApp.router(title: 'TaskFlow', routerConfig: appRouter),
    ); // Encerra a configuração dos providers.
  } // Encerra a construção da interface.
} // Encerra a declaração de TaskFlowApp.
