import 'package:flutter/material.dart';
import 'package:lets_collect/src/ui/authentication/Signup/components/widget/firstscreen/singup_first_last_screen.dart';

import '../../../../constants/colors.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(child: SignupUiwidget1()),
    );
  }
}
