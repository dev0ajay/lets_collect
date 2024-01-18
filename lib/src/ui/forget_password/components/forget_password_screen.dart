import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import 'widget/froget_password_email_screen.dart';

class Forget_password_screen extends StatefulWidget {
  const Forget_password_screen({super.key});

  @override
  State<Forget_password_screen> createState() => _Forget_password_screenState();
}

class _Forget_password_screenState extends State<Forget_password_screen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: ForgetPasswordEmailWidget(),
    );
  }
}
