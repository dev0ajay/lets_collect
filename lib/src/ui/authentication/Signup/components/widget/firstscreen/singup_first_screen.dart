import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_collect/src/components/Custome_Textfiled.dart';
import 'package:lets_collect/src/components/my_button.dart';
import 'package:lets_collect/src/constants/assets.dart';
import 'package:lets_collect/src/constants/strings.dart';
import 'package:lets_collect/src/ui/authentication/Signup/components/widget/firstscreen/sign_up_argument_class.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../../../../bloc/country_bloc/country_bloc.dart';
import '../../../../../../bloc/google_signIn_cubit/google_sign_in_cubit.dart';
import '../../../../../../bloc/nationality_bloc/nationality_bloc.dart';
import '../../../../../../constants/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpFirstScreen extends StatefulWidget {
  final String from;
  final String gUserMail;

  const SignUpFirstScreen(
      {super.key, required this.from, required this.gUserMail});

  @override
  State<SignUpFirstScreen> createState() => _SignUpFirstScreenState();
}

class _SignUpFirstScreenState extends State<SignUpFirstScreen> {
  bool isChecked = true;
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController gmailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repasswordController = TextEditingController();

  final FocusNode _firstname = FocusNode();
  final FocusNode _secondname = FocusNode();
  final FocusNode _email = FocusNode();
  final FocusNode _password = FocusNode();
  final FocusNode _repassword = FocusNode();

  bool passwordConfirmed() {
    if (passwordController.text.trim() == repasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? validateFirstname(String? value) {
    String pattern = "[a-zA-Z]";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value)) {
      // return 'Enter first name';
      return AppLocalizations.of(context)!.enterfirstname;
    } else {
      return null;
    }
  }

