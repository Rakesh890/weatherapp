import 'package:flutter/material.dart';
import 'package:weatherapp/presentation/screens/landing/landing.dart';

import '../../injectors/injector.dart';
import '../../presentation/screens/home/home.dart';

class Routes {
  static const String home = '/home';
  static const String landing = '/landing';

  static Route<String> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case landing:
        return MaterialPageRoute(builder: (_) => const LandingScreen());
      default:
        return MaterialPageRoute(builder: (_) => const LandingScreen());
    }
  }
}
