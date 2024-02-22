import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lets_collect/src/bloc/home_bloc/home_bloc.dart';
import 'package:lets_collect/src/ui/home/components/widgets/custom_scroll_view_widget.dart';
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

  @override
  void initState() {
    super.initState();
   setState(() {
     ObjectFactory().prefs.isEmailVerifiedStatus() == true
         ? isDone = true
         : false;
   });
    // isDone = true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if(state is HomeLoaded) {
          if(  ObjectFactory().prefs.isEmailNotVerifiedStatus() == false
              ) {
            showDialog(
                context: context,
                builder: (BuildContext context) => const AlertOverlay());
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

          LoginCongratsCard(
            isDone: isDone,
          ),
          // LoginCongratsCard(
          //   isDone: isDone,
          //   emailVerifiedPoints: emailVerifiedPoints,
          // )
        ],
      ),
    );
  }
}
