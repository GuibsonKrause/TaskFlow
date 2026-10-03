import 'package:firebase_auth/firebase_auth.dart';

/// Mantém todas as chamadas ao Firebase Authentication fora da interface.
class AuthRepository {
  AuthRepository([FirebaseAuth? auth]) : _auth = auth ?? FirebaseAuth.instance;

  final FirebaseAuth _auth;

  /// Retorna a sessão conhecida pelo SDK neste momento.
  User? get currentUser => _auth.currentUser;

  /// Emite a sessão inicial e cada entrada ou saída posterior.
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<void> register(String email, String password) async {
    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> login(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> logout() => _auth.signOut();

  Future<void> sendPasswordReset(String email) =>
      _auth.sendPasswordResetEmail(email: email);
}
