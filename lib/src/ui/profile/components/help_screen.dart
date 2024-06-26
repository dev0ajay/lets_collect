import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_collect/src/ui/profile/profile_screen.dart';
import 'package:lets_collect/src/utils/network_connectivity/bloc/network_bloc.dart';
import 'package:lets_collect/src/utils/screen_size/size_config.dart';
import 'package:lottie/lottie.dart';
import '../../../constants/assets.dart';
import '../../../constants/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  bool networkSuccess = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(

        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_outlined,
              color: AppColors.primaryWhiteColor,
            )),
        title: Text(
          AppLocalizations.of(context)!.helpcenter,
          // "Help Center",
          style: GoogleFonts.openSans(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryWhiteColor,
          ),
        ),

        actions: const [
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(right: 10),
              child: Text(
                "1.3.16+22",
                style: TextStyle(fontSize: 12),
              ),
            ),
          )
        ],
      ),
      body: BlocConsumer<NetworkBloc, NetworkState>(
        listener: (context, state) {
          if (state is NetworkSuccess) {
            networkSuccess = true;
          }
        },
        builder: (context, state) {
          if (state is NetworkSuccess) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
                child: Column(
                  children: [
                    Center(
                        child: SvgPicture.asset(
                      Assets.HELP_SVG,
                      fit: BoxFit.cover,
                      height: 200,
                    )),
                    const SizedBox(height: 35),
                    // InkWell(
                    //   onTap: () {
                    //     showDialog(
                    //       context: context,
                    //       builder: (BuildContext context) {
                    //         return AlertDialog(
                    //           shape: RoundedRectangleBorder(
                    //               borderRadius:
                    //               BorderRadius.circular(10)),
                    //           content: SizedBox(
                    //             height: getProportionateScreenHeight(260),
                    //             width: getProportionateScreenWidth(320),
                    //             child: Lottie.asset(Assets.SOON),
                    //           ),
                    //         );
                    //       },
                    //     );
                    //   },
                    //   child: const ProfileDetailsListTileWidget(
                    //       labelText: "How to redeem my points ?"),
                    // ),
                    GestureDetector(
                      onTap: () {
                        context.push('/how_to_redeem');
                      },
                      child: ProfileDetailsListTileWidget(
                        // labelText: "How to redeem my points ?"
                        labelText:
                            AppLocalizations.of(context)!.howtoredeemmypoints,
                      ),
                    ),
                    const SizedBox(height: 15),

                    GestureDetector(
                      onTap: () {
                        context.push('/point_calculation');
                      },
                      child: ProfileDetailsListTileWidget(
                        // labelText: "Point Calculations"
                        labelText:
                            AppLocalizations.of(context)!.pointcalculations,
                      ),
                    ),
                    const SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {
                        context.push('/terms_and_condition');
                      },
                      child: ProfileDetailsListTileWidget(
                        // labelText: "Terms and Conditions"
                        labelText:
                            AppLocalizations.of(context)!.termsandconditions,
                      ),
                    ),
                    const SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {
                        context.push('/privacy_policies');
                      },
                      child: ProfileDetailsListTileWidget(
                        // labelText: "Privacy policies"
                        labelText: AppLocalizations.of(context)!.privacypolicy,
                      ),
                    ),
                    const SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {
                        context.push('/contact_us');
                        print("contact_us tapped");
                      },
                      child: ProfileDetailsListTileWidget(
                        // labelText: "Need more help"
                        labelText: AppLocalizations.of(context)!.needmorehelp,
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is NetworkFailure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(Assets.NO_INTERNET),
                  Text(
                    "You are not connected to the internet",
                    style: GoogleFonts.openSans(
                      color: AppColors.primaryGrayColor,
                      fontSize: 20,
                    ),
                  ).animate().scale(delay: 200.ms, duration: 300.ms),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
