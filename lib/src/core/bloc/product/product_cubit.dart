import 'dart:io';

import 'package:abersoft/src/src.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCubit extends Cubit<BaseState<Product>> {
  final BaseAbersoftRepository abersoftRepository;

  ProductCubit({
    required this.abersoftRepository,
  }) : super(InitializedState());

  void initialize() async {
    Product? product;

    emit(const LoadingState());

    try {
      product = await abersoftRepository.getListProduct();
    } catch (e) {
      emit(ErrorState(error: '$e'));
    }

    emit(LoadedState(data: product));
  }

  void upload({
    required String name,
    required String description,
    required File image,
  }) async {
    emit(const LoadingState());

    try {
      await abersoftRepository.addProduct(
        name: name,
        description: description,
        image: image,
      );
    } catch (e) {
      emit(ErrorState(error: '$e'));
    }

    emit(SuccessState());
  }
}
