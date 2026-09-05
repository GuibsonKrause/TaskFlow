// Importa widgets usados para localizar elementos nos testes.
import 'package:flutter/material.dart';
// Importa as ferramentas oficiais de testes de widgets do Flutter.
import 'package:flutter_test/flutter_test.dart';
// Importa o widget raiz que será testado.
import 'package:taskflow/main.dart';

// Define o ponto de entrada da suíte de testes.
void main() {
  // Declara o teste que verifica as tarefas exibidas inicialmente.
  testWidgets('exibe a lista de tarefas locais', (tester) async {
    // Renderiza o aplicativo no ambiente de testes.
    await tester.pumpWidget(const TaskFlowApp());

    // Confirma que o título do aplicativo aparece uma vez.
    expect(find.text('TaskFlow'), findsOneWidget);
    // Confirma que as três tarefas iniciais são apresentadas em Cards.
    expect(find.byType(Card), findsNWidgets(3));
    // Confirma que cada Card contém um ListTile.
    expect(find.byType(ListTile), findsNWidgets(3));
    // Confirma que o título da primeira tarefa aparece.
    expect(find.text('Planejar a semana'), findsOneWidget);
    // Confirma que o título da segunda tarefa aparece.
    expect(find.text('Estudar Flutter'), findsOneWidget);
    // Confirma que o título da terceira tarefa aparece.
    expect(find.text('Organizar materiais'), findsOneWidget);
    // Confirma que existe uma tarefa concluída.
    expect(find.text('Concluída'), findsOneWidget);
    // Confirma que existem duas tarefas pendentes.
    expect(find.text('Pendente'), findsNWidgets(2));
    // Confirma que existe um ícone de tarefa concluída.
    expect(find.byIcon(Icons.check_circle), findsOneWidget);
    // Confirma que existem dois ícones de tarefa pendente.
    expect(find.byIcon(Icons.pending), findsNWidgets(2));
  }); // Encerra o teste da lista inicial.

  // Declara o teste do fluxo de validação e cadastro.
  testWidgets('valida e cadastra uma nova tarefa', (tester) async {
    // Renderiza uma nova instância do aplicativo no ambiente de testes.
    await tester.pumpWidget(const TaskFlowApp());

    // Pressiona o botão com ícone de adição.
    await tester.tap(find.byIcon(Icons.add));
    // Aguarda o término da animação de navegação.
    await tester.pumpAndSettle();

    // Confirma que o formulário foi aberto.
    expect(find.text('Nova tarefa'), findsOneWidget);

    // Digita um título menor que o mínimo permitido.
    await tester.enterText(find.byType(TextFormField).first, 'AB');
    // Pressiona o botão para tentar salvar o formulário inválido.
    await tester.tap(find.text('Salvar'));
    // Processa a atualização da interface após a validação.
    await tester.pump();

    // Confirma que a mensagem de tamanho mínimo foi exibida.
    expect(
      // Localiza o texto de validação apresentado abaixo do campo.
      find.text('O título deve possuir pelo menos 3 caracteres.'),
      // Exige que a mensagem apareça exatamente uma vez.
      findsOneWidget,
    ); // Encerra a verificação da mensagem do campo.
    // Confirma que o SnackBar geral de erro foi exibido.
    expect(find.text('Corrija os campos antes de salvar.'), findsOneWidget);

    // Substitui o valor inválido por um título válido.
    await tester.enterText(find.byType(TextFormField).first, 'Nova tarefa');
    // Digita uma descrição no segundo campo.
    await tester.enterText(
      // Localiza o último campo, correspondente à descrição.
      find.byType(TextFormField).last,
      // Informa o texto usado como descrição da nova tarefa.
      'Descrição da nova tarefa',
    ); // Encerra o preenchimento da descrição.
    // Pressiona novamente o botão de salvamento.
    await tester.tap(find.text('Salvar'));
    // Aguarda a navegação de volta e a reconstrução da Home.
    await tester.pumpAndSettle();

    // Confirma o retorno à tela principal.
    expect(find.text('TaskFlow'), findsOneWidget);
    // Confirma que o título cadastrado aparece na lista.
    expect(find.text('Nova tarefa'), findsOneWidget);
    // Confirma que a descrição cadastrada aparece na lista.
    expect(find.text('Descrição da nova tarefa'), findsOneWidget);
    // Confirma que o feedback de sucesso foi exibido.
    expect(find.text('Tarefa cadastrada com sucesso!'), findsOneWidget);
    // Confirma que a lista agora contém quatro Cards.
    expect(find.byType(Card), findsNWidgets(4));
  }); // Encerra o teste do fluxo de cadastro.
} // Encerra a suíte de testes.
