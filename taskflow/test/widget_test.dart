import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taskflow/main.dart';

void main() {
  testWidgets('exibe os elementos principais da HomeScreen', (tester) async {
    await tester.pumpWidget(const TaskFlowApp());

    expect(find.text('TaskFlow'), findsOneWidget);
    expect(find.text('Bem-vindo ao TaskFlow!'), findsOneWidget);
    expect(find.text('Organize suas tarefas de forma simples'), findsOneWidget);
    expect(find.text('Começar'), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
  });
}
