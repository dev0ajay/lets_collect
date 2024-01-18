import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_collect/src/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:lets_collect/src/components/my_button.dart';
import 'package:lets_collect/src/constants/assets.dart';
import 'package:lets_collect/src/constants/strings.dart';
import 'package:lets_collect/src/model/auth/forgot_password_otp_request.dart';
import 'package:lets_collect/src/utils/data/object_factory.dart';
import 'package:lets_collect/src/utils/screen_size/size_config.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';

import '../../../../constants/colors.dart';
import '../forgot_password arguments.dart';


class ForgetPasswordOtpScreen extends StatefulWidget {
 final ForgotPasswordArguments? forgotPasswordArguments;


   const ForgetPasswordOtpScreen({
    Key? key,required this.forgotPasswordArguments

  }) : super(key: key);

  @override
  State<ForgetPasswordOtpScreen> createState() =>
      _ForgetPasswordOtpScreenState();
}

class _ForgetPasswordOtpScreenState extends State<ForgetPasswordOtpScreen> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();


  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = Colors.pink;
    const fillColor = Colors.white;
    const borderColor = Colors.white;

    final defaultPinTheme = PinTheme(
      width: 40,
      height: 40,
      textStyle: const TextStyle(fontSize: 22, color: Colors.black),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor),
      ),
    );

    SizeConfig().init(context);
    return Form(
      key: formKey,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.primaryColor,
          body: Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
              listener: (context, state) {
                if (state is ForgotPasswordOtpLoaded) {
                  if (state.forgotPasswordOtpRequestResponse.success == true) {
                   if(state.forgotPasswordOtpRequestResponse.token.isNotEmpty) {
                     ObjectFactory().prefs.setAuthToken(token: state.forgotPasswordOtpRequestResponse.token);
                   }
                    context.go('/forgot_password_reset');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            state.forgotPasswordOtpRequestResponse.message,
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
                  } else if (state.forgotPasswordOtpRequestResponse.success ==
                      false) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            state.forgotPasswordOtpRequestResponse.message,
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
                  }
                }
              },
              builder: (context, state) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: getProportionateScreenHeight(30),
                      ),
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
                          ),
                        ],
                      ).animate().then(delay: 200.ms).slideX(),
                      SizedBox(
                        height: getProportionateScreenHeight(30),
                      ),
                      // Center(
                      //   child: Text(
                      //     Strings.LOGIN_LETS_COLLECT,
                      //     style: TextStyle(color: Colors.white, fontSize: 40, fontFamily: "Fonarto"),
                      //   ),
                      // ).animate().then(delay: 200.ms).slideX(),
                       Center(
                        child: Lottie.asset(Assets.OTP,height: 150,width: 150,fit: BoxFit.cover),
                      ).animate().then(delay: 200.ms).slideX(),
                      const SizedBox(
                        height: 20,
                      ),
                       Center(
                        child: Text(
                          Strings.ALMOST_DONE,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.openSans(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryWhiteColor,
                          )
                        ),
                      ).animate().then(delay: 200.ms).slideX(),
                      SizedBox(
                        height: getProportionateScreenHeight(20),
                      ),
                       Center(
                        child: Text(
                         "A One-Time password has been send to ${widget.forgotPasswordArguments!.email}. ",
                          style: const TextStyle(color: Colors.white, fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      ).animate().then(delay: 200.ms).slideX(),

                      SizedBox(
                        height: getProportionateScreenHeight(30),
                      ),

                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Container(
                            height: getProportionateScreenHeight(230),
                            width: getProportionateScreenWidth(320),
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                const Flexible(
                                  flex: 1,
                                  child: Center(
                                    child: Text(
                                      "OTP Number",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                Flexible(
                                  flex: 3,
                                  child: Directionality(
                                    // Specify direction if desired
                                    textDirection: TextDirection.ltr,
                                    child: Pinput(
                                      keyboardType: TextInputType.number,
                                      controller: pinController,
                                      focusNode: focusNode,
                                      androidSmsAutofillMethod:
                                          AndroidSmsAutofillMethod
                                              .smsUserConsentApi,
                                      listenForMultipleSmsOnAndroid: true,
                                      defaultPinTheme: defaultPinTheme,
                                      separatorBuilder: (index) =>
                                          const SizedBox(width: 10),
                                      // validator: (value) {
                                      // return value!.isEmpty ?
                                      //     "The fields are empty" : "";
                                      // },
                                      // onClipboardFound: (value) {
                                      //   debugPrint('onClipboardFound: $value');
                                      //   pinController.setText(value);
                                      // },
                                      hapticFeedbackType:
                                          HapticFeedbackType.lightImpact,
                                      onCompleted: (pin) {
                                        debugPrint('onCompleted: $pin');
                                      },
                                      onChanged: (value) {
                                        debugPrint('onChanged: $value');
                                      },
                                      cursor: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 9),
                                            width: 22,
                                            height: 1,
                                            color: focusedBorderColor,
                                          ),
                                        ],
                                      ),

                                      focusedPinTheme: defaultPinTheme.copyWith(
                                        decoration: defaultPinTheme.decoration!
                                            .copyWith(
                                          color: fillColor,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          border: Border.all(
                                              color: focusedBorderColor),
                                        ),
                                      ),
                                      submittedPinTheme:
                                          defaultPinTheme.copyWith(
                                        decoration: defaultPinTheme.decoration!
                                            .copyWith(
                                          color: fillColor,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: focusedBorderColor),
                                        ),
                                      ),
                                      errorPinTheme:
                                          defaultPinTheme.copyBorderWith(
                                        border:
                                            Border.all(color: Colors.redAccent),
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 2,
                                  child: BlocBuilder<ForgotPasswordBloc,
                                      ForgotPasswordState>(
                                    builder: (context, state) {
                                      if (state is ForgotPasswordOtpLoading) {
                                        return const Center(
                                          child: RefreshProgressIndicator(
                                            color: AppColors.primaryWhiteColor,
                                            backgroundColor:
                                                AppColors.secondaryButtonColor,
                                          ),
                                        );
                                      }
                                      return Center(
                                        child: MyButton(
                                          Textfontsize: 16,
                                          TextColors: Colors.white,
                                          text: Strings.OTP_BUTTON_VERIFY,
                                          color: AppColors.secondaryColor,
                                          width: 340,
                                          height: 40,
                                          onTap: () {
                                            if (formKey.currentState!
                                                .validate()) {
                                              BlocProvider.of<
                                                          ForgotPasswordBloc>(
                                                      context)
                                                  .add(
                                                      ForgotPasswordOtpRequestEvent(
                                                          forgotPasswordOtpRequest:
                                                              ForgotPasswordOtpRequest(
                                                email: widget.forgotPasswordArguments!.email,
                                                otp: pinController.text,
                                              )));
                                            }
                                          },
                                          showImage: false,
                                          imagePath: '',
                                          imagewidth: 0,
                                          imageheight: 0,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ).animate().then(delay: 200.ms).slideX(),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
