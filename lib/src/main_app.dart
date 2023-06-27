import 'package:abersoft/src/src.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) =>
      BlocBuilder<AppSetupCubit, BaseState<AppData>>(
        builder: (context, state) {
          if (state is SuccessState && state.data?.navigatorKey != null) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              navigatorKey: state.data?.navigatorKey,
              initialRoute: RouteName.loginScreen,
              onGenerateRoute: AppRouter().onGenerateRoute,
              theme: ThemeData(
                useMaterial3: true,
                colorSchemeSeed: Colors.transparent,
              ),
              builder: (context, child) =>
                  BlocListener<AuthenticateCubit, BaseState>(
                listener: (context, authState) {
                  if (authState is SuccessState) {
                    state.data?.navigatorKey?.currentState!
                        .pushNamedAndRemoveUntil(
                      RouteName.homeScreen,
                      (route) => false,
                    );
                  }
                },
                child: child!,
              ),
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      );
}
