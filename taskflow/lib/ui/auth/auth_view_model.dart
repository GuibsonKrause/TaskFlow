import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:taskflow/data/repositories/auth_repository.dart';

/// Expõe à interface a sessão, o andamento e mensagens de autenticação.
class AuthViewModel extends ChangeNotifier {
  AuthViewModel(this._repository) {
    _subscription = _repository.authStateChanges.listen(
      (user) {
        _user = user;
        _isReady = true;
        notifyListeners();
      },
      onError: (Object error) {
        _errorMessage = 'Não foi possível verificar a sessão. Tente novamente.';
        _isReady = true;
        notifyListeners();
      },
    );
  }

  final AuthRepository _repository;
  late final StreamSubscription<User?> _subscription;
  User? _user;
  bool _isReady = false;
  bool _isLoading = false;
  String? _errorMessage;
  String? _successMessage;

  User? get currentUser => _user;
  bool get isReady => _isReady;
  bool get isAuthenticated => _user != null;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;

  /// Executa uma operação por vez e traduz falhas antes de avisar a View.
  Future<bool> _run(Future<void> Function() operation) async {
    if (_isLoading) return false;
    _isLoading = true;
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();
    try {
      await operation();
      return true;
    } on FirebaseAuthException catch (error) {
      _errorMessage = _friendlyMessage(error.code);
      return false;
    } catch (_) {
      _errorMessage = 'Não foi possível concluir a operação. Tente novamente.';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> register(String email, String password) =>
      _run(() => _repository.register(email.trim(), password));

  Future<bool> login(String email, String password) =>
      _run(() => _repository.login(email.trim(), password));

  Future<bool> logout() => _run(_repository.logout);

  Future<bool> sendPasswordReset(String email) async {
    final sent = await _run(() => _repository.sendPasswordReset(email.trim()));
    if (sent) {
      // Mensagem neutra evita confirmar se um endereço possui conta.
      _successMessage =
          'Se o e-mail estiver cadastrado, você receberá um link.';
      notifyListeners();
    }
    return sent;
  }

  String _friendlyMessage(String code) => switch (code) {
    'invalid-email' => 'Informe um e-mail válido.',
    'email-already-in-use' => 'Este e-mail já está cadastrado.',
    'weak-password' => 'Escolha uma senha mais forte.',
    'user-not-found' ||
    'wrong-password' ||
    'invalid-credential' => 'E-mail ou senha incorretos.',
    'user-disabled' => 'Esta conta está desativada.',
    'too-many-requests' => 'Muitas tentativas. Tente novamente mais tarde.',
    'network-request-failed' => 'Verifique sua conexão com a internet.',
    'operation-not-allowed' =>
      'Ative o login por e-mail e senha no console Firebase.',
    _ => 'Não foi possível concluir a operação. Tente novamente.',
  };

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
