/// Regras compartilhadas pelos três formulários de autenticação.
String? validateEmail(String? value) {
  final email = value?.trim() ?? '';
  if (email.isEmpty) return 'Informe o e-mail.';
  if (!RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(email)) {
    return 'Informe um e-mail válido.';
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) return 'Informe a senha.';
  if (value.length < 6) return 'A senha deve ter pelo menos 6 caracteres.';
  return null;
}
