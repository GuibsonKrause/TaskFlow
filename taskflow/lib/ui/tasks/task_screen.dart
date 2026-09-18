// Importa os widgets e recursos do Material Design do Flutter.
import 'package:flutter/material.dart';
// Importa as extensões de navegação do go_router.
import 'package:go_router/go_router.dart';
// Importa as extensões read e watch do Provider.
import 'package:provider/provider.dart';
// Importa o widget reutilizável que exibe cada tarefa.
import 'package:taskflow/core/task_card.dart';
// Importa o modelo retornado pela tela de cadastro.
import 'package:taskflow/domain/task.dart';
// Importa o ViewModel responsável pelo estado da tela.
import 'package:taskflow/ui/tasks/task_view_model.dart';

// Declara a tela que apresenta o estado fornecido pelo TaskViewModel.
class TaskScreen extends StatelessWidget {
  // Cria a tela de tarefas e permite o recebimento opcional de uma chave.
  const TaskScreen({super.key});

  // Abre o formulário e encaminha a tarefa retornada ao ViewModel.
  Future<void> _openTaskForm(BuildContext context) async {
    // Navega para o cadastro usando o caminho configurado no router.
    final task = await context.push<Task>('/tasks/new');

    // Interrompe o fluxo se nada foi salvo ou se o contexto deixou de existir.
    if (task == null || !context.mounted) {
      // Sai do método sem solicitar alterações no estado.
      return;
    } // Encerra a verificação do resultado da navegação.

    // Solicita ao ViewModel a inclusão da tarefa retornada.
    context.read<TaskViewModel>().addTask(task);

    // Obtém o gerenciador de mensagens da tela atual.
    ScaffoldMessenger.of(context)
      // Oculta uma mensagem anterior que ainda esteja visível.
      ..hideCurrentSnackBar()
      // Exibe a confirmação visual do cadastro.
      ..showSnackBar(
        // Cria a mensagem de sucesso mostrada ao usuário.
        const SnackBar(content: Text('Tarefa cadastrada com sucesso!')),
      ); // Encerra a exibição da mensagem.
  } // Encerra o método de abertura do formulário.

  // Constrói a interface a partir do estado observado no ViewModel.
  @override
  Widget build(BuildContext context) {
    // Observa as tarefas e reconstrói a tela quando o ViewModel notificar.
    final tasks = context.watch<TaskViewModel>().tasks;

    // Retorna a estrutura visual básica da página.
    return Scaffold(
      // Exibe o título da lista na barra superior.
      appBar: AppBar(title: const Text('Minhas tarefas')),
      // Cria uma lista rolável usando somente o estado exposto pelo ViewModel.
      body: ListView.separated(
        // Adiciona espaçamento ao redor de toda a lista.
        padding: const EdgeInsets.all(16),
        // Informa quantos itens devem ser construídos.
        itemCount: tasks.length,
        // Insere um espaço vertical entre dois cards consecutivos.
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        // Constrói um card para a tarefa localizada no índice atual.
        itemBuilder: (context, index) => TaskCard(task: tasks[index]),
      ), // Encerra a lista de tarefas.
      // Cria o botão flutuante usado para iniciar um cadastro.
      floatingActionButton: FloatingActionButton(
        // Abre o formulário quando o usuário pressiona o botão.
        onPressed: () => _openTaskForm(context),
        // Fornece uma descrição acessível para o botão.
        tooltip: 'Adicionar tarefa',
        // Exibe o símbolo de adição dentro do botão.
        child: const Icon(Icons.add),
      ), // Encerra o botão flutuante.
    ); // Encerra e retorna a página de tarefas.
  } // Encerra a construção da tela.
} // Encerra a declaração de TaskScreen.
