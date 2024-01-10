import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_collect/src/constants/assets.dart';
import 'package:lets_collect/src/constants/strings.dart';
import 'package:lets_collect/src/model/auth/login_request.dart';
import 'package:lets_collect/src/bloc/login_bloc/login_bloc.dart';
import '../../../../../components/Custome_Textfiled.dart';
import '../../../../../components/my_button.dart';
import '../../../../../constants/colors.dart';
import '../../../../../utils/data/object_factory.dart';
import '../../../../forget_password/components/forget_password_screen.dart';
import '../../../Signup/components/singup_screen.dart';
import 'package:google_fonts/google_fonts.dart';


class LoginUiwidget extends StatefulWidget {
  const LoginUiwidget({Key? key}) : super(key: key);

  @override
  State<LoginUiwidget> createState() => _LoginUiwidgetState();
}

class _LoginUiwidgetState extends State<LoginUiwidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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

  String? validatePassword(String? value) {
    String pattern =
        r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,}$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty) {
      return 'Please enter password';
    }
    if (value.length < 6) {
      return "Length should be 8 or more";
    }
    if (!regex.hasMatch(value)) {
      return "Must contain at least 1 uppercase, 1 lowercase, 1 special character";
    }
    return null;
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginLoaded) {
          if (state.loginRequestResponse.message == "Successfully logged in") {
            ObjectFactory().prefs.setAuthToken(token: state.loginRequestResponse.token);

            context.go("/home");
            // ignore: unnecessary_null_comparison
          } else if (state.loginRequestResponse.success == false &&
              state.loginRequestResponse.token.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(
                backgroundColor: AppColors.primaryWhiteColor,
                content: Text(
                  state.loginRequestResponse.message,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            );
          }
        }
      },
      builder: (context, state) {
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
                              fontFamily: "Fonarto",
                              letterSpacing: 2.0),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: Image.asset(
                          Assets.APP_LOGO,
                          scale: 30,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                       Center(
                        child: Text(
                          Strings.LOGIN_WELCOME_BACK,
                          style: GoogleFonts.openSans(
                              color: AppColors.primaryWhiteColor,
                              fontSize: 24,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                          )
                        ),
                      ),
                      const SizedBox(height: 30),
                       Padding(
                        padding: EdgeInsets.only(left: 5, bottom: 5),
                        child: Text(Strings.LOGIN_EMAIL_LABEL_TEXT,
                            style:GoogleFonts.roboto(
                              color: AppColors.primaryWhiteColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              letterSpacing: 0, // This is the default value for normal line height
                            ),
                        ),
                      ),
                      MyTextField(
                        hintText: Strings.LOGIN_EMAIL_HINT_TEXT,
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
                        padding: EdgeInsets.only(left: 5, bottom: 5),
                        child: Text(Strings.LOGIN_PASSWORD_LABEL_TEXT,
                            style:GoogleFonts.roboto(
                              color: AppColors.primaryWhiteColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              letterSpacing: 0, // This is the default value for normal line height
                            ),
                        ),
                      ),
                      MyTextField(

                        hintText: Strings.LOGIN_PASSWORD_HINT_TEXT,
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
                      Padding(
                        padding: const EdgeInsets.only(left: 265, bottom: 5),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const Forget_password_screen()),
                              );
                            },
                            child:  Text(
                                Strings.LOGIN_FORGET_PASSWORD_TEXT,
                                style: GoogleFonts.roboto(
                                  color: AppColors.primaryWhiteColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                  letterSpacing: 0, // This is the default value for normal line height
                                ),
                            )),
                      ),
                      const SizedBox(
                        height: 20
                      ),
                      BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                          if (state is LoginLoading) {
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
                              text: Strings.LOGIN_BUTTON_TEXT,
                              color: AppColors.secondaryColor,
                              width: 340,
                              height: 40,
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  BlocProvider.of<LoginBloc>(context).add(
                                    LoginRequestEvent(
                                      loginRequest: LoginRequest(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      ),
                                    ),
                                  );
                                } else {
                                  Fluttertoast.showToast(
                                    msg: "All fields are important",
                                    toastLength: Toast.LENGTH_LONG,
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
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 15
                      ),
                       Center(
                          child: Text(Strings.LOGIN_DONT_HAVE_AN_AC,
                              style: GoogleFonts.openSans(
                                color: AppColors.primaryWhiteColor,
                                fontSize: 12,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                              )
                          )),
                      const SizedBox(
                        height: 30
                      ),
                      Center(
                        child: MyButton(
                          imagePath: Assets.MAIL,
                          Textfontsize: 16,
                          TextColors: AppColors.primaryBlackColor,
                          text: Strings.EMAIL_SINGUP,
                          color: Colors.white,
                          width: 160,
                          height: 50,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUp_screen(),
                              ),
                            );
                          },
                          showImage: true,
                          imagewidth: 28,
                          imageheight: 20,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: MyButton(
                              imagePath: Assets.GOOGLE,
                              Textfontsize: 14,
                              TextColors: AppColors.primaryBlackColor,
                              text: Strings.Google_singup,
                              color: Colors.white,
                              width: 160,
                              height: 50,
                              onTap: () {},
                              showImage: true,
                              imagewidth: 20,
                              imageheight: 20,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: MyButton(
                              imagePath: Assets.FACEBOOK,
                              Textfontsize: 14,
                              TextColors: AppColors.primaryBlackColor,
                              text: Strings.FACEBOOK_SIGNUP,
                              color: Colors.white,
                              width: 160,
                              height: 50,
                              onTap: () {},
                              showImage: true,
                              imagewidth: 8,
                              imageheight: 20,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                       Padding(
                        padding: EdgeInsets.only(left: 35),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(Strings.LOGIN_NOTES1,
                                      style: GoogleFonts.openSans(
                                        color: AppColors.primaryWhiteColor,
                                        fontSize: 12,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w400,
                                      )
                                  ),
                                ),
                                // SizedBox(
                                //   width: 6,
                                // ),
                                Expanded(
                                  child: Text(Strings.LOGIN_NOTES2,
                                      style: GoogleFonts.openSans(
                                        color: AppColors.secondaryColor,
                                        fontSize: 12,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w600,
                                      )
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(Strings.LOGIN_NOTES3,
                                      style: GoogleFonts.openSans(
                                        color: AppColors.primaryWhiteColor,
                                        fontSize: 12,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w600,
                                      )
                                  ),
                                ),
                                // SizedBox(
                                //   width: 6,
                                // ),
                                Expanded(
                                  flex: 6,
                                  child: Text(Strings.LOGIN_NOTES4,
                                      style: GoogleFonts.openSans(
                                        color: AppColors.secondaryColor,
                                        fontSize: 12,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w600,
                                      ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
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
  }
}
