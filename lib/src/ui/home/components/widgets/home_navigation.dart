import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lets_collect/src/bloc/home_bloc/home_bloc.dart';
import 'package:lets_collect/src/ui/home/components/widgets/custom_scroll_view_widget.dart';
import 'package:lets_collect/src/ui/home/components/widgets/email_verified_alert_overlay.dart';
import 'package:lets_collect/src/utils/data/object_factory.dart';
import 'alert_overlay_widget.dart';
import 'login_congrats_card.dart';

class HomeScreenNavigation extends StatefulWidget {
  final Function(int) onIndexChanged;

  const HomeScreenNavigation({super.key, required this.onIndexChanged});

  @override
  State<HomeScreenNavigation> createState() => _HomeScreenNavigationState();
}

class _HomeScreenNavigationState extends State<HomeScreenNavigation> {
  int bottomNavIndex = 0;
  bool isDone = false;
  bool isEmailVerified = false;
  bool isEmailVerifyRewardExecuted = false;
  bool isEmailNotVerifyExecuted = false;

  late Timer? _timer;
  late String emailVerifiedPoints = "0";
  // void initializePrefs() {
  //   setState(() {
  //     ObjectFactory().prefs.setIsEmailVerifiedStatus(false);
  //     ObjectFactory().prefs.setIsEmailNotVerifiedCalled(true);
  //   });
  // }

  void callEmailNotVerified() {
    if(ObjectFactory().prefs.isEmailNotVerifiedStatus()! == true &&  ObjectFactory().prefs.isEmailNotVerifiedCalled()! == true) {
      showDialog(
        context: context,
        builder: (BuildContext context) =>
        const AlertOverlay(),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    isEmailNotVerifyExecuted = true;
    // initializePrefs();
    // setState(() {
    //   // ObjectFactory().prefs.setIsEmailNotVerifiedCalled(false);
    //   if( ObjectFactory().prefs.isEmailVerifiedStatus() == true && ObjectFactory().prefs.isEmailVerified() == true) {
    //     isDone = false;
    //   }else {
    //     isDone = true;
    //   }
    //
    //
    // });
    // isDone = true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is HomeLoaded) {
          if (state.homeResponse.emailVerified == 1) {
            ObjectFactory().prefs.setIsEmailVerified(true);
            ObjectFactory().prefs.isEmailVerified()! && !ObjectFactory().prefs.isEmailVerifiedStatus()!?
            showDialog(
              context: context,
              builder: (BuildContext context) =>
              const EmailVerifiedAlertOverlay()
            ) : const SizedBox();

          } else if (state.homeResponse.emailVerified == 0) {
            ObjectFactory().prefs.setIsEmailNotVerifiedStatus(true);
            if(isEmailNotVerifyExecuted == false) {
              callEmailNotVerified();
            }else {
              return;
            }
          }
        }
      },
      child: Stack(
        children: [
          CustomScrollViewWidget(
            onIndexChanged: (index) {
              widget.onIndexChanged(index);
            },
          ),

          // LoginCongratsCard(
          //   isDone: isDone,
          // ),
          // LoginCongratsCard(
          //   isDone: isDone,
          //   emailVerifiedPoints: emailVerifiedPoints,
          // )
        ],
      ),
    );
  }
}
