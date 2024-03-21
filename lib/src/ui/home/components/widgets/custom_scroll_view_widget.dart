import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_collect/src/bloc/home_bloc/home_bloc.dart';
import 'package:lets_collect/src/constants/colors.dart';
import 'package:lets_collect/src/utils/network_connectivity/bloc/network_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../../constants/assets.dart';
import '../../../../utils/data/object_factory.dart';
import '../../../../utils/screen_size/size_config.dart';
import '../../../special_offer/components/offer_details_arguments.dart';

class CustomScrollViewWidget extends StatefulWidget {
  final Function(int) onIndexChanged;

  const CustomScrollViewWidget({super.key, required this.onIndexChanged});

  @override
  State<CustomScrollViewWidget> createState() => _CustomScrollViewWidgetState();
}

class _CustomScrollViewWidgetState extends State<CustomScrollViewWidget> {
  final List<String> offerList = [
    "https://lh3.googleusercontent.com/p/AF1QipMqqa46dLkIiz3erib-jJvTmfLfuu1Yc4KPbpqn=w1080-h608-p-no-v0",
    "https://www.graceonline.in/uploads/press-release/2021/07/15/presstips-to-buy-groceries-from-the-online-grocery-store-in-chennaiTWY1626328442.webp",
    "https://img.freepik.com/free-vector/online-grocery-store-banner-design_23-2150089538.jpg?size=626&ext=jpg&ga=GA1.1.1826414947.1699833600&semt=ais",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkZwedb3OKxvYwv_-Xq8EZY5tXaTj4bGcKhA&usqp=CAU",
    "https://www.shutterstock.com/image-vector/collection-food-sale-vertical-banner-260nw-1978888238.jpg",
  ];
  final List<String> brandList = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkXn-ER1y5GoZMhdpJbNDFwmVcF6EgNnKx2L0HLIUl4Z6FOMAKNjuFFyn-8t7Irm4VaTg&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQeBSJV5_fHf8lK_P-qzwrrSknGjOLp2tiRUFdKRlEJnIoj3aTWK2N2TVeVIwGhh35qKgY&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQNcSY2jWuEl3yWP4EaataDBwiXVfhmBXaXITE6UeLDD_hOPJJLNA648j_06wxTNV76nq0&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRrNlRN3EbfaSAcDV81Z8lgpVHMYMtWcMO5Akj_bLmcfnaCAdlIVVAo-aXZJbNnemdN1YU&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRudtbxCfi5rEfivx9St1HyF5bAaZ4ELtTAReUredMIfL98B1hcJMY1kjQo_UJXDUpdS7s&usqp=CAU",
  ];
  int carouselIndex = 0;
  bool networkSuccess = false;

  @override
  void initState() {
    BlocProvider.of<HomeBloc>(context).add(GetHomeData());
    print(ObjectFactory().prefs.getEmailVerifiedPoints());
    print("IS EMAIL VERIFIED: ${ObjectFactory().prefs.isEmailVerified()}");
    print(
        "IS EMAIL VERIFIED STATUS: ${ObjectFactory().prefs.isEmailVerifiedStatus()}");

    print(
        "IS EMAIL NOT VERIFIED STATUS: ${ObjectFactory().prefs.isEmailNotVerifiedStatus()}");

    print(
        "IS EMAIL NOT VERIFIED CALLED: ${ObjectFactory().prefs.isEmailNotVerifiedCalled()}");
    super.initState();
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
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocConsumer<NetworkBloc, NetworkState>(
      builder: (context, state) {
        if (state is NetworkSuccess) {
          return BlocConsumer<HomeBloc, HomeState>(
            listener: (context, state) {
              ///If and only if Network success
              // if(state is NetworkSuccess) {
              //   BlocProvider.of<HomeBloc>(context).add(GetHomeData());
              // }
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
                  setState(() {
                    ObjectFactory().prefs.setIsEmailVerified(true);
                  });
                  // // ObjectFactory().prefs.setIsEmailNotVerifiedStatus(false);
                  // ObjectFactory().prefs.setIsEmailVerifiedStatus(false);
                  ObjectFactory().prefs.setEmailVerifiedPoints(
                      verifiedPoints: state.homeResponse.emailVerificationPoints
                          .toString());
                } else if (state.homeResponse.emailVerified == 0) {
                  ObjectFactory().prefs.setIsEmailNotVerifiedStatus(true);
                }
                return CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverAppBar(
                      leading: const SizedBox(),
                      pinned: true,
                      stretch: true,
                      // collapsedHeight: getProportionateScreenHeight(60),
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
                                "Hi ${ObjectFactory().prefs.getUserName() ?? ""}!",
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
                      sliver: SliverToBoxAdapter(
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
                                  child: const CupertinoTextField.borderless(
                                    padding: EdgeInsets.only(
                                        left: 15,
                                        top: 15,
                                        right: 6,
                                        bottom: 10),
                                    placeholder: 'Referral code',
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Flexible(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 3,
                                  fixedSize: const Size(120, 48),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  backgroundColor: AppColors.secondaryColor,
                                ),
                                onPressed: () {},
                                child: const Text(
                                  "Bonus point!",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: AppColors.primaryWhiteColor),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      padding:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
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
                                  print("INDEX::4}");
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
                                          "Scan",
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
                                  print("INDEX::1}");
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
                                          "Total points \n ${state.homeResponse.totalPoints} pts",
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
                                  "Brands",
                                  style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                InkWell(
                                  splashColor: AppColors.borderColor,
                                  splashFactory: InkSparkle.splashFactory,
                                  onTap: () {
                                    print("INDEX::2}");
                                    widget.onIndexChanged(2);
                                  },
                                  child: SizedBox(
                                    height: 25,
                                    width: 50,
                                    child: Center(
                                      child: Text(
                                        "View all",
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
                                                  padding: EdgeInsets.all(5),
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
                          left: 10, right: 10, top: 0, bottom: 8),
                    ),
                    SliverPadding(
                      sliver: SliverToBoxAdapter(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Special Offers for you",
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                context.go('/special_offer');
                              },
                              child: SizedBox(
                                height: 25,
                                width: 50,
                                child: Center(
                                  child: Text(
                                    "View all",
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
                      ),
                      padding:
                          const EdgeInsets.only(left: 15, right: 15, top: 15),
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
                                          ),
                                        );
                                      },
                                      child: Container(
                                        height:
                                            getProportionateScreenHeight(170),
                                        width:
                                            MediaQuery.of(context).size.width,
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
              return CustomScrollView(
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
                      titlePadding: const EdgeInsets.all(10),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Hi Sarah",
                            style: TextStyle(
                              fontSize: 20,
                              color: AppColors.primaryWhiteColor,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.mail_sharp,
                            ),
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverPadding(
                    sliver: SliverToBoxAdapter(
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
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade400,
                                    blurRadius: 1.0, // soften the shadow
                                    spreadRadius: 0.0, //extend the shadow
                                    offset: const Offset(
                                      0.0, // Move to right 10  horizontally
                                      0.0, // Move to bottom 10 Vertically
                                    ),
                                  ),
                                  BoxShadow(
                                    color: Colors.grey.shade300,
                                    blurRadius: 1.0, // soften the shadow
                                    spreadRadius: 0.0, //extend the shadow
                                    offset: const Offset(
                                      -1.0, // Move to right 10  horizontally
                                      -1.0, // Move to bottom 10 Vertically
                                    ),
                                  ),
                                ],
                              ),
                              child: SizedBox(
                                height: getProportionateScreenHeight(50),
                                child: const CupertinoTextField.borderless(
                                  padding: EdgeInsets.only(
                                      left: 15, top: 15, right: 6, bottom: 10),
                                  placeholder: 'Referral code',
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Flexible(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 3,
                                fixedSize: const Size(120, 48),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                backgroundColor: AppColors.secondaryButtonColor,
                              ),
                              onPressed: () {},
                              child: const Text(
                                "Bonus point!",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    padding:
                        const EdgeInsets.only(top: 10, left: 10, right: 10),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Container(
                              height: getProportionateScreenHeight(160),
                              width: getProportionateScreenWidth(150),
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                gradient: const RadialGradient(
                                  radius: 0.6,
                                  colors: [
                                    AppColors.containerRadialColor1,
                                    AppColors.containerRadialColor,
                                    AppColors.containerRadialColor2,
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
                                      child: Image.asset(Assets.SCAN, scale: 6)
                                          .animate()
                                          .shake(
                                            duration: const Duration(
                                                milliseconds: 400),
                                          ),
                                    ),
                                  ),
                                  const Flexible(
                                    flex: 1,
                                    child: Text(
                                      "Scan",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Container(
                              height: getProportionateScreenHeight(160),
                              width: getProportionateScreenWidth(150),
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                gradient: const RadialGradient(
                                  radius: 0.6,
                                  colors: [
                                    AppColors.primaryColor2,
                                    AppColors.primaryColor3,
                                    AppColors.primaryColor,
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
                                          Image.asset(Assets.WALLET, scale: 8)
                                              .animate()
                                              .shake(
                                                duration: const Duration(
                                                    milliseconds: 400),
                                              ),
                                    ),
                                  ),
                                  const Text(
                                    "Total points \n 1200 pts",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
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
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Brands",
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                "View all",
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            // color: Colors.green,
                            height: 100,
                            child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: brandList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: getProportionateScreenWidth(100),
                                      // padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.shade400,
                                            blurRadius: 1.0,
                                            // soften the shadow
                                            spreadRadius: 0.0,
                                            //extend the shadow
                                            offset: const Offset(
                                              1.0,
                                              // Move to right 10  horizontally
                                              1.0, // Move to bottom 10 Vertically
                                            ),
                                          ),
                                          BoxShadow(
                                            color: Colors.grey.shade300,
                                            blurRadius: 1.0,
                                            // soften the shadow
                                            spreadRadius: 0.0,
                                            //extend the shadow
                                            offset: const Offset(
                                              -1.0,
                                              // Move to right 10  horizontally
                                              -1.0, // Move to bottom 10 Vertically
                                            ),
                                          ),
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl: brandList[index],
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover,
                                                  colorFilter:
                                                      const ColorFilter.mode(
                                                          Colors.red,
                                                          BlendMode.colorBurn)),
                                            ),
                                          ),
                                          // placeholder: (context, url) => CircularProgressIndicator(),
                                          // errorWidget: (context, url, error) => Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 0, bottom: 8),
                  ),
                  SliverPadding(
                    sliver: SliverToBoxAdapter(
                      child: Text(
                        "Special Offers for you",
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                    ),
                    padding: const EdgeInsets.only(left: 10, right: 10),
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
                                    offerList.length,
                                    (index) => Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Container(
                                        height:
                                            getProportionateScreenHeight(110),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColors.borderColor,
                                              width: 1),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: AppColors.boxShadow,
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
                                              color: AppColors.boxShadow,
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
                                              BorderRadius.circular(10),
                                          child: CachedNetworkImage(
                                            fit: BoxFit.fill,
                                            imageUrl: offerList[index],
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
                                            // placeholder: (context, url) => CircularProgressIndicator(),
                                            // errorWidget: (context, url, error) => Icon(Icons.error),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )));
                        },
                        childCount: 1,
                      ),
                    ),
                    padding:
                        const EdgeInsets.only(bottom: 100, left: 10, right: 10),
                  ),
                ],
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
                  "You are not connected to the internet",
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
}
