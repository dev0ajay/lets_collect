import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_collect/src/utils/data/object_factory.dart';
import 'package:lets_collect/src/utils/screen_size/size_config.dart';
import '../../../../constants/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AlertOverlay extends StatefulWidget {
  const AlertOverlay({super.key});

  @override
  State<StatefulWidget> createState() => AlertOverlayState();
}

class AlertOverlayState extends State<AlertOverlay>
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
              height: getProportionateScreenHeight(300),
              decoration: ShapeDecoration(
                  color: AppColors.primaryWhiteColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0))),
              child: Column(
                children: <Widget>[
                  Expanded(
                      flex: 1,
                      child: Padding(
                        padding:
                        const EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
                        child: Text(
                          AppLocalizations.of(context)!.hurryup,
                          // "Hurry Up!",
                          style: GoogleFonts.openSans(
                            fontSize: 19,
                            fontWeight: FontWeight.w700,
                            color: AppColors.secondaryColor,
                          ),
                        ),
                      )),
                  Expanded(
                      flex: 2,
                      child: Padding(
                        padding:
                        const EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
                        child: Text(
                          AppLocalizations.of(context)!.pleaseverifythemailwehavesendtoyouandearnpoints,
                          // "Please verify the mail we have send to you and earn points.",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: AppColors.cardTextColor,
                          ),
                        ),
                      )),
                  Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ButtonTheme(
                              height: 35.0,
                              minWidth: 110.0,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.secondaryColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                ),
                                child:  Text(
                                  AppLocalizations.of(context)!.close,
                                  // 'Close',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.primaryWhiteColor,
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    ObjectFactory().prefs.setIsEmailNotVerifiedStatus(false);
                                    // ObjectFactory().prefs.setIsEmailNotVerifiedCalled(true);
                                  });
                                  context.pop();
                                },
                              ),
                            ),
                          ),
                        ],
                      ))
                ],
              )),
        ),
      ),
    );
  }
}