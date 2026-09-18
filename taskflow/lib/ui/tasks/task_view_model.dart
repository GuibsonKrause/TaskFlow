// Importa ChangeNotifier, usado para comunicar mudanças à interface.
import 'package:flutter/foundation.dart';
// Importa o repositório que fornece e altera os dados.
import 'package:taskflow/data/repositories/task_repository.dart';
// Importa o modelo exposto pelo ViewModel.
import 'package:taskflow/domain/task.dart';

// Faz a ligação entre os dados do repositório e a interface de tarefas.
class TaskViewModel extends ChangeNotifier {
  // Recebe o repositório por injeção e carrega seu estado inicial.
  TaskViewModel(this._repository) {
    // Obtém as tarefas assim que o ViewModel é criado.
    loadTasks();
  } // Encerra o construtor do ViewModel.

  // Mantém a dependência de dados privada para a interface.
  final TaskRepository _repository;
  // Armazena o estado atual que será exposto aos widgets.
  List<Task> _tasks = const [];

  // Disponibiliza a lista atual sem permitir que a UI substitua o estado.
  List<Task> get tasks => _tasks;

  // Obtém do repositório a versão mais recente das tarefas.
  void loadTasks() {
    // Atualiza o estado interno com uma lista não modificável.
    _tasks = _repository.getTasks();
    // Notifica os widgets interessados para que reconstruam a interface.
    notifyListeners();
  } // Encerra a atualização das tarefas.

  // Solicita ao repositório a inclusão de uma tarefa.
  void addTask(Task task) {
    // Persiste temporariamente a tarefa no repositório em memória.
    _repository.addTask(task);
    // Recarrega o estado e notifica a interface sobre a alteração.
    loadTasks();
  } // Encerra a operação de inclusão.
} // Encerra a declaração de TaskViewModel.
