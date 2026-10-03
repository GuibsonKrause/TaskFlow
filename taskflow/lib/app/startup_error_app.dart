// Importa os componentes visuais usados no feedback de inicialização.
import 'package:flutter/material.dart';

// Apresenta uma falha de inicialização sem expor detalhes técnicos ao usuário.
class StartupErrorApp extends StatelessWidget {
  // Permite criar a tela de falha como um widget constante.
  const StartupErrorApp({super.key});

  // Implementa a construção da interface de erro.
  @override
  Widget build(BuildContext context) {
    // Cria uma interface independente das dependências do aplicativo principal.
    return const MaterialApp(
      // Identifica o aplicativo durante a exibição do erro.
      title: 'TaskFlow',
      // Exibe uma página simples para informar a falha.
      home: Scaffold(
        // Respeita as áreas ocupadas pelos elementos do sistema.
        body: SafeArea(
          // Centraliza a mensagem na tela.
          child: Center(
            // Mantém o texto afastado das bordas.
            child: Padding(
              // Define a margem interna da mensagem.
              padding: EdgeInsets.all(24),
              // Mostra uma orientação sem revelar a exceção interna.
              child: Text(
                // Solicita uma nova abertura após resolver a falha.
                'Não foi possível iniciar o TaskFlow. Tente abrir o aplicativo novamente.',
                // Centraliza as linhas da mensagem.
                textAlign: TextAlign.center,
              ), // Encerra a mensagem.
            ), // Encerra o espaçamento.
          ), // Encerra a centralização.
        ), // Encerra a área segura.
      ), // Encerra a página de erro.
    ); // Encerra a aplicação de feedback.
  } // Encerra a construção da interface.
} // Encerra o widget de falha de inicialização.
