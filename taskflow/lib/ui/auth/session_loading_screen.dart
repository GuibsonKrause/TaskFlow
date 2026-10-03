import 'package:flutter/material.dart';

/// Impede mostrar rotas protegidas antes da primeira resposta da sessão.
class SessionLoadingScreen extends StatelessWidget {
  const SessionLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: CircularProgressIndicator()));
}
