import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lets_collect/src/utils/data/object_factory.dart';
import 'package:lets_collect/src/utils/screen_size/size_config.dart';

import '../../../constants/colors.dart';

class LogOutAlertOverlay extends StatefulWidget {
  const LogOutAlertOverlay({super.key});

  @override
  State<StatefulWidget> createState() => LogOutAlertOverlayState();
}

class LogOutAlertOverlayState extends State<LogOutAlertOverlay>
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

  Future<void> _signOut() async {
    GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
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
              height: 300,
              decoration: ShapeDecoration(
                  color: AppColors.primaryWhiteColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0))),
              child: Column(
                children: <Widget>[
                  Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 40.0, left: 20.0, right: 20.0),
                        child: Text(
                          "Are you sure you want to log out?",
                          style: GoogleFonts.openSans(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      )),
                  Flexible(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 30.0, left: 20.0, right: 20.0),
                        child: Row(
                          // mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                fixedSize: const Size(100, 40),
                                backgroundColor: AppColors.secondaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                ObjectFactory().prefs.setIsLoggedIn(false);
                                ObjectFactory().prefs.clearPrefs();
                                _signOut();
                                context.go('/login');
                              },
                              child: Text(
                                "Yes",
                                style: GoogleFonts.openSans(
                                  fontSize: 16,
                                  color: AppColors.primaryWhiteColor,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                fixedSize: const Size(100, 40),
                                backgroundColor: AppColors.secondaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                context.pop();
                              },
                              child: Text(
                                "No",
                                style: GoogleFonts.openSans(
                                  fontSize: 16,
                                  color: AppColors.primaryWhiteColor,
                                ),
                              ),
                            ),

                          ],
                        ),
                      )),
                ],
              )),
        ),
      ),
    );
  }
}
