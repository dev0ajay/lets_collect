import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_collect/src/components/Custome_Textfiled.dart';
import 'package:lets_collect/src/components/my_button.dart';
import 'package:lets_collect/src/constants/assets.dart';
import 'package:lets_collect/src/constants/colors.dart';
import 'package:lets_collect/src/utils/network_connectivity/bloc/network_bloc.dart';
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
  final FocusNode _subjectFocus = FocusNode();
  bool networkSuccess= false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocConsumer<NetworkBloc, NetworkState>(
      listener: (context, state) {
        if (state is NetworkSuccess) {
          networkSuccess = true;
        }
      },
      builder: (context, state) {
        if (state is NetworkSuccess) {
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
                            child: SvgPicture.asset(
                              Assets.APP_LOGO,
                              fit: BoxFit.cover,
                              height: 40,
                            ),
                          )
                              .animate()
                              .scale(delay: 200.ms, duration: 300.ms),
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
                          Text("Referral Program Terms and Conditions",style: GoogleFonts.roboto(
                              color: AppColors.secondaryColor, fontWeight: FontWeight.w400,fontSize: 16)),
                          const SizedBox(height: 5),
                          Text("By participating in the [Your App Name] Referral Program ('Program'), you agree to be bound by these terms and conditions. Please read them carefully before participating."),
                          const SizedBox(height: 15),
                          Text("Eligibility:",style: GoogleFonts.roboto(
                              color: AppColors.secondaryColor, fontWeight: FontWeight.w400,fontSize: 16)) ,
                          const SizedBox(height: 5),
                          Text("The Program is open to all users of the [Your App Name] mobile application."),
                          const SizedBox(height: 5),
                          Text("Participants must be of legal age in their jurisdiction to participate.") ,
                          const SizedBox(height: 5),
                          Text("Employees, contractors, and affiliates of [Your Company Name] are not eligible to participate"),
                          const SizedBox(height: 35,),
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
                              hintText : AppLocalizations.of(context)!.subject,
                              obscureText: false,
                              maxLines: 1,
                              controller: nameController,
                              keyboardType: TextInputType.text,
                              focusNode: _subjectFocus,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '';
                                }
                                return null;
                              },
                            ),
                          ).animate().scale(delay: 200.ms, duration: 300.ms),
                          const SizedBox(height: 35),
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
                            // hintText: "Email",
                            hintText : AppLocalizations.of(context)!.email,
                            obscureText: false,
                            maxLines: 1,
                            controller: emailController,
                            keyboardType: TextInputType.text,
                            focusNode: _subjectFocus,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '';
                              }
                              return null;
                            },
                          ),
                        ).animate().scale(delay: 200.ms, duration: 300.ms),
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
                              // hintText: "Pone Number",
                              hintText : AppLocalizations.of(context)!.phonenumber,
                              obscureText: false,
                              maxLines: 1,
                              controller: mobileNumberController,
                              keyboardType: TextInputType.text,
                              focusNode: _subjectFocus,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '';
                                }
                                return null;
                              },
                            ),
                          ).animate().scale(delay: 200.ms, duration: 300.ms),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child:Center(
                              child: MyButton(
                                Textfontsize: 16,
                                TextColors: Colors.white,
                                // text: "Submit",
                                text : AppLocalizations.of(context)!.submit,
                                color: AppColors.secondaryColor,
                                width: 340,
                                height: 40,
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {

                                    print("Subject = $nameController");
                                    print("Message = $emailController");
                                    print("Message = $mobileNumberController");

                                  } else {
                                    Fluttertoast.showToast(
                                      // msg: "All Fields are important",
                                      msg:  AppLocalizations.of(context)!
                                          .allfieldsareimportant,
                                      toastLength: Toast.LENGTH_LONG,
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
                              ),
                            ),
                          )
                              .animate()
                              .scale(delay: 200.ms, duration: 300.ms),
                        ],
                      ),
                    ),
                  ),
                ),
              ));
        } else if (state is NetworkFailure) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(Assets.NO_INTERNET),
                Text(
                  AppLocalizations.of(context)!.youarenotconnectedtotheinternet,
                  // "You are not connected to the internet",
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
    );
  }
}
