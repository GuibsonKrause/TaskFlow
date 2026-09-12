// Importa os widgets e recursos do Material Design do Flutter.
import 'package:flutter/material.dart';
// Importa as extensões de navegação do go_router.
import 'package:go_router/go_router.dart';
// Importa o widget reutilizável que exibe cada tarefa.
import 'package:taskflow/core/task_card.dart';
// Importa o modelo usado pela lista local de tarefas.
import 'package:taskflow/domain/task.dart';

// Declara a tela que apresenta as tarefas cadastradas em memória.
class TaskListScreen extends StatefulWidget {
  // Cria a tela de lista e permite o recebimento opcional de uma chave.
  const TaskListScreen({super.key});

  // Cria o objeto responsável por armazenar o estado da lista.
  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
} // Encerra a declaração de TaskListScreen.

// Implementa o estado mutável da lista de tarefas.
class _TaskListScreenState extends State<TaskListScreen> {
  // Inicializa a lista em memória com três tarefas de exemplo.
  final List<Task> _tasks = [
    // Cria a primeira tarefa mockada.
    Task(
      // Define o identificador da primeira tarefa.
      id: '1',
      // Define o título da primeira tarefa.
      title: 'Planejar a semana',
      // Define a descrição da primeira tarefa.
      description: 'Definir as prioridades e os compromissos da semana.',
      // Marca a primeira tarefa como concluída.
      isCompleted: true,
      // Define a data de criação da primeira tarefa.
      createdAt: DateTime(2026, 8, 25),
    ), // Encerra a primeira tarefa mockada.
    // Cria a segunda tarefa mockada.
    Task(
      // Define o identificador da segunda tarefa.
      id: '2',
      // Define o título da segunda tarefa.
      title: 'Estudar Flutter',
      // Define a descrição da segunda tarefa.
      description: 'Revisar widgets de layout e listas.',
      // Mantém a segunda tarefa como pendente.
      isCompleted: false,
      // Define a data de criação da segunda tarefa.
      createdAt: DateTime(2026, 8, 26),
    ), // Encerra a segunda tarefa mockada.
    // Cria a terceira tarefa mockada.
    Task(
      // Define o identificador da terceira tarefa.
      id: '3',
      // Define o título da terceira tarefa.
      title: 'Organizar materiais',
      // Define a descrição da terceira tarefa.
      description: 'Separar anotações e arquivos da disciplina.',
      // Mantém a terceira tarefa como pendente.
      isCompleted: false,
      // Define a data de criação da terceira tarefa.
      createdAt: DateTime(2026, 8, 27),
    ), // Encerra a terceira tarefa mockada.
  ]; // Encerra a lista local de tarefas.

  // Abre o formulário e aguarda a tarefa retornada ao salvar.
  Future<void> _openTaskForm() async {
    // Navega para o cadastro usando o caminho da rota, sem named route.
    final task = await context.push<Task>('/tasks/new');

    // Interrompe o fluxo se nada foi salvo ou se a tela deixou de existir.
    if (task == null || !mounted) {
      // Sai do método sem modificar a lista.
      return;
    } // Encerra a verificação do resultado da navegação.

    // Solicita a reconstrução da tela após alterar os dados locais.
    setState(() {
      // Adiciona a nova tarefa ao final da lista existente.
      _tasks.add(task);
    }); // Encerra a atualização do estado.

    // Obtém o gerenciador de SnackBars da tela atual.
    ScaffoldMessenger.of(context)
      // Oculta uma mensagem anterior que ainda esteja visível.
      ..hideCurrentSnackBar()
      // Exibe a confirmação visual do cadastro.
      ..showSnackBar(
        // Cria a mensagem de sucesso mostrada ao usuário.
        const SnackBar(content: Text('Tarefa cadastrada com sucesso!')),
      ); // Encerra a exibição do SnackBar.
  } // Encerra o método de abertura do formulário.

  // Constrói a interface atual da lista.
  @override
  Widget build(BuildContext context) {
    // Retorna a estrutura visual básica da página.
    return Scaffold(
      // Exibe o título da lista na barra superior.
      appBar: AppBar(title: const Text('Minhas tarefas')),
      // Cria uma lista rolável com separadores entre os cards.
      body: ListView.separated(
        // Adiciona espaçamento ao redor de toda a lista.
        padding: const EdgeInsets.all(16),
        // Informa quantos itens devem ser construídos.
        itemCount: _tasks.length,
        // Insere um espaço vertical entre dois cards consecutivos.
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        // Constrói um card para a tarefa localizada no índice atual.
        itemBuilder: (context, index) => TaskCard(task: _tasks[index]),
      ), // Encerra a lista de tarefas.
      // Cria o botão flutuante usado para iniciar um cadastro.
      floatingActionButton: FloatingActionButton(
        // Abre o formulário quando o usuário pressiona o botão.
        onPressed: _openTaskForm,
        // Fornece uma descrição acessível para o botão.
        tooltip: 'Adicionar tarefa',
        // Exibe o símbolo de adição dentro do botão.
        child: const Icon(Icons.add),
      ), // Encerra o botão flutuante.
    ); // Encerra e retorna a página de tarefas.
  } // Encerra a construção da tela.
} // Encerra a declaração do estado da lista.
