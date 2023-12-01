import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/core/routings/routes.dart';
import 'package:weatherapp/presentation/blocs/splash/splash_cubit.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) => SplashCubit(),
      child: BlocBuilder<SplashCubit, SplashState>(
        builder: (context, state) {
          context.read<SplashCubit>().initializeData();
          if (state is SplashInitial) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: const Center(
                child: Text(
                  "My Weather",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
            );
          } else if (state is SplashFinished) {
           WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
               Navigator.pushReplacementNamed(context,Routes.home);

           });
          }
          return const SizedBox();
        },
      ),
    ));
  }
}
