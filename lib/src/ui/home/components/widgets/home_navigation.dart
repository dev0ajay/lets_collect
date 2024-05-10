import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lets_collect/src/ui/home/components/widgets/custom_scroll_view_widget.dart';
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
  Widget build(BuildContext context) {
    return Stack(
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
    );
  }
}
