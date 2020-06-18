import 'package:flutter/material.dart';

class NavigationService {
  final navigatorKey = GlobalKey<NavigatorState>();
  static NavigationService _singleton;

  NavigationService._();

  factory NavigationService() {
    if (_singleton == null) _singleton = NavigationService._();

    return _singleton;
  }

  Future<dynamic> forceNamedRoute(String routeName) => navigatorKey.currentState
      .pushNamedAndRemoveUntil(routeName, (route) => false);

  Future<dynamic> pushNamedRoute(String routeName) =>
      navigatorKey.currentState.pushNamed(routeName);

  Future<dynamic> replaceNamedRoute(String routeName) =>
      navigatorKey.currentState.pushReplacementNamed(routeName);
}
