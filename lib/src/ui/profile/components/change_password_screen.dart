import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_collect/language.dart';
import 'package:lets_collect/src/bloc/change_password_bloc/change_password_bloc.dart';
import 'package:lets_collect/src/bloc/language/language_bloc.dart';
import 'package:lets_collect/src/components/Custome_Textfiled.dart';
import 'package:lets_collect/src/components/my_button.dart';
import 'package:lets_collect/src/constants/assets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lets_collect/src/model/change_password/change_password_request.dart';
import 'package:lets_collect/src/utils/network_connectivity/bloc/network_bloc.dart';
import 'package:lets_collect/src/utils/screen_size/size_config.dart';
import 'package:lottie/lottie.dart';

import '../../../constants/colors.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool networkSuccess = false;
  TextEditingController currentPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController confirmNewPassController = TextEditingController();

  final FocusNode _currentPassFocus = FocusNode();
  final FocusNode _newPassFocus = FocusNode();
  final FocusNode _confirmNewPassFocus = FocusNode();

  bool passwordConfirmed() {
    if (newPassController.text.trim() == confirmNewPassController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  String? validatePassword(String? value) {
    String pattern =
        r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty) {
      // return 'Please enter password';
      return AppLocalizations.of(context)!.pleaseenterpassword;
    }
    if (value.length < 8) {
      // return "Length should be 8 or more";
      return AppLocalizations.of(context)!.lengthshouldbe;
    }
    if (!regex.hasMatch(value)) {
      return AppLocalizations.of(context)!.mustcontainatleast;
      // return "Must contain at least 1 uppercase, 1 lowercase, 1 special character";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          color: AppColors.primaryWhiteColor,
          iconSize: 20,
          icon: const Icon(
            Icons.arrow_back_ios_new,
          ),
          onPressed: () {
            context.pop();
          },
        ),
        title: Text(
          AppLocalizations.of(context)!.changepassword,
          // "Change Password",
          style: GoogleFonts.openSans(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryWhiteColor,
          ),
        ),
        actions: const [
          Padding(
            padding:  EdgeInsets.only(right: 20.0),
            child:  Image(
              image: AssetImage(Assets.APP_LOGO),
              width: 40,
              height: 40,
              // fit: BoxFit.cover,
            ),
          ),
        ],
      ),
      backgroundColor: AppColors.primaryColor,
      body: BlocConsumer<NetworkBloc, NetworkState>(
        listener: (context, state) {
          if (state is NetworkSuccess) {
            networkSuccess = true;
          }
        },
        builder: (context, state) {
          if(state is NetworkSuccess){
            return BlocConsumer<ChangePasswordBloc, ChangePasswordState>(
              listener: (context, state) {
                if (state is ChangePasswordLoaded) {
                  if (state.changePasswordRequestResponse.success == true &&
                      state.changePasswordRequestResponse.message ==
                          "Password changed successfully.") {
                    _showDialogBox(context: context);
                  }
                }
                if (state is ChangePasswordLoaded) {
                  if (state.changePasswordRequestResponse.success == false &&
                      state.changePasswordRequestResponse.message ==
                          "Invalid password.") {
                    _showDialogBox(context: context);
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
                              .scale(
                            duration: const Duration(milliseconds: 300),
                          )
                              .then()
                              .shake(duration: const Duration(milliseconds: 300)),
                          const SizedBox(height: 20),
                          Flexible(
                            flex: 0,
                            child: Center(
                                child: Text(
                                    AppLocalizations.of(context)!.donotworrywewillhelpyouchangepassword,
                                    // "Do not Worry! We will help you change password.",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.openSans(
                                      fontSize: 16,
                                      color: AppColors.primaryWhiteColor,
                                    )).animate()
                                    .then(delay: 200.ms)
                                    .scale(
                                  duration: const Duration(milliseconds: 300),
                                )
                                    .then()
                                    .shake(duration: const Duration(milliseconds: 300))),
                          ),
                          const SizedBox(
                            height: 70,
                          ),
                          Flexible(
                            flex: 0,
                            child: Padding(
                                padding: const EdgeInsets.only(left: 5, bottom: 10),
                                child: Text(
                                    AppLocalizations.of(context)!.currentpassword,
                                    // "Current Password",
                                    style: GoogleFonts.openSans(
                                      fontSize: 16,
                                      color: AppColors.primaryWhiteColor,
                                    ))).animate()
                                .then(delay: 200.ms)
                                .scale(
                              duration: const Duration(milliseconds: 300),
                            )
                                .then()
                                .shake(duration: const Duration(milliseconds: 300)),
                          ),
                          Expanded(
                            flex: 0,
                            child: MyTextField(
                              // horizontal: 20,
                              focusNode: _currentPassFocus,
                              hintText: AppLocalizations.of(context)!.entercurrentpassword,
                              // hintText: "Enter Current Password",
                              obscureText: false,
                              maxLines: 1,
                              controller: currentPassController,
                              keyboardType: TextInputType.text,
                            ).animate()
                                .then(delay: 200.ms)
                                .scale(
                              duration: const Duration(milliseconds: 300),
                            )
                                .then()
                                .shake(duration: const Duration(milliseconds: 300)),
                          ),
                          Flexible(
                            flex: 0,
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 10, bottom: 10),
                                child: Text(
                                    AppLocalizations.of(context)!.newpassword,
                                    // "New Password",
                                    style: GoogleFonts.openSans(
                                      fontSize: 16,
                                      color: AppColors.primaryWhiteColor,
                                    ))).animate()
                                .then(delay: 200.ms)
                            // .slideX()
                                .scale(
                              duration: const Duration(milliseconds: 300),
                            )
                                .then()
                                .shake(duration: const Duration(milliseconds: 300)),
                          ),
                          Expanded(
                            flex: 0,
                            child: MyTextField(
                              focusNode: _newPassFocus,
                              hintText: AppLocalizations.of(context)!.enternewpassword,
                              obscureText: false,
                              maxLines: 1,
                              controller: newPassController,
                              keyboardType: TextInputType.text,
                            ).animate()
                                .then(delay: 200.ms)
                            // .slideX()
                                .scale(
                              duration: const Duration(milliseconds: 300),
                            )
                                .then()
                                .shake(duration: const Duration(milliseconds: 300)),
                          ),
                          Flexible(
                            flex: 0,
                            child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 10, bottom: 10),
                                child: Text(
                                    AppLocalizations.of(context)!.reenternewpassword,
                                    // " Re-enter New Password",
                                    style: GoogleFonts.openSans(
                                      fontSize: 16,
                                      color: AppColors.primaryWhiteColor,
                                    ))).animate()
                                .then(delay: 200.ms)
                                .scale(
                              duration: const Duration(milliseconds: 300),
                            )
                                .then()
                                .shake(duration: const Duration(milliseconds: 300)),
                          ),
                          Expanded(
                            flex: 0,
                            child: MyTextField(
                              // horizontal: 20,
                              focusNode: _confirmNewPassFocus,
                              hintText: AppLocalizations.of(context)!.enternewpassword,
                              obscureText: false,
                              maxLines: 1,
                              controller: confirmNewPassController,
                              keyboardType: TextInputType.text,
                            ).animate()
                                .then(delay: 200.ms)
                            // .slideX()
                                .scale(
                              duration: const Duration(milliseconds: 300),
                            )
                                .then()
                                .shake(duration: const Duration(milliseconds: 300)),
                          ),
                          const SizedBox(height: 100),
                          BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
                            builder: (context, state) {
                              if (state is ChangePasswordLoading) {
                                return const Center(
                                  child: RefreshProgressIndicator(
                                    color: AppColors.primaryWhiteColor,
                                    backgroundColor:
                                    AppColors.secondaryColor,
                                  ),
                                );
                              }
                              return Center(
                                child: MyButton(
                                  Textfontsize: 16,
                                  TextColors: AppColors.primaryWhiteColor,
                                  text: AppLocalizations.of(context)!.submit,
                                  // text: "Submit",
                                  color: AppColors.secondaryColor,
                                  width: 340,
                                  height: 40,
                                  onTap: () {
                                    String? passwordError =
                                    validatePassword(newPassController.text);

                                    // Check if passwords match
                                    if (newPassController.text !=
                                        confirmNewPassController.text) {
                                      Fluttertoast.showToast(
                                        msg: AppLocalizations.of(context)!.newpasswordandconfirmpassworddonotmatch,
                                        // msg: "New password and confirm password do not match",
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM,
                                        backgroundColor: AppColors.secondaryColor,
                                        textColor: AppColors.primaryWhiteColor,
                                      );
                                      return; // Exit early if passwords don't match
                                    }

                                    // Check if any field is empty or if there's a validation error
                                    if (currentPassController.text.isEmpty ||
                                        newPassController.text.isEmpty ||
                                        passwordError != null ||
                                        confirmNewPassController.text.isEmpty) {
                                      Fluttertoast.showToast(
                                        msg: AppLocalizations.of(context)!
                                            .allfieldsareimportant,
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM,
                                        backgroundColor: AppColors.secondaryColor,
                                        textColor: AppColors.primaryWhiteColor,
                                      );
                                      return; // Exit early if any field is empty or validation fails
                                    }

                                    if (_formKey.currentState!.validate()) {
                                      BlocProvider.of<ChangePasswordBloc>(context)
                                          .add(
                                        GetChangePasswordEvent(
                                          changePasswordRequest:
                                          ChangePasswordRequest(
                                            oldPassword: currentPassController.text.toString(),
                                            newPassword: newPassController.text.toString(),
                                            confirmPassword:
                                            confirmNewPassController.text.toString(),
                                          ),
                                        ),
                                      );
                                      print("Current Pass = $currentPassController");
                                      print("New Pass = $newPassController");
                                      print(
                                          "Confirm Pass = $confirmNewPassController");
                                    } else {
                                      Fluttertoast.showToast(
                                        msg: AppLocalizations.of(context)!
                                            .allfieldsareimportant,
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM,
                                        backgroundColor: AppColors.secondaryColor,
                                        textColor: AppColors.primaryWhiteColor,
                                      );
                                    }
                                  },
                                  showImage: false,
                                  imagePath: '',
                                  imagewidth: 0,
                                  imageheight: 0,
                                ).animate()
                                    .then(delay: 200.ms)
                                // .slideX()
                                    .scale(
                                  duration: const Duration(milliseconds: 300),
                                )
                                    .then()
                                    .shake(duration: const Duration(milliseconds: 300)),
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
          else if (state is NetworkFailure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(Assets.NO_INTERNET),
                  Text(
                    AppLocalizations.of(context)!.youarenotconnectedtotheinternet,
                    style: GoogleFonts.openSans(
                      color: AppColors.primaryGrayColor,
                      fontSize: 20,
                    ),
                  ).animate().scale(delay: 200.ms, duration: 300.ms),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  void _showDialogBox({
    required BuildContext context,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
            builder: (context, state) {
              if (state is ChangePasswordLoaded) {
                if (state.changePasswordRequestResponse.success == true &&
                    state.changePasswordRequestResponse.message ==
                        "Password changed successfully.") {
                  return AlertDialog(
                    backgroundColor: AppColors.primaryWhiteColor,
                    elevation: 5,
                    alignment: Alignment.center,
                    content: SizedBox(
                      height: getProportionateScreenHeight(230),
                      width: getProportionateScreenWidth(500),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: IconButton(
                              onPressed: () {
                                currentPassController.clear();
                                newPassController.clear();
                                confirmNewPassController.clear();
                                context.pop();
                                // Navigator.of(context).pop();
                              },
                              icon: const Icon(Icons.close),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            context.read<LanguageBloc>().state.selectedLanguage ==
                                Language.english
                                ? state.changePasswordRequestResponse.message
                                : state.changePasswordRequestResponse.messageArabic,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.openSans(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: AppColors.secondaryColor,
                            ),
                          ),
                          const SizedBox(height: 30),
                          Text(
                            AppLocalizations.of(context)!.congratulations,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.openSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.only(left: 50, right: 50),
                            child: MyButton(
                              Textfontsize: 16,
                              TextColors: Colors.white,
                              // text: "Ok",
                              text: AppLocalizations.of(context)!.ok,
                              color: AppColors.secondaryColor,
                              height: 40,
                              // Adjust the height as needed
                              onTap: () {
                                currentPassController.clear();
                                newPassController.clear();
                                confirmNewPassController.clear();
                                context.pop();
                              },
                              showImage: false,
                              imagePath: '',
                              imagewidth: 0,
                              imageheight: 0,
                              width: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  if (state.changePasswordRequestResponse.success == false &&
                      state.changePasswordRequestResponse.message ==
                          "Invalid password.") {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: AppColors.primaryWhiteColor,
                      elevation: 5,
                      alignment: Alignment.center,
                      content: SizedBox(
                        height: getProportionateScreenHeight(260),
                        width: getProportionateScreenWidth(320),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: IconButton(
                                onPressed: () {
                                  currentPassController.clear();
                                  newPassController.clear();
                                  confirmNewPassController.clear();
                                  context.pop();
                                },
                                icon: const Icon(Icons.close),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Flexible(
                              flex: 3,
                              child: Center(
                                child: Image.asset(
                                  Assets.APP_LOGO,
                                  height: 95,
                                  width: 150,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Flexible(
                              flex: 2,
                              child: Text(
                                context
                                    .read<LanguageBloc>()
                                    .state
                                    .selectedLanguage ==
                                    Language.english
                                    ? state.changePasswordRequestResponse.message
                                    : state.changePasswordRequestResponse
                                    .messageArabic,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.openSans(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Flexible(
                              flex: 1,
                              child: Text(
                                AppLocalizations.of(context)!.thankyou,
                                // "Thank You !",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.roboto(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            MyButton(
                                text: AppLocalizations.of(context)!.ok,
                                color: AppColors.secondaryColor,
                                width: 200,
                                height: 30,
                                onTap: () {
                                  currentPassController.clear();
                                  newPassController.clear();
                                  confirmNewPassController.clear();
                                  context.pop();
                                },
                                TextColors: AppColors.primaryWhiteColor,
                                Textfontsize: 16,
                                showImage: false,
                                imagePath: "",
                                imagewidth: 0,
                                imageheight: 0)
                            // Flexible(
                            //   flex: 3,
                            //   child: Lottie.asset(Assets.SCANING),
                            // ),
                          ],
                        ),
                      ),
                    );
                  }
                }
              }
              if (state is ChangePasswordError) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: AppColors.primaryWhiteColor,
                  elevation: 5,
                  alignment: Alignment.center,
                  content: SizedBox(
                    height: getProportionateScreenHeight(260),
                    width: getProportionateScreenWidth(320),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            onPressed: () {
                              currentPassController.clear();
                              newPassController.clear();
                              confirmNewPassController.clear();
                              context.pop();
                            },
                            icon: const Icon(Icons.close),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Flexible(
                          flex: 3,
                          child: Center(
                            child: Image.asset(
                              Assets.APP_LOGO,
                              height: 95,
                              width: 150,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Flexible(
                          flex: 2,
                          child: Text(
                            context.read<LanguageBloc>().state.selectedLanguage ==
                                Language.english
                                ? state.errorMsg
                                : AppLocalizations.of(context)!
                                .oopsitlooksliketheserverisnot,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.openSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Flexible(
                          flex: 1,
                          child: Text(
                            AppLocalizations.of(context)!.thankyou,
                            // "Thank You !",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        MyButton(
                            text: AppLocalizations.of(context)!.ok,
                            color: AppColors.secondaryColor,
                            width: 200,
                            height: 30,
                            onTap: () {
                              currentPassController.clear();
                              newPassController.clear();
                              confirmNewPassController.clear();
                              context.pop();
                            },
                            TextColors: AppColors.primaryWhiteColor,
                            Textfontsize: 16,
                            showImage: false,
                            imagePath: "",
                            imagewidth: 0,
                            imageheight: 0)
                        // Flexible(
                        //   flex: 3,
                        //   child: Lottie.asset(Assets.SCANING),
                        // ),
                      ],
                    ),
                  ),
                );
              }
              return const SizedBox();
            }),
      ),
    );
  }
}