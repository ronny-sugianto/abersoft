import 'package:equatable/equatable.dart';

/// Base class for all models in the application
abstract class BaseModel extends Equatable {
  /// toJson converter
  Map<String, dynamic> toJson();

  /// copyWith converter
  BaseModel copyWith();

  @override
  List<Object?> get props => [];
}
