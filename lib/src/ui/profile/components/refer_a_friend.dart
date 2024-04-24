import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_collect/language.dart';
import 'package:lets_collect/src/bloc/language/language_bloc.dart';
import 'package:lets_collect/src/bloc/referral_bloc/referral_bloc.dart';
import 'package:lets_collect/src/components/Custome_Textfiled.dart';
import 'package:lets_collect/src/components/my_button.dart';
import 'package:lets_collect/src/constants/assets.dart';
import 'package:lets_collect/src/constants/colors.dart';
import 'package:lets_collect/src/model/referral/referral_friend_request.dart';
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
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _nameFocus = FocusNode();

  bool networkSuccess = false;
  int index = 0;
  String referralID = "0";
  String pageTitle = "";
  String pageContent = "";

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
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
        body: BlocConsumer<NetworkBloc, NetworkState>(
          listener: (context, state) {
            if (state is NetworkSuccess) {
              networkSuccess = true;
            }
          },
          builder: (context, state) {
            if (state is NetworkSuccess) {
              return BlocConsumer<ReferralBloc, ReferralState>(
                listener: (context, state) {
                  if(state is ReferralListLoading){
                    Center(
                      child: Lottie.asset(Assets.JUMBINGDOT,
                          height: 200, width: 200),
                    );
                  }
                  if (state is ReferralListLoaded) {
                    if (state.referralListResponse.success == true) {
                      referralID = state.referralListResponse.data[index].referralId.toString();
                      print("referralId == ${referralID}");

                      pageTitle = context.read<LanguageBloc>().state.selectedLanguage == Language.english
                          ? state.referralListResponse.cmsData.pageTitle
                          : state.referralListResponse.cmsData.pageTitleArabic;

                      pageContent =
                      context.read<LanguageBloc>().state.selectedLanguage == Language.english
                          ? state.referralListResponse.cmsData.pageContent
                          : state.referralListResponse.cmsData.pageContentArabic;
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

                  return Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: SizedBox(
                          // height: MediaQuery.of(context).size.height,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 40,
                              ),
                              state is ReferralListLoaded
                                  ? Expanded(
                                flex: 0,
                                child: Center(
                                  child: Lottie.asset(Assets.CHOOSE,
                                      height: 200, width: 200),
                                ),
                              )
                                  : SizedBox(),
                              state is ReferralListLoaded
                                  ?Expanded(
                                flex: 0,
                                child: Center(
                                  child: ClipOval(
                                    child: SvgPicture.asset(
                                      Assets.SHADE_SVG,
                                      fit: BoxFit.cover,
                                      height: 12,
                                    ),
                                  ),
                                ),
                              )
                                  : SizedBox(),
                              const SizedBox(height: 35),
                              state is ReferralListLoaded
                                  ?Expanded(
                                flex: 0,
                                child: Text(AppLocalizations.of(context)!.termsandconditions,
                                    style: GoogleFonts.roboto(
                                        color: AppColors.secondaryColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16)),
                              )
                                  : SizedBox(),
                              const SizedBox(height: 20),
                              state is ReferralListLoaded
                                  ? Expanded(
                                flex: 0,
                                child: Text(pageContent),
                              )
                                  : Center(
                                child: Lottie.asset(Assets.JUMBINGDOT,
                                    height: 500, width: 100),
                              ),
                              const SizedBox(
                                height: 35,
                              ),
                              state is ReferralListLoaded
                                  ? Expanded(
                                flex: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryWhiteColor,
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
                                )
                                    .animate()
                                    .scale(delay: 200.ms, duration: 300.ms),
                              )
                                  : SizedBox(),
                              const SizedBox(height: 35),
                              state is ReferralListLoaded
                                  ? Expanded(
                                flex: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryWhiteColor,
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
                                    hintText:
                                    AppLocalizations.of(context)!.email,
                                    obscureText: false,
                                    maxLines: 1,
                                    controller: emailController,
                                    keyboardType: TextInputType.text,
                                    focusNode: _emailFocus,
                                  ),
                                )
                                    .animate()
                                    .scale(delay: 200.ms, duration: 300.ms),
                              )
                                  :  SizedBox(),
                              const SizedBox(
                                height: 20,
                              ),
                              state is ReferralListLoaded
                                  ? Expanded(
                                flex: 0,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 15,bottom: 20),
                                  child: Center(
                                    child: BlocBuilder<ReferralBloc,
                                        ReferralState>(
                                      builder: (context, state) {
                                        if (state is ReferralFriendLoading) {
                                          return const Center(
                                            child: RefreshProgressIndicator(
                                              color:
                                              AppColors.primaryWhiteColor,
                                              backgroundColor:
                                              AppColors.secondaryColor,
                                            ),
                                          );
                                        }
                                        return MyButton(
                                          Textfontsize: 16,
                                          TextColors: AppColors.primaryWhiteColor,
                                          // text: "Submit",
                                          text: AppLocalizations.of(context)!
                                              .submit,
                                          color: AppColors.secondaryColor,
                                          width: 340,
                                          height: 40,

                                          onTap: () {
                                            if (nameController.text.isEmpty ||
                                                emailController.text.isEmpty) {
                                              Fluttertoast.showToast(
                                                msg: AppLocalizations.of(
                                                    context)!
                                                    .allfieldsareimportant,
                                                toastLength: Toast.LENGTH_LONG,
                                                gravity: ToastGravity.BOTTOM,
                                                backgroundColor:
                                                AppColors.secondaryColor,
                                                textColor:
                                                AppColors.primaryWhiteColor,
                                              );
                                              return;
                                            }

                                            String? emailValidation =
                                            validateEmail(
                                                emailController.text);
                                            if (emailValidation != null) {
                                              Fluttertoast.showToast(
                                                msg: emailValidation,
                                                toastLength: Toast.LENGTH_LONG,
                                                gravity: ToastGravity.BOTTOM,
                                                backgroundColor:
                                                AppColors.secondaryColor,
                                                textColor:
                                                AppColors.primaryWhiteColor,
                                              );
                                              return; // Stop further execution
                                            }

                                            if (_formKey.currentState!
                                                .validate()) {
                                              BlocProvider.of<ReferralBloc>(
                                                  context)
                                                  .add(GetReferralFriendEvent(
                                                referralFriendRequest:
                                                ReferralFriendRequest(
                                                  referralId:
                                                  referralID.toString(),
                                                  name: nameController.text,
                                                  email: emailController.text,
                                                ),
                                              ));
                                              print(
                                                  "referralId = ${referralID.toString()}");
                                              print(
                                                  "Subject = $nameController");
                                              print(
                                                  "Message = $emailController");
                                            } else {
                                              Fluttertoast.showToast(
                                                msg: AppLocalizations.of(
                                                    context)!
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
                                        );
                                      },
                                    ),
                                  ),
                                )
                                    .animate()
                                    .scale(delay: 200.ms, duration: 300.ms),
                              )
                                  : SizedBox(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
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
            }
            return const SizedBox();
          },
        ),
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
          BlocProvider.of<ReferralBloc>(context).add(GetReferralListEvent());
          nameController.clear();
          emailController.clear();
          context.pop();
          return false;
        },
        child:
        BlocBuilder<ReferralBloc, ReferralState>(builder: (context, state) {
          if (state is ReferralFriendLoaded) {
            if (state.referralFriendRequestResponse.success == true) {
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
                            BlocProvider.of<ReferralBloc>(context).add(GetReferralListEvent());
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
                              ? state.referralFriendRequestResponse.message
                              : state
                              .referralFriendRequestResponse.messageArabic,
                          // AppLocalizations.of(context)!.referralsendseuccessfully,
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
                            BlocProvider.of<ReferralBloc>(context).add(GetReferralListEvent());
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
            } else {
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
                              BlocProvider.of<ReferralBloc>(context).add(GetReferralListEvent());
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
                            context.read<LanguageBloc>().state.selectedLanguage == Language.english
                                ? state.referralFriendRequestResponse.message
                                : state.referralFriendRequestResponse.messageArabic,
                            // AppLocalizations.of(context)!.useralreadyregistered,
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
                              BlocProvider.of<ReferralBloc>(context).add(GetReferralListEvent());
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
                              BlocProvider.of<ReferralBloc>(context).add(GetReferralListEvent());
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
                                ? state.referralFriendRequestResponse.message
                                : state.referralFriendRequestResponse
                                .messageArabic,
                            // AppLocalizations.of(context)!.invalidreferral,
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
                            AppLocalizations.of(context)!
                                .pleaselogoutandreopentheapplication,
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
                              BlocProvider.of<ReferralBloc>(context).add(GetReferralListEvent());
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
                            context
                                .read<LanguageBloc>()
                                .state
                                .selectedLanguage ==
                                Language.english
                                ? state.referralFriendRequestResponse.message
                                : state.referralFriendRequestResponse
                                .messageArabic,
                            // AppLocalizations.of(context)!.invalidreferral,
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
                              BlocProvider.of<ReferralBloc>(context).add(GetReferralListEvent());
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
                          BlocProvider.of<ReferralBloc>(context).add(GetReferralListEvent());
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
                        context.read<LanguageBloc>().state.selectedLanguage == Language.english
                            ? state.errorMsg
                            : AppLocalizations.of(context)!.oopslookslikewearefacing,
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
                          BlocProvider.of<ReferralBloc>(context).add(GetReferralListEvent());
                        },
                        TextColors: AppColors.primaryWhiteColor,
                        Textfontsize: 16,
                        showImage: false,
                        imagePath: "",
                        imagewidth: 0,
                        imageheight: 0)
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