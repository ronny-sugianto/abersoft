import 'package:abersoft/src/src.dart';
import 'package:alice/alice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InitializeApp extends StatelessWidget {
  final Alice alice;
  final BaseSharedPrefClient sharedPrefClient;
  final BaseApiClient apiClient;
  final BaseAbersoftRepository abersoftRepository;

  const InitializeApp({
    super.key,
    required this.alice,
    required this.sharedPrefClient,
    required this.apiClient,
    required this.abersoftRepository,
  });

  /// Will Place with MultiBlocProvider and MultiRepositoryProvider
  /// to make dependency injection

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AppSetupCubit()..initialize(alice: alice),
          ),
          BlocProvider(
            create: (context) => AuthenticateCubit(
              abersoftRepository: abersoftRepository,
            )..isLogged(),
          ),
        ],
        child: MultiRepositoryProvider(
          providers: [
            RepositoryProvider(create: (context) => sharedPrefClient),
            RepositoryProvider(create: (context) => apiClient),
            RepositoryProvider(create: (context) => abersoftRepository),
          ],
          child: const MainApp(),
        ),
      );
}
