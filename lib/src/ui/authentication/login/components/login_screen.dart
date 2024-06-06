import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_collect/src/ui/authentication/login/components/widget/login_ui.dart';
import 'package:lets_collect/src/utils/network_connectivity/bloc/network_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../../../constants/assets.dart';
import '../../../../constants/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: BlocBuilder<NetworkBloc, NetworkState>(builder: (context, state) {
        if (state is NetworkSuccess) {
          return const SafeArea(
            child: LoginUiwidget(),
          );
        }
        if (state is NetworkFailure) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(Assets.NO_INTERNET),
                Text(
                  AppLocalizations.of(context)!.youarenotconnectedtotheinternet,
                  // "You are not connected to the internet",
                  style: GoogleFonts.openSans(
                    color: AppColors.primaryWhiteColor,
                    fontSize: 20,
                  ),
                ).animate().scale(delay: 200.ms, duration: 300.ms),
              ],
            ),
          );
        }
        return const SizedBox();
      }),
    );
  }
}
