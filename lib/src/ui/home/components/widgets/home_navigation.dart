import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lets_collect/src/bloc/home_bloc/home_bloc.dart';
import 'package:lets_collect/src/ui/home/components/widgets/alert_overlay_widget.dart';
import 'package:lets_collect/src/ui/home/components/widgets/custom_scroll_view_widget.dart';
import 'login_congrats_card.dart';

class HomeScreenNavigation extends StatefulWidget {
  const HomeScreenNavigation({super.key});

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

  @override
  void initState() {

    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        const CustomScrollViewWidget(),
        BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            if(!isEmailVerifyRewardExecuted) {
              if (state is HomeLoaded) {
                if (state.homeResponse.emailVerificationPoints != 0 || state.homeResponse.emailVerificationPoints!.isGreaterThan(0)) {
                  setState(() {
                    isDone = true;
                    isEmailVerifyRewardExecuted = true;
                    emailVerifiedPoints =
                        state.homeResponse.emailVerificationPoints.toString();
                  });
                }

                if(isEmailNotVerifyExecuted) {
                  if (state.homeResponse.emailVerified == 0 && state.homeResponse.emailVerificationPoints == 0) {
                    setState(() {
                      isEmailNotVerifyExecuted = true;
                    });
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => const AlertOverlay());
                  }
                }

              }

            }
          },
          builder: (context, state) {
            return LoginCongratsCard(
              isDone: isDone,
              emailVerifiedPoints: emailVerifiedPoints,
            );
          },
        )
      ],
    );
  }
}
