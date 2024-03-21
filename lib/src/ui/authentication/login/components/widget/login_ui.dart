import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lets_collect/src/bloc/google_login/google_login_bloc.dart';
import 'package:lets_collect/src/bloc/google_signIn_cubit/google_sign_in_cubit.dart';
import 'package:lets_collect/src/constants/assets.dart';
import 'package:lets_collect/src/constants/strings.dart';
import 'package:lets_collect/src/model/auth/google_login_request.dart';
import 'package:lets_collect/src/model/auth/login_request.dart';
import 'package:lets_collect/src/bloc/login_bloc/login_bloc.dart';
import 'package:lets_collect/src/utils/data/object_factory.dart';
import 'package:lets_collect/src/utils/screen_size/size_config.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../../../bloc/apple_sign_in/apple_sign_in_cubit.dart';
import '../../../../../components/Custome_Textfiled.dart';
import '../../../../../components/my_button.dart';
import '../../../../../constants/colors.dart';
import '../../../../forget_password/components/forget_password_screen.dart';
import '../../../Signup/components/singup_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginUiwidget extends StatefulWidget {
  const LoginUiwidget({super.key});

  @override
  State<LoginUiwidget> createState() => _LoginUiwidgetState();
}

class _LoginUiwidgetState extends State<LoginUiwidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>[
    'email',
    'https://www.googleapi.com/auth/contacts.readonly'
  ]);
  late GoogleSignInAccount _currentUser;

  String? validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value)) {
      // return 'Enter a valid email address';
      return AppLocalizations.of(context)!.enteravalidemailaddress;
    } else {
      return null;
    }
  }

  String? validatePassword(String? value) {
    String pattern =
        r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,}$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty) {
      // return 'Please enter password';
      return AppLocalizations.of(context)!.pleaseenterpassword;
    }
    if (value.length < 6) {
      // return "Length should be 8 or more";
      return AppLocalizations.of(context)!.lengthshouldbe;
    }
    if (!regex.hasMatch(value)) {
      // return "Must contain at least 1 uppercase, 1 lowercase, 1 special character";
      return AppLocalizations.of(context)!.mustcontainatleast;
    }
    return null;
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final auth = FirebaseAuth.instance;
  String gUsername = "";
  String gUserEmail = "";

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(
        url,
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    registerNotification();
    // _googleSignIn.onCurrentUserChanged.listen((account) {
    //   setState(() {
    //     _currentUser = account!;
    //   });
    //   if (_currentUser != null) {
    //     print("User already authenticated");
    //   }
    // });
    // _googleSignIn.signInSilently();
  }

  void registerNotification() {
    FirebaseMessaging fm = FirebaseMessaging.instance;
    fm.getToken().then((token) {
      print("token is $token");
      Strings.FCM = token ?? "";
      ObjectFactory().prefs.setFcmToken(token: token);
    });
  }

  Future<void> handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print("Sign in error: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final appleSignInCubit = BlocProvider.of<AppleSignInCubit>(context);
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginLoaded) {
          if (state.loginRequestResponse.success == true &&
              state.loginRequestResponse.token.isNotEmpty) {
            ObjectFactory()
                .prefs
                .setAuthToken(token: state.loginRequestResponse.token);
            ObjectFactory().prefs.setUserId(
                userId: state.loginRequestResponse.data.id.toString());
            ObjectFactory().prefs.setUserName(
                userName: state.loginRequestResponse.data.firstName);
            ObjectFactory().prefs.setIsLoggedIn(true);
            context.pushReplacement("/home");
            // ignore: unnecessary_null_comparison
          } else if (state.loginRequestResponse.success == false &&
              state.loginRequestResponse.token.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: AppColors.secondaryColor,
                content: Text(
                  state.loginRequestResponse.message,
                  style: const TextStyle(color: AppColors.primaryWhiteColor),
                ),
              ),
            );
          }
        }
        if (state is LoginLoadingConnectionRefused) {
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
        if (state is LoginLoadingRequestTimeOut) {
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
        if (state is LoginLoadingServerError) {
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
      },
      builder: (context, state) {
        return BlocConsumer<GoogleLoginBloc, GoogleLoginState>(
          listener: (context, state) {
            if (state is GoogleLoginErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: AppColors.secondaryColor,
                  content: Text(
                    state.msg,
                    style: const TextStyle(color: AppColors.primaryWhiteColor),
                  ),
                ),
              );
            }
            if (state is GoogleLoginLoaded) {
              if (state.googleLoginResponse.success == true &&
                  state.googleLoginResponse.token!.isNotEmpty) {
                ObjectFactory()
                    .prefs
                    .setAuthToken(token: state.googleLoginResponse.token);
                ObjectFactory().prefs.setUserId(
                    userId: state.googleLoginResponse.data!.id.toString());
                ObjectFactory().prefs.setUserName(
                    userName: state.googleLoginResponse.data!.firstName);
                ObjectFactory().prefs.setIsLoggedIn(true);
                context.pushReplacement("/home");
                // ignore: unnecessary_null_comparison
              } else if (state.googleLoginResponse.success == false &&
                  state.googleLoginResponse.token!.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: AppColors.secondaryColor,
                    content: Text(
                      state.googleLoginResponse.message!,
                      style:
                          const TextStyle(color: AppColors.primaryWhiteColor),
                    ),
                  ),
                );
                // Navigator.of(context).push(PageRouteBuilder(
                //   reverseTransitionDuration: const Duration(seconds: 5),
                //   transitionDuration: const Duration(seconds: 3),
                //   pageBuilder: (context, animation, secondaryAnimation) => SignUpScreen(
                //     from: 'Google', gmail: gUserEmail,
                //   ),
                //   transitionsBuilder: (context, animation, secondaryAnimation, child) {
                //     const begin = Offset(0.0, 1.0);
                //     const end = Offset.zero;
                //     const curve = Curves.ease;
                //     var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                //     return SlideTransition(
                //       position: animation.drive(tween),
                //       child: child,
                //     );
                //   },
                // ),
                // );
              }
            }
          },
          builder: (context, state) {
            if (state is GoogleLoginLoading) {
              return Stack(
                children: [
                  const Scaffold(backgroundColor: Colors.transparent),
                  const Opacity(
                    opacity: 0.8,
                    child: ModalBarrier(
                        dismissible: false, color: Colors.transparent),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 90,
                          width: 90,
                          decoration:
                              const BoxDecoration(color: AppColors.boxShadow),
                          child: Lottie.asset(Assets.JUMBINGDOT,
                              height: 90, width: 90),
                        ),
                        const Text(
                          "Please wait",
                          style: TextStyle(color: AppColors.secondaryColor),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
            return WillPopScope(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Text(
                              Strings.LOGIN_LETS_COLLECT,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                letterSpacing: 2.0,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Center(
                            child: Image.asset(
                              Assets.APP_LOGO,
                              scale: 30,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Center(
                            child: Text(
                              AppLocalizations.of(context)!.welcomeback,
                              // Strings.LOGIN_WELCOME_BACK,
                              style: GoogleFonts.openSans(
                                color: AppColors.primaryWhiteColor,
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Padding(
                            padding: const EdgeInsets.only(left: 5, bottom: 5),
                            child: Text(
                              AppLocalizations.of(context)!.email,
                              // Strings.LOGIN_EMAIL_LABEL_TEXT,
                              style: GoogleFonts.roboto(
                                color: AppColors.primaryWhiteColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          MyTextField(
                            hintText: AppLocalizations.of(context)!.enteryouremail,
                            // hintText: Strings.LOGIN_EMAIL_HINT_TEXT,
                            obscureText: false,
                            maxLines: 1,
                            controller: emailController,
                            keyboardType: TextInputType.text,
                            focusNode: _emailFocus,
                            validator: (value) {
                              String? err = validateEmail(value);
                              if (err != null) {
                                _emailFocus.requestFocus();
                              }
                              return err;
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5, bottom: 5),
                            child: Text(
                              // Strings.LOGIN_PASSWORD_LABEL_TEXT,
                              AppLocalizations.of(context)!.password,
                              style: GoogleFonts.roboto(
                                color: AppColors.primaryWhiteColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          MyTextField(
                            hintText: AppLocalizations.of(context)!.enteryourpassword,
                            // hintText: Strings.LOGIN_PASSWORD_HINT_TEXT,
                            obscureText: true,
                            maxLines: 1,
                            controller: passwordController,
                            keyboardType: TextInputType.text,
                            focusNode: _passwordFocus,
                            validator: (value) {
                              String? err = validatePassword(value);
                              if (err != null) {
                                _passwordFocus.requestFocus();
                              }
                              return err;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    PageRouteBuilder(
                                      reverseTransitionDuration:
                                          const Duration(milliseconds: 750),
                                      transitionDuration:
                                          const Duration(milliseconds: 750),
                                      pageBuilder: (context, animation,
                                              secondaryAnimation) =>
                                          const ForgetPasswordScreen(),
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        const begin = Offset(1.0, 0.0);
                                        const end = Offset.zero;
                                        const curve = Curves.decelerate;
                                        var tween = Tween(
                                                begin: begin, end: end)
                                            .chain(CurveTween(curve: curve));
                                        return SlideTransition(
                                          position: animation.drive(tween),
                                          child: child,
                                        );
                                      },
                                    ),
                                  );
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.forgetpassword,
                                  // Strings.LOGIN_FORGET_PASSWORD_TEXT,
                                  textAlign: TextAlign.left,
                                  maxLines: 1,
                                  style: GoogleFonts.roboto(
                                    color: AppColors.primaryWhiteColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          BlocBuilder<LoginBloc, LoginState>(
                            builder: (context, state) {
                              if (state is LoginLoading) {
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
                                  text: AppLocalizations.of(context)!.login,
                                  // text: Strings.LOGIN_BUTTON_TEXT,
                                  color: AppColors.secondaryColor,
                                  width: 340,
                                  height: 40,
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      // If the form is valid, perform login action
                                      BlocProvider.of<LoginBloc>(context).add(
                                        LoginRequestEvent(
                                          loginRequest: LoginRequest(
                                            email: emailController.text,
                                            password: passwordController.text,
                                            deviceToken: ObjectFactory()
                                                .prefs
                                                .getFcmToken()!,
                                            deviceType:
                                                Platform.isAndroid ? "A" : "I",
                                          ),
                                        ),
                                      );
                                    } else {
                                      Fluttertoast.showToast(
                                        msg: AppLocalizations.of(context)!.allfieldsareimportant,
                                        // msg: "All fields are important",
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM,
                                        backgroundColor:
                                            AppColors.primaryWhiteColor,
                                        textColor: AppColors.secondaryColor,
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
                          const SizedBox(height: 15),
                          Center(
                            child: Text(
                              AppLocalizations.of(context)!.donthaveanaccount,
                              // Strings.LOGIN_DONT_HAVE_AN_AC,
                              style: GoogleFonts.openSans(
                                color: AppColors.primaryWhiteColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: MyButton(
                                  imagePath: Assets.MAIL,
                                  Textfontsize: 14,
                                  TextColors: AppColors.iconGreyColor,
                                  text: AppLocalizations.of(context)!.emailsignup,
                                  // text: Strings.EMAIL_SINGUP,
                                  color: AppColors.primaryWhiteColor,
                                  width: 160,
                                  height: 40,
                                  onTap: () {
                                    Navigator.of(context).push(
                                      PageRouteBuilder(
                                        reverseTransitionDuration:
                                            const Duration(milliseconds: 750),
                                        transitionDuration:
                                            const Duration(milliseconds: 750),
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            const SignUpScreen(
                                          from: 'Email',
                                          gmail: '',
                                        ),
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          const begin = Offset(0.0, 1.0);
                                          const end = Offset.zero;
                                          const curve = Curves.decelerate;
                                          var tween = Tween(
                                                  begin: begin, end: end)
                                              .chain(CurveTween(curve: curve));
                                          return SlideTransition(
                                            position: animation.drive(tween),
                                            child: child,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  showImage: true,
                                  imagewidth: 28,
                                  imageheight: 20,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Platform.isIOS
                                  ? Flexible(
                                      child: BlocConsumer<AppleSignInCubit,
                                          AppleSignInStatus>(
                                        builder: (context, state) {
                                          return state ==
                                                  AppleSignInStatus.loading
                                              ? const CircularProgressIndicator()
                                              : MyButton(
                                                  imagePath: Assets.APPLE_LOGO,
                                                  Textfontsize: 14,
                                                  TextColors:
                                                      AppColors.iconGreyColor,
                                                  text: Strings.APPLE_SINGUP,
                                                  color: AppColors
                                                      .primaryWhiteColor,
                                                  width: 160,
                                                  height: 40,
                                                  onTap: () {
                                                    // appleSignInCubit
                                                    //     .signInWithApple();
                                                    // Navigator.of(context).push(
                                                    //   PageRouteBuilder(
                                                    //     reverseTransitionDuration:
                                                    //         const Duration(
                                                    //             milliseconds: 750),
                                                    //     transitionDuration:
                                                    //         const Duration(
                                                    //             milliseconds: 750),
                                                    //     pageBuilder: (context, animation,
                                                    //             secondaryAnimation) =>
                                                    //         const SignUpScreen(
                                                    //       from: 'Email',
                                                    //       gmail: '',
                                                    //     ),
                                                    //     transitionsBuilder: (context,
                                                    //         animation,
                                                    //         secondaryAnimation,
                                                    //         child) {
                                                    //       const begin = Offset(0.0, 1.0);
                                                    //       const end = Offset.zero;
                                                    //       const curve = Curves.decelerate;
                                                    //       var tween = Tween(
                                                    //               begin: begin, end: end)
                                                    //           .chain(CurveTween(
                                                    //               curve: curve));
                                                    //       return SlideTransition(
                                                    //         position:
                                                    //             animation.drive(tween),
                                                    //         child: child,
                                                    //       );
                                                    //     },
                                                    //   ),
                                                    // );
                                                  },
                                                  showImage: true,
                                                  imagewidth: 28,
                                                  imageheight: 20,
                                                );
                                        },
                                        listener: (context, state) {
                                          if (state ==
                                              AppleSignInStatus.success) {
                                            context.go('/home');

                                          } else {
                                            return;
                                          }
                                        },
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: BlocConsumer<GoogleSignInCubit,
                                    GoogleSignInState>(
                                  listener: (context, state) {
                                    if (state is GoogleSignInSuccess) {
                                      gUsername = state.user.displayName!;
                                      gUserEmail = state.user.email!;
                                      BlocProvider.of<GoogleLoginBloc>(context)
                                          .add(
                                        GetGoogleLoginEvent(
                                          googleLoginRequest:
                                              GoogleLoginRequest(
                                            email: state.user.email!,
                                            deviceToken: ObjectFactory()
                                                .prefs
                                                .getFcmToken()!,
                                            deviceType:
                                                Platform.isAndroid ? "A" : "I",
                                            displayName:
                                                state.user.displayName!,
                                            mobileNo: "0",
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  builder: (context, state) {
                                    return ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        fixedSize: const Size(160, 40),
                                        backgroundColor:
                                            AppColors.primaryWhiteColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      onPressed:
                                          state is GoogleSignInCubitLoading
                                              ? null
                                              : () => context
                                                  .read<GoogleSignInCubit>()
                                                  .login(),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            Assets.GOOGLE,
                                            width: 20,
                                            height: 20,
                                            fit: BoxFit.cover,
                                          ),
                                          const SizedBox(width: 8),
                                          state is GoogleSignInCubitLoading
                                              ? const Center(
                                                  // widthFactor: 2,
                                                  child: SizedBox(
                                                    height: 10,
                                                    width: 10,
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: AppColors
                                                          .secondaryColor,
                                                      strokeWidth: 2,
                                                    ),
                                                  ),
                                                )
                                              : Text(
                                            // AppLocalizations.of(context)!.shjkjk,
                                                  "Sign In",
                                                  style: GoogleFonts.roboto(
                                                    color: AppColors
                                                        .primaryGrayColor,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: 10),
                              Flexible(
                                child: MyButton(
                                  imagePath: Assets.FACEBOOK,
                                  Textfontsize: 14,
                                  TextColors: AppColors.iconGreyColor,
                                  text: Strings.FACEBOOK_SIGNUP,
                                  color: AppColors.primaryWhiteColor,
                                  width: 160,
                                  height: 40,
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          content: SizedBox(
                                            height:
                                                getProportionateScreenHeight(
                                                    260),
                                            width: getProportionateScreenWidth(
                                                320),
                                            child: Lottie.asset(Assets.SOON),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  showImage: true,
                                  imagewidth: 8,
                                  imageheight: 20,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Padding(
                            padding: const EdgeInsets.only(left: 13,right: 13),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                            AppLocalizations.of(context)!.termsandconditionds,
                                      // Strings.LOGIN_NOTES1,
                                      style: GoogleFonts.openSans(
                                        color: AppColors.primaryWhiteColor,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    InkWell(
                                      splashColor: AppColors.borderColor,
                                      splashFactory: InkRipple.splashFactory,
                                      onTap: () {
                                        _launchInBrowser(
                                          Strings.TERMS_AND_CONDITION_URL,
                                        );
                                      },
                                      child: Text(
                                        AppLocalizations.of(context)!.bysigningupyouagreetothe,
                                        // Strings.LOGIN_NOTES2,
                                        style: GoogleFonts.openSans(
                                          color: AppColors.secondaryColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.privacypolicy,
                                      // Strings.LOGIN_NOTES3,
                                      style: GoogleFonts.openSans(
                                        color: AppColors.primaryWhiteColor,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    InkWell(
                                      splashColor: AppColors.borderColor,
                                      splashFactory: InkRipple.splashFactory,
                                      onTap: () {
                                        _launchInBrowser(
                                            Strings.PRIVACY_POLICY_URL);
                                      },
                                      child: Text(
                                        AppLocalizations.of(context)!.andour,
                                        // Strings.LOGIN_NOTES4,
                                        style: GoogleFonts.openSans(
                                          color: AppColors.secondaryColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              onWillPop: () async {
                return false;
              },
            );
          },
        );
      },
    );
  }
}
