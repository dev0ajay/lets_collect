import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../constants/assets.dart';
import '../../../constants/colors.dart';
import '../../../constants/strings.dart';
import 'widget/froget_password_email_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        leading: IconButton(
          color: Colors.white,
          iconSize: 20,
          icon: const Icon(
            Icons.arrow_back_ios_new,
          ),
          onPressed: () {
            context.pop();
          },
        ),
        title: Text(
          AppLocalizations.of(context)!.forgetpassword,
          // Strings.FORGET_REST_PASSWORTD,
          style: GoogleFonts.openSans(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryWhiteColor,
          ),
        ).animate().then(delay: 200.ms).slideX(),
        actions:  [
          const Image(
            image: AssetImage(Assets.APP_LOGO),
            width: 40,
            height: 40,
// fit: BoxFit.cover,
          ).animate().then(delay: 200.ms).slideX(),
        ],
      ),
      backgroundColor: AppColors.primaryColor,
      body: const ForgetPasswordEmailWidget(),
    );
  }
}
