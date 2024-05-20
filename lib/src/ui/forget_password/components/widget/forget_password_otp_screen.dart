import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_collect/language.dart';
import 'package:lets_collect/src/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:lets_collect/src/bloc/language/language_bloc.dart';
import 'package:lets_collect/src/components/my_button.dart';
import 'package:lets_collect/src/constants/assets.dart';
import 'package:lets_collect/src/model/auth/forgot_password_otp_request.dart';
import 'package:lets_collect/src/utils/data/object_factory.dart';
import 'package:lets_collect/src/utils/screen_size/size_config.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';
import '../../../../constants/colors.dart';
import '../../../../utils/network_connectivity/bloc/network_bloc.dart';
import '../forgot_password arguments.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForgetPasswordOtpScreen extends StatefulWidget {
  final ForgotPasswordArguments? forgotPasswordArguments;

  const ForgetPasswordOtpScreen(
      {super.key, required this.forgotPasswordArguments});

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
    super.dispose();
    pinController.dispose();
    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = AppColors.secondaryColor;
    const fillColor = AppColors.primaryWhiteColor;
    const borderColor = AppColors.primaryWhiteColor;

    final defaultPinTheme = PinTheme(
      width: 40,
      height: 40,
      textStyle:  const TextStyle(fontSize: 22, color: AppColors.primaryGrayColor),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor),
      ),
    );

    SizeConfig().init(context);
    return Form(
      key: formKey,
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.primaryColor,
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
            AppLocalizations.of(context)!.resetpassword,
            style: GoogleFonts.openSans(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryWhiteColor,
            ),
          ),
          actions: const [
            Image(
              image: AssetImage(Assets.APP_LOGO),
              width: 40,
              height: 40,
            ),
          ],
        ),
        body: BlocConsumer<NetworkBloc, NetworkState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is NetworkFailure) {
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
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
                  listener: (context, state) {
                    if (state is ForgotPasswordOtpLoaded) {
                      if (state.forgotPasswordOtpRequestResponse.success ==
                          true) {
                        if (state.forgotPasswordOtpRequestResponse.token
                            .isNotEmpty) {
                          ObjectFactory().prefs.setAuthToken(
                              token:
                                  state.forgotPasswordOtpRequestResponse.token);
                        }
                        context.go('/forgot_password_reset');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              context
                                          .read<LanguageBloc>()
                                          .state
                                          .selectedLanguage ==
                                      Language.english
                                  ? state
                                      .forgotPasswordOtpRequestResponse.message
                                  : state.forgotPasswordOtpRequestResponse
                                      .messageArabic,
                              style: const TextStyle(
                                color: AppColors.primaryWhiteColor,
                              ),
                            ),
                            backgroundColor: AppColors.secondaryColor,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                            ),
                          ),
                        );
                      } else if (state
                              .forgotPasswordOtpRequestResponse.success ==
                          false) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              context
                                          .read<LanguageBloc>()
                                          .state
                                          .selectedLanguage ==
                                      Language.english
                                  ? state
                                      .forgotPasswordOtpRequestResponse.message
                                  : state.forgotPasswordOtpRequestResponse
                                      .messageArabic,
                              style: const TextStyle(
                                color: AppColors.primaryWhiteColor,
                              ),
                            ),
                            backgroundColor: AppColors.secondaryColor,
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
                          Center(
                            child: Lottie.asset(Assets.OTP,
                                height: 150, width: 150, fit: BoxFit.cover),
                          ).animate().then(delay: 200.ms).slideX(),
                          const SizedBox(height: 20),
                          Center(
                            child:
                                Text(AppLocalizations.of(context)!.almostdone,
                                    // Strings.ALMOST_DONE,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.openSans(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primaryWhiteColor,
                                    )),
                          ).animate().then(delay: 200.ms).slideX(),
                          SizedBox(
                            height: getProportionateScreenHeight(20),
                          ),
                          Center(
                            child: Text(
                              "${AppLocalizations.of(context)!.aonetimepasswordhasbeensendto} ${widget.forgotPasswordArguments!.email}.",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14),
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
                                    Flexible(
                                      flex: 1,
                                      child: Center(
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .otpnumber,
                                          // "OTP Number",
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
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
                                          // onCompleted: (pin) {
                                          //   debugPrint('onCompleted: $pin');
                                          // },
                                          // onChanged: (value) {
                                          //   debugPrint('onChanged: $value');
                                          // },
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

                                          focusedPinTheme:
                                              defaultPinTheme.copyWith(
                                            decoration: defaultPinTheme
                                                .decoration!
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
                                            decoration: defaultPinTheme
                                                .decoration!
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
                                            border: Border.all(
                                                color: Colors.redAccent),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 2,
                                      child: BlocBuilder<ForgotPasswordBloc,
                                          ForgotPasswordState>(
                                        builder: (context, state) {
                                          if (state
                                              is ForgotPasswordOtpLoading) {
                                            return const Center(
                                              child: RefreshProgressIndicator(
                                                color:
                                                    AppColors.primaryWhiteColor,
                                                backgroundColor: AppColors
                                                    .secondaryButtonColor,
                                              ),
                                            );
                                          }
                                          return Center(
                                            child: MyButton(
                                              Textfontsize: 16,
                                              TextColors:
                                                  AppColors.primaryWhiteColor,
                                              text:
                                                  AppLocalizations.of(context)!
                                                      .verifyotp,
                                              // text: Strings.OTP_BUTTON_VERIFY,
                                              color: AppColors.secondaryColor,
                                              width: 340,
                                              height: 40,
                                              onTap: () {
                                                if (pinController
                                                        .text.isNotEmpty &&
                                                    pinController.length >= 4) {
                                                  BlocProvider.of<
                                                              ForgotPasswordBloc>(
                                                          context)
                                                      .add(
                                                          ForgotPasswordOtpRequestEvent(
                                                              forgotPasswordOtpRequest:
                                                                  ForgotPasswordOtpRequest(
                                                    email: widget
                                                        .forgotPasswordArguments!
                                                        .email,
                                                    otp: pinController.text,
                                                  )));
                                                } else {
                                                  Fluttertoast.showToast(
                                                    msg: AppLocalizations.of(
                                                            context)!
                                                        .allfieldsareimportant,
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.BOTTOM,
                                                    backgroundColor: AppColors
                                                        .secondaryColor,
                                                    textColor: AppColors
                                                        .primaryWhiteColor,
                                                  );
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
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
