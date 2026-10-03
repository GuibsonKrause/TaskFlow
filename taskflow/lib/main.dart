// Importa a inicialização oficial do Firebase para Flutter.
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
// Importa os widgets e recursos do Material Design do Flutter.
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// Importa os widgets usados para injetar repositório e ViewModel.
import 'package:provider/provider.dart';
// Importa a configuração compartilhada de navegação do aplicativo.
import 'package:taskflow/app/router.dart';
// Importa a tela de falha apresentada caso a inicialização não termine.
import 'package:taskflow/app/startup_error_app.dart';
import 'package:taskflow/data/repositories/auth_repository.dart';
import 'package:taskflow/ui/auth/auth_view_model.dart';
// Importa as opções que serão geradas pelo comando flutterfire configure.
import 'package:taskflow/firebase_options.dart';
// Importa a implementação em memória do repositório de tarefas.
import 'package:taskflow/data/repositories/task_repository.dart';
// Importa o ViewModel que gerencia o estado das tarefas.
import 'package:taskflow/ui/tasks/task_view_model.dart';

// Define o ponto de entrada da aplicação Dart.
Future<void> main() async {
  // Prepara a comunicação com plugins antes de iniciar o Firebase.
  WidgetsFlutterBinding.ensureInitialized();
  // Aguarda a inicialização antes de construir a aplicação principal.
  try {
    // Inicializa o app padrão com as opções da plataforma atual.
    await Firebase.initializeApp(
      // Usa a configuração produzida pelo FlutterFire CLI.
      options: DefaultFirebaseOptions.currentPlatform,
    ); // Encerra a chamada de inicialização.
  } catch (error, stackTrace) {
    // Registra o diagnóstico pelos mecanismos de erro do Flutter.
    FlutterError.reportError(
      // Preserva a exceção e sua origem para depuração.
      FlutterErrorDetails(exception: error, stack: stackTrace),
    ); // Encerra o registro do erro.
    // Exibe uma mensagem de falha sem abrir uma aplicação parcialmente iniciada.
    runApp(const StartupErrorApp());
    // Impede a criação do TaskFlow quando o Firebase falha.
    return;
  } // Encerra o tratamento da inicialização.
  // Cria e exibe o widget raiz do TaskFlow.
  runApp(const TaskFlowApp());
} // Encerra a função principal.

// Declara o widget raiz imutável do aplicativo.
class TaskFlowApp extends StatefulWidget {
  // Cria o widget raiz e permite o recebimento opcional de uma chave.
  const TaskFlowApp({super.key, this.firebaseAuth});

  /// Permite injetar uma implementação de teste sem tocar no Firebase real.
  final FirebaseAuth? firebaseAuth;

  @override
  State<TaskFlowApp> createState() => _TaskFlowAppState();
}

class _TaskFlowAppState extends State<TaskFlowApp> {
  late final AuthRepository _authRepository;
  late final AuthViewModel _authViewModel;
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _authRepository = AuthRepository(widget.firebaseAuth);
    _authViewModel = AuthViewModel(_authRepository);
    _router = createAppRouter(_authViewModel);
  }

  @override
  void dispose() {
    _router.dispose();
    _authViewModel.dispose();
    super.dispose();
  }

  // Constrói a interface do widget raiz.
  @override
  Widget build(BuildContext context) {
    // Injeta as dependências uma única vez acima de todas as rotas.
    return MultiProvider(
      // Declara as dependências disponíveis para a árvore de widgets.
      providers: [
        Provider<AuthRepository>.value(value: _authRepository),
        ChangeNotifierProvider<AuthViewModel>.value(value: _authViewModel),
        // Cria uma única instância do repositório em memória.
        Provider<TaskRepository>(create: (context) => TaskRepository()),
        // Cria e gerencia o ciclo de vida do ViewModel com o repositório injetado.
        ChangeNotifierProvider<TaskViewModel>(
          // Obtém o repositório existente e o entrega ao ViewModel.
          create: (context) => TaskViewModel(context.read<TaskRepository>()),
        ), // Encerra a configuração do ChangeNotifierProvider.
      ], // Encerra a lista de dependências.
      // Configura o aplicativo Material usando o GoRouter compartilhado.
      child: MaterialApp.router(title: 'TaskFlow', routerConfig: _router),
    ); // Encerra a configuração dos providers.
  } // Encerra a construção da interface.
} // Encerra a declaração de TaskFlowApp.
