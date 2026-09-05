import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taskflow/main.dart';

void main() {
  testWidgets('exibe a lista de tarefas locais', (tester) async {
    await tester.pumpWidget(const TaskFlowApp());

    expect(find.text('TaskFlow'), findsOneWidget);
    expect(find.byType(Card), findsNWidgets(3));
    expect(find.byType(ListTile), findsNWidgets(3));
    expect(find.text('Planejar a semana'), findsOneWidget);
    expect(find.text('Estudar Flutter'), findsOneWidget);
    expect(find.text('Organizar materiais'), findsOneWidget);
    expect(find.text('Concluída'), findsOneWidget);
    expect(find.text('Pendente'), findsNWidgets(2));
    expect(find.byIcon(Icons.check_circle), findsOneWidget);
    expect(find.byIcon(Icons.pending), findsNWidgets(2));
  });

  testWidgets('valida e cadastra uma nova tarefa', (tester) async {
    await tester.pumpWidget(const TaskFlowApp());

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    expect(find.text('Nova tarefa'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).first, 'AB');
    await tester.tap(find.text('Salvar'));
    await tester.pump();

    expect(
      find.text('O título deve possuir pelo menos 3 caracteres.'),
      findsOneWidget,
    );
    expect(find.text('Corrija os campos antes de salvar.'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).first, 'Nova tarefa');
    await tester.enterText(
      find.byType(TextFormField).last,
      'Descrição da nova tarefa',
    );
    await tester.tap(find.text('Salvar'));
    await tester.pumpAndSettle();

    expect(find.text('TaskFlow'), findsOneWidget);
    expect(find.text('Nova tarefa'), findsOneWidget);
    expect(find.text('Descrição da nova tarefa'), findsOneWidget);
    expect(find.text('Tarefa cadastrada com sucesso!'), findsOneWidget);
    expect(find.byType(Card), findsNWidgets(4));
  });
}