  String? validateLastname(String? value) {
    String pattern = "["
        "a-zA-Z]";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value)) {
      // return 'Enter last name';
      return AppLocalizations.of(context)!.enterlastname;
    } else {
      return null;
    }
  }

  String? validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value)) {
      // return 'Enter a new email address';
      return AppLocalizations.of(context)!.enteranewenailaddress;
    } else {
      return null;
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
      return AppLocalizations.of(context)!.lengthshouldbe;
      // return "Length should be 8 or more";
    }
    if (!regex.hasMatch(value)) {
      // return "Must contain at least 1 uppercase, 1 lowercase, 1 special character";
      return AppLocalizations.of(context)!.mustcontainatleast;
    }
    return null;
  }

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
    BlocProvider.of<NationalityBloc>(context).add(GetNationality());
    BlocProvider.of<CountryBloc>(context).add(GetCountryEvent());

  }


  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
      };
      // if (states.any(interactiveStates.contains)) {
      //   return Colors.blue;
      // }
      return Colors.white;
    }

    return WillPopScope(
      onWillPop: () async {
        context.read<GoogleSignInCubit>().signOut();
        context.pop();
        return false;
      },
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
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
                      ),
                    )),
                    const Center(
                      child: Image(
                        image: AssetImage(Assets.APP_LOGO),
                        width: 100,
                        height: 80,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                        child: Text(
                          AppLocalizations.of(context)!.jointodayandstartcollect,
                      // Strings.SIGNUP_SUB_HEADING,
                      style: GoogleFonts.openSans(
                        color: AppColors.primaryWhiteColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    )),
                    const SizedBox(height: 40),
                    Row(
                      children: [
                        Flexible(
                          child: MyTextField(
                            focusNode: _firstname,
                            // horizontal: 10,
                            hintText: AppLocalizations.of(context)!.firstname,
                            // hintText: Strings.SIGNUP_FIRSTNAME_LABEL_TEXT,
                            obscureText: false,
                            maxLines: 1,
                            controller: firstnameController,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              String? err = validateFirstname(value);
                              if (err != null) {
                                _firstname.requestFocus();
                              }
                              return err;
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Flexible(
                          child: MyTextField(
                            focusNode: _secondname,
                            // horizontal: 10,
                            hintText: AppLocalizations.of(context)!.lastname,
                            // hintText: Strings.SIGNUP_LASTNAME_LABEL_TEXT,
                            obscureText: false,
                            maxLines: 1,
                            controller: lastnameController,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              String? err = validateLastname(value);
                              if (err != null) {
                                _secondname.requestFocus();
                              }
                              return err;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    MyTextField(
                      // horizontal: 20,
                      focusNode: _email,
                      hintText: AppLocalizations.of(context)!.email,
                      // hintText: Strings.SIGNUP_EMAIL_LABEL_TEXT,
                      obscureText: false,
                      maxLines: 1,
                      controller: emailController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        String? err = validateEmail(value);
                        if (err != null) {
                          _email.requestFocus();
                        }
                        return err;
                      },
                    ),
                    const SizedBox(height: 20),
                    MyTextField(
                      // horizontal: 20,
                      focusNode: _password,
                      // hintText: Strings.SINGUP_PASSWORD_LABEL_TEXT,
                      hintText: AppLocalizations.of(context)!.password,
                      obscureText: true,
                      maxLines: 1,
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        String? err = validatePassword(value);
                        if (err != null) {
                          _password.requestFocus();
                        }
                        return err;
                      },
                    ),
                    const SizedBox(height: 20),
                    MyTextField(
                      // horizontal: 20,
                      focusNode: _repassword,
                      hintText: AppLocalizations.of(context)!.reentepassword,
                      // hintText: Strings.SINGUP_REPASSWORD_LABEL_TEXT,
                      obscureText: true,
                      maxLines: 1,
                      controller: repasswordController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        String? err = validatePassword(value);
                        if (err != null) {
                          _repassword.requestFocus();
                        }
                        return err;
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Checkbox(
                            checkColor: AppColors.secondaryColor,
                            fillColor: MaterialStateProperty.resolveWith(getColor),
                            value: isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked = value!;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Text(
                            AppLocalizations.of(context)!.wedidlovetosendyousomeamazingoffer,
                            // Strings.SIGNUP_TEXT1,
                            style: GoogleFonts.openSans(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: AppColors.primaryWhiteColor,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Center(
                      child: MyButton(
                        Textfontsize: 16,
                        TextColors: Colors.white,
                        text: AppLocalizations.of(context)!.signup,
                        // text: Strings.SINGUP_BUTTON_TEXT,
                        color: isChecked
                            ? AppColors.secondaryColor
                            : AppColors.primaryGrayColor,
                        width: 340,
                        height: 40,
                        onTap: isChecked
                            ? () {
                                if (passwordConfirmed()) {
                                  if (_formKey.currentState!.validate()) {
                                    context.push(
                                      '/signUpCalenderScreen',
                                      extra: SignUpArgumentClass(
                                        firsname: firstnameController.text,
                                        lastName: lastnameController.text,
                                        email: widget.from == "Email"
                                            ? emailController.text
                                            : gmailController.text,
                                        password: passwordController.text,
                                        confirmPassword: repasswordController.text,
                                      ),
                                    );
                                  } else {
                                    Fluttertoast.showToast(
                                      msg: AppLocalizations.of(context)!.allfieldsareimportant,
                                      // msg: "All fields are important",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor: Colors.black87,
                                      textColor: Colors.white,
                                    );
                                  }
                                } else {
                                  Fluttertoast.showToast(
                                    msg: AppLocalizations.of(context)!.allfieldsareimportant,
                                    // msg: "Enter correct password",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor: Colors.black87,
                                    textColor: Colors.white,
                                  );
                                }
                              }
                            : null,
                        showImage: false,
                        imagePath: '',
                        imagewidth: 0,
                        imageheight: 0,
                      ),
                    ),
                    const SizedBox(height: 15),
                    const TermsAndConditionWidget(),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(onPressed: () {
              context.pop();
            }, icon: const Icon(Icons.arrow_back_ios,),color: AppColors.primaryWhiteColor,),
          ),

        ],
      ),
    );
  }
}

class TermsAndConditionWidget extends StatelessWidget {
  const TermsAndConditionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 13),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text :AppLocalizations.of(context)!.bysigningupyouagreetothe,
              // text: 'By signing up, you agree to the',
              style: GoogleFonts.openSans(
                color: AppColors.primaryWhiteColor,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.8,
              ),
            ),
            TextSpan(
              text: ' ',
              style: GoogleFonts.openSans(
                color: AppColors.primaryWhiteColor,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.8,
              ),
            ),
            TextSpan(
              text :AppLocalizations.of(context)!.termsandconditions,
              // text: 'Terms and Conditions\n',
              style: GoogleFonts.openSans(
                color: AppColors.secondaryColor,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.8,
              ),
            ),
            TextSpan(
              text : AppLocalizations.of(context)!.andour,
              // text: 'and our',
              style: GoogleFonts.openSans(
                color: AppColors.primaryWhiteColor,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.8,
              ),
            ),
            TextSpan(
              text: ' ',
              style: GoogleFonts.openSans(
                color: AppColors.secondaryColor,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.8,
              ),
            ),
            TextSpan(
              text: AppLocalizations.of(context)!.privacypolicy,
              // text: 'Privacy Policy',
              style: GoogleFonts.openSans(
                color: AppColors.secondaryColor,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
