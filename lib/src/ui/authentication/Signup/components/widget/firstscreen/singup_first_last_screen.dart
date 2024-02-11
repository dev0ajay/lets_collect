import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_collect/src/components/Custome_Textfiled.dart';
import 'package:lets_collect/src/components/my_button.dart';
import 'package:lets_collect/src/constants/assets.dart';
import 'package:lets_collect/src/constants/strings.dart';
import 'package:lets_collect/src/ui/authentication/Signup/components/widget/firstscreen/sign_up_argument_class.dart';
import '../../../../../../bloc/nationality_bloc/nationality_bloc.dart';
import '../../../../../../constants/colors.dart';

class SignupUiwidget1 extends StatefulWidget {
  const SignupUiwidget1({super.key});

  @override
  State<SignupUiwidget1> createState() => _SignupUiwidget1State();
}

class _SignupUiwidget1State extends State<SignupUiwidget1> {
  bool isChecked = false;
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repasswordController = TextEditingController();

  FocusNode _firstname = FocusNode();
  FocusNode _secondname = FocusNode();
  FocusNode _email = FocusNode();
  FocusNode _password = FocusNode();
  FocusNode _repassword = FocusNode();

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
      return 'Enter first name';
    } else {
      return null;
    }
  }

  String? validateLastname(String? value) {
    String pattern = "["
        "a-zA-Z]";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value)) {
      return 'Enter last name';
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
      return 'Enter a new email address';
    } else {
      return null;
    }
  }

  String? validatePassword(String? value) {
    String pattern =
        r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty) {
      return 'Please enter password';
    }
    if (value.length < 8) {
      return "Length should be 8 or more";
    }
    if (!regex.hasMatch(value)) {
      return "Must contain at least 1 uppercase, 1 lowercase, 1 special character";
    }
    return null;
  }
  @override
  void initState() {
    super.initState();
    // BlocProvider.of<NationalityBloc>(context).add(GetNationality());

  }

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        // MaterialState.hovered,
        // MaterialState.focused,
      };
      // if (states.any(interactiveStates.contains)) {
      //   return Colors.blue;
      // }
      return Colors.white;
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
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
              )).animate().then(delay: 200.ms).slideX(),
              const Center(
                child: Image(
                  image: AssetImage(Assets.APP_LOGO),
                  width: 100,
                  height: 80,
                ),
              ).animate().then(delay: 200.ms).slideX(),
              const SizedBox(height: 20),
               Center(
                  child: Text(
                Strings.SIGNUP_SUB_HEADING,
                style: GoogleFonts.openSans(
                  color: AppColors.primaryWhiteColor,fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              )).animate().then(delay: 200.ms).slideX(),
              const SizedBox(height: 40),
              Row(
                children: [
                  Flexible(
                    child: MyTextField(
                      focusNode: _firstname,
                      // horizontal: 10,
                      hintText: Strings.SIGNUP_FIRSTNAME_LABEL_TEXT,
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
                      hintText: Strings.SIGNUP_LASTNAME_LABEL_TEXT,
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
              ).animate().then(delay: 200.ms).slideX(),
              const SizedBox(
                height: 20
              ),
              MyTextField(
                // horizontal: 20,
                focusNode: _email,
                hintText: Strings.SIGNUP_EMAIL_LABEL_TEXT,
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
              ).animate().then(delay: 200.ms).slideX(),
              const SizedBox(
                height: 20,
              ),
              MyTextField(
                // horizontal: 20,
                focusNode: _password,
                hintText: Strings.SINGUP_PASSWORD_LABEL_TEXT,
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
              ).animate().then(delay: 200.ms).slideX(),
              const SizedBox(height: 20),
              MyTextField(
                // horizontal: 20,
                focusNode: _repassword,
                hintText: Strings.SINGUP_REPASSWORD_LABEL_TEXT,
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
              ).animate().then(delay: 200.ms).slideX(),
              const SizedBox(
                height: 20,
              ),
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
                      Strings.SIGNUP_TEXT1,
                      style: GoogleFonts.openSans(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primaryWhiteColor,
                        letterSpacing: 1,
                      ),
                                       ),
                   ),
                ],
              ).animate().then(delay: 200.ms).slideX(),
              const SizedBox(height: 15),
              Center(
                child: MyButton(
                  Textfontsize: 16,
                  TextColors: Colors.white,
                  text: Strings.SINGUP_BUTTON_TEXT,
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
                                  email: emailController.text,
                                  password: passwordController.text,
                                  confirmPassword: repasswordController.text,
                                ),
                              );
                            } else {
                              Fluttertoast.showToast(
                                msg: "All fields are important",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.black87,
                                textColor: Colors.white,
                              );
                            }
                          } else {
                            Fluttertoast.showToast(
                              msg: "Enter correct password",
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
              ).animate().then(delay: 200.ms).slideX(),
              const SizedBox(height: 15),
               const TermsAndConditionWidget().animate().then(delay: 200.ms).slideX(),
            ],
          ),
        ),
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
             text: 'By signing up, you agree to the',
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
             text: 'Terms and Conditions\n',
             style: GoogleFonts.openSans(
               color: AppColors.secondaryColor,
               fontSize: 12,
               fontWeight: FontWeight.w600,
               letterSpacing: 0.8,
             ),
           ),
           TextSpan(
             text: 'and our',
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
             text: 'Privacy Policy',
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
