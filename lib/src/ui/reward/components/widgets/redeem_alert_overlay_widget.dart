import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_collect/src/bloc/redeem/redeem_bloc.dart';
import 'package:lets_collect/src/utils/screen_size/size_config.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../constants/assets.dart';
import '../../../../constants/colors.dart';
import '../../../scan/components/widgets/scan_screen_collect_button.dart';

class RedeemAlertOverlayWidget extends StatefulWidget {
  final String imageUrl;
  final String requiredPoints;
  final String qrUrl;
  const RedeemAlertOverlayWidget({super.key,required this.imageUrl,required this.requiredPoints,required this.qrUrl});

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
  String qrUrl = "";

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
          if (timer.tick >= timerMaxSeconds) {
            context.pop();
            context.pop();
          }
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
    print(widget.imageUrl);
    print(widget.requiredPoints);
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
      child: BlocConsumer<RedeemBloc, RedeemState>(
  listener: (context, state) {
    if(state is RedeemLoaded) {
      qrUrl = state.qrCodeUrlRequestResponse.data!.url!;
    }
  },
  builder: (context, state) {
    return Material(
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
                Expanded(
                  flex: 4,
                  child: Center(
                    child: CachedNetworkImage(
                      imageUrl:
                      widget.imageUrl,
                      fit: BoxFit.fill,
                      placeholder: (context, url) => Lottie.asset(Assets.JUMBINGDOT,height: 10,width: 10),
                      errorWidget: (context, url, error) => const ImageIcon(
                        size: 100,
                        color: AppColors.hintColor,
                        AssetImage(Assets.NO_IMG),),
                    ),
                  ),
                ),
                // const SizedBox(height: 20),
                Expanded(
                  flex: 2,
                  child: Text(
                    "Points get Redeemed: ${widget.requiredPoints} points",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                // const SizedBox(height: 10),
                Flexible(
                  flex: 1,
                  child: Text(
                    "Remaining time",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Text(
                    timerText,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                    ),
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
                 Expanded(
                  flex: 2,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                      onTap: () {
                          context.push('/qr_code');
                      },
                        child:  const ScanScreenCollectButton(text: "Redeem"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  },
),
    );
  }
}
