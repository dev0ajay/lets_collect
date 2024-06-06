import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../../bloc/country_bloc/country_bloc.dart';
import '../../bloc/nationality_bloc/nationality_bloc.dart';
import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../constants/strings.dart';
import '../../utils/api/firebase.dart';
import '../../utils/data/object_factory.dart';
import '../../utils/network_connectivity/bloc/network_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final splashDelay = 3;
  NotificationServices notificationServices = NotificationServices();

  _loadWidget() async {
    var duration = Duration(seconds: splashDelay);
    return Timer(duration, navigationPage);
  }

  void navigationPage() {
    if (mounted) {
      ObjectFactory().prefs.isLoggedIn()!
          ? context.go('/home')
          : context.go('/login');
    }
  }

  ///Register Notification Service
  void registerNotification() {
    FirebaseMessaging fm = FirebaseMessaging.instance;
    fm.getToken().then((token) {
      print("token is $token");
      Strings.FCM = token ?? "";
      ObjectFactory().prefs.setFcmToken(token: token);
    });
  }

  @override
  void initState() {
    super.initState();
    registerNotification();
    _loadWidget();
    notificationServices.requestNotificationPermission();
    notificationServices.forgroundMessage();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices.getDeviceToken().then((value) {
    });
    BlocProvider.of<NationalityBloc>(context).add(GetNationality());
    BlocProvider.of<CountryBloc>(context).add(GetCountryEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworkBloc, NetworkState>(
      builder: (context, state) {
        if (state is NetworkSuccess) {
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
        } else if (state is NetworkFailure) {
          return Material(
            color: AppColors.primaryColor,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(Assets.NO_INTERNET),
                  Text(
                    AppLocalizations.of(context)!
                        .youarenotconnectedtotheinternet,
                    style: GoogleFonts.openSans(
                      color: AppColors.primaryGrayColor,
                      fontSize: 20,
                    ),
                  ).animate().scale(delay: 200.ms, duration: 300.ms),
                ],
              ),
            ),
          );
        } else if (state is NetworkInitial) {
          return Material(
            color: AppColors.primaryColor,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(Assets.NO_INTERNET),
                  Text(
                    AppLocalizations.of(context)!
                        .youarenotconnectedtotheinternet,
                    style: GoogleFonts.openSans(
                      color: AppColors.primaryGrayColor,
                      fontSize: 20,
                    ),
                  ).animate().scale(delay: 200.ms, duration: 300.ms),
                ],
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
