import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:weatherapp/presentation/screens/home/home.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IndexedStack(
          children: [
            HomeScreen(),
          ],
        ),
        bottomNavigationBar: customBottomAppBar(context));
  }

  customBottomAppBar(BuildContext context) {
    return Container(
      width: 258,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0x7f7582f4),
          width: 0.50,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0xff7582f4),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
        gradient: const LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [Color(0xff262c51), Color(0xff3e3f74)],
        ),
      ),
    );
  }
}
