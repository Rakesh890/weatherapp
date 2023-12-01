import 'package:flutter/material.dart';
import 'package:weatherapp/presentation/screens/landing/landing.dart';
import 'package:weatherapp/presentation/screens/splash/splash.dart';

import '../../injectors/injector.dart';
import '../../presentation/screens/home/home.dart';

class Routes {
  static const String home = '/home';
  static const String landing = '/landing';
  static const String splash = '/splash';

  static Route<String> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case landing:
        return MaterialPageRoute(builder: (_) => const LandingScreen());
      default:
        return MaterialPageRoute(builder: (_) => const LandingScreen());
    }
  }
}
