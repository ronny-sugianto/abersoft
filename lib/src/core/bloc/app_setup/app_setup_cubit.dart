import 'package:abersoft/src/src.dart';
import 'package:alice/alice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppSetupCubit extends Cubit<BaseState<AppData>> {
  AppSetupCubit() : super(InitializedState());

  void initialize({
    required Alice alice,
  }) {
    emit(const LoadingState());
    GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

    try {
      alice.setNavigatorKey(navigatorKey);
    } catch (e) {
      return emit(ErrorState(error: '$e'));
    }

    emit(
      SuccessState(
        data: AppData(alice: alice, navigatorKey: navigatorKey),
      ),
    );
  }
}
