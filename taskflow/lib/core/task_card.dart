// Importa os widgets e recursos do Material Design do Flutter.
import 'package:flutter/material.dart';
// Importa o modelo que fornece os dados exibidos pelo card.
import 'package:taskflow/domain/task.dart';

// Declara um widget reutilizável para apresentar uma tarefa.
class TaskCard extends StatelessWidget {
  // Cria o card exigindo a tarefa que será exibida.
  const TaskCard({super.key, required this.task});

  // Armazena a tarefa recebida pelo widget.
  final Task task;

  // Constrói a representação visual da tarefa.
  @override
  Widget build(BuildContext context) {
    // Define o texto do status conforme o estado de conclusão.
    final status = task.isCompleted ? 'Concluída' : 'Pendente';
    // Define verde para tarefas concluídas e laranja para pendentes.
    final statusColor = task.isCompleted ? Colors.green : Colors.orange;
    // Define o ícone que representa visualmente o status da tarefa.
    final statusIcon = task.isCompleted ? Icons.check_circle : Icons.pending;

    // Retorna um Card para destacar a tarefa na lista.
    return Card(
      // Usa ListTile para organizar ícone, título e informações secundárias.
      child: ListTile(
        // Exibe à esquerda o ícone com a cor correspondente ao status.
        leading: Icon(statusIcon, color: statusColor),
        // Exibe o título principal da tarefa.
        title: Text(task.title),
        // Agrupa verticalmente a descrição e o status.
        subtitle: Column(
          // Alinha o conteúdo secundário ao início horizontal da coluna.
          crossAxisAlignment: CrossAxisAlignment.start,
          // Declara os widgets apresentados abaixo do título.
          children: [
            // Exibe a descrição informada para a tarefa.
            Text(task.description),
            // Adiciona um pequeno espaço entre descrição e status.
            const SizedBox(height: 4),
            // Exibe o texto do status calculado anteriormente.
            Text(
              // Informa o conteúdo textual do status.
              status,
              // Personaliza a cor e o peso do texto do status.
              style: TextStyle(
                // Aplica ao texto a cor correspondente ao status.
                color: statusColor,
                // Destaca o status com peso seminegrito.
                fontWeight: FontWeight.w600,
              ), // Encerra a configuração visual do status.
            ), // Encerra o widget de texto do status.
          ], // Encerra a lista de elementos secundários.
        ), // Encerra a coluna de descrição e status.
      ), // Encerra o ListTile.
    ); // Encerra e retorna o Card.
  } // Encerra a construção do widget.
} // Encerra a declaração de TaskCard.
