// Importa os widgets e recursos do Material Design do Flutter.
import 'package:flutter/material.dart';
// Importa as extensões de navegação do go_router.
import 'package:go_router/go_router.dart';

// Declara a tela inicial que direciona o usuário para suas tarefas.
class HomeScreen extends StatelessWidget {
  // Cria a tela inicial e permite o recebimento opcional de uma chave.
  const HomeScreen({super.key});

  // Constrói a interface da tela inicial.
  @override
  Widget build(BuildContext context) {
    // Retorna a estrutura visual básica da página.
    return Scaffold(
      // Exibe o nome do aplicativo na barra superior.
      appBar: AppBar(title: const Text('TaskFlow')),
      // Centraliza o conteúdo de boas-vindas na tela.
      body: Center(
        // Organiza textos e botão verticalmente.
        child: Column(
          // Faz a coluna ocupar apenas o espaço necessário.
          mainAxisSize: MainAxisSize.min,
          // Declara os elementos apresentados na tela inicial.
          children: [
            // Exibe a saudação ao usuário.
            const Text(
              // Define o texto de boas-vindas.
              'Bem-vindo ao TaskFlow!',
              // Destaca visualmente o texto principal.
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ), // Encerra o texto de boas-vindas.
            // Adiciona espaço entre a saudação e a descrição.
            const SizedBox(height: 8),
            // Explica a finalidade do aplicativo.
            const Text('Organize suas tarefas de forma simples'),
            // Adiciona espaço antes do botão de navegação.
            const SizedBox(height: 24),
            // Cria o botão que abre a lista de tarefas.
            ElevatedButton(
              // Navega para a rota da lista usando o caminho, sem named route.
              onPressed: () => context.push('/tasks'),
              // Exibe o texto da ação disponível ao usuário.
              child: const Text('Ver tarefas'),
            ), // Encerra o botão de acesso à lista.
          ], // Encerra os elementos da coluna.
        ), // Encerra a coluna centralizada.
      ), // Encerra o conteúdo centralizado.
    ); // Encerra e retorna a página inicial.
  } // Encerra a construção da tela.
} // Encerra a declaração de HomeScreen.
