import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_collect/language.dart';
import 'package:lets_collect/src/bloc/brand_and_partner_product_bloc/brand_and_partner_product_bloc.dart';
import 'package:lets_collect/src/bloc/language/language_bloc.dart';
import 'package:lets_collect/src/model/reward_tier/brand_and_partner_product_request.dart';
import 'package:lets_collect/src/ui/reward/components/brand_and_partner_redeem_arguments.dart';
import 'package:lets_collect/src/ui/reward/components/lets_collect_redeem_screen_arguments.dart';
import 'package:lets_collect/src/utils/screen_size/size_config.dart';
import 'package:lottie/lottie.dart';
import '../../../../constants/assets.dart';
import '../../../../constants/colors.dart';
import '../widgets/custome_rounded_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BrandProductListingScreen extends StatefulWidget {
  final LetCollectRedeemScreenArguments redeemScreenArguments;

  const BrandProductListingScreen(
      {super.key, required this.redeemScreenArguments});

  @override
  State<BrandProductListingScreen> createState() =>
      _BrandProductListingScreenState();
}

class _BrandProductListingScreenState extends State<BrandProductListingScreen> {
  String? eligibleFilter;
  List<String> selectedSortVariants = <String>[];
  String selectedSortFilter = "";
  List<String> sort = <String>[
    "Recent",
    "Expiry First",
    "Points Low",
    "Points High",
  ];

  List<String> sort_ar = <String>[
    "الأحدث",
    "الانتهاء أولا",
    "النقاط المنخفضة",
    "النقاط العالية",
  ];
  String? sortOption;
  String sortQuery = "";

