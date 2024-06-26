import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_collect/src/bloc/home_bloc/home_bloc.dart';
import 'package:lets_collect/src/utils/data/object_factory.dart';
import 'package:lets_collect/src/utils/screen_size/size_config.dart';
import '../../../../constants/assets.dart';
import '../../../../constants/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EmailVerifiedAlertOverlay extends StatefulWidget {
  const EmailVerifiedAlertOverlay({super.key});

  @override
  State<StatefulWidget> createState() => EmailVerifiedAlertOverlayState();
}

class EmailVerifiedAlertOverlayState extends State<EmailVerifiedAlertOverlay>
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
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoaded) {
          return Center(
            child: Material(
              color: Colors.transparent,
              child: ScaleTransition(
                scale: scaleAnimation,
                child: Container(
                  margin: const EdgeInsets.all(20.0),
                  padding: const EdgeInsets.all(15.0),
                  height: 350,
                  width: getProportionateScreenWidth(400),
                  decoration: ShapeDecoration(
                      color: AppColors.primaryWhiteColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0))),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Expanded(
                        flex: 4,
                          child: Image.asset(Assets.GIFT_ICON),
                      ),
                      const SizedBox(height: 10),
                      Flexible(
                        // flex: 1,
                        child: Text(
                          AppLocalizations.of(context)!.congratulations,
                          // "Congratulations !",
                          style: GoogleFonts.openSans(
                            color: AppColors.secondaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      Flexible(
                        // flex: 1,
                        child: Text(
                          AppLocalizations.of(context)!.youhaveearned,
                          // "You have earned",
                          style: GoogleFonts.roboto(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.cardTextColor,
                          ),
                        ),
                      ),
                      // const SizedBox(height: 10),

                      Expanded(
                        flex: 2,
                        child: Text(
                          state.homeResponse.emailVerificationPoints.toString(),
                          style: GoogleFonts.openSans(
                            color: AppColors.cardTextColor,
                            fontSize: 44,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      Flexible(
                        flex: 1,
                        child: Text(
                          AppLocalizations.of(context)!.points,
                          // "Points",
                          style: GoogleFonts.roboto(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.cardTextColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Flexible(
                        flex: 2,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            fixedSize: const Size(121, 36),
                            backgroundColor: AppColors.secondaryColor,
                          ),
                          onPressed: () {
                            context.pop();
                            ObjectFactory().prefs.setIsEmailVerified(false);
                          },
                          child: Text(
                            AppLocalizations.of(context)!.yay,
                            // "Yay!",
                            style: GoogleFonts.roboto(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColors.primaryWhiteColor,
                            ),
                          ),
                        ),
                      ),
                      // const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
