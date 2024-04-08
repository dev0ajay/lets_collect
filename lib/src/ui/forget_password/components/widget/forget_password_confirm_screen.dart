import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_collect/language.dart';
import 'package:lets_collect/src/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:lets_collect/src/bloc/language/language_bloc.dart';
import 'package:lets_collect/src/components/Custome_Textfiled.dart';
import 'package:lets_collect/src/components/my_button.dart';
import 'package:lets_collect/src/constants/assets.dart';
import 'package:lets_collect/src/constants/colors.dart';
import 'package:lets_collect/src/model/auth/forgot_password_reset_request.dart';
import 'package:lottie/lottie.dart';
import '../../../../utils/data/object_factory.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../utils/network_connectivity/bloc/network_bloc.dart';

class ForgetPasswordConfirmScreen extends StatefulWidget {
  const ForgetPasswordConfirmScreen({super.key});

  @override
  State<ForgetPasswordConfirmScreen> createState() =>
      _ForgetPasswordConfirmScreenState();
}

class _ForgetPasswordConfirmScreenState
    extends State<ForgetPasswordConfirmScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final FocusNode _passFocus = FocusNode();
  final FocusNode _repassFocus = FocusNode();

  String? validatePassword(String? value) {
    String pattern =
        r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.pleaseenterpassword;
      // return 'Please enter password';
    }
    if (value.length < 8) {
      return AppLocalizations.of(context)!.lengthshouldbe;
      // return "Length should be 8 or more";
    }
    if (!regex.hasMatch(value)) {
      return AppLocalizations.of(context)!.mustcontainatleast;
      // return "Must contain at least 1 uppercase, 1 lowercase, 1 special character";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
        listener: (context, state) {
          if (state is ForgotPasswordResetLoaded) {
            if (state.forgotPasswordResetRequestResponse.success == true) {
              context.pushReplacement('/login');
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    context.read<LanguageBloc>().state.selectedLanguage ==
                            Language.english
                        ? state.forgotPasswordResetRequestResponse.message
                        : state
                            .forgotPasswordResetRequestResponse.messageArabic,
                  ),
                ),
              );
            } else if (state.forgotPasswordResetRequestResponse.success ==
                false) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    context.read<LanguageBloc>().state.selectedLanguage ==
                            Language.english
                        ? state.forgotPasswordResetRequestResponse.message
                        : state
                            .forgotPasswordResetRequestResponse.messageArabic,
                  ),
                ),
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.primaryColor3,
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
                                  color: AppColors.primaryWhiteColor,
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
                                  AppLocalizations.of(context)!.resetpassword,
                                  // Strings.FORGET_REST_PASSWORTD,
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
                                ),
                              ],
                            ).animate().then(delay: 200.ms).slideX(),
                            const SizedBox(
                              height: 60,
                            ),
                            Center(
                                child: Lottie.asset(Assets.RESET,
                                    height: 150, width: 190)),
                            const SizedBox(
                              height: 20,
                            ),
                            Center(
                                child: Text(
                              AppLocalizations.of(context)!.passwordreset,
                              // Strings.FORGET_PASSWORD_RESET,
                              style: const TextStyle(
                                  color: AppColors.primaryWhiteColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            )).animate().then(delay: 200.ms).slideX(),
                            const SizedBox(
                              height: 70,
                            ),
                            Padding(
                                padding:
                                    const EdgeInsets.only(left: 5, bottom: 5),
                                child: Text(
                                  AppLocalizations.of(context)!.newpassword,
                                  // Strings.FORGET_NEW_PASSWORD,
                                  style: const TextStyle(
                                      color: AppColors.primaryWhiteColor,
                                      fontSize: 15),
                                )).animate().then(delay: 200.ms).slideX(),
                            MyTextField(
                              // horizontal: 20,
                              focusNode: _passFocus,
                              hintText: AppLocalizations.of(context)!
                                  .pleaseenterpassword,
                              // hintText: Strings.FORGET_NEW_PASSWORD_HINT,
                              obscureText: true,
                              maxLines: 1,
                              controller: newPasswordController,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                String? err = validatePassword(value);
                                if (err != null) {
                                  _passFocus.requestFocus();
                                }
                                return err;
                              },
                            ).animate().then(delay: 200.ms).slideX(),
                            const SizedBox(
                              height: 30,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 5, bottom: 5),
                              child: Text(
                                AppLocalizations.of(context)!.confirmpassword,
                                // Strings.FORGET_CONFIRM_PASSWORD,
                                style: const TextStyle(
                                    color: AppColors.primaryWhiteColor,
                                    fontSize: 15),
                              ),
                            ).animate().then(delay: 200.ms).slideX(),
                            MyTextField(
                              // horizontal: 20,
                              focusNode: _repassFocus,
                              hintText:
                                  AppLocalizations.of(context)!.reentepassword,
                              // hintText: Strings.FORGET_CONFIRM_PASSWORD_HINT,
                              obscureText: true,
                              maxLines: 1,
                              controller: confirmPasswordController,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                String? err = validatePassword(value);
                                if (err != null) {
                                  _repassFocus.requestFocus();
                                }
                                return err;
                              },
                            ).animate().then(delay: 200.ms).slideX(),
                            const SizedBox(
                              height: 50,
                            ),
                            Center(
                              child: BlocBuilder<ForgotPasswordBloc,
                                  ForgotPasswordState>(
                                builder: (context, state) {
                                  if (state is ForgotPasswordResetLoading) {
                                    return const RefreshProgressIndicator(
                                      color: AppColors.primaryWhiteColor,
                                      backgroundColor:
                                          AppColors.secondaryButtonColor,
                                    );
                                  }
                                  return MyButton(
                                    Textfontsize: 16,
                                    TextColors: AppColors.primaryWhiteColor,
                                    // text: Strings.BUTTON_VERIFICATION,
                                    text: AppLocalizations.of(context)!.verify,
                                    color: AppColors.secondaryColor,
                                    width: 340,
                                    height: 40,
                                    onTap: () {
                                      print(
                                          ObjectFactory().prefs.getAuthToken());
                                      if (_formKey.currentState!.validate()) {
                                        BlocProvider.of<ForgotPasswordBloc>(
                                                context)
                                            .add(
                                          ForgotPasswordResetRequestEvent(
                                              forgotPasswordResetRequest:
                                                  ForgotPasswordResetRequest(
                                            password:
                                                newPasswordController.text,
                                            passwordConfirmation:
                                                confirmPasswordController.text,
                                          )),
                                        );
                                      } else {
                                        Fluttertoast.showToast(
                                          msg: AppLocalizations.of(context)!
                                              .allfieldsareimportant,
                                          // msg: "All fields are important",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          backgroundColor:
                                              AppColors.secondaryColor,
                                          textColor:
                                              AppColors.primaryWhiteColor,
                                        );
                                      }
                                    },
                                    showImage: false,
                                    imagePath: '',
                                    imagewidth: 0,
                                    imageheight: 0,
                                  );
                                },
                              ).animate().then(delay: 200.ms).slideX(),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          );
        },
      ),
    );
  }
}