  @override
  void initState() {
    super.initState();
    BlocProvider.of<BrandAndPartnerProductBloc>(context).add(
      GetBrandAndPartnerProductRequest(
        brandAndPartnerProductRequest: BrandAndPartnerProductRequest(
          sort: "",
          eligible: "",
          brandId: widget.redeemScreenArguments.iD.toString(),

        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(5),
          bottomRight: Radius.circular(5),
        )),
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.primaryWhiteColor,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                    ),
                    backgroundColor: AppColors.primaryWhiteColor,
                    barrierColor: Colors.black38,
                    elevation: 2,
                    isScrollControlled: true,
                    isDismissible: true,
                    builder: (BuildContext bc) {
                      return StatefulBuilder(
                        builder: (BuildContext context, setState) {
                          void clearFilter() {
                            setState(() {
                              selectedSortVariants = <String>[];
                            });
                          }

                          // filterWidgets.clear();
                          return Stack(
                            children: [
                              Positioned(
                                top: 0,
                                left: 0,
                                right: 0,
                                // bottom: 20,
                                child: SafeArea(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .sortby,
                                              // "Sort by",
                                              style: GoogleFonts.roboto(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color:
                                                    AppColors.primaryGrayColor,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                Icons.close,
                                                color:
                                                    AppColors.primaryGrayColor,
                                              ),
                                            )
                                          ],
                                        ),
                                        const Divider(
                                            color: AppColors.primaryGrayColor),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 2,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 60),
                                      Column(
                                        children: List.generate(
                                          sort.length,
                                          (index) => Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 6),
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 6),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                mainAxisSize: MainAxisSize.max,
                                                children: <Widget>[
                                                  Text(
                                                    context
                                                                .read<
                                                                    LanguageBloc>()
                                                                .state
                                                                .selectedLanguage ==
                                                            Language.english
                                                        ? sort[index]
                                                        : sort_ar[index],
                                                    softWrap: true,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge!
                                                        .copyWith(
                                                          fontSize: 15,
                                                        ),
                                                  ),
                                                  selectedSortVariants
                                                          .contains(sort[index])
                                                      ? InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              selectedSortVariants
                                                                  .remove(sort[
                                                                      index]);
                                                            });
                                                          },
                                                          child:
                                                              const CustomRoundedButton(
                                                                  enabled:
                                                                      true),
                                                        )
                                                      : InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              selectedSortVariants
                                                                  .add(sort[
                                                                      index]);
                                                              if (selectedSortVariants
                                                                      .length >
                                                                  1) {
                                                                selectedSortVariants
                                                                    .removeAt(
                                                                        0);
                                                              }
                                                              selectedSortFilter =
                                                                  selectedSortVariants[
                                                                      0];
                                                              if (selectedSortFilter ==
                                                                  "Recent") {
                                                                sortQuery =
                                                                    "recent";
                                                              }
                                                              if (selectedSortFilter ==
                                                                  "Expiry First") {
                                                                sortQuery =
                                                                    "expire_first";
                                                              }
                                                              if (selectedSortFilter ==
                                                                  "Points Low") {
                                                                sortQuery =
                                                                    "points_low";
                                                              }
                                                              if (selectedSortFilter ==
                                                                  "Points High") {
                                                                sortQuery =
                                                                    "points_high";
                                                              }
                                                            });
                                                          },
                                                          child:
                                                              const CustomRoundedButton(
                                                            enabled: false,
                                                          ),
                                                        ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 80),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                left: 0,
                                child: SafeArea(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20, bottom: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            clearFilter();
                                            context.pop();
                                            BlocProvider.of<
                                                        BrandAndPartnerProductBloc>(
                                                    context)
                                                .add(
                                              GetBrandAndPartnerProductRequest(
                                                  brandAndPartnerProductRequest:
                                                      BrandAndPartnerProductRequest(
                                                sort: "",
                                                eligible: "",
                                                brandId: widget
                                                    .redeemScreenArguments.iD!,
                                                // redemptionTier: "2",
                                              )),
                                            );
                                          },
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                .clearall,
                                            // "Clear All",
                                            style: GoogleFonts.roboto(
                                              color: AppColors.primaryColor,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            fixedSize: const Size(100, 40),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            backgroundColor:
                                                AppColors.secondaryColor,
                                          ),
                                          onPressed: () {
                                            BlocProvider.of<
                                                        BrandAndPartnerProductBloc>(
                                                    context)
                                                .add(
                                              GetBrandAndPartnerProductRequest(
                                                brandAndPartnerProductRequest:
                                                    BrandAndPartnerProductRequest(
                                                  sort: sortQuery,
                                                  eligible: "",
                                                  brandId: widget
                                                      .redeemScreenArguments
                                                      .iD!,
                                                  // redemptionTier: "2",
                                                ),
                                              ),
                                            );
                                            context.pop();
                                          },
                                          child: Text(
                                            AppLocalizations.of(context)!.apply,
                                            // "Apply",
                                            style: GoogleFonts.roboto(
                                              color:
                                                  AppColors.primaryWhiteColor,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    });
              },
              child: Container(
                padding: const EdgeInsets.only(left: 8, right: 8),
                height: 20,
                width: 68,
                decoration: BoxDecoration(
                  color: AppColors.primaryWhiteColor,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x4F000000),
                      blurRadius: 4.10,
                      offset: Offset(2, 4),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.sort,
                      // "Sort",
                      style: const TextStyle(
                        color: AppColors.iconGreyColor,
                        fontSize: 13,
                      ),
                    ),
                    SvgPicture.asset(Assets.SORT_SVG, height: 10, width: 10),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 15),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    useSafeArea: true,
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                    ),
                    backgroundColor: AppColors.primaryWhiteColor,
                    barrierColor: Colors.black38,
                    elevation: 2,
                    isScrollControlled: true,
                    isDismissible: true,
                    builder: (BuildContext bc) {
                      return StatefulBuilder(
                        builder: (BuildContext context, setState) {
                          void clearFilter() {
                            setState(() {
                              eligibleFilter = "";
                            });
                          }

                          // filterWidgets.clear();
                          return Stack(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 1.6,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 60),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 6),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 6),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            mainAxisSize: MainAxisSize.max,
                                            children: <Widget>[
                                              Text(
                                                AppLocalizations.of(context)!
                                                    .eligible,
                                                // "Eligible",
                                                softWrap: true,
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                      fontSize: 15,
                                                    ),
                                              ),
                                              eligibleFilter == "Eligible"
                                                  ? InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          eligibleFilter = "";
                                                          // selectedFilters[]
                                                        });
                                                      },
                                                      child: Container(
                                                        height: 20,
                                                        width: 20,
                                                        decoration:
                                                            const BoxDecoration(
                                                          shape: BoxShape
                                                              .rectangle,
                                                          image:
                                                              DecorationImage(
                                                            image: AssetImage(Assets
                                                                .DISABLED_TICK),
                                                            fit: BoxFit.contain,
                                                            scale: 6,
                                                          ),
                                                          color: AppColors
                                                              .secondaryColor,
                                                          boxShadow: [
                                                            BoxShadow(
                                                                blurRadius: 1.5,
                                                                color: Colors
                                                                    .black38,
                                                                offset: Offset(
                                                                    0, 1))
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  : InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          eligibleFilter =
                                                              "Eligible";
                                                        });
                                                      },
                                                      child: Container(
                                                        height: 20,
                                                        width: 20,
                                                        decoration:
                                                            const BoxDecoration(
                                                          shape: BoxShape
                                                              .rectangle,
                                                          color:
                                                              Color(0xFFD9D9D9),
                                                          image:
                                                              DecorationImage(
                                                            image: AssetImage(Assets
                                                                .DISABLED_TICK),
                                                            fit: BoxFit.contain,
                                                          ),
                                                          boxShadow: [
                                                            BoxShadow(
                                                                blurRadius: 1.5,
                                                                color: Colors
                                                                    .black38,
                                                                offset: Offset(
                                                                    0, 1))
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                left: 0,
                                child: SafeArea(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: AppColors.primaryWhiteColor,
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.boxShadow,
                                          blurRadius: 4,
                                          offset: Offset(4, 2),
                                          spreadRadius: 0,
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20, bottom: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              clearFilter();
                                            },
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .clearall,
                                              // "Clear All",
                                              style: GoogleFonts.roboto(
                                                color: AppColors.underlineColor,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              fixedSize: const Size(100, 40),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              backgroundColor:
                                                  AppColors.secondaryColor,
                                            ),
                                            onPressed: () {
                                              BlocProvider.of<
                                                          BrandAndPartnerProductBloc>(
                                                      context)
                                                  .add(
                                                GetBrandAndPartnerProductRequest(
                                                    brandAndPartnerProductRequest:
                                                        BrandAndPartnerProductRequest(
                                                  sort: "",
                                                  eligible: eligibleFilter ==
                                                          "Eligible"
                                                      ? "1"
                                                      : "",
                                                  brandId: widget
                                                      .redeemScreenArguments
                                                      .iD!,
                                                  // redemptionTier: "2",
                                                )),
                                              );
                                              context.pop();
                                            },
                                            child: Text(
                                              // "Apply",
                                              AppLocalizations.of(context)!
                                                  .apply,
                                              style: GoogleFonts.roboto(
                                                color:
                                                    AppColors.primaryWhiteColor,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: AppColors.primaryWhiteColor,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.0),
                                      topRight: Radius.circular(20.0),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Container(
                                      // height: 40,
                                      color: AppColors.primaryWhiteColor,
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)!
                                                    .filterby,
                                                // "Filter by",
                                                style: GoogleFonts.roboto(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors
                                                      .primaryGrayColor,
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  context.pop();
                                                },
                                                icon: const Icon(
                                                  Icons.close,
                                                  color: AppColors
                                                      .primaryGrayColor,
                                                ),
                                              )
                                            ],
                                          ),
                                          const Divider(
                                              color:
                                                  AppColors.primaryGrayColor),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    });
              },
              child: Container(
                padding: const EdgeInsets.only(left: 8, right: 8),
                height: 20,
                width: 68,
                decoration: BoxDecoration(
                  color: AppColors.primaryWhiteColor,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x4F000000),
                      blurRadius: 4.10,
                      offset: Offset(2, 4),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.filter,
                      // "Filter",
                      style: const TextStyle(
                        color: AppColors.iconGreyColor,
                        fontSize: 13,
                      ),
                    ),
                    SvgPicture.asset(
                      Assets.FILTER_SVG,
                      height: 10,
                      width: 10,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.read<LanguageBloc>().state.selectedLanguage ==
                          Language.english
                      ? widget.redeemScreenArguments.name!
                      : widget.redeemScreenArguments.name!,
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryWhiteColor,
                  ),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: widget.redeemScreenArguments.totalPoint,
                        style: GoogleFonts.openSans(
                          color: AppColors.primaryWhiteColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                      TextSpan(
                        text: AppLocalizations.of(context)!.pts,
                        // text: 'pts',
                        style: GoogleFonts.openSans(
                          color: AppColors.primaryWhiteColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
            child: buildBrandProductGridMethod(),
          )),
    );
  }

  BlocBuilder<BrandAndPartnerProductBloc, BrandAndPartnerProductState>
      buildBrandProductGridMethod() {
    return BlocBuilder<BrandAndPartnerProductBloc, BrandAndPartnerProductState>(
      builder: (context, state) {
        if (state is BrandAndPartnerProductLoading) {
          return Center(
            heightFactor: getProportionateScreenHeight(15),
            child: const RefreshProgressIndicator(
              color: AppColors.secondaryColor,
              backgroundColor: AppColors.primaryWhiteColor,
            ),
          );
        }
        if (state is BrandAndPartnerProductErrorState) {
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 4,
                  child: Lottie.asset(Assets.TRY_AGAIN),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    context.read<LanguageBloc>().state.selectedLanguage ==
                            Language.english
                        ? state.errorMsg
                        : AppLocalizations.of(context)!
                            .oopslookslikewearefacing,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: AppColors.primaryColor),
                  ),
                ),
                // const Spacer(),
                Flexible(
                  flex: 4,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                        fixedSize: const Size(100, 50),
                        backgroundColor: AppColors.primaryColor),
                    onPressed: () {
                      BlocProvider.of<BrandAndPartnerProductBloc>(context).add(
                        GetBrandAndPartnerProductRequest(
                          brandAndPartnerProductRequest:
                              BrandAndPartnerProductRequest(
                            sort: "",
                            eligible: "",
                            brandId: widget.redeemScreenArguments.iD.toString(),
                            // redemptionTier: "2",
                          ),
                        ),
                      );
                    },
                    child: Text(
                      // "Try again",
                      AppLocalizations.of(context)!.tryagain,
                      style:
                          const TextStyle(color: AppColors.primaryWhiteColor),
                    ),
                  ),
                ),
                // const Text("state"),
              ],
            ),
          );
        }
        if (state is BrandAndPartnerProductLoaded) {
          if (state.brandAndPartnerProductRequestResponse.data!.rewards!
              .isNotEmpty) {
            return GridView.builder(
                shrinkWrap: true,
                itemCount: state.brandAndPartnerProductRequestResponse.data!
                    .rewards!.length,
                padding: const EdgeInsets.only(bottom: 60, top: 20),
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 15.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 1,
                  crossAxisCount: 2,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      context.push(
                        '/redeem_screen',
                        extra: BrandAndPartnerRedeemArguments(
                          rewardId: state.brandAndPartnerProductRequestResponse
                              .data!.rewards![index].rewardId!,
                          requiredPoints: state
                              .brandAndPartnerProductRequestResponse
                              .data!
                              .rewards![index]
                              .requiredPoints
                              .toString(),
                          productImageUrl: state
                              .brandAndPartnerProductRequestResponse
                              .data!
                              .rewards![index]
                              .rewardImage!,
                          qrCodeGenerationUrl: "",
                          whereToRedeem: state
                              .brandAndPartnerProductRequestResponse
                              .data!
                              .rewards![index]
                              .reedemStores!,
                          from: 'brand_products',
                          totalPoint: widget.redeemScreenArguments.totalPoint
                              .toString(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primaryWhiteColor,
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x4F000000),
                            blurRadius: 4.10,
                            offset: Offset(2, 4),
                            spreadRadius: 0,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Center(
                              child: SizedBox(
                                width: 120,
                                height: 100,
                                child: CachedNetworkImage(
                                  alignment: Alignment.center,
                                  fadeInCurve: Curves.easeIn,
                                  fadeInDuration:
                                      const Duration(milliseconds: 200),
                                  fit: BoxFit.contain,
                                  imageUrl: state
                                      .brandAndPartnerProductRequestResponse
                                      .data!
                                      .rewards![index]
                                      .rewardImage!,
                                  width: MediaQuery.of(context).size.width,
                                  placeholder: (context, url) => SizedBox(
                                    // height: getProportionateScreenHeight(170),
                                    width: MediaQuery.of(context).size.width,
                                    child: Center(
                                      child: Lottie.asset(
                                        Assets.JUMBINGDOT,
                                        height: 45,
                                        width: 45,
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const ImageIcon(
                                    color: AppColors.hintColor,
                                    AssetImage(Assets.NO_IMG),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, left: 20),
                              child: Text(
                                state.brandAndPartnerProductRequestResponse
                                    .data!.rewards![index].requiredPoints
                                    .toString(),
                                style: const TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          } else {
            return Center(
              heightFactor: getProportionateScreenHeight(15),
              child: Lottie.asset(Assets.OOPS),
            );
          }
        }
        return const SizedBox();
      },
    );
  }
}
