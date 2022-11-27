import 'dart:async';
import 'dart:developer';
import 'package:devin/common/theme.dart';
import 'package:devin/pages/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'intro_login.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  nextScreen() {
    var duration = const Duration(seconds: 5);
    return Timer(
      duration,
      route,
    );
  }

  route() async {
    int? isViewed;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    isViewed = preferences.getInt("onBoarding");
    log("isviewed: " + isViewed.toString());

    Navigator.pushReplacement(
      context,
      PageTransition(
        child: isViewed == 0 ? const OnBoardingScreen() : const DashboardPage(),
        type: PageTransitionType.rightToLeft,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    nextScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 300,
            ),
            SvgPicture.asset(
              "assets/svg/splash.svg",
            ),
            const Spacer(),
          ],
        ),
      ),
      bottomSheet: SizedBox(
        height: 400,
        width: double.infinity,
        child: WaveWidget(
          config: CustomConfig(
            gradients: [
              [primaryYellow, secondaryYellow],
              [secondaryYellow, primaryYellow],
            ],
            durations: [
              3500,
              5000,
            ],
            heightPercentages: [
              0.20,
              0.30,
            ],
          ),
          waveAmplitude: 0,
          size: const Size(
            double.infinity,
            400,
          ),
        ),
      ),
    );
  }
}
