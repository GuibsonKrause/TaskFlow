// Importa o modelo armazenado pelo repositório.
import 'package:taskflow/domain/task.dart';

// Centraliza o acesso às tarefas mantidas em memória nesta etapa do projeto.
class TaskRepository {
  // Inicializa o repositório com três tarefas de exemplo.
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
  ]; // Encerra a lista privada mantida pelo repositório.

  // Retorna uma cópia não modificável das tarefas armazenadas.
  List<Task> getTasks() => List.unmodifiable(_tasks);

  // Adiciona uma nova tarefa ao armazenamento em memória.
  void addTask(Task task) {
    // Inclui a tarefa recebida na lista privada do repositório.
    _tasks.add(task);
  } // Encerra a operação de adição.
} // Encerra a declaração de TaskRepository.
