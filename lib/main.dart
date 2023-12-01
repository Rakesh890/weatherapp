import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/core/routings/routes.dart';
import 'package:weatherapp/presentation/blocs/home/home_bloc.dart';
import 'package:weatherapp/utils/colors.dart';
import 'injectors/injector.dart' as di;
import 'injectors/injector.dart';

void main() async {
  di.initDepInject();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeBloc(weatherUseCase: serviceLocator()),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: true,
        title: 'Flutter Demo',
        theme: ThemeData(
            useMaterial3: true, scaffoldBackgroundColor: AppColors.linearWeatherColorOne),
        initialRoute: Routes.home,
        onGenerateRoute: Routes.onGenerateRoute,
      ),
    );
  }
}
