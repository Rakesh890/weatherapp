
import 'package:flutter/material.dart';

import '../../injectors/injector.dart';
import '../../presentation/screens/home/home.dart';

class Routes {
  static const String home = '/home';


  static Route<String> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) =>  HomeScreen());
      default:
        return MaterialPageRoute(builder: (_) =>  HomeScreen());
    }
  }
}
