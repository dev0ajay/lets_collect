import 'package:email_validator/email_validator.dart';
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
import 'package:lets_collect/src/model/auth/forgot_password_email_model.dart';
import 'package:lets_collect/src/ui/forget_password/components/forgot_password%20arguments.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
  final FocusNode _emailFocus = FocusNode();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
      listener: (context, state) {
        if (state is ForgotPasswordLoadingNotFound) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.secondaryColor,
              content: Text(
                state.errorMsg,
                style: const TextStyle(color: AppColors.primaryWhiteColor),
              ),
            ),
          );
        }
        if (state is ForgotPasswordLoadingBadRequest) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.secondaryColor,
              content: Text(
                state.errorMsg,
                style: const TextStyle(color: AppColors.primaryWhiteColor),
              ),
            ),
          );
        }
        if (state is ForgotPasswordLoadingTimeOutError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.secondaryColor,
              content: Text(
                state.errorMsg,
                style: const TextStyle(color: AppColors.primaryWhiteColor),
              ),
            ),
          );
        }
        if (state is ForgotPasswordLoadingError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.secondaryColor,
              content: Text(
                state.errorMsg,
                style: const TextStyle(color: AppColors.primaryWhiteColor),
              ),
            ),
          );
        }
        if (state is ForgotPasswordLoaded) {
          if (state.forgotPasswordEmailRequestResponse.success == true) {
            context.push(
              '/forgot_password_otp',
              extra: ForgotPasswordArguments(email: emailController.text),
            );
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
                    height: 20
                  ),
                  Center(
                      child: Text(
                        AppLocalizations.of(context)!.donotworry,
                          // Strings.FORGOT_PASSWORD_DISCRIPTION,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.openSans(
                            fontSize: 16,
                            color: AppColors.primaryWhiteColor,
                          ))).animate().then(delay: 200.ms).slideX(),
                  const SizedBox(
                    height: 70,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 5, bottom: 15,right: 5),
                      child: Text(
                          AppLocalizations.of(context)!.emailaddress,
                          // Strings.FORGET_EMAIL_TEXT,
                          style: GoogleFonts.openSans(
                            fontSize: 16,
                            color: AppColors.primaryWhiteColor,
                          ))).animate().then(delay: 200.ms).slideX(),
                  MyTextField(
                    // horizontal: 20,
                    focusNode: _emailFocus,
                    hintText: AppLocalizations.of(context)!.enteryouremail,
                    // hintText: Strings.FORGET_EMAIL_HINT,
                    obscureText: false,
                    maxLines: 1,
                    controller: emailController,
                    keyboardType: TextInputType.text,
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
                          text: AppLocalizations.of(context)!.rest,
                          // text: Strings.OTP_BUTTON_SEND,
                          color: AppColors.secondaryColor,
                          width: 340,
                          height: 40,
                          onTap: () {
                            if (EmailValidator.validate(emailController.text)) {
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
                                msg: AppLocalizations.of(context)!.pleaseenteravalidmail,
                                // msg: "Please enter a valid mail.",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: AppColors.primaryWhiteColor,
                                textColor: AppColors.secondaryColor,
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
    );
  }
}
