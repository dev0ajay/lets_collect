import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_collect/src/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:lets_collect/src/components/Custome_Textfiled.dart';
import 'package:lets_collect/src/components/my_button.dart';
import 'package:lets_collect/src/constants/assets.dart';
import 'package:lets_collect/src/constants/strings.dart';
import 'package:lets_collect/src/model/auth/forgot_password_email_model.dart';
import 'package:lets_collect/src/ui/forget_password/components/forgot_password%20arguments.dart';

import '../../../../constants/colors.dart';

class ForgetPasswordEmailWidget extends StatefulWidget {
  const ForgetPasswordEmailWidget({super.key});

  @override
  State<ForgetPasswordEmailWidget> createState() =>
      _ForgetPasswordEmailWidgetState();
}

class _ForgetPasswordEmailWidgetState extends State<ForgetPasswordEmailWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  FocusNode _emailFocus = FocusNode();

  String? validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value)) {
      return 'Enter a valid email address';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
        listener: (context, state) {
          if (state is ForgotPasswordLoaded) {
            if (state.forgotPasswordEmailRequestResponse.success == true) {
              context.push('/forgot_password_otp',extra: ForgotPasswordArguments(email: emailController.text),);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.forgotPasswordEmailRequestResponse.message,
                    style: const TextStyle(
                      color: AppColors.secondaryColor,
                    ),
                  ),
                  backgroundColor: AppColors.primaryColor,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                ),
              );
            } else if (state.forgotPasswordEmailRequestResponse.success ==
                false) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.forgotPasswordEmailRequestResponse.message,
                    style: const TextStyle(
                      color: AppColors.secondaryColor,
                    ),
                  ),
                  backgroundColor: AppColors.primaryWhiteColor,
                ),
              );
            }
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          color: Colors.white,
                          iconSize: 20,
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                          ),
                          // the method which is called
                          // when button is pressed
                          onPressed: () {
                            context.pop();
                          },
                        ),
                        Text(
                          Strings.FORGET_REST_PASSWORTD,
                          style: GoogleFonts.openSans(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryWhiteColor,
                          ),
                        ),
                        const Image(
                          image: AssetImage(Assets.APP_LOGO),
                          width: 40,
                          height: 40,
                          // fit: BoxFit.cover,
                        ),
                      ],
                    ).animate().then(delay: 200.ms).slideX(),
                    const SizedBox(
                      height: 60,
                    ),
                    Center(
                      child: Image.asset(
                        Assets.LOCK,
                        width: 100,
                        height: 100,
                      ),
                    )
                        .animate()
                        .then(delay: 200.ms)
                        .slideX()
                        .scale(
                          duration: const Duration(milliseconds: 300),
                        )
                        .then()
                        .shake(duration: const Duration(milliseconds: 300)),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                        child: Text(Strings.FORGOT_PASSWORD_DISCRIPTION,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.openSans(
                              fontSize: 16,
                              color: AppColors.primaryWhiteColor,
                            ))).animate().then(delay: 200.ms).slideX(),
                    const SizedBox(
                      height: 70,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 5, bottom: 15),
                        child: Text(Strings.FORGET_EMAIL_TEXT,
                            style: GoogleFonts.openSans(
                              fontSize: 16,
                              color: AppColors.primaryWhiteColor,
                            ))).animate().then(delay: 200.ms).slideX(),
                    MyTextField(
                      // horizontal: 20,
                      focusNode: _emailFocus,
                      hintText: Strings.FORGET_EMAIL_HINT,
                      obscureText: false,
                      maxLines: 1,
                      controller: emailController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        String? err = validateEmail(value);
                        if (err != null) {
                          _emailFocus.requestFocus();
                        }
                        return err;
                      },
                    ).animate().then(delay: 200.ms).slideX(),
                    const SizedBox(height: 100),
                    BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
                      builder: (context, state) {
                        if (state is ForgotPasswordLoading) {
                          return const Center(
                            child: RefreshProgressIndicator(
                              color: AppColors.primaryWhiteColor,
                              backgroundColor: AppColors.secondaryColor,
                            ),
                          );
                        }

                        return Center(
                          child: MyButton(
                            Textfontsize: 16,
                            TextColors: Colors.white,
                            text: Strings.OTP_BUTTON_TEXT,
                            color: AppColors.secondaryColor,
                            width: 340,
                            height: 40,
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                BlocProvider.of<ForgotPasswordBloc>(context)
                                    .add(
                                  ForgotPasswordEmailRequestEvent(
                                    forgotPasswordEmailRequest:
                                        ForgotPasswordEmailRequest(
                                            email: emailController.text),
                                  ),
                                );
                              } else {
                                Fluttertoast.showToast(
                                  msg: "Please enter the mail",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.black87,
                                  textColor: Colors.white,
                                );
                              }
                            },
                            showImage: false,
                            imagePath: '',
                            imagewidth: 0,
                            imageheight: 0,
                          ).animate().then(delay: 200.ms).slideX(),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
