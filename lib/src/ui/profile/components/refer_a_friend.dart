import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_collect/src/bloc/referral_bloc/referral_bloc.dart';
import 'package:lets_collect/src/components/Custome_Textfiled.dart';
import 'package:lets_collect/src/components/my_button.dart';
import 'package:lets_collect/src/constants/assets.dart';
import 'package:lets_collect/src/constants/colors.dart';
import 'package:lets_collect/src/model/referral/referral_friend_request.dart';
import 'package:lets_collect/src/utils/screen_size/size_config.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReferralScreen extends StatefulWidget {
  const ReferralScreen({super.key});

  @override
  State<ReferralScreen> createState() => _ReferralScreenState();
}

class _ReferralScreenState extends State<ReferralScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _nameFocus = FocusNode();

  bool networkSuccess = false;
  int index = 0;
  int referralId = 0;

  String? validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value)) {
      return AppLocalizations.of(context)!.enteravalidemailaddress;
    } else {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ReferralBloc>(context).add(GetReferralListEvent());
    // BlocProvider.of<ReferralBloc>(context).add(GetReferralFriendEvent(referralFriendRequest: ReferralFriendRequest(referralId: '', name: '', email: '')));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocConsumer<ReferralBloc, ReferralState>(
      listener: (context, state) {
        // if (state is ReferralListLoading) {
          // const Center(
          //   heightFactor: 10,
          //   child: RefreshProgressIndicator(
          //     color: AppColors.secondaryColor,
          //   ),
          // );
        // }
        if (state is ReferralListLoaded) {
          if (state.referralListResponse.success == true) {
            referralId = state.referralListResponse.data[index].referralId;
            print(
                "referralId == ${state.referralListResponse.data[index].referralId}");
          }
        }
        if (state is ReferralListLoaded) {
          if (state.referralListResponse.success == false) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: AppColors.secondaryColor,
                content: Text(
                  AppLocalizations.of(context)!.someerroroccurred,
                  // "Some Error Happened",
                  style: GoogleFonts.openSans(
                    color: AppColors.primaryWhiteColor,
                  ),
                ),
              ),
            );
          }
        }

        if (state is ReferralFriendLoading) {
          const Center(
            heightFactor: 10,
            child: RefreshProgressIndicator(
              color: AppColors.secondaryColor,
            ),
          );
        }
        if (state is ReferralFriendLoaded) {
          if (state.referralFriendRequestResponse.success == true) {
            _showDialogBox(context: context);
          }
        }
        if (state is ReferralFriendLoaded) {
          if (state.referralFriendRequestResponse.success == false &&
              state.referralFriendRequestResponse.message ==
                  "User already registered.") {
            _showDialogBox(context: context);
          }
        }

        if (state is ReferralFriendLoaded) {
          if (state.referralFriendRequestResponse.success == false &&
              state.referralFriendRequestResponse.message ==
                  "Invalid Referral") {
            _showDialogBox(context: context);
          }
        }

        if (state is ReferralFriendLoaded) {
          if (state.referralFriendRequestResponse.success == false &&
              state.referralFriendRequestResponse.message ==
                  "Referral Expired") {
            _showDialogBox(context: context);
          }
        }


        if (state is ReferralFriendLoaded) {
          if (state is ReferralFriendError) {
            _showDialogBox(context: context);
          }
        }
      },
      builder: (context, state) {
        return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: AppColors.primaryColor,
                leading: IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_outlined,
                      color: AppColors.primaryWhiteColor,
                    )),
                title: Text(
                  // "Refer a Friend",
                  AppLocalizations.of(context)!.referafriend,
                  style: GoogleFonts.openSans(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryWhiteColor,
                  ),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        Center(
                            child: Lottie.asset(Assets.CHOOSE,
                                height: 200, width: 200)),
                        Center(
                          child: ClipOval(
                            child: SvgPicture.asset(
                              Assets.SHADE_SVG,
                              fit: BoxFit.cover,
                              height: 12,
                            ),
                          ),
                        ),
                        const SizedBox(height: 35),
                        Text("Referral Program Terms and Conditions",
                            style: GoogleFonts.roboto(
                                color: AppColors.secondaryColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 16)),
                        const SizedBox(height: 5),
                        const Text(
                            "By participating in the [Your App Name] Referral Program ('Program'), you agree to be bound by these terms and conditions. Please read them carefully before participating."),
                        const SizedBox(height: 15),
                        Text("Eligibility:",
                            style: GoogleFonts.roboto(
                                color: AppColors.secondaryColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 16)),
                        const SizedBox(height: 5),
                        const Text(
                            "The Program is open to all users of the [Your App Name] mobile application."),
                        const SizedBox(height: 5),
                        const Text(
                            "Participants must be of legal age in their jurisdiction to participate."),
                        const SizedBox(height: 5),
                        const Text(
                            "Employees, contractors, and affiliates of [Your Company Name] are not eligible to participate"),
                        const SizedBox(
                          height: 35,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: const Offset(3, 3),
                              ),
                            ],
                          ),
                          child: MyTextField(
                            // hintText: "Subject",
                            hintText: AppLocalizations.of(context)!.friendname,
                            obscureText: false,
                            maxLines: 1,
                            controller: nameController,
                            keyboardType: TextInputType.text,
                            focusNode: _nameFocus,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '';
                              }
                              return null;
                            },
                          ),
                        ).animate().scale(delay: 200.ms, duration: 300.ms),
                        const SizedBox(height: 35),

                        // Container(
                        //   decoration: BoxDecoration(
                        //     color: Colors.white,
                        //     borderRadius: BorderRadius.circular(8.0),
                        //     boxShadow: [
                        //       BoxShadow(
                        //         color: Colors.grey.withOpacity(0.5),
                        //         spreadRadius: 1,
                        //         blurRadius: 1,
                        //         offset: const Offset(3, 3),
                        //       ),
                        //     ],
                        //   ),
                        //   child: MyTextField(
                        //     // hintText: "Email",
                        //     hintText: AppLocalizations.of(context)!.email,
                        //     obscureText: false,
                        //     maxLines: 1,
                        //     controller: emailController,
                        //     keyboardType: TextInputType.text,
                        //     focusNode: _emailFocus,
                        //     validator: (value) {
                        //       String? err = validateEmail(value) as String?;
                        //       if (err != null) {
                        //         _emailFocus.requestFocus();
                        //       }
                        //       return err;
                        //     },
                        //   ),
                        // ).animate().scale(delay: 200.ms, duration: 300.ms),

                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: const Offset(3, 3),
                              ),
                            ],
                          ),
                          child: MyTextField(
                            hintText: AppLocalizations.of(context)!.email,
                            obscureText: false,
                            maxLines: 1,
                            controller: emailController,
                            keyboardType: TextInputType.text,
                            focusNode: _emailFocus,
                          ),
                        ).animate().scale(delay: 200.ms, duration: 300.ms),

                        // const SizedBox(
                        //   height: 35,
                        // ),
                        // Container(
                        //   decoration: BoxDecoration(
                        //     color: Colors.white,
                        //     borderRadius: BorderRadius.circular(8.0),
                        //     boxShadow: [
                        //       BoxShadow(
                        //         color: Colors.grey.withOpacity(0.5),
                        //         spreadRadius: 1,
                        //         blurRadius: 1,
                        //         offset: const Offset(3, 3),
                        //       ),
                        //     ],
                        //   ),
                        //   child: MyTextField(
                        //     // hintText: "Pone Number",
                        //     hintText : AppLocalizations.of(context)!.phonenumber,
                        //     obscureText: false,
                        //     maxLines: 1,
                        //     controller: mobileNumberController,
                        //     keyboardType: TextInputType.text,
                        //     focusNode: _subjectFocus,
                        //     validator: (value) {
                        //       if (value == null || value.isEmpty) {
                        //         return '';
                        //       }
                        //       return null;
                        //     },
                        //   ),
                        // ).animate().scale(delay: 200.ms, duration: 300.ms),
                        const SizedBox(
                          height: 20,
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Center(
                            child: BlocBuilder<ReferralBloc, ReferralState>(
                              builder: (context, state) {
                                if (state is ReferralFriendLoading) {
                                  return const Center(
                                    child: RefreshProgressIndicator(
                                      color: AppColors.primaryWhiteColor,
                                      backgroundColor: AppColors.secondaryColor,
                                    ),
                                  );
                                }
                                return MyButton(
                                  Textfontsize: 16,
                                  TextColors: Colors.white,
                                  // text: "Submit",
                                  text: AppLocalizations.of(context)!.submit,
                                  color: AppColors.secondaryColor,
                                  width: 340,
                                  height: 40,

                                  onTap: () {
                                    if (nameController.text.isEmpty ||
                                        emailController.text.isEmpty) {
                                      Fluttertoast.showToast(
                                        msg: AppLocalizations.of(context)!
                                            .allfieldsareimportant,
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM,
                                        backgroundColor:
                                            AppColors.secondaryColor,
                                        textColor: AppColors.primaryWhiteColor,
                                      );
                                      return;
                                    }

                                    String? emailValidation =
                                        validateEmail(emailController.text);
                                    if (emailValidation != null) {
                                      Fluttertoast.showToast(
                                        msg: emailValidation,
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM,
                                        backgroundColor:
                                            AppColors.secondaryColor,
                                        textColor: AppColors.primaryWhiteColor,
                                      );
                                      return; // Stop further execution
                                    }

                                    // Your existing logic for submitting the referral friend request
                                    if (_formKey.currentState!.validate()) {
                                      BlocProvider.of<ReferralBloc>(context)
                                          .add(GetReferralFriendEvent(
                                        referralFriendRequest:
                                            ReferralFriendRequest(
                                          referralId: referralId.toString(),
                                          name: nameController.text,
                                          email: emailController.text,
                                        ),
                                      ));
                                      print(
                                          "referralId = ${referralId.toString()}");
                                      print("Subject = $nameController");
                                      print("Message = $emailController");
                                    } else {
                                      Fluttertoast.showToast(
                                        msg: AppLocalizations.of(context)!
                                            .allfieldsareimportant,
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM,
                                        backgroundColor:
                                            AppColors.secondaryColor,
                                        textColor: AppColors.primaryWhiteColor,
                                      );
                                    }
                                  },

                                  // onTap: () {
                                  //   if (_formKey.currentState!.validate()) {
                                  //     BlocProvider.of<ReferralBloc>(context)
                                  //         .add(GetReferralFriendEvent(
                                  //             referralFriendRequest:
                                  //                 ReferralFriendRequest(
                                  //                     referralId:
                                  //                         referralId.toString(),
                                  //                     name: nameController.text
                                  //                         .toString(),
                                  //                     email: emailController
                                  //                         .text
                                  //                         .toString())));
                                  //     print(
                                  //         "referralId = ${referralId.toString()}");
                                  //     print("Subject = $nameController");
                                  //     print("Message = $emailController");
                                  //     // print("Message = $mobileNumberController");
                                  //   } else {
                                  //     Fluttertoast.showToast(
                                  //       // msg: "All Fields are important",
                                  //       msg: AppLocalizations.of(context)!
                                  //           .allfieldsareimportant,
                                  //       toastLength: Toast.LENGTH_LONG,
                                  //       gravity: ToastGravity.BOTTOM,
                                  //       backgroundColor:
                                  //           AppColors.secondaryColor,
                                  //       textColor: AppColors.primaryWhiteColor,
                                  //     );
                                  //   }
                                  // },
                                  showImage: false,
                                  imagePath: '',
                                  imagewidth: 0,
                                  imageheight: 0,
                                );
                              },
                            ),
                          ),
                        ).animate().scale(delay: 200.ms, duration: 300.ms),
                      ],
                    ),
                  ),
                ),
              ),
            ));
      },
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
        child: BlocBuilder<ReferralBloc, ReferralState>(
            // "Invalid Referral"

          builder: (context, state) {
            if(state is ReferralFriendLoaded){
              if (state.referralFriendRequestResponse.success == true){
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
                              nameController.clear();
                              emailController.clear();
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
                            AppLocalizations.of(context)!.referralsendseuccessfully,
                            // "Referral send Successfully",
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
                              nameController.clear();
                              emailController.clear();
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
              else{
                if (state.referralFriendRequestResponse.success == false &&
                    state.referralFriendRequestResponse.message ==
                        "User already registered.") {
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
                                nameController.clear();
                                emailController.clear();
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
                              AppLocalizations.of(context)!.useralreadyregistered,
                              // "User already registered.!",
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
                                nameController.clear();
                                emailController.clear();
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
                if (state.referralFriendRequestResponse.success == false &&
                    state.referralFriendRequestResponse.message ==
                        "Invalid Referral") {
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
                                nameController.clear();
                                emailController.clear();
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
                              AppLocalizations.of(context)!.invalidreferral,
                              // "Invalid Referral",
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
                              AppLocalizations.of(context)!.pleaselogoutandreopentheapplication,
                              // "Please Logout and re-open the Application !",
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
                                nameController.clear();
                                emailController.clear();
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
                if (state.referralFriendRequestResponse.success == false &&
                    state.referralFriendRequestResponse.message ==
                        "Referral Expired") {
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
                                nameController.clear();
                                emailController.clear();
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
                              AppLocalizations.of(context)!.invalidreferral,
                              // "Invalid Referral",
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
                              // "Please Logout and re-open the Application !",
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
                                nameController.clear();
                                emailController.clear();
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
            if (state is ReferralFriendError) {
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
                            nameController.clear();
                            emailController.clear();
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
                          state.errorMsg,
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
                            nameController.clear();
                            emailController.clear();
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
            }
        ),
      ),
    );
  }
}
