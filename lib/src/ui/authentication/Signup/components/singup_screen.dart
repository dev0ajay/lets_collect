import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_collect/src/ui/authentication/Signup/components/widget/firstscreen/singup_first_screen.dart';
import 'package:lets_collect/src/utils/network_connectivity/bloc/network_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../../../constants/assets.dart';
import '../../../../constants/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpScreen extends StatefulWidget {
  final String from;
  final String gmail;

  const SignUpScreen({super.key, required this.from, required this.gmail});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: BlocConsumer<NetworkBloc, NetworkState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is NetworkInitial) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(Assets.NO_INTERNET),
                  Text(
                    // "You are not connected to the internet",
                    AppLocalizations.of(context)!
                        .youarenotconnectedtotheinternet,
                    style: GoogleFonts.openSans(
                      color: AppColors.primaryGrayColor,
                      fontSize: 20,
                    ),
                  ).animate().scale(delay: 200.ms, duration: 300.ms),
                ],
              ),
            );
          } else if (state is NetworkFailure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(Assets.NO_INTERNET),
                  Text(
                    // "You are not connected to the internet",
                    AppLocalizations.of(context)!
                        .youarenotconnectedtotheinternet,
                    style: GoogleFonts.openSans(
                      color: AppColors.primaryGrayColor,
                      fontSize: 20,
                    ),
                  ).animate().scale(delay: 200.ms, duration: 300.ms),
                ],
              ),
            );
          } else if (state is NetworkSuccess) {
            return SafeArea(
              child: SignUpFirstScreen(
                from: widget.from,
                gUserMail: widget.gmail,
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
