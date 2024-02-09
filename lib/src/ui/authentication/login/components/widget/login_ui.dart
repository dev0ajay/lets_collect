import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lets_collect/src/bloc/google_signIn_cubit/google_sign_in_cubit.dart';
import 'package:lets_collect/src/constants/assets.dart';
import 'package:lets_collect/src/constants/strings.dart';
import 'package:lets_collect/src/model/auth/login_request.dart';
import 'package:lets_collect/src/bloc/login_bloc/login_bloc.dart';
import 'package:lets_collect/src/utils/data/object_factory.dart';
import 'package:lets_collect/src/utils/screen_size/size_config.dart';
import '../../../../../components/Custome_Textfiled.dart';
import '../../../../../components/my_button.dart';
import '../../../../../constants/colors.dart';
import '../../../../forget_password/components/forget_password_screen.dart';
import '../../../Signup/components/singup_screen.dart';

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
  final auth = FirebaseAuth.instance;
   String gUser = "";

  @override
  void initState() {
    super.initState();

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

  Future<void> handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print("Sign in error: $error");
    }
  }

  // Future<User?> signInWithGoogle({required BuildContext context}) async {
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   User? user;
  //
  //   final GoogleSignIn googleSignIn = GoogleSignIn();
  //
  //   final GoogleSignInAccount? googleSignInAccount =
  //       await googleSignIn.signIn();
  //
  //   if (googleSignInAccount != null) {
  //     final GoogleSignInAuthentication googleSignInAuthentication =
  //         await googleSignInAccount.authentication;
  //
  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleSignInAuthentication.accessToken,
  //       idToken: googleSignInAuthentication.idToken,
  //     );
  //
  //     try {
  //       final UserCredential userCredential =
  //           await auth.signInWithCredential(credential);
  //
  //       user = userCredential.user;
  //     } on FirebaseAuthException catch (e) {
  //       if (e.code == 'account-exists-with-different-credential') {
  //         // handle the error here
  //       } else if (e.code == 'invalid-credential') {
  //         // handle the error here
  //       }
  //     } catch (e) {
  //       // handle the error here
  //     }
  //   }
  //
  //   return user;
  // }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
                userName: state.loginRequestResponse.data.userName);
            ObjectFactory().prefs.setIsLoggedIn(true);
            context.pushReplacement("/home");
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
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text(
                          Strings.LOGIN_WELCOME_BACK,
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
                          Strings.LOGIN_EMAIL_LABEL_TEXT,
                          style: GoogleFonts.roboto(
                            color: AppColors.primaryWhiteColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
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
                        padding: const EdgeInsets.only(left: 5, bottom: 5),
                        child: Text(
                          Strings.LOGIN_PASSWORD_LABEL_TEXT,
                          style: GoogleFonts.roboto(
                            color: AppColors.primaryWhiteColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const Forget_password_screen(),
                                ),
                              );
                            },
                            child: Text(
                              Strings.LOGIN_FORGET_PASSWORD_TEXT,
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
                              text: Strings.LOGIN_BUTTON_TEXT,
                              color: AppColors.secondaryColor,
                              width: 340,
                              height: 40,
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  // If the form is valid, perform login action
                                  // For demo, I'm just navigating to the HomeScreen
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
                      const SizedBox(height: 15),
                      Center(
                        child: Text(
                          Strings.LOGIN_DONT_HAVE_AN_AC,
                          style: GoogleFonts.openSans(
                            color: AppColors.primaryWhiteColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: MyButton(
                          imagePath: Assets.MAIL,
                          Textfontsize: 16,
                          TextColors: AppColors.iconGreyColor,
                          text: Strings.EMAIL_SINGUP,
                          color: AppColors.primaryWhiteColor,
                          width: 160,
                          height: 40,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpScreen(),
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
                            child: BlocConsumer<GoogleSignInCubit,
                                GoogleSignInState>(
                              listener: (context, state) {
                                if(state is GoogleSignInSuccess) {
                                  gUser = state.user.displayName!;
                                  context.go('/home');
                                }
                              },
                              builder: (context, state) {
                                return ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: const Size(160, 40),
                                    backgroundColor:
                                        AppColors.primaryWhiteColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: state is GoogleSignInLoading
                                      ? null
                                      : () => context
                                          .read<GoogleSignInCubit>()
                                          .login(),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        Assets.GOOGLE,
                                        width: 20,
                                        height: 20,
                                        fit: BoxFit.cover,
                                      ),
                                      const SizedBox(width: 8),
                                      state is GoogleSignInLoading
                                          ? const Center(
                                              // widthFactor: 2,
                                              child: Padding(
                                              padding: EdgeInsets.only(
                                                  top: 2, bottom: 2, left: 20),
                                              child: CircularProgressIndicator(
                                                color: AppColors.secondaryColor,
                                                strokeWidth: 2,
                                              ),
                                            ),
                                      )
                                          : Text(
                                        gUser,
                                              // Strings.Google_singup,
                                              style: GoogleFonts.roboto(
                                                color:
                                                    AppColors.primaryGrayColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                    ],
                                  ),
                                );
                                //   MyButton(
                                //   imagePath: Assets.GOOGLE,
                                //   Textfontsize: 14,
                                //   TextColors: AppColors.iconGreyColor,
                                //   text: state is GoogleSignInLoading ? CircularProgressIndicator(
                                //
                                //   ) : Strings.Google_singup,
                                //   color: AppColors.primaryWhiteColor,
                                //   width: 160,
                                //   height: 40,
                                //   onTap: () {
                                //     // handleSignIn();
                                //     // signInWithGoogle(context: context);
                                //     if ()
                                //   },
                                //   showImage: true,
                                //   imagewidth: 20,
                                //   imageheight: 20,
                                // );
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
                              onTap: () {},
                              showImage: true,
                              imagewidth: 8,
                              imageheight: 20,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.only(left: 13),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  Strings.LOGIN_NOTES1,
                                  style: GoogleFonts.openSans(
                                    color: AppColors.primaryWhiteColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  Strings.LOGIN_NOTES2,
                                  style: GoogleFonts.openSans(
                                    color: AppColors.secondaryColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  Strings.LOGIN_NOTES3,
                                  style: GoogleFonts.openSans(
                                    color: AppColors.primaryWhiteColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  Strings.LOGIN_NOTES4,
                                  style: GoogleFonts.openSans(
                                    color: AppColors.secondaryColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
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
