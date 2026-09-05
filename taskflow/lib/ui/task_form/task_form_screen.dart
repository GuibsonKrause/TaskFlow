// Importa os widgets e recursos do Material Design do Flutter.
import 'package:flutter/material.dart';
// Importa o modelo criado quando o formulário é salvo.
import 'package:taskflow/domain/task.dart';

// Declara a tela de formulário com estado para controlar seus campos.
class TaskFormScreen extends StatefulWidget {
  // Cria a tela de formulário e permite o recebimento opcional de uma chave.
  const TaskFormScreen({super.key});

  // Cria o objeto responsável pelo estado do formulário.
  @override
  State<TaskFormScreen> createState() => _TaskFormScreenState();
} // Encerra a declaração de TaskFormScreen.

// Implementa o estado e o comportamento do formulário.
class _TaskFormScreenState extends State<TaskFormScreen> {
  // Cria a chave usada para acessar e validar o estado do Form.
  final _formKey = GlobalKey<FormState>();
  // Controla o texto digitado no campo de título.
  final _titleController = TextEditingController();
  // Controla o texto digitado no campo de descrição.
  final _descriptionController = TextEditingController();

  // Valida o valor informado no campo de título.
  String? _validateTitle(String? value) {
    // Remove espaços nas extremidades e trata valor nulo como vazio.
    final title = value?.trim() ?? '';

    // Verifica se nenhum título útil foi informado.
    if (title.isEmpty) {
      // Retorna a mensagem apresentada abaixo do campo obrigatório.
      return 'Informe o título da tarefa.';
    } // Encerra a validação de título vazio.

    // Verifica se o título possui menos de três caracteres.
    if (title.length < 3) {
      // Retorna a mensagem que informa o tamanho mínimo exigido.
      return 'O título deve possuir pelo menos 3 caracteres.';
    } // Encerra a validação de tamanho mínimo.

    // Retorna nulo para indicar que o título é válido.
    return null;
  } // Encerra o método de validação do título.

  // Valida o formulário e cria a tarefa quando os dados são válidos.
  void _saveTask() {
    // Executa todos os validadores e verifica se algum campo é inválido.
    if (!_formKey.currentState!.validate()) {
      // Obtém o gerenciador de SnackBars do formulário.
      ScaffoldMessenger.of(context)
        // Remove uma mensagem anterior que ainda esteja aparecendo.
        ..hideCurrentSnackBar()
        // Exibe um feedback geral sobre os erros encontrados.
        ..showSnackBar(
          // Cria a mensagem de erro mostrada na parte inferior da tela.
          const SnackBar(content: Text('Corrija os campos antes de salvar.')),
        ); // Encerra a exibição do SnackBar de erro.
      // Interrompe o salvamento para que o usuário corrija os dados.
      return;
    } // Encerra o tratamento do formulário inválido.

    // Captura uma única data para o identificador e a criação da tarefa.
    final createdAt = DateTime.now();
    // Cria uma nova tarefa com os valores tratados do formulário.
    final task = Task(
      // Gera um identificador local a partir do instante de criação.
      id: createdAt.microsecondsSinceEpoch.toString(),
      // Remove espaços extras do título digitado.
      title: _titleController.text.trim(),
      // Remove espaços extras da descrição opcional.
      description: _descriptionController.text.trim(),
      // Define toda nova tarefa como pendente.
      isCompleted: false,
      // Registra quando a tarefa foi criada.
      createdAt: createdAt,
    ); // Encerra a criação da nova tarefa.

    // Fecha o formulário e devolve a tarefa para a tela anterior.
    Navigator.of(context).pop(task);
  } // Encerra o método de salvamento.

  // Libera os recursos mantidos pelos controladores antes de destruir a tela.
  @override
  void dispose() {
    // Descarta o controlador do título.
    _titleController.dispose();
    // Descarta o controlador da descrição.
    _descriptionController.dispose();
    // Permite que a classe base finalize o descarte do estado.
    super.dispose();
  } // Encerra o descarte dos recursos.

  // Constrói a interface atual da tela de formulário.
  @override
  Widget build(BuildContext context) {
    // Retorna a estrutura visual básica da página.
    return Scaffold(
      // Cria a barra superior com o título da tela.
      appBar: AppBar(title: const Text('Nova tarefa')),
      // Adiciona espaçamento ao redor do formulário.
      body: Padding(
        // Define dezesseis pixels de espaço em todos os lados.
        padding: const EdgeInsets.all(16),
        // Agrupa e gerencia os campos que serão validados.
        child: Form(
          // Associa o Form à chave usada pelo método de salvamento.
          key: _formKey,
          // Organiza os campos e o botão verticalmente.
          child: Column(
            // Faz os elementos ocuparem a largura disponível.
            crossAxisAlignment: CrossAxisAlignment.stretch,
            // Declara os elementos apresentados dentro do formulário.
            children: [
              // Cria o campo editável e validável de título.
              TextFormField(
                // Associa o campo ao controlador de título.
                controller: _titleController,
                // Configura o rótulo e a borda visual do campo.
                decoration: const InputDecoration(
                  // Exibe o nome do campo para o usuário.
                  labelText: 'Título',
                  // Desenha uma borda ao redor do campo.
                  border: OutlineInputBorder(),
                ), // Encerra a decoração do campo de título.
                // Faz o botão do teclado avançar para o próximo campo.
                textInputAction: TextInputAction.next,
                // Associa ao campo as regras de validação do título.
                validator: _validateTitle,
              ), // Encerra o campo de título.
              // Adiciona espaço entre os dois campos.
              const SizedBox(height: 16),
              // Cria o campo editável de descrição opcional.
              TextFormField(
                // Associa o campo ao controlador de descrição.
                controller: _descriptionController,
                // Configura o rótulo e a borda visual do campo.
                decoration: const InputDecoration(
                  // Informa que o preenchimento da descrição é opcional.
                  labelText: 'Descrição (opcional)',
                  // Desenha uma borda ao redor do campo.
                  border: OutlineInputBorder(),
                ), // Encerra a decoração do campo de descrição.
                // Reserva inicialmente três linhas para a descrição.
                minLines: 3,
                // Limita o crescimento visível do campo a cinco linhas.
                maxLines: 5,
                // Mantém no teclado a ação de inserir uma nova linha.
                textInputAction: TextInputAction.newline,
              ), // Encerra o campo de descrição.
              // Adiciona espaço antes do botão de salvamento.
              const SizedBox(height: 24),
              // Cria o botão principal do formulário.
              FilledButton(
                // Executa a validação e o salvamento ao pressionar o botão.
                onPressed: _saveTask,
                // Exibe o texto que descreve a ação do botão.
                child: const Text('Salvar'),
              ), // Encerra o botão de salvamento.
            ], // Encerra a lista de elementos do formulário.
          ), // Encerra a coluna do formulário.
        ), // Encerra o Form.
      ), // Encerra a área com espaçamento.
    ); // Encerra e retorna a estrutura da página.
  } // Encerra a construção da tela de formulário.
} // Encerra a declaração do estado de TaskFormScreen.
