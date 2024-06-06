import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_collect/src/bloc/home_bloc/home_bloc.dart';
import 'package:lets_collect/src/bloc/referral_bloc/referral_bloc.dart';
import 'package:lets_collect/src/components/my_button.dart';
import 'package:lets_collect/src/constants/colors.dart';
import 'package:lets_collect/src/model/referral/referral_code_update_request.dart';
import 'package:lets_collect/src/utils/network_connectivity/bloc/network_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../../../language.dart';
import '../../../../bloc/language/language_bloc.dart';
import '../../../../constants/assets.dart';
import '../../../../utils/data/object_factory.dart';
import '../../../../utils/screen_size/size_config.dart';
import '../../../special_offer/components/offer_details_arguments.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'emailNotVerifiedAlertOverlay.dart';
import 'email_verified_alert_overlay.dart';

class CustomScrollViewWidget extends StatefulWidget {
  final Function(int) onIndexChanged;

  const CustomScrollViewWidget({super.key, required this.onIndexChanged});

  @override
  State<CustomScrollViewWidget> createState() => _CustomScrollViewWidgetState();
}

class _CustomScrollViewWidgetState extends State<CustomScrollViewWidget> {
  int carouselIndex = 0;
  bool networkSuccess = false;
  late bool _isEmailVerified = false;
  late bool _isEmailNotVerifyExecuted = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController referralController = TextEditingController();

