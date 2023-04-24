import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:math' as math;

import 'country_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _animationController =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 6), () {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const CountryStateList()));
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: AnimatedBuilder(
                    animation: _animationController,
                    child: Container(
                      decoration: const BoxDecoration(),
                      width: MediaQuery.of(context).size.width * .6,
                      // height: MediaQuery.of(context).size.height * .4,
                      child: const Image(
                          image: AssetImage("images/covid_virus.png")),
                    ),
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _animationController.value * 4.0 * math.pi,
                        child: child,
                      );
                    }),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .09,
              ),
              SizedBox(
                  // height: 20,
                  child: DefaultTextStyle(
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                ),
                child: Shimmer.fromColors(
                  direction: ShimmerDirection.ltr ,
                  baseColor: Colors.green.shade700,
                  highlightColor: Colors.green.shade100,
                  child: AnimatedTextKit(
                    animatedTexts: [
                      FadeAnimatedText('    Covid19\n Tracker App',
                          duration: const Duration(seconds: 5)),
                    ],
                  ),
                ),
              ))
            ]),
      ),
    );
  }
}
