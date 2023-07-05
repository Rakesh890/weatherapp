import 'package:flutter/material.dart';
import 'package:weatherapp/core/routings/routes.dart';
import 'package:weatherapp/utils/colors.dart';
import 'injectors/injector.dart' as di;

void main() async {
  di.initDepInject();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'Flutter Demo',
      theme: ThemeData(
          useMaterial3: true, scaffoldBackgroundColor: AppColors.solid2Color),
      initialRoute: Routes.landing,
      onGenerateRoute: Routes.onGenerateRoute,
    );
  }
}
