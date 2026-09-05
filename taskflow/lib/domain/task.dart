// Representa uma tarefa do domínio do aplicativo.
class Task {
  // Cria uma tarefa imutável exigindo todos os seus dados.
  const Task({
    // Recebe o identificador único da tarefa.
    required this.id,
    // Recebe o título da tarefa.
    required this.title,
    // Recebe a descrição da tarefa.
    required this.description,
    // Recebe a informação que indica se a tarefa foi concluída.
    required this.isCompleted,
    // Recebe a data e o horário de criação da tarefa.
    required this.createdAt,
  }); // Encerra o construtor da tarefa.

  // Armazena o identificador único da tarefa.
  final String id;
  // Armazena o título da tarefa.
  final String title;
  // Armazena a descrição, que pode ser uma string vazia.
  final String description;
  // Armazena o estado de conclusão da tarefa.
  final bool isCompleted;
  // Armazena a data e o horário em que a tarefa foi criada.
  final DateTime createdAt;
} // Encerra a declaração do modelo Task.
