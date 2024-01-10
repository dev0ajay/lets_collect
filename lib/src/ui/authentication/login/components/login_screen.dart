import 'package:flutter/material.dart';
import 'package:lets_collect/src/ui/authentication/login/components/widget/login_ui.dart';
import '../../../../constants/colors.dart';

class Login_screen extends StatefulWidget {
  const Login_screen({super.key});

  @override
  State<Login_screen> createState() => _Login_screenState();
}

class _Login_screenState extends State<Login_screen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(child: LoginUiwidget()),
    );
  }
}
