import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_collect/src/bloc/brand_and_partner_product_bloc/brand_and_partner_product_bloc.dart';
import 'package:lets_collect/src/ui/reward/components/lets_collect_redeem_screen_arguments.dart';
import 'package:lets_collect/src/utils/data/object_factory.dart';
import 'package:lets_collect/src/utils/screen_size/size_config.dart';
import 'package:lottie/lottie.dart';

import '../../../../bloc/filter_bloc/filter_bloc.dart';
import '../../../../bloc/reward_tier_bloc/reward_tier_bloc.dart';
import '../../../../constants/assets.dart';
import '../../../../constants/colors.dart';
import '../../../../model/reward_tier/brand_and_partner_product_request.dart';
import '../../../../model/reward_tier/reward_tier_request.dart';
import '../brand_and_partner_redeem_arguments.dart';
import '../widgets/custome_rounded_button.dart';

class PartnerProductListingScreen extends StatefulWidget {
  final LetCollectRedeemScreenArguments redeemScreenArguments;
  const PartnerProductListingScreen({super.key,required this.redeemScreenArguments});

  @override
  State<PartnerProductListingScreen> createState() =>
      _PartnerProductListingScreenState();
}

class _PartnerProductListingScreenState
    extends State<PartnerProductListingScreen> {

  String? eligibleFilter;
  List<String> selectedSortVariants = <String>[];
  String selectedSortFilter = "";
  List<String> sort = <String>[
    "Recent",
    "Expiry First",
    "Points Low",
    "Points High",
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
          redemptionTier: "3",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
  SizeConfig().init(context);
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
                                    padding:
                                    const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .center,
                                          children: [
                                            Text(
                                              "Sort by",
                                              style: GoogleFonts
                                                  .roboto(
                                                fontSize: 16,
                                                fontWeight:
                                                FontWeight.w400,
                                                color: AppColors
                                                    .primaryGrayColor,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                Icons.close,
                                                color: AppColors
                                                    .primaryGrayColor,
                                              ),
                                            )
                                          ],
                                        ),
                                        const Divider(
                                            color: AppColors
                                                .primaryGrayColor),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context)
                                    .size
                                    .height /
                                    2,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 60),
                                      Column(
                                        children: List.generate(
                                          sort.length,
                                              (index) => Padding(
                                            padding:
                                            const EdgeInsets
                                                .symmetric(
                                                horizontal: 8,
                                                vertical: 6),
                                            child: Container(
                                              padding:
                                              const EdgeInsets
                                                  .symmetric(
                                                  horizontal:
                                                  10,
                                                  vertical: 6),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                mainAxisSize:
                                                MainAxisSize
                                                    .max,
                                                children: <Widget>[
                                                  Text(
                                                    sort[index],
                                                    softWrap: true,
                                                    overflow:
                                                    TextOverflow
                                                        .ellipsis,
                                                    style: Theme.of(
                                                        context)
                                                        .textTheme
                                                        .bodyText1!
                                                        .copyWith(
                                                      fontSize:
                                                      15,
                                                    ),
                                                  ),
                                                  selectedSortVariants
                                                      .contains(
                                                      sort[
                                                      index])
                                                      ? InkWell(
                                                    onTap:
                                                        () {
                                                      setState(
                                                              () {
                                                            selectedSortVariants
                                                                .remove(sort[index]);
                                                          });
                                                    },
                                                    child: const CustomRoundedButton(
                                                        enabled:
                                                        true),
                                                  )
                                                      : InkWell(
                                                    onTap:
                                                        () {
                                                      setState(
                                                              () {
                                                            selectedSortVariants
                                                                .add(sort[index]);
                                                            if (selectedSortVariants.length >
                                                                1) {
                                                              selectedSortVariants.removeAt(0);
                                                            }
                                                            selectedSortFilter = selectedSortVariants[0];
                                                            if(selectedSortFilter == "Recent") {
                                                              sortQuery = "recent";
                                                            }
                                                            if(selectedSortFilter == "Expiry First") {
                                                              sortQuery = "expire_first";
                                                            }
                                                            if(selectedSortFilter == "Points Low") {
                                                              sortQuery = "points_low";
                                                            }
                                                            if(selectedSortFilter == "Points High") {
                                                              sortQuery = "points_high";
                                                            }
                                                          });
                                                    },
                                                    child: const CustomRoundedButton(
                                                      enabled:
                                                      false,
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
                                        left: 20,
                                        right: 20,
                                        bottom: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceBetween,
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
                                                    brandId: widget.redeemScreenArguments.iD!,
                                                    redemptionTier: "3",
                                                  )
                                              ),
                                            );
                                          },
                                          child: Text(
                                            "Clear All",
                                            style:
                                            GoogleFonts.roboto(
                                              color: AppColors
                                                  .primaryColor,
                                              fontWeight:
                                              FontWeight.w400,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton
                                              .styleFrom(
                                            fixedSize:
                                            const Size(100, 40),
                                            shape:
                                            RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius
                                                  .circular(8),
                                            ),
                                            backgroundColor:
                                            AppColors
                                                .secondaryColor,
                                          ),
                                          onPressed: () async{
                                            print(selectedSortFilter);
                                            print("Sort Selected: $sortQuery");
                                            BlocProvider.of<
                                                BrandAndPartnerProductBloc>(
                                                context)
                                                .add(
                                              GetBrandAndPartnerProductRequest(
                                                  brandAndPartnerProductRequest:
                                                  BrandAndPartnerProductRequest(
                                                    sort: sortQuery,
                                                    eligible: "",
                                                    brandId: widget.redeemScreenArguments.iD!,
                                                    redemptionTier: "3",
                                                  )
                                              ),
                                            );
                                            context.pop();
                                          },
                                          child: Text(
                                            "Apply",
                                            style:
                                            GoogleFonts.roboto(
                                              color: AppColors
                                                  .primaryWhiteColor,
                                              fontWeight:
                                              FontWeight.w400,
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
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Sort",
                      style: TextStyle(
                        color: AppColors.iconGreyColor,
                        fontSize: 13,
                      ),
                    ),
                    Icon(
                      Icons.sort,
                      size: 18,
                      color: AppColors.iconGreyColor,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 15),
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
                             eligibleFilter = "";
                            });
                          }
                          return Stack(
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context)
                                    .size
                                    .height /
                                    1.6,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                          height: 60),
                                      Padding(
                                        padding:
                                        const EdgeInsets
                                            .symmetric(
                                            horizontal: 8,
                                            vertical: 6),
                                        child: Container(
                                          padding:
                                          const EdgeInsets
                                              .symmetric(
                                              horizontal:
                                              10,
                                              vertical:
                                              6),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            mainAxisSize:
                                            MainAxisSize
                                                .max,
                                            children: <Widget>[
                                              Text(
                                                "Eligible",
                                                softWrap:
                                                true,
                                                overflow:
                                                TextOverflow
                                                    .ellipsis,
                                                style: Theme.of(
                                                    context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(
                                                  fontSize:
                                                  15,
                                                ),
                                              ),
                                              eligibleFilter ==
                                                  "Eligible"
                                                  ? InkWell(
                                                onTap:
                                                    () {
                                                  setState(
                                                          () {
                                                        eligibleFilter =
                                                        "";
                                                        // selectedFilters[]
                                                      });
                                                },
                                                child:
                                                Container(
                                                  height:
                                                  20,
                                                  width:
                                                  20,
                                                  decoration:
                                                  const BoxDecoration(
                                                    shape:
                                                    BoxShape.rectangle,
                                                    image:
                                                    DecorationImage(
                                                      image: AssetImage(Assets.DISABLED_TICK),
                                                      fit: BoxFit.contain,
                                                      scale: 6,
                                                    ),
                                                    color:
                                                    AppColors.secondaryColor,
                                                    boxShadow: [
                                                      BoxShadow(blurRadius: 1.5, color: Colors.black38, offset: Offset(0, 1))
                                                    ],
                                                  ),
                                                ),
                                              )
                                                  : InkWell(
                                                onTap:
                                                    () {
                                                  setState(
                                                          () {
                                                        eligibleFilter =
                                                        "Eligible";
                                                      });
                                                },
                                                child:
                                                Container(
                                                  height:
                                                  20,
                                                  width:
                                                  20,
                                                  decoration:
                                                  const BoxDecoration(
                                                    shape:
                                                    BoxShape.rectangle,
                                                    color:
                                                    Color(0xFFD9D9D9),
                                                    image:
                                                    DecorationImage(
                                                      image: AssetImage(Assets.DISABLED_TICK),
                                                      fit: BoxFit.contain,
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(blurRadius: 1.5, color: Colors.black38, offset: Offset(0, 1))
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                          height: 80),
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
                                    decoration:
                                    const BoxDecoration(
                                      color: AppColors
                                          .primaryWhiteColor,
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors
                                              .boxShadow,
                                          blurRadius: 4,
                                          offset:
                                          Offset(4, 2),
                                          spreadRadius: 0,
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding:
                                      const EdgeInsets
                                          .only(
                                          left: 20,
                                          right: 20,
                                          bottom: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              clearFilter();
                                            },
                                            child: Text(
                                              "Clear All",
                                              style:
                                              GoogleFonts
                                                  .roboto(
                                                color: AppColors
                                                    .underlineColor,
                                                fontWeight:
                                                FontWeight
                                                    .w400,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                          ElevatedButton(
                                            style:
                                            ElevatedButton
                                                .styleFrom(
                                              fixedSize:
                                              const Size(
                                                  100,
                                                  40),
                                              shape:
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius
                                                    .circular(
                                                    8),
                                              ),
                                              backgroundColor:
                                              AppColors
                                                  .secondaryColor,
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
                                                          "Eligible" ? "1" : "",
                                                      brandId: widget.redeemScreenArguments.iD!,
                                                      redemptionTier: "3",
                                                    )
                                                ),
                                              );
                                              context.pop();
                                            },
                                            child: Text(
                                              "Apply",
                                              style:
                                              GoogleFonts
                                                  .roboto(
                                                color: AppColors
                                                    .primaryWhiteColor,
                                                fontWeight:
                                                FontWeight
                                                    .w400,
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
                                  decoration:
                                  const BoxDecoration(
                                    color: AppColors
                                        .primaryWhiteColor,
                                    borderRadius:
                                    BorderRadius.only(
                                      topLeft:
                                      Radius.circular(
                                          20.0),
                                      topRight:
                                      Radius.circular(
                                          20.0),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets
                                        .symmetric(
                                        horizontal: 15),
                                    child: Container(
                                      // height: 40,
                                      color: Colors.white,
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            crossAxisAlignment:
                                            CrossAxisAlignment
                                                .center,
                                            children: [
                                              Text(
                                                "Filter by",
                                                style:
                                                GoogleFonts
                                                    .roboto(
                                                  fontSize:
                                                  16,
                                                  fontWeight:
                                                  FontWeight
                                                      .w400,
                                                  color: AppColors
                                                      .primaryGrayColor,
                                                ),
                                              ),
                                              IconButton(
                                                onPressed:
                                                    () {},
                                                icon:
                                                const Icon(
                                                  Icons.close,
                                                  color: AppColors
                                                      .primaryGrayColor,
                                                ),
                                              )
                                            ],
                                          ),
                                          const Divider(
                                              color: AppColors
                                                  .primaryGrayColor),
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
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Filter",
                      style: TextStyle(
                        color: AppColors.iconGreyColor,
                        fontSize: 13,
                      ),
                    ),
                    Icon(
                      Icons.sort,
                      size: 18,
                      color: AppColors.iconGreyColor,
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
              children: [
                Text(
                  "Partner",
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
                        text: '800',
                        style: GoogleFonts.openSans(
                          color: AppColors.primaryWhiteColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                      TextSpan(
                        text: 'pts',
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
            child: buildPartnerProductGridMethod(),
          )),
    );
  }

  BlocBuilder<BrandAndPartnerProductBloc, BrandAndPartnerProductState> buildPartnerProductGridMethod() {
    return BlocBuilder<BrandAndPartnerProductBloc, BrandAndPartnerProductState>(
  builder: (context, state) {
    SizeConfig().init(context);
    if(state is BrandAndPartnerProductLoading) {
      return   Center(
        heightFactor: getProportionateScreenHeight(15),
        child: const RefreshProgressIndicator(
          color: AppColors.secondaryColor,
          backgroundColor: AppColors.primaryWhiteColor,
        ),
      );
    }
    if(state is BrandAndPartnerProductErrorState) {
      return Center(
        heightFactor: getProportionateScreenHeight(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(Assets.TRY_AGAIN,width: 230,height: 100),
          ],
        ),
      );
    }
    if(state is BrandAndPartnerProductLoaded) {
      if(state.brandAndPartnerProductRequestResponse.data!.rewards!.isNotEmpty) {
        return GridView.builder(
          shrinkWrap: true,
          itemCount: state.brandAndPartnerProductRequestResponse.data!.rewards!.length,
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
                context.push('/redeem_screen',
                  extra: BrandAndPartnerRedeemArguments(
                    requiredPoints: state.brandAndPartnerProductRequestResponse.data!.rewards![index].requiredPoints.toString(),
                    productImageUrl: state.brandAndPartnerProductRequestResponse.data!.rewards![index].productImage!,
                    qrCodeGenerationUrl: "",
                    whereToRedeem: state.brandAndPartnerProductRequestResponse.data!.rewards![index].reedemStores!,
                    from: 'brand_products',
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
                child:
                Column(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Center(
                        child: SizedBox(
                          width: 120,
                          height: 100,
                          child:
                          CachedNetworkImage(
                            alignment: Alignment.center,
                            fadeInCurve: Curves.easeIn,
                            fadeInDuration: const Duration(milliseconds: 200),
                            fit: BoxFit.contain,
                            imageUrl: state.brandAndPartnerProductRequestResponse.data!.rewards![index].productImage!,
                            width: MediaQuery.of(context).size.width,
                            placeholder: (context, url) => Lottie.asset(Assets.JUMBINGDOT,height: 10,width: 10),
                            errorWidget: (context, url, error) => const ImageIcon(
                              color: AppColors.hintColor,
                              AssetImage(Assets.NO_IMG),),

                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0, left: 20),
                        child: Text(
                          "${state.brandAndPartnerProductRequestResponse.data!.rewards![index].requiredPoints} points",
                          style: const TextStyle(
                              color: AppColors.primaryColor, fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }else {
        return Center(
            heightFactor: getProportionateScreenHeight(15),
            child: Lottie.asset(Assets.OOPS));
      }
    }
    return const SizedBox();

  },
);
  }
}
