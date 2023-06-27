import 'package:abersoft/src/src.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticateCubit extends Cubit<BaseState> {
  final BaseAbersoftRepository abersoftRepository;

  AuthenticateCubit({
    required this.abersoftRepository,
  }) : super(InitializedState());

  void isLogged() async {
    emit(const LoadingState());

    try {
      bool isLogged = await abersoftRepository.isLogged();

      if (!isLogged) throw 'UnAuthenticated';
    } catch (e) {
      return emit(InitializedState());
    }

    return emit(SuccessState());
  }

  void login({
    required String username,
    required String password,
  }) async {
    emit(const LoadingState());

    try {
      await abersoftRepository.login(username: username, password: password);
    } catch (e) {
      return emit(InitializedState());
    }

    return emit(SuccessState());
  }
}
