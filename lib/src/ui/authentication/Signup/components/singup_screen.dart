import 'package:flutter/material.dart';
import 'package:lets_collect/src/ui/authentication/Signup/components/widget/firstscreen/singup_first_screen.dart';

import '../../../../constants/colors.dart';

class SignUpScreen extends StatefulWidget {
  final String from;
  final String gmail;
  const SignUpScreen({super.key, required this.from,required this.gmail});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(child: SignUpFirstScreen(from: widget.from, gUserMail: widget.gmail,)),
    );
  }
}
