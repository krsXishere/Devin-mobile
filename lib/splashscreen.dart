import 'package:devin/pages/intro_login.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Image.asset(
            'assets/png/logo_devin.png',
            height: 120,
            width: 120,
          ),
        ],
      ),
      backgroundColor: Colors.white,
      nextScreen: const OnBoardingScreen(),
      splashIconSize: 200,
      duration: 2000,
      splashTransition: SplashTransition.sizeTransition,
      pageTransitionType: PageTransitionType.leftToRightWithFade,
      animationDuration: const Duration(seconds: 1),
    );
  }
}
