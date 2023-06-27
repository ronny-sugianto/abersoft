import 'package:abersoft/src/src.dart';
import 'package:alice/alice.dart';
import 'package:flutter/material.dart';

class AppData extends BaseModel {
  final Alice? alice;
  final GlobalKey<NavigatorState>? navigatorKey;

  AppData({this.alice, this.navigatorKey});

  @override
  BaseModel copyWith({
    Alice? alice,
    GlobalKey<NavigatorState>? navigatorKey,
  }) =>
      AppData(
        alice: alice ?? this.alice,
        navigatorKey: navigatorKey ?? this.navigatorKey,
      );

  @override
  Map<String, dynamic> toJson() => {
        'alice': alice,
        'navigatorKey': navigatorKey,
      };

  @override
  List<Object?> get props => [alice, navigatorKey];
}
