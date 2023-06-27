import 'dart:io';

import 'package:abersoft/src/src.dart';
import 'package:dio/dio.dart';

part 'abersoft_repository.dart';

abstract class BaseAbersoftRepository {
  Future<bool> isLogged();
  Future<String?> login({
    required String username,
    required String password,
  });
  Future<Product?> addProduct({
    required String name,
    required String description,
    required File image,
  });
  Future<Product?> getListProduct();
}
