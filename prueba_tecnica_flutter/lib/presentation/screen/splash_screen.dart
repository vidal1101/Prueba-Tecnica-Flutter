import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:prueba_tecnica_flutter/presentation/screen/home_screen.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AnimatedSplashScreen(
      splashIconSize: double.infinity,
      backgroundColor: Colors.black,
      nextScreen: const HomeScreen(),
      duration: 2200,
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.fade,

      splash: _splashBody(size),
    );
  }

  Widget _splashBody(Size size) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          children: [
            SizedBox(height: size.height * 0.15),


            FadeIn(
              delay: const Duration(milliseconds: 400),
              child: const Text(
                "Prueba Técnica Flutter",
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),

        Positioned(
          bottom: size.height * 0.05,
          child: const Text(
            "Versión 1.0.0",
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
        )
      ],
    );
  }
}
