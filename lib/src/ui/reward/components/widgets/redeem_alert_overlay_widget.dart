import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_collect/src/utils/screen_size/size_config.dart';

import '../../../../constants/colors.dart';
import '../../../scan/components/widgets/scan_screen_collect_button.dart';

class RedeemAlertOverlayWidget extends StatefulWidget {
  const RedeemAlertOverlayWidget({super.key});

  @override
  State<StatefulWidget> createState() => RedeemAlertOverlayWidgetState();
}

class RedeemAlertOverlayWidgetState extends State<RedeemAlertOverlayWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  final interval = const Duration(seconds: 1);
  final int timerMaxSeconds = 60;
  int currentSeconds = 0;

  String get timerText =>
      '${((timerMaxSeconds - currentSeconds) ~/ 60).toString().padLeft(2, '0')}: ${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0')}';

  bool isOneTime = false;

  startTimeout([int? milliseconds]) {
    var duration = interval;

    Timer.periodic(duration, (timer) {
      if (mounted) {
        setState(() {
          print(timer.tick);
          currentSeconds = timer.tick;
          if (timer.tick >= timerMaxSeconds) timer.cancel();
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
    startTimeout();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            margin: const EdgeInsets.all(20.0),
            padding: const EdgeInsets.all(15.0),
            height: getProportionateScreenHeight(450),
            decoration: ShapeDecoration(
                color: AppColors.primaryWhiteColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: const Icon(Icons.close),
                  ),
                ),
                // const SizedBox(height: 10),
                Center(
                  child: Image.network(
                    "https://images.unsplash.com/photo-1525904097878-94fb15835963?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                    height: 95,
                    width: 150,
                  ),
                ),
                // const SizedBox(height: 20),
                Text(
                  "Points Redeemed: 60 points",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.openSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                // const SizedBox(height: 10),
                Text(
                  "Remaining time",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  timerText,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.openSans(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  "Minutes",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                // SizedBox(height:30),
                const Align(
                  alignment: Alignment.bottomCenter,
                  child: ScanScreenCollectButton(text: "Redeem"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
