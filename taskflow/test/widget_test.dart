import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:taskflow/main.dart';

/// Substitui apenas o SDK nos testes; nenhuma conta real é criada.
class FakeAuth extends Fake implements FirebaseAuth {
  FakeAuth({bool signedIn = false}) : _user = signedIn ? FakeUser() : null;

  final _changes = StreamController<User?>.broadcast();
  User? _user;
  int loginCalls = 0;
  int resetCalls = 0;
  Completer<void>? loginGate;

  @override
  User? get currentUser => _user;

  @override
  Stream<User?> authStateChanges() async* {
    yield _user;
    yield* _changes.stream;
  }

  @override
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    loginCalls++;
    await loginGate?.future;
    if (password == 'erro123') {
      throw FirebaseAuthException(code: 'invalid-credential');
    }
    _user = FakeUser();
    _changes.add(_user);
    return FakeCredential();
  }

  @override
  Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    _user = FakeUser();
    _changes.add(_user);
    return FakeCredential();
  }

  @override
  Future<void> sendPasswordResetEmail({
    required String email,
    ActionCodeSettings? actionCodeSettings,
  }) async {
    resetCalls++;
  }

  @override
  Future<void> signOut() async {
    _user = null;
    _changes.add(null);
  }

  Future<void> close() => _changes.close();
}

class FakeUser extends Fake implements User {}

class FakeCredential extends Fake implements UserCredential {}

void main() {
  testWidgets('protege tarefas e mostra login sem sessão', (tester) async {
    final auth = FakeAuth();
    addTearDown(auth.close);
    await tester.pumpWidget(TaskFlowApp(firebaseAuth: auth));
    await tester.pumpAndSettle();

    expect(find.text('Entrar no TaskFlow'), findsOneWidget);
    GoRouter.of(
      tester.element(find.text('Entrar no TaskFlow')),
    ).go('/tasks/new');
    await tester.pumpAndSettle();
    expect(find.text('Entrar no TaskFlow'), findsOneWidget);
    expect(find.text('Nova tarefa'), findsNothing);
  });

  testWidgets('valida login, traduz erro e permite recuperar senha', (
    tester,
  ) async {
    final auth = FakeAuth();
    addTearDown(auth.close);
    await tester.pumpWidget(TaskFlowApp(firebaseAuth: auth));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Entrar'));
    await tester.pump();
    expect(find.text('Informe o e-mail.'), findsOneWidget);
    expect(auth.loginCalls, 0);

    await tester.enterText(
      find.byType(TextFormField).first,
      'aluno@example.com',
    );
    await tester.enterText(find.byType(TextFormField).last, 'erro123');
    await tester.tap(find.text('Entrar'));
    await tester.pumpAndSettle();
    expect(find.text('E-mail ou senha incorretos.'), findsOneWidget);

    await tester.tap(find.text('Esqueci minha senha'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField), 'aluno@example.com');
    await tester.tap(find.text('Enviar link'));
    await tester.pumpAndSettle();
    expect(auth.resetCalls, 1);
    expect(
      find.textContaining('Se o e-mail estiver cadastrado'),
      findsOneWidget,
    );
  });

  testWidgets('cadastro abre tarefas e logout bloqueia a lista', (
    tester,
  ) async {
    final auth = FakeAuth();
    addTearDown(auth.close);
    await tester.pumpWidget(TaskFlowApp(firebaseAuth: auth));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Criar conta'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byType(TextFormField).at(0),
      'aluno@example.com',
    );
    await tester.enterText(find.byType(TextFormField).at(1), 'senha123');
    await tester.enterText(find.byType(TextFormField).at(2), 'diferente');
    await tester.tap(find.text('Cadastrar'));
    await tester.pump();
    expect(find.text('As senhas não coincidem.'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).at(2), 'senha123');
    await tester.tap(find.text('Cadastrar'));
    await tester.pumpAndSettle();
    expect(find.text('Minhas tarefas'), findsOneWidget);
    expect(find.byType(Card), findsNWidgets(3));

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).first, 'Nova tarefa');
    await tester.tap(find.text('Salvar'));
    await tester.pumpAndSettle();
    expect(find.byType(Card), findsNWidgets(4));

    await tester.tap(find.byTooltip('Sair'));
    await tester.pumpAndSettle();
    expect(find.text('Entrar no TaskFlow'), findsOneWidget);
    expect(find.text('Minhas tarefas'), findsNothing);
  });

  testWidgets('sessão existente ignora a rota de login', (tester) async {
    final auth = FakeAuth(signedIn: true);
    addTearDown(auth.close);
    await tester.pumpWidget(TaskFlowApp(firebaseAuth: auth));
    await tester.pumpAndSettle();
    expect(find.text('Minhas tarefas'), findsOneWidget);
    GoRouter.of(tester.element(find.text('Minhas tarefas'))).go('/login');
    await tester.pumpAndSettle();
    expect(find.text('Minhas tarefas'), findsOneWidget);
    expect(find.text('Entrar no TaskFlow'), findsNothing);
  });

  testWidgets('loading impede envios simultâneos do login', (tester) async {
    final auth = FakeAuth()..loginGate = Completer<void>();
    addTearDown(auth.close);
    await tester.pumpWidget(TaskFlowApp(firebaseAuth: auth));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byType(TextFormField).first,
      'aluno@example.com',
    );
    await tester.enterText(find.byType(TextFormField).last, 'senha123');
    await tester.tap(find.text('Entrar'));
    await tester.pump();

    expect(auth.loginCalls, 1);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(
      tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
      isNull,
    );

    auth.loginGate!.complete();
    await tester.pumpAndSettle();
    expect(auth.loginCalls, 1);
    expect(find.text('Minhas tarefas'), findsOneWidget);
  });
}
