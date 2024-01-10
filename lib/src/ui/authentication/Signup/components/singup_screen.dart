import 'package:flutter/material.dart';
import 'package:lets_collect/src/constants/colors.dart';
import 'package:lets_collect/src/ui/authentication/Signup/components/widget/firstscreen/singup_first_last_screen.dart';

class SignUp_screen extends StatefulWidget {
  const SignUp_screen({super.key});

  @override
  State<SignUp_screen> createState() => _SignUp_screenState();
}

class _SignUp_screenState extends State<SignUp_screen> {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.primaryColor,
      body:  SafeArea(child: SignupUiwidget1()),
    );
  }
}
