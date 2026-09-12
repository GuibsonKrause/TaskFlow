// Importa a API atual do pacote go_router.
import 'package:go_router/go_router.dart';
// Importa a tela inicial do aplicativo.
import 'package:taskflow/ui/home/home_screen.dart';
// Importa a tela que lista as tarefas.
import 'package:taskflow/ui/tasks/task_list_screen.dart';
// Importa a tela de cadastro de tarefas.
import 'package:taskflow/ui/task_form/task_form_screen.dart';

// Cria uma única configuração compartilhada de navegação do aplicativo.
final GoRouter appRouter = GoRouter(
  // Define a rota inicial como a tela de boas-vindas.
  initialLocation: '/',
  // Declara todas as rotas usando caminhos, sem named routes.
  routes: [
    // Configura o caminho raiz do aplicativo.
    GoRoute(
      // Define o endereço da tela inicial.
      path: '/',
      // Constrói a tela inicial quando o caminho raiz é acessado.
      builder: (context, state) => const HomeScreen(),
    ), // Encerra a configuração da rota inicial.
    // Configura o caminho que apresenta a lista de tarefas.
    GoRoute(
      // Define o endereço da lista de tarefas.
      path: '/tasks',
      // Constrói a lista quando o caminho de tarefas é acessado.
      builder: (context, state) => const TaskListScreen(),
    ), // Encerra a configuração da rota de tarefas.
    // Configura o caminho usado para cadastrar uma nova tarefa.
    GoRoute(
      // Define o endereço da tela de cadastro.
      path: '/tasks/new',
      // Constrói o formulário quando o caminho de cadastro é acessado.
      builder: (context, state) => const TaskFormScreen(),
    ), // Encerra a configuração da rota de cadastro.
  ], // Encerra a lista de rotas.
); // Encerra a configuração única do GoRouter.
