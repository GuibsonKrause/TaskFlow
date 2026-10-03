# taskflow

Aplicativo de tarefas com Provider, go_router e dados em memória.

## Configurar Firebase no seu projeto

A inicialização usa `Firebase.initializeApp` e `DefaultFirebaseOptions.currentPlatform`, conforme a [documentação oficial](https://firebase.google.com/docs/flutter/setup).

O arquivo `lib/firebase_options.dart` atual foi gerado pelo FlutterFire CLI. Cada aluno que utilizar um projeto Firebase próprio deve executar `flutterfire configure` na sua cópia local para gerar as opções correspondentes. Não preencha chaves manualmente.

No terminal, dentro de `taskflow`, execute:

```powershell
firebase --version
dart pub global activate flutterfire_cli
firebase login
flutterfire configure
dart format .
flutter analyze
flutter run
```

Se Firebase CLI não estiver instalado, instale-o com `npm install -g firebase-tools` (requer Node.js compatível). Se `flutterfire` não for reconhecido no Windows, acrescente o diretório `bin` do Pub Cache ao PATH ou execute:

```powershell
dart pub global run flutterfire_cli:flutterfire configure
```

Selecione seu projeto Firebase e somente as plataformas que utilizará. Permita atualizar `lib/firebase_options.dart`. Preserve os identificadores Android/iOS existentes; o CLI fará a configuração das plataformas escolhidas. O `firebase_core` já foi adicionado ao projeto.

Após configurar, o Firebase precisa inicializar com sucesso antes de abrir o TaskFlow. Em caso de falha, o aplicativo mostra uma mensagem e registra o diagnóstico no console. Corrija a configuração indicada no diagnóstico e reinicie o app. As tarefas continuam em memória; a autenticação usa Firebase Authentication.

Os testes de widgets montam `TaskFlowApp` diretamente e não validam a conexão real com Firebase. Essa conexão deve ser verificada executando o aplicativo após `flutterfire configure`.

## Autenticação por e-mail e senha

No [Firebase Console](https://console.firebase.google.com/), abra o projeto conectado ao aplicativo. Em **Authentication > Sign-in method**, ative o provedor **E-mail/senha** e salve. Depois, dentro da pasta `taskflow`, atualize a configuração para o novo produto e reinicie o aplicativo:

```powershell
dart pub global run flutterfire_cli:flutterfire configure
flutter run
```

O aplicativo oferece cadastro, login, recuperação de senha e logout. As rotas de tarefas exigem uma sessão autenticada. As tarefas continuam em memória no dispositivo e ainda não são associadas ou sincronizadas por usuário; autenticação não substitui um banco de dados nem regras de acesso aos dados.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
