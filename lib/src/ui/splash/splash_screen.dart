import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:lets_collect/src/model/notification/push_notification_model.dart';
import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../utils/api/firebase.dart';
import '../../utils/data/object_factory.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final splashDelay = 3;
  late final FirebaseMessaging _messaging;
  NotificationServices notificationServices = NotificationServices();
  PushNotification? _notificationInfo;


  _loadWidget() async {
    var duration = Duration(seconds: splashDelay);
    // registerNotification();
    // initializePrefs();
    return Timer(duration, navigationPage);
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

    super.initState();
    _loadWidget();
    notificationServices.requestNotificationPermission();
    notificationServices.forgroundMessage();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    // notificationServices.isTokenRefresh();

    notificationServices.getDeviceToken().then((value){
      if (kDebugMode) {
        print('device token');
        print(value);
      }
    });


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
                .fadeIn(
                  duration: const Duration(milliseconds: 900),
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

