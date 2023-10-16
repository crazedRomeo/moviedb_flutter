import 'package:flutter/material.dart';
import 'package:test/views/dashboard.dart';
import 'package:test/views/home.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/index':
        return MaterialPageRoute(builder: (_) => DashboardScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      default:
        return MaterialPageRoute(builder: (_) => HomeScreen());
    }
  }
}
