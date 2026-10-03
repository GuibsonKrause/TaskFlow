import 'package:go_router/go_router.dart';
import 'package:taskflow/ui/auth/auth_view_model.dart';
import 'package:taskflow/ui/auth/forgot_password_screen.dart';
import 'package:taskflow/ui/auth/login_screen.dart';
import 'package:taskflow/ui/auth/register_screen.dart';
import 'package:taskflow/ui/auth/session_loading_screen.dart';
import 'package:taskflow/ui/home/home_screen.dart';
import 'package:taskflow/ui/task_form/task_form_screen.dart';
import 'package:taskflow/ui/tasks/task_screen.dart';

/// Cria um router para a sessão desta instância do aplicativo.
GoRouter createAppRouter(AuthViewModel auth) => GoRouter(
  initialLocation: '/',
  refreshListenable: auth,
  redirect: (context, state) {
    final location = state.matchedLocation;
    if (!auth.isReady) {
      return location == '/auth/loading' ? null : '/auth/loading';
    }
    final isAuthPage =
        location == '/login' ||
        location == '/register' ||
        location == '/forgot-password';
    if (auth.isAuthenticated) {
      return isAuthPage || location == '/' || location == '/auth/loading'
          ? '/tasks'
          : null;
    }
    return isAuthPage ? null : '/login';
  },
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(
      path: '/auth/loading',
      builder: (context, state) => const SessionLoadingScreen(),
    ),
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/forgot-password',
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    GoRoute(path: '/tasks', builder: (context, state) => const TaskScreen()),
    GoRoute(
      path: '/tasks/new',
      builder: (context, state) => const TaskFormScreen(),
    ),
  ],
);
