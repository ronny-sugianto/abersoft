import 'package:abersoft/src/src.dart';
import 'package:alice/alice.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final alice = Alice(showNotification: true);

  BaseApiClient apiClient = ApiClient(alice: alice);
  BaseSharedPrefClient sharedPrefClient = SharedPrefClient.instance;

  BaseAbersoftRepository abersoftRepository = AbersoftRepository(
    sharedPrefClient: sharedPrefClient,
    apiClient: apiClient,
  );

  runApp(
    InitializeApp(
      alice: alice,
      sharedPrefClient: sharedPrefClient,
      apiClient: apiClient,
      abersoftRepository: abersoftRepository,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
