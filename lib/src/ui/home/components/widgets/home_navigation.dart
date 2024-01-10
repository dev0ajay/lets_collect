import 'dart:async';

import 'package:flutter/material.dart';
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
  bool isOneTime = false;
  late Timer? _timer;
  @override
  void initState() {
    // TODO: implement initState
    _timer = Timer(const Duration(milliseconds: 1000), () async {
      setState(() {
        isDone = true;
        isOneTime = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        CustomScrollViewWidget(),
        LoginCongratsCard(isDone: isDone),
      ],
    );
  }
}