  ///Url Launcher
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
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocConsumer<NetworkBloc, NetworkState>(
      builder: (context, state) {
        if (state is NetworkSuccess) {
          return BlocConsumer<HomeBloc, HomeState>(
            listener: (context, state) {
              if (state is HomeLoaded) {
                if (!_isEmailVerified && !_isEmailNotVerifyExecuted) {
                  if (state.homeResponse.emailVerified == 1) {
                    _isEmailVerified = true;
                    ObjectFactory().prefs.setIsEmailVerified(true);
                    if(ObjectFactory().prefs.isEmailVerified()!) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            const EmailVerifiedAlertOverlay());
                    }
                  } else if (state.homeResponse.emailVerified == 0 &&
                      !_isEmailNotVerifyExecuted ) {
                    _isEmailNotVerifyExecuted = true;

                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          const EmailNotVerifiedAlertOverlay(),
                    );
                  }
                }
              }
            },
            builder: (context, state) {
              if (state is HomeLoading) {
                return const Center(
                  child: RefreshProgressIndicator(
                    color: AppColors.secondaryColor,
                    backgroundColor: AppColors.primaryWhiteColor,
                  ),
                );
              }
              if (state is HomeErrorState) {
                return Center(
                  child: Column(
                    children: [
                      Lottie.asset(Assets.TRY_AGAIN),
                      const Text("state"),
                    ],
                  ),
                );
              }

              if (state is HomeLoaded) {
                if (state.homeResponse.emailVerified == 1) {
                  ObjectFactory().prefs.setEmailVerifiedPoints(
                      verifiedPoints: state.homeResponse.emailVerificationPoints
                          .toString());
                }
                return CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverAppBar(
                      leading: const SizedBox(),
                      pinned: true,
                      stretch: true,
                      backgroundColor: AppColors.primaryColor,
                      expandedHeight: getProportionateScreenHeight(80),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(9),
                          bottomLeft: Radius.circular(9),
                        ),
                      ),
                      flexibleSpace: FlexibleSpaceBar(
                        collapseMode: CollapseMode.parallax,
                        centerTitle: false,
                        titlePadding: const EdgeInsets.only(
                            top: 10, bottom: 0, left: 10, right: 10),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 5,
                              child: Text(
                                "${AppLocalizations.of(context)!.hi}  ${ObjectFactory().prefs.getUserName() ?? ""}!",
                                // "Hi ${ObjectFactory().prefs.getUserName() ?? ""}!",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.openSans(
                                    fontSize: 22, fontWeight: FontWeight.w600),
                              ),
                            ),
                            Flexible(
                              child: Stack(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      context.push('/notification');
                                    },
                                    icon: const Icon(
                                      Icons.mail_sharp,
                                    ),
                                    color: AppColors.primaryWhiteColor,
                                  ),
                                  // BlocBuilder<NotificationBloc,
                                  //     NotificationState>(
                                  //   builder: (context, state) {
                                  //     return Positioned(
                                  //       right: 0,
                                  //       top: 10,
                                  //       left: 20,
                                  //       child: Container(
                                  //         padding: const EdgeInsets.all(2),
                                  //         decoration: const BoxDecoration(
                                  //           shape: BoxShape.circle,
                                  //           color: AppColors
                                  //               .secondaryColor, // Change color as needed
                                  //         ),
                                  //         constraints: const BoxConstraints(
                                  //           minWidth: 10,
                                  //           minHeight: 10,
                                  //         ),
                                  //       ),
                                  //     );
                                  //   },
                                  // ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverPadding(
                      sliver: BlocConsumer<ReferralBloc, ReferralState>(
                        listener: (context, state) {
                          // if (state is ReferralCodeUpdateLoading) {
                          //   const Center(
                          //     heightFactor: 10,
                          //     child: RefreshProgressIndicator(
                          //       color: AppColors.secondaryColor,
                          //     ),
                          //   );
                          // }

                          if (state is ReferralCodeUpdateLoaded) {
                            if (state.referralCodeUpdateRequestResponse.success == true) {
                              _showDialogBox(context: context);
                            } else {
                              if (state.referralCodeUpdateRequestResponse
                                  .success ==
                                  false &&
                                  state.referralCodeUpdateRequestResponse
                                      .message ==
                                      "The referral code field is required") {
                                _showDialogBox(context: context);
                              }
                              if (state.referralCodeUpdateRequestResponse
                                  .success ==
                                  false &&
                                  state.referralCodeUpdateRequestResponse
                                      .message ==
                                      "Invalid Referral Code") {
                                _showDialogBox(context: context);
                              }
                              if (state.referralCodeUpdateRequestResponse
                                  .success ==
                                  false &&
                                  state.referralCodeUpdateRequestResponse
                                      .message ==
                                      "Referral code already added") {
                                _showDialogBox(context: context);
                              }
                              if (state.referralCodeUpdateRequestResponse
                                  .success ==
                                  false &&
                                  state.referralCodeUpdateRequestResponse
                                      .message ==
                                      "User already referred.") {
                                _showDialogBox(context: context);
                              }
                            }
                          }
                        },
                        builder: (context, state) {
                          return Form(
                            key: _formKey,
                            child: SliverToBoxAdapter(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Flexible(
                                    flex: 2,
                                    child: Container(
                                      height: 50,
                                      // width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryWhiteColor,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: AppColors.borderColor, width: 1),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: AppColors.boxShadow,
                                            blurRadius: 4,
                                            offset: Offset(4, 2),
                                            spreadRadius: 0,
                                          ),
                                          BoxShadow(
                                            color: AppColors.boxShadow,
                                            blurRadius: 4,
                                            offset: Offset(-4, -2),
                                            spreadRadius: 0,
                                          ),
                                        ],
                                      ),
                                      child: SizedBox(
                                        height: getProportionateScreenHeight(50),
                                        child:  CupertinoTextField.borderless(
                                          padding: const EdgeInsets.only(
                                              left: 15,
                                              top: 15,
                                              right: 6,
                                              bottom: 10),
                                          // placeholder: 'Referral code',
                                          placeholder: AppLocalizations.of(context)!.referralcode,
                                          controller: referralController,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Flexible(
                                    child: BlocBuilder<ReferralBloc, ReferralState>(
                                      builder: (context, state) {
                                        if (state is ReferralCodeUpdateLoading) {
                                          return const Center(
                                            child: RefreshProgressIndicator(
                                              color: AppColors
                                                  .primaryWhiteColor,
                                              backgroundColor:
                                              AppColors.secondaryColor,
                                            ),
                                          );
                                        }
                                        return ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            elevation: 3,
                                            fixedSize: const Size(120, 48),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            backgroundColor: AppColors.secondaryColor,
                                          ),
                                          onPressed: () {
                                            if (referralController
                                                .text.isEmpty) {
                                              Fluttertoast.showToast(
                                                // msg: "The referral code field is required",
                                                msg: AppLocalizations.of(context)!.thereferralcodefieldisrequired,
                                                toastLength:
                                                Toast.LENGTH_LONG,
                                                gravity:
                                                ToastGravity.BOTTOM,
                                                backgroundColor: AppColors
                                                    .secondaryColor,
                                                textColor: AppColors
                                                    .primaryWhiteColor,
                                              );
                                              return;
                                            }

                                            if (_formKey.currentState!
                                                .validate()) {
                                              String selectedLanguage = context.read<LanguageBloc>().state.selectedLanguage == Language.english
                                                  ? Language.english.text
                                                  : Language.arabic.text;

                                              // print('Selected Language: $selectedLanguage');

                                              BlocProvider.of<ReferralBloc>(
                                                  context).add(GetReferralCodeUpdateEvent(
                                                referralCodeUpdateRequest: ReferralCodeUpdateRequest(
                                                    referralCode: referralController.text,
                                                    language:  selectedLanguage
                                                ),
                                              ),
                                              );
                                            } else {
                                              Fluttertoast.showToast(
                                                // msg: "The referral code field is required",
                                                msg: AppLocalizations.of(context)!.thereferralcodefieldisrequired,
                                                toastLength:
                                                Toast.LENGTH_LONG,
                                                gravity:
                                                ToastGravity.BOTTOM,
                                                backgroundColor: AppColors.secondaryColor,
                                                textColor: AppColors.primaryWhiteColor,
                                              );
                                            }
                                          },
                                          child:  Text(
                                            AppLocalizations.of(context)!.bonuspoint,
                                            // "Bonus point!",
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                color: AppColors.primaryWhiteColor),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      padding: const EdgeInsets.only(
                          top: 15, left: 10, right: 10, bottom: 15),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 0),
                              child: InkWell(
                                splashFactory: InkSplash.splashFactory,
                                splashColor: AppColors.borderColor,
                                onTap: () {
                                  // print("INDEX::4}");
                                  widget.onIndexChanged(4);
                                },
                                child: Container(
                                  height: getProportionateScreenHeight(160),
                                  width: getProportionateScreenWidth(150),
                                  decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(
                                        color: AppColors.boxShadow,
                                        blurRadius: 4,
                                        offset: Offset(4, 2),
                                        spreadRadius: 0,
                                      ),
                                      BoxShadow(
                                        color: AppColors.boxShadow,
                                        blurRadius: 4,
                                        offset: Offset(-4, -2),
                                        spreadRadius: 0,
                                      ),
                                    ],
                                    // color: AppColors.primaryColor,
                                    gradient: const RadialGradient(
                                      center: Alignment(0, 1),
                                      radius: 0,
                                      colors: [
                                        Color(0xFFFFCACE),
                                        Color(0xFFF55562),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        flex: 3,
                                        child: Center(
                                          child:
                                              Image.asset(Assets.SCAN, scale: 6)
                                                  .animate()
                                                  .shake(
                                                    duration: const Duration(
                                                        milliseconds: 400),
                                                  ),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 1,
                                        child: Text(
                                          AppLocalizations.of(context)!.scan,
                                          // "Scan",
                                          style: GoogleFonts.openSans(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.primaryWhiteColor,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 0),
                              child: InkWell(
                                onTap: () {
                                  // print("INDEX::1}");
                                  widget.onIndexChanged(1);
                                },
                                child: Container(
                                  height: getProportionateScreenHeight(160),
                                  width: getProportionateScreenWidth(150),
                                  decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(
                                        color: AppColors.boxShadow,
                                        blurRadius: 4,
                                        offset: Offset(4, 2),
                                        spreadRadius: 0,
                                      ),
                                      BoxShadow(
                                        color: AppColors.boxShadow,
                                        blurRadius: 4,
                                        offset: Offset(-4, -2),
                                        spreadRadius: 0,
                                      ),
                                    ],
                                    // color: AppColors.primaryColor,
                                    gradient: const RadialGradient(
                                      center: Alignment(0, 1),
                                      radius: 0,
                                      colors: [
                                        Color(0xFF6B78A3),
                                        Color(0xFF111B3E)
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        flex: 3,
                                        child: Center(
                                          child: Image.asset(Assets.WALLET,
                                                  scale: 9)
                                              .animate()
                                              .shake(
                                                duration: const Duration(
                                                    milliseconds: 400),
                                              ),
                                        ),
                                      ),
                                      Flexible(
                                        flex: 1,
                                        child: Text(
                                          AppLocalizations.of(context)!.rewards,
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.openSans(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.primaryWhiteColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverPadding(
                      sliver: SliverToBoxAdapter(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.brands,
                                  // "Brands",
                                  style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                InkWell(
                                  splashColor: AppColors.borderColor,
                                  splashFactory: InkSparkle.splashFactory,
                                  onTap: () {
                                    // print("INDEX::2}");
                                    widget.onIndexChanged(2);
                                  },
                                  child: SizedBox(
                                    height: 25,
                                    width: 50,
                                    child: Center(
                                      child: Text(
                                        AppLocalizations.of(context)!.viewall,
                                        // "View all",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.roboto(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  // color: Colors.green,
                                  height: getProportionateScreenHeight(130),
                                  child: CarouselSlider(
                                    items: List.generate(
                                        state.homeResponse.data!.brands!.length,
                                        (index) => GestureDetector(
                                              onTap: () {
                                                _launchInBrowser(
                                                  state
                                                      .homeResponse
                                                      .data!
                                                      .brands![index]
                                                      .brandLink!,
                                                );
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5,
                                                    right: 5,
                                                    left: 5,
                                                    bottom: 5),
                                                child: Container(
                                                  padding: const EdgeInsets.all(5),
                                                  margin:
                                                      const EdgeInsets.all(9),
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: AppColors
                                                        .primaryWhiteColor,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color:
                                                            AppColors.boxShadow,
                                                        blurRadius: 4,
                                                        offset: Offset(4, 2),
                                                        spreadRadius: 0,
                                                      ),
                                                      BoxShadow(
                                                        color:
                                                            AppColors.boxShadow,
                                                        blurRadius: 4,
                                                        offset: Offset(-4, -2),
                                                        spreadRadius: 0,
                                                      ),
                                                    ],
                                                  ),
                                                  child: CachedNetworkImage(
                                                    fadeInCurve: Curves.easeIn,
                                                    fadeInDuration:
                                                        const Duration(
                                                            milliseconds: 200),
                                                    imageUrl: state
                                                        .homeResponse
                                                        .data!
                                                        .brands![index]
                                                        .brandLogo!,
                                                    placeholder:
                                                        (context, url) =>
                                                            SizedBox(
                                                      // height: getProportionateScreenHeight(170),
                                                      // width: MediaQuery.of(context).size.width,
                                                      child: Center(
                                                        child: Lottie.asset(
                                                          Assets.JUMBINGDOT,
                                                          height: 35,
                                                          width: 35,
                                                        ),
                                                      ),
                                                    ),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            const SizedBox(
                                                      child: Center(
                                                        child: ImageIcon(
                                                          color: AppColors
                                                              .hintColor,
                                                          AssetImage(
                                                              Assets.NO_IMG),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                        growable: true),
                                    options: CarouselOptions(
                                      onPageChanged: (index, reason) {
                                        setState(() {
                                          carouselIndex = index;
                                        });
                                      },
                                      height: 105.0,
                                      enlargeCenterPage: false,
                                      autoPlay: true,
                                      aspectRatio: 8 / 9,
                                      autoPlayCurve: Curves.fastOutSlowIn,
                                      enableInfiniteScroll: true,
                                      autoPlayAnimationDuration:
                                          const Duration(milliseconds: 800),
                                      viewportFraction: 0.4,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: DotsIndicator(
                                    dotsCount:
                                        state.homeResponse.data!.brands!.length,
                                    axis: Axis.horizontal,
                                    position: carouselIndex,
                                    decorator: DotsDecorator(
                                        spacing: const EdgeInsets.only(
                                            left: 3, right: 3),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        activeShape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        size: Size(
                                            (MediaQuery.of(context).size.width -
                                                    290) /
                                                state.homeResponse.data!.brands!
                                                    .length,
                                            5),
                                        activeSize: Size(
                                            (MediaQuery.of(context).size.width -
                                                    290) /
                                                state.homeResponse.data!.brands!
                                                    .length,
                                            5),
                                        color: AppColors.shadow,
                                        activeColor: AppColors.secondaryColor),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 8),
                    ),
                    SliverPadding(
                      sliver: SliverToBoxAdapter(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Visibility(
                              visible: state.homeResponse.data!.offers!.isNotEmpty,
                              child: Text(
                                AppLocalizations.of(context)!.specialoffersforyou,
                                style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Visibility(
                              visible: state.homeResponse.data!.offers!.isNotEmpty,
                              child: GestureDetector(
                                onTap: () {
                                  context.go('/special_offer');
                                },
                                child: SizedBox(
                                  height: 25,
                                  width: 50,
                                  child: Center(
                                    child: Text(
                                      AppLocalizations.of(context)!.viewall,
                                      // "View all",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.roboto(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 15),
                    ),
                    SliverPadding(
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, index) {
                            return Column(
                              children: AnimateList(
                                effects: [
                                  FadeEffect(delay: 300.ms),
                                ],
                                children: List.generate(
                                  state.homeResponse.data!.offers!.length,
                                  (index) => Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: GestureDetector(
                                      onTap: () {
                                        context.push(
                                          '/special_offer_details',
                                          extra: OfferDetailsArguments(
                                            offerHeading: state
                                                .homeResponse
                                                .data!
                                                .offers![index]
                                                .offerHeading!,
                                            endDate: state.homeResponse.data!
                                                .offers![index].endDate!,
                                            offerDetailText: state
                                                .homeResponse
                                                .data!
                                                .offers![index]
                                                .offerDetails!,
                                            offerImgUrl: state
                                                .homeResponse
                                                .data!
                                                .offers![index]
                                                .offerImage!,
                                            startDate: state.homeResponse.data!
                                                .offers![index].startDate!,
                                            storeList: state
                                                .homeResponse
                                                .data!
                                                .offers![index]
                                                .superMartketName!,
                                            offerHeadingArabic: state
                                                .homeResponse
                                                .data!
                                                .offers![index]
                                                .offerHeadingArabic!,
                                            offerDetailTextArabic: state
                                                .homeResponse
                                                .data!
                                                .offers![index]
                                                .offerDetailsArabic!,
                                          ),
                                        );
                                      },
                                      child: Container(
                                        height:
                                            getProportionateScreenHeight(170),
                                        width:
                                            getProportionateScreenWidth(320),
                                        // padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: AppColors.shadow,
                                              blurRadius: 1.0,
                                              // soften the shadow
                                              spreadRadius: 0.0,
                                              //extend the shadow
                                              offset: Offset(
                                                1.0,
                                                // Move to right 10  horizontally
                                                1.0, // Move to bottom 10 Vertically
                                              ),
                                            ),
                                            BoxShadow(
                                              color: AppColors.shadow,
                                              blurRadius: 1.0,
                                              // soften the shadow
                                              spreadRadius: 0.0,
                                              //extend the shadow
                                              offset: Offset(
                                                -1.0,
                                                // Move to right 10  horizontally
                                                -1.0, // Move to bottom 10 Vertically
                                              ),
                                            ),
                                          ],
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: CachedNetworkImage(
                                            imageUrl: state.homeResponse.data!
                                                .offers![index].offerImage!,
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                            placeholder: (context, url) =>
                                                SizedBox(
                                              height:
                                                  getProportionateScreenHeight(
                                                      170),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Center(
                                                child: Lottie.asset(
                                                  Assets.JUMBINGDOT,
                                                  height: 55,
                                                  width: 55,
                                                ),
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const ImageIcon(
                                              color: AppColors.hintColor,
                                              AssetImage(Assets.NO_IMG),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          childCount: 1,
                        ),
                      ),
                      padding: const EdgeInsets.only(
                          bottom: 120, left: 10, right: 10),
                    ),
                  ],
                );
              }
              return const SizedBox();
            },
          );
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
        }else if(state is NetworkInitial) {
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
      listener: (BuildContext context, NetworkState state) {
        if (state is NetworkSuccess) {
          networkSuccess = true;
        }
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
        child:
            BlocBuilder<ReferralBloc, ReferralState>(builder: (context, state) {
          if (state is ReferralCodeUpdateLoaded) {
            if (state.referralCodeUpdateRequestResponse.success == true &&
                state.referralCodeUpdateRequestResponse.message ==
                    "Referral code added successfully.") {
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
                            referralController.clear();
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
                          AppLocalizations.of(context)!
                              .referralcodeaddedsuccessfully,
                          // state.referralCodeUpdateRequestResponse.message,
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
                            referralController.clear();
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
            } else {
              if (state.referralCodeUpdateRequestResponse.success == false &&
                  state.referralCodeUpdateRequestResponse.message ==
                      "The referral code field is required") {
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
                              referralController.clear();
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
                            // state.referralCodeUpdateRequestResponse.message,
                            AppLocalizations.of(context)!
                                .thereferralcodefieldisrequired,
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
                              referralController.clear();
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
              if (state.referralCodeUpdateRequestResponse.success == false &&
                  state.referralCodeUpdateRequestResponse.message ==
                      "Invalid Referral Code") {
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
                              referralController.clear();
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
                            AppLocalizations.of(context)!.invalidreferralcode,
                            // state.referralCodeUpdateRequestResponse.message,
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
                              referralController.clear();
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
              if (state.referralCodeUpdateRequestResponse.success == false &&
                  state.referralCodeUpdateRequestResponse.message ==
                      "Referral code already added") {
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
                              referralController.clear();
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
                            AppLocalizations.of(context)!
                                .referralcodealreadyadded,
                            // state.referralCodeUpdateRequestResponse.message,
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
                              referralController.clear();
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
          if (state is ReferralCodeUpdateError) {
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
                          referralController.clear();
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
                          referralController.clear();
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
        }),
      ),
    );
  }
}
