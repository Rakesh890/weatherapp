import 'package:flutter/material.dart';
import 'package:weatherapp/core/routings/routes.dart';
import 'injectors/injector.dart' as di;

void main() async {
  await di.initDepInject();
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
          useMaterial3: true,
          primarySwatch: Colors.blue,
        ),
        initialRoute: Routes.home,
        onGenerateRoute: Routes.onGenerateRoute,);
  }
}
