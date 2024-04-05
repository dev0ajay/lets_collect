import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../../constants/assets.dart';
import '../../../../../constants/colors.dart';

class ProgressIndicatorOverlay extends StatefulWidget {
  const ProgressIndicatorOverlay({super.key});

  @override
  State<StatefulWidget> createState() => ProgressIndicatorOverlayState();
}

class ProgressIndicatorOverlayState extends State<ProgressIndicatorOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  bool isEmailNotVerifyExecuted = false;

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
              // height: getProportionateScreenHeight(300),
              decoration: ShapeDecoration(
                  color: AppColors.primaryWhiteColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0))),
              child: Column(
                children: <Widget>[
                Center(
                  child: Lottie.asset(Assets.JUMBINGDOT),
              ),
                ],
              )),
        ),
      ),
    );
  }
}
