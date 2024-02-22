import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../constants/strings.dart';
import '../../utils/data/object_factory.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}



class _SplashScreenState extends State<SplashScreen> {
  final splashDelay = 3;




  _loadWidget() async {
    var duration = Duration(seconds: splashDelay);
    registerNotification();
    return Timer(duration, navigationPage);
  }

  void registerNotification() {
    FirebaseMessaging fm = FirebaseMessaging.instance;
    fm.getToken().then((token) {
      print("token is $token");
      Strings.FCM = token ?? "";
      ObjectFactory().prefs.setFcmToken(token: token);
    });
  }

  void navigationPage() {
    if (mounted) {
      ObjectFactory().prefs.isLoggedIn()!
          ? context.go('/home')
          : context.go('/login');
    }
  }

  @override
  void initState() {
    _loadWidget();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
       color: AppColors.primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              Assets.SPLASH_LOGO,
              fit: BoxFit.cover,
              alignment: Alignment.center,
            )
                .animate()
                .fadeIn(duration: const Duration(milliseconds: 900),
            )
                .slideX(
                    duration: const Duration(
                      milliseconds: 500,
                    ),
                    curve: Curves.easeIn)
                .then()
                .shimmer(duration: const Duration(milliseconds: 800)),
          ),
        ],
      ),
    );
  }
}
