import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_collect/language.dart';
import 'package:lets_collect/src/bloc/language/language_bloc.dart';
import 'package:lets_collect/src/bloc/reward_tier_bloc/reward_tier_bloc.dart';
import 'package:lets_collect/src/model/reward_tier/reward_tier_request.dart';
import 'package:lets_collect/src/ui/reward/components/lets_collect_redeem_screen_arguments.dart';
import 'package:lets_collect/src/ui/reward/components/widgets/custome_rounded_button.dart';
import 'package:lets_collect/src/utils/network_connectivity/bloc/network_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../bloc/filter_bloc/filter_bloc.dart';
import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../utils/screen_size/size_config.dart';
import 'components/widgets/sliver_background_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RewardScreen extends StatefulWidget {
  const RewardScreen({super.key});

  @override
  State<RewardScreen> createState() => _RewardScreenState();
}

class _RewardScreenState extends State<RewardScreen> {
  bool isLetsCollectSelected = false;
  bool isBrandSelected = false;
  bool isPartnerSelected = false;
  bool isScrolledToExtend = false;
  bool isRewardTierSelected = false;
  ScrollController _scrollController = ScrollController();
  String? sortOption;
  bool isBrandFilterTileSelected = false;
  bool isCategoryFilterTileSelected = false;
  String selectedBrandFilters = "";
  String selectedCategoryFilters = "";
  List<String> selectedBrandVariants = <String>[];
  List<String> selectedCategoryVariants = <String>[];
  String? eligibleFilter;
  List<String> selectedSortVariants = <String>[];
  String selectedSortFilter = "";
  String sortQuery = "";

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
  String letsCollectTotalPoints = "0";
  bool lastStatus = true;
  double height = 250;

  ///Scoll Listerner
  void _scrollListener() {
    if (_isShrink != lastStatus) {
      setState(() {
        lastStatus = _isShrink;
      });
    }
  }

  bool get _isShrink {
    return _scrollController.hasClients &&
        _scrollController.offset > (height - kToolbarHeight);
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(_scrollController.position.minScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.elasticOut);
    } else {
      Timer(const Duration(milliseconds: 400), () => _scrollToBottom());
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
    BlocProvider.of<FilterBloc>(context).add(GetBrandAndCategoryFilterList());
    BlocProvider.of<RewardTierBloc>(context).add(
      RewardTierRequestEvent(
        rewardTierRequest: RewardTierRequest(
            sort: "", eligible: "", categoryId: "", brandId: ""),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocConsumer<NetworkBloc, NetworkState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is NetworkSuccess) {
          return BlocConsumer<RewardTierBloc, RewardTierState>(
            listener: (context, state) {
              if (state is RewardTierLoaded) {
                if (state.rewardTierRequestResponse.data != null) {
                  letsCollectTotalPoints =
                      state.rewardTierRequestResponse.totalPoints.toString();
                }
              }
            },
            builder: (context, state) {
              return CustomScrollView(
                controller: _scrollController,
                physics: const ClampingScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    leading: const SizedBox(),
                    pinned: true,
                    centerTitle: false,
                    titleSpacing: 0,
                    titleTextStyle: const TextStyle(fontSize: 18),
                    title: _isShrink && isLetsCollectSelected == true
                        ? Row(
                            children: [
                              Flexible(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                        context: context,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20.0),
                                            topRight: Radius.circular(20.0),
                                          ),
                                        ),
                                        backgroundColor:
                                            AppColors.primaryWhiteColor,
                                        barrierColor: Colors.black38,
                                        elevation: 2,
                                        isScrollControlled: true,
                                        isDismissible: true,
                                        builder: (BuildContext bc) {
                                          return StatefulBuilder(
                                            builder: (BuildContext context,
                                                setState) {
                                              void clearFilter() {
                                                setState(() {
                                                  selectedSortVariants =
                                                      <String>[];
                                                });
                                              }

                                              // filterWidgets.clear();
                                              return Stack(
                                                children: [
                                                  SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            2,
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Column(
                                                        children: [
                                                          const SizedBox(
                                                              height: 60),
                                                          Column(
                                                            children:
                                                                List.generate(
                                                              sort.length,
                                                              (index) =>
                                                                  Padding(
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        8,
                                                                    vertical:
                                                                        6),
                                                                child:
                                                                    Container(
                                                                  padding: const EdgeInsets
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
                                                                        context.read<LanguageBloc>().state.selectedLanguage ==
                                                                                Language.english
                                                                            ? sort[index]
                                                                            : sort_ar[index],
                                                                        softWrap:
                                                                            true,
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
                                                                                  selectedSortVariants.remove(sort[index]);
                                                                                });
                                                                              },
                                                                              child: const CustomRoundedButton(enabled: true),
                                                                            )
                                                                          : InkWell(
                                                                              onTap: () {
                                                                                setState(() {
                                                                                  selectedSortVariants.add(sort[index]);
                                                                                  if (selectedSortVariants.length > 1) {
                                                                                    selectedSortVariants.removeAt(0);
                                                                                  }
                                                                                  selectedSortFilter = selectedSortVariants[0];
                                                                                  if (selectedSortFilter == "Recent") {
                                                                                    sortQuery = "recent";
                                                                                  }
                                                                                  if (selectedSortFilter == "Expiry First") {
                                                                                    sortQuery = "expire_first";
                                                                                  }
                                                                                  if (selectedSortFilter == "Points Low") {
                                                                                    sortQuery = "points_low";
                                                                                  }
                                                                                  if (selectedSortFilter == "Points High") {
                                                                                    sortQuery = "points_high";
                                                                                  }
                                                                                });
                                                                              },
                                                                              child: const CustomRoundedButton(
                                                                                enabled: false,
                                                                              ),
                                                                            ),
                                                                    ],
                                                                  ),
                                                                ),
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
                                                                context.pop();
                                                                BlocProvider.of<
                                                                            RewardTierBloc>(
                                                                        context)
                                                                    .add(
                                                                  RewardTierRequestEvent(
                                                                    rewardTierRequest:
                                                                        RewardTierRequest(
                                                                      sort: "",
                                                                      eligible:
                                                                          "",
                                                                      categoryId:
                                                                          "",
                                                                      brandId:
                                                                          "",
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                              child: Text(
                                                                AppLocalizations.of(
                                                                        context)!
                                                                    .clearall,
                                                                // "Clear All",
                                                                style:
                                                                    GoogleFonts
                                                                        .roboto(
                                                                  color: AppColors
                                                                      .primaryColor,
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
                                                              onPressed:
                                                                  () async {

                                                                BlocProvider.of<
                                                                            RewardTierBloc>(
                                                                        context)
                                                                    .add(
                                                                  RewardTierRequestEvent(
                                                                    rewardTierRequest:
                                                                        RewardTierRequest(
                                                                      sort:
                                                                          sortQuery,
                                                                      eligible:
                                                                          "",
                                                                      categoryId:
                                                                          "",
                                                                      brandId:
                                                                          "",
                                                                    ),
                                                                  ),
                                                                );
                                                                context.pop();
                                                                clearFilter();
                                                              },
                                                              child: Text(
                                                                AppLocalizations.of(
                                                                        context)!
                                                                    .apply,
                                                                // "Apply",
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
                                                  Positioned(
                                                    top: 4,
                                                    left: 0,
                                                    right: 0,
                                                    // bottom: 20,
                                                    child: SafeArea(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
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
                                                                  AppLocalizations.of(
                                                                          context)!
                                                                      .sortby,
                                                                  // "Sort by",
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
                                                                      () {
                                                                    context
                                                                        .pop();
                                                                    clearFilter();
                                                                  },
                                                                  icon:
                                                                      const Icon(
                                                                    Icons.close,
                                                                    color: AppColors
                                                                        .primaryGrayColor,
                                                                  ),
                                                                ),
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
                                                ],
                                              );
                                            },
                                          );
                                        });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    height: 20,
                                    width: 68,
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryWhiteColor,
                                      borderRadius: BorderRadius.circular(5),
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
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          // "Sort",
                                          AppLocalizations.of(context)!.sort,
                                          style: const TextStyle(
                                            color: AppColors.iconGreyColor,
                                            fontSize: 13,
                                          ),
                                        ),
                                        SvgPicture.asset(
                                          Assets.SORT_SVG,
                                          height: 10,
                                          width: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Flexible(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                        context: context,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20.0),
                                            topRight: Radius.circular(20.0),
                                          ),
                                        ),
                                        backgroundColor:
                                            AppColors.primaryWhiteColor,
                                        barrierColor: Colors.black38,
                                        elevation: 2,
                                        isScrollControlled: true,
                                        isDismissible: true,
                                        builder: (BuildContext bc) {
                                          return StatefulBuilder(
                                            builder: (BuildContext context,
                                                setState) {
                                              void clearFilter() {
                                                setState(() {
                                                  selectedBrandVariants =
                                                      <String>[];
                                                  selectedCategoryVariants =
                                                      <String>[];
                                                });
                                              }

                                              // filterWidgets.clear();

                                              return BlocBuilder<FilterBloc,
                                                  FilterState>(
                                                builder: (context, state) {
                                                  if (state is BrandLoading) {
                                                    return Center(
                                                      child: Lottie.asset(
                                                          Assets.JUMBINGDOT,
                                                          height: 100,
                                                          width: 100),
                                                    );
                                                  }
                                                  if (state is BrandLoaded) {
                                                    return Stack(
                                                      children: [
                                                        SizedBox(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height /
                                                              1.6,
                                                          child:
                                                              SingleChildScrollView(
                                                            child: Column(
                                                              children: [
                                                                const SizedBox(
                                                                    height: 60),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          8,
                                                                      vertical:
                                                                          6),
                                                                  child:
                                                                      Container(
                                                                    padding: const EdgeInsets
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
                                                                          AppLocalizations.of(context)!
                                                                              .eligible,
                                                                          // "Eligible",
                                                                          softWrap:
                                                                              true,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .bodyLarge!
                                                                              .copyWith(
                                                                                fontSize: 15,
                                                                              ),
                                                                        ),
                                                                        eligibleFilter ==
                                                                                "Eligible"
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
                                                                                  decoration: const BoxDecoration(
                                                                                    shape: BoxShape.rectangle,
                                                                                    image: DecorationImage(
                                                                                      image: AssetImage(Assets.DISABLED_TICK),
                                                                                      fit: BoxFit.contain,
                                                                                      scale: 6,
                                                                                    ),
                                                                                    color: AppColors.secondaryColor,
                                                                                    boxShadow: [
                                                                                      BoxShadow(blurRadius: 1.5, color: Colors.black38, offset: Offset(0, 1))
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              )
                                                                            : InkWell(
                                                                                onTap: () {
                                                                                  setState(() {
                                                                                    eligibleFilter = "Eligible";
                                                                                  });
                                                                                },
                                                                                child: Container(
                                                                                  height: 20,
                                                                                  width: 20,
                                                                                  decoration: const BoxDecoration(
                                                                                    shape: BoxShape.rectangle,
                                                                                    color: AppColors.primaryWhiteColor,
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
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      isBrandFilterTileSelected =
                                                                          !isBrandFilterTileSelected;
                                                                    });
                                                                  },
                                                                  child:
                                                                      ListTile(
                                                                    trailing: !isBrandFilterTileSelected ==
                                                                            true
                                                                        ? const ImageIcon(
                                                                            color:
                                                                                AppColors.secondaryColor,
                                                                            AssetImage(Assets.SIDE_ARROW),
                                                                          )
                                                                        : const ImageIcon(
                                                                            color:
                                                                                AppColors.secondaryColor,
                                                                            AssetImage(Assets.DOWN_ARROW),
                                                                          ),
                                                                    title: Text(
                                                                        AppLocalizations.of(context)!
                                                                            .brand),
                                                                    // Text("Brand"),
                                                                  ),
                                                                ),
                                                                isBrandFilterTileSelected ==
                                                                        true
                                                                    ? SingleChildScrollView(
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsets
                                                                              .only(
                                                                              right: 15,
                                                                              left: 15,
                                                                              bottom: 5,
                                                                              top: 5),
                                                                          child:
                                                                              Column(
                                                                            children:
                                                                                List.generate(
                                                                              state.brandAndCategoryFilterResponse.data.brands.length,
                                                                              (index) => Padding(
                                                                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                                                                child: Container(
                                                                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    children: <Widget>[
                                                                                      Text(
                                                                                        context.read<LanguageBloc>().state.selectedLanguage == Language.english ? state.brandAndCategoryFilterResponse.data.brands[index].brandName : state.brandAndCategoryFilterResponse.data.brands[index].brandNameArabic,
                                                                                        softWrap: true,
                                                                                        overflow: TextOverflow.ellipsis,
                                                                                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                                                                              fontSize: 15,
                                                                                            ),
                                                                                      ),
                                                                                      selectedBrandVariants.contains(state.brandAndCategoryFilterResponse.data.brands[index].id.toString())
                                                                                          ? InkWell(
                                                                                              onTap: () {
                                                                                                setState(() {
                                                                                                  selectedBrandVariants.remove(state.brandAndCategoryFilterResponse.data.brands[index].id.toString());
                                                                                                  selectedBrandFilters = "";
                                                                                                });
                                                                                              },
                                                                                              child: Container(
                                                                                                height: 20,
                                                                                                width: 20,
                                                                                                decoration: const BoxDecoration(
                                                                                                  shape: BoxShape.rectangle,
                                                                                                  image: DecorationImage(
                                                                                                    image: AssetImage(Assets.DISABLED_TICK),
                                                                                                    fit: BoxFit.contain,
                                                                                                    scale: 6,
                                                                                                  ),
                                                                                                  color: AppColors.secondaryColor,
                                                                                                  boxShadow: [
                                                                                                    BoxShadow(blurRadius: 1.5, color: Colors.black38, offset: Offset(0, 1))
                                                                                                  ],
                                                                                                ),
                                                                                              ),
                                                                                            )
                                                                                          : InkWell(
                                                                                              onTap: () {
                                                                                                setState(() {
                                                                                                  selectedBrandVariants.add(state.brandAndCategoryFilterResponse.data.brands[index].id.toString());
                                                                                                  if (selectedBrandVariants.length > 1) {
                                                                                                    selectedBrandVariants.removeAt(0);
                                                                                                  }
                                                                                                  selectedBrandFilters = selectedBrandVariants[0].toString();
                                                                                                });
                                                                                              },
                                                                                              child: Container(
                                                                                                height: 20,
                                                                                                width: 20,
                                                                                                decoration: const BoxDecoration(
                                                                                                  shape: BoxShape.rectangle,
                                                                                                  color: AppColors.primaryWhiteColor,
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
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      )
                                                                    : const SizedBox(),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      isCategoryFilterTileSelected =
                                                                          !isCategoryFilterTileSelected;
                                                                    });
                                                                  },
                                                                  child:
                                                                      ListTile(
                                                                    trailing: !isCategoryFilterTileSelected ==
                                                                            true
                                                                        ? const ImageIcon(
                                                                            color:
                                                                                AppColors.secondaryColor,
                                                                            AssetImage(Assets.SIDE_ARROW),
                                                                          )
                                                                        : const ImageIcon(
                                                                            color:
                                                                                AppColors.secondaryColor,
                                                                            AssetImage(Assets.DOWN_ARROW),
                                                                          ),
                                                                    title: Text(
                                                                        AppLocalizations.of(context)!
                                                                            .category),
                                                                    // Text("Category"),
                                                                  ),
                                                                ),
                                                                isCategoryFilterTileSelected ==
                                                                        true
                                                                    ? SingleChildScrollView(
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsets
                                                                              .only(
                                                                              right: 15,
                                                                              left: 15,
                                                                              bottom: 5,
                                                                              top: 5),
                                                                          child:
                                                                              Column(
                                                                            children:
                                                                                List.generate(
                                                                              state.brandAndCategoryFilterResponse.data.category.length,
                                                                              (index) => Padding(
                                                                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                                                                child: Container(
                                                                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    children: <Widget>[
                                                                                      Text(
                                                                                        context.read<LanguageBloc>().state.selectedLanguage == Language.english ? state.brandAndCategoryFilterResponse.data.category[index].category : state.brandAndCategoryFilterResponse.data.category[index].categoryNameArabic,
                                                                                        softWrap: true,
                                                                                        overflow: TextOverflow.ellipsis,
                                                                                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                                                                              fontSize: 15,
                                                                                            ),
                                                                                      ),
                                                                                      selectedCategoryVariants.contains(state.brandAndCategoryFilterResponse.data.category[index].id.toString())
                                                                                          ? InkWell(
                                                                                              onTap: () {
                                                                                                setState(() {
                                                                                                  selectedCategoryVariants.remove(state.brandAndCategoryFilterResponse.data.category[index].id.toString());
                                                                                                  selectedCategoryFilters = "";
                                                                                                  // selectedFilters[]
                                                                                                });
                                                                                              },
                                                                                              child: Container(
                                                                                                height: 20,
                                                                                                width: 20,
                                                                                                decoration: const BoxDecoration(
                                                                                                  shape: BoxShape.rectangle,
                                                                                                  image: DecorationImage(
                                                                                                    image: AssetImage(Assets.DISABLED_TICK),
                                                                                                    fit: BoxFit.contain,
                                                                                                    scale: 6,
                                                                                                  ),
                                                                                                  color: AppColors.secondaryColor,
                                                                                                  boxShadow: [
                                                                                                    BoxShadow(blurRadius: 1.5, color: Colors.black38, offset: Offset(0, 1))
                                                                                                  ],
                                                                                                ),
                                                                                              ),
                                                                                            )
                                                                                          : InkWell(
                                                                                              onTap: () {
                                                                                                setState(() {
                                                                                                  selectedCategoryVariants.add(state.brandAndCategoryFilterResponse.data.category[index].id.toString());
                                                                                                  if (selectedCategoryVariants.length > 1) {
                                                                                                    selectedCategoryVariants.removeAt(0);
                                                                                                  }
                                                                                                  selectedCategoryFilters = selectedCategoryVariants[0].toString();
                                                                                                });
                                                                                              },
                                                                                              child: Container(
                                                                                                height: 20,
                                                                                                width: 20,
                                                                                                decoration: const BoxDecoration(
                                                                                                  shape: BoxShape.rectangle,
                                                                                                  color: AppColors.primaryWhiteColor,
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
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      )
                                                                    : const SizedBox(),
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
                                                                    blurRadius:
                                                                        4,
                                                                    offset:
                                                                        Offset(
                                                                            4,
                                                                            2),
                                                                    spreadRadius:
                                                                        0,
                                                                  ),
                                                                ],
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            20,
                                                                        right:
                                                                            20,
                                                                        bottom:
                                                                            10),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        clearFilter();
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        AppLocalizations.of(context)!
                                                                            .clearall,
                                                                        // "Clear All",
                                                                        style: GoogleFonts
                                                                            .roboto(
                                                                          color:
                                                                              AppColors.underlineColor,
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                          fontSize:
                                                                              14,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    ElevatedButton(
                                                                      style: ElevatedButton
                                                                          .styleFrom(
                                                                        fixedSize: const Size(
                                                                            100,
                                                                            40),
                                                                        shape:
                                                                            RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(8),
                                                                        ),
                                                                        backgroundColor:
                                                                            AppColors.secondaryColor,
                                                                      ),
                                                                      onPressed:
                                                                          () {

                                                                        BlocProvider.of<RewardTierBloc>(context)
                                                                            .add(
                                                                          RewardTierRequestEvent(
                                                                            rewardTierRequest:
                                                                                RewardTierRequest(
                                                                              sort: "",
                                                                              eligible: eligibleFilter == "Eligible" ? "1" : "",
                                                                              categoryId: selectedCategoryFilters.isEmpty ? "" : selectedCategoryFilters,
                                                                              brandId: selectedBrandFilters.isEmpty ? "" : selectedBrandFilters,
                                                                            ),
                                                                          ),
                                                                        );
                                                                        context
                                                                            .pop();
                                                                        _scrollToBottom();
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        AppLocalizations.of(context)!
                                                                            .apply,
                                                                        // "Apply",
                                                                        style: GoogleFonts
                                                                            .roboto(
                                                                          color:
                                                                              AppColors.primaryWhiteColor,
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                          fontSize:
                                                                              14,
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
                                                                  BorderRadius
                                                                      .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        20.0),
                                                                topRight: Radius
                                                                    .circular(
                                                                        20.0),
                                                              ),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          15),
                                                              child: Container(
                                                                // height: 40,
                                                                color: Colors
                                                                    .white,
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
                                                                          AppLocalizations.of(context)!
                                                                              .filterby,
                                                                          // "Filter by",
                                                                          style:
                                                                              GoogleFonts.roboto(
                                                                            fontSize:
                                                                                16,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            color:
                                                                                AppColors.primaryGrayColor,
                                                                          ),
                                                                        ),
                                                                        IconButton(
                                                                          onPressed:
                                                                              () {
                                                                            context.pop();
                                                                          },
                                                                          icon:
                                                                              const Icon(
                                                                            Icons.close,
                                                                            color:
                                                                                AppColors.primaryGrayColor,
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
                                                  }
                                                  return const SizedBox();
                                                },
                                              );
                                            },
                                          );
                                        });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    height: 20,
                                    width: 68,
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryWhiteColor,
                                      borderRadius: BorderRadius.circular(5),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color(0x0F000000),
                                          blurRadius: 4,
                                          offset: Offset(4, 2),
                                          spreadRadius: 0,
                                        ),
                                        BoxShadow(
                                          color: Color(0x0F000000),
                                          blurRadius: 4,
                                          offset: Offset(-4, -2),
                                          spreadRadius: 0,
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                              ),
                              const Spacer(flex: 1),
                              Flexible(
                                flex: 1,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.letscollect,
                                      // "LetsCollect",
                                      overflow: TextOverflow.fade,
                                      softWrap: true,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                    Text(letsCollectTotalPoints.toString()),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : _isShrink && isBrandSelected == true
                            ? Row(
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: GestureDetector(
                                      onTap: () {
                                        showModalBottomSheet(
                                            context: context,
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20.0),
                                                topRight: Radius.circular(20.0),
                                              ),
                                            ),
                                            backgroundColor:
                                                AppColors.primaryWhiteColor,
                                            barrierColor: Colors.black38,
                                            elevation: 2,
                                            isScrollControlled: true,
                                            isDismissible: true,
                                            builder: (BuildContext bc) {
                                              return StatefulBuilder(
                                                builder: (BuildContext context,
                                                    setState) {
                                                  void clearFilter() {
                                                    setState(() {
                                                      selectedSortVariants =
                                                          <String>[];
                                                    });
                                                  }

                                                  // filterWidgets.clear();
                                                  return Stack(
                                                    children: [
                                                      SizedBox(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            2,
                                                        child:
                                                            SingleChildScrollView(
                                                          child: Column(
                                                            children: [
                                                              const SizedBox(
                                                                  height: 60),
                                                              Column(
                                                                children: List
                                                                    .generate(
                                                                  sort.length,
                                                                  (index) =>
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                            8,
                                                                        vertical:
                                                                            6),
                                                                    child:
                                                                        Container(
                                                                      padding: const EdgeInsets
                                                                          .symmetric(
                                                                          horizontal:
                                                                              10,
                                                                          vertical:
                                                                              6),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: <Widget>[
                                                                          Text(
                                                                            context.read<LanguageBloc>().state.selectedLanguage == Language.english
                                                                                ? sort[index]
                                                                                : sort_ar[index],
                                                                            softWrap:
                                                                                true,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                                                                  fontSize: 15,
                                                                                ),
                                                                          ),
                                                                          selectedSortVariants.contains(sort[index])
                                                                              ? InkWell(
                                                                                  onTap: () {
                                                                                    setState(() {
                                                                                      selectedSortVariants.remove(sort[index]);
                                                                                    });
                                                                                  },
                                                                                  child: const CustomRoundedButton(enabled: true),
                                                                                )
                                                                              : InkWell(
                                                                                  onTap: () {
                                                                                    setState(() {
                                                                                      selectedSortVariants.add(
                                                                                        context.read<LanguageBloc>().state.selectedLanguage == Language.english ? sort[index] : sort_ar[index],
                                                                                      );
                                                                                      if (selectedSortVariants.length > 1) {
                                                                                        selectedSortVariants.removeAt(0);
                                                                                      }
                                                                                      selectedSortFilter = selectedSortVariants[0];
                                                                                      if (selectedSortFilter == "Recent") {
                                                                                        sortQuery = "recent";
                                                                                      }
                                                                                      if (selectedSortFilter == "Expiry First") {
                                                                                        sortQuery = "expire_first";
                                                                                      }
                                                                                      if (selectedSortFilter == "Points Low") {
                                                                                        sortQuery = "points_low";
                                                                                      }
                                                                                      if (selectedSortFilter == "Points High") {
                                                                                        sortQuery = "points_high";
                                                                                      }
                                                                                    });
                                                                                  },
                                                                                  child: const CustomRoundedButton(
                                                                                    enabled: false,
                                                                                  ),
                                                                                ),
                                                                        ],
                                                                      ),
                                                                    ),
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
                                                                  onPressed:
                                                                      () {
                                                                    clearFilter();
                                                                    context
                                                                        .pop();
                                                                    BlocProvider.of<RewardTierBloc>(
                                                                            context)
                                                                        .add(
                                                                      RewardTierRequestEvent(
                                                                        rewardTierRequest:
                                                                            RewardTierRequest(
                                                                          sort:
                                                                              "",
                                                                          eligible:
                                                                              "",
                                                                          categoryId:
                                                                              "",
                                                                          brandId:
                                                                              "",
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                  child: Text(
                                                                    AppLocalizations.of(
                                                                            context)!
                                                                        .clearall,
                                                                    // "Clear All",
                                                                    style: GoogleFonts
                                                                        .roboto(
                                                                      color: AppColors
                                                                          .primaryColor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontSize:
                                                                          14,
                                                                    ),
                                                                  ),
                                                                ),
                                                                ElevatedButton(
                                                                  style: ElevatedButton
                                                                      .styleFrom(
                                                                    fixedSize:
                                                                        const Size(
                                                                            100,
                                                                            40),
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8),
                                                                    ),
                                                                    backgroundColor:
                                                                        AppColors
                                                                            .secondaryColor,
                                                                  ),
                                                                  onPressed:
                                                                      () async {

                                                                    BlocProvider.of<RewardTierBloc>(
                                                                            context)
                                                                        .add(
                                                                      RewardTierRequestEvent(
                                                                        rewardTierRequest:
                                                                            RewardTierRequest(
                                                                          sort:
                                                                              sortQuery,
                                                                          eligible:
                                                                              "",
                                                                          categoryId:
                                                                              "",
                                                                          brandId:
                                                                              "",
                                                                        ),
                                                                      ),
                                                                    );
                                                                    context
                                                                        .pop();
                                                                  },
                                                                  child: Text(
                                                                    AppLocalizations.of(
                                                                            context)!
                                                                        .apply,
                                                                    // "Apply",
                                                                    style: GoogleFonts
                                                                        .roboto(
                                                                      color: AppColors
                                                                          .primaryWhiteColor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontSize:
                                                                          14,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        top: 0,
                                                        left: 0,
                                                        right: 0,
                                                        // bottom: 20,
                                                        child: SafeArea(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        15),
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
                                                                      AppLocalizations.of(
                                                                              context)!
                                                                          .sortby,
                                                                      // "Sort by",
                                                                      style: GoogleFonts
                                                                          .roboto(
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        color: AppColors
                                                                            .primaryGrayColor,
                                                                      ),
                                                                    ),
                                                                    IconButton(
                                                                      onPressed:
                                                                          () {
                                                                        context
                                                                            .pop();
                                                                        clearFilter();
                                                                      },
                                                                      icon:
                                                                          const Icon(
                                                                        Icons
                                                                            .close,
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
                                                    ],
                                                  );
                                                },
                                              );
                                            });
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                            left: 8, right: 8),
                                        height: 20,
                                        width: 68,
                                        decoration: BoxDecoration(
                                          color: AppColors.primaryWhiteColor,
                                          borderRadius:
                                              BorderRadius.circular(5),
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
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .sort,
                                              // "Sort",
                                              style: const TextStyle(
                                                color: AppColors.iconGreyColor,
                                                fontSize: 13,
                                              ),
                                            ),
                                            SvgPicture.asset(
                                              Assets.SORT_SVG,
                                              height: 10,
                                              width: 10,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Flexible(
                                    flex: 1,
                                    child: GestureDetector(
                                      onTap: () {
                                        showModalBottomSheet(
                                            context: context,
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20.0),
                                                topRight: Radius.circular(20.0),
                                              ),
                                            ),
                                            backgroundColor:
                                                AppColors.primaryWhiteColor,
                                            barrierColor: Colors.black38,
                                            elevation: 2,
                                            isScrollControlled: true,
                                            isDismissible: true,
                                            builder: (BuildContext bc) {
                                              return StatefulBuilder(
                                                builder: (BuildContext context,
                                                    setState) {
                                                  void clearFilter() {
                                                    setState(() {
                                                      selectedBrandVariants =
                                                          <String>[];
                                                      selectedBrandFilters = "";
                                                      selectedCategoryVariants =
                                                          <String>[];
                                                      selectedCategoryFilters =
                                                          "";
                                                    });
                                                  }

                                                  // filterWidgets.clear();

                                                  return BlocBuilder<FilterBloc,
                                                      FilterState>(
                                                    builder: (context, state) {
                                                      if (state
                                                          is BrandLoading) {
                                                        return Center(
                                                          child: Lottie.asset(
                                                              Assets.JUMBINGDOT,
                                                              height: 100,
                                                              width: 100),
                                                        );
                                                      }
                                                      if (state
                                                          is BrandLoaded) {
                                                        return Stack(
                                                          children: [
                                                            SizedBox(
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height /
                                                                  1.6,
                                                              child:
                                                                  SingleChildScrollView(
                                                                child: Column(
                                                                  children: [
                                                                    const SizedBox(
                                                                        height:
                                                                            60),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .symmetric(
                                                                          horizontal:
                                                                              8,
                                                                          vertical:
                                                                              6),
                                                                      child:
                                                                          Container(
                                                                        padding: const EdgeInsets
                                                                            .symmetric(
                                                                            horizontal:
                                                                                10,
                                                                            vertical:
                                                                                6),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children: <Widget>[
                                                                            Text(
                                                                              AppLocalizations.of(context)!.eligible,
                                                                              // "Eligible",
                                                                              softWrap: true,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
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
                                                                                      decoration: const BoxDecoration(
                                                                                        shape: BoxShape.rectangle,
                                                                                        image: DecorationImage(
                                                                                          image: AssetImage(Assets.DISABLED_TICK),
                                                                                          fit: BoxFit.contain,
                                                                                          scale: 6,
                                                                                        ),
                                                                                        color: AppColors.secondaryColor,
                                                                                        boxShadow: [
                                                                                          BoxShadow(blurRadius: 1.5, color: Colors.black38, offset: Offset(0, 1))
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                                : InkWell(
                                                                                    onTap: () {
                                                                                      setState(() {
                                                                                        eligibleFilter = "Eligible";
                                                                                      });
                                                                                    },
                                                                                    child: Container(
                                                                                      height: 20,
                                                                                      width: 20,
                                                                                      decoration: const BoxDecoration(
                                                                                        shape: BoxShape.rectangle,
                                                                                        color: AppColors.primaryWhiteColor,
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
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          isBrandFilterTileSelected =
                                                                              !isBrandFilterTileSelected;
                                                                        });
                                                                      },
                                                                      child: ListTile(
                                                                          trailing: !isBrandFilterTileSelected == true
                                                                              ? const ImageIcon(
                                                                                  color: AppColors.secondaryColor,
                                                                                  AssetImage(Assets.SIDE_ARROW),
                                                                                )
                                                                              : const ImageIcon(
                                                                                  color: AppColors.secondaryColor,
                                                                                  AssetImage(Assets.DOWN_ARROW),
                                                                                ),
                                                                          title: Text(AppLocalizations.of(context)!.brand)
                                                                          // Text("Brand"),
                                                                          ),
                                                                    ),
                                                                    isBrandFilterTileSelected ==
                                                                            true
                                                                        ? SingleChildScrollView(
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.only(right: 15, left: 15, bottom: 5, top: 5),
                                                                              child: Column(
                                                                                children: List.generate(
                                                                                  state.brandAndCategoryFilterResponse.data.brands.length,
                                                                                  (index) => Padding(
                                                                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                                                                    child: Container(
                                                                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                                                                      child: Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        children: <Widget>[
                                                                                          Text(
                                                                                            context.read<LanguageBloc>().state.selectedLanguage == Language.english ? state.brandAndCategoryFilterResponse.data.brands[index].brandName : state.brandAndCategoryFilterResponse.data.brands[index].brandNameArabic,
                                                                                            softWrap: true,
                                                                                            overflow: TextOverflow.ellipsis,
                                                                                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                                                                                  fontSize: 15,
                                                                                                ),
                                                                                          ),
                                                                                          selectedBrandVariants.contains(state.brandAndCategoryFilterResponse.data.brands[index].id.toString())
                                                                                              ? InkWell(
                                                                                                  onTap: () {
                                                                                                    setState(() {
                                                                                                      selectedBrandVariants.remove(state.brandAndCategoryFilterResponse.data.brands[index].id.toString());
                                                                                                      selectedBrandFilters = "";
                                                                                                    });
                                                                                                  },
                                                                                                  child: Container(
                                                                                                    height: 20,
                                                                                                    width: 20,
                                                                                                    decoration: const BoxDecoration(
                                                                                                      shape: BoxShape.rectangle,
                                                                                                      image: DecorationImage(
                                                                                                        image: AssetImage(Assets.DISABLED_TICK),
                                                                                                        fit: BoxFit.contain,
                                                                                                        scale: 6,
                                                                                                      ),
                                                                                                      color: AppColors.secondaryColor,
                                                                                                      boxShadow: [
                                                                                                        BoxShadow(blurRadius: 1.5, color: Colors.black38, offset: Offset(0, 1))
                                                                                                      ],
                                                                                                    ),
                                                                                                  ),
                                                                                                )
                                                                                              : InkWell(
                                                                                                  onTap: () {
                                                                                                    setState(() {
                                                                                                      selectedBrandVariants.add(state.brandAndCategoryFilterResponse.data.brands[index].id.toString());
                                                                                                      if (selectedBrandVariants.length > 1) {
                                                                                                        selectedBrandVariants.removeAt(0);
                                                                                                      }
                                                                                                      selectedBrandFilters = selectedBrandVariants[0].toString();
                                                                                                    });
                                                                                                  },
                                                                                                  child: Container(
                                                                                                    height: 20,
                                                                                                    width: 20,
                                                                                                    decoration: const BoxDecoration(
                                                                                                      shape: BoxShape.rectangle,
                                                                                                      color: AppColors.primaryWhiteColor,
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
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          )
                                                                        : const SizedBox(),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          isCategoryFilterTileSelected =
                                                                              !isCategoryFilterTileSelected;
                                                                        });
                                                                      },
                                                                      child:
                                                                          ListTile(
                                                                        trailing: !isCategoryFilterTileSelected ==
                                                                                true
                                                                            ? const ImageIcon(
                                                                                color: AppColors.secondaryColor,
                                                                                AssetImage(Assets.SIDE_ARROW),
                                                                              )
                                                                            : const ImageIcon(
                                                                                color: AppColors.secondaryColor,
                                                                                AssetImage(Assets.DOWN_ARROW),
                                                                              ),
                                                                        title: Text(
                                                                            AppLocalizations.of(context)!.category),
                                                                        // Text("Category"),
                                                                      ),
                                                                    ),
                                                                    isCategoryFilterTileSelected ==
                                                                            true
                                                                        ? SingleChildScrollView(
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.only(right: 15, left: 15, bottom: 5, top: 5),
                                                                              child: Column(
                                                                                children: List.generate(
                                                                                  state.brandAndCategoryFilterResponse.data.category.length,
                                                                                  (index) => Padding(
                                                                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                                                                    child: Container(
                                                                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                                                                      child: Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        children: <Widget>[
                                                                                          Text(
                                                                                            context.read<LanguageBloc>().state.selectedLanguage == Language.english ? state.brandAndCategoryFilterResponse.data.category[index].category : state.brandAndCategoryFilterResponse.data.category[index].categoryNameArabic,
                                                                                            softWrap: true,
                                                                                            overflow: TextOverflow.ellipsis,
                                                                                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                                                                                  fontSize: 15,
                                                                                                ),
                                                                                          ),
                                                                                          selectedCategoryVariants.contains(state.brandAndCategoryFilterResponse.data.category[index].id.toString())
                                                                                              ? InkWell(
                                                                                                  onTap: () {
                                                                                                    setState(() {
                                                                                                      selectedCategoryVariants.remove(state.brandAndCategoryFilterResponse.data.category[index].id.toString());
                                                                                                      selectedCategoryFilters = "";
                                                                                                    });
                                                                                                  },
                                                                                                  child: Container(
                                                                                                    height: 20,
                                                                                                    width: 20,
                                                                                                    decoration: const BoxDecoration(
                                                                                                      shape: BoxShape.rectangle,
                                                                                                      image: DecorationImage(
                                                                                                        image: AssetImage(Assets.DISABLED_TICK),
                                                                                                        fit: BoxFit.contain,
                                                                                                        scale: 6,
                                                                                                      ),
                                                                                                      color: AppColors.secondaryColor,
                                                                                                      boxShadow: [
                                                                                                        BoxShadow(blurRadius: 1.5, color: Colors.black38, offset: Offset(0, 1))
                                                                                                      ],
                                                                                                    ),
                                                                                                  ),
                                                                                                )
                                                                                              : InkWell(
                                                                                                  onTap: () {
                                                                                                    setState(() {
                                                                                                      selectedCategoryVariants.add(state.brandAndCategoryFilterResponse.data.category[index].id.toString());
                                                                                                      if (selectedCategoryVariants.length > 1) {
                                                                                                        selectedCategoryVariants.removeAt(0);
                                                                                                      }
                                                                                                      selectedCategoryFilters = selectedCategoryVariants[0].toString();
                                                                                                    });
                                                                                                  },
                                                                                                  child: Container(
                                                                                                    height: 20,
                                                                                                    width: 20,
                                                                                                    decoration: const BoxDecoration(
                                                                                                      shape: BoxShape.rectangle,
                                                                                                      color: AppColors.primaryWhiteColor,
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
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          )
                                                                        : const SizedBox(),
                                                                    const SizedBox(
                                                                        height:
                                                                            80),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            Positioned(
                                                              bottom: 0,
                                                              right: 0,
                                                              left: 0,
                                                              child: SafeArea(
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    color: AppColors
                                                                        .primaryWhiteColor,
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                        color: AppColors
                                                                            .boxShadow,
                                                                        blurRadius:
                                                                            4,
                                                                        offset: Offset(
                                                                            4,
                                                                            2),
                                                                        spreadRadius:
                                                                            0,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            20,
                                                                        right:
                                                                            20,
                                                                        bottom:
                                                                            10),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            clearFilter();
                                                                          },
                                                                          child:
                                                                              Text(
                                                                            AppLocalizations.of(context)!.clearall,
                                                                            // "Clear All",
                                                                            style:
                                                                                GoogleFonts.roboto(
                                                                              color: AppColors.underlineColor,
                                                                              fontWeight: FontWeight.w400,
                                                                              fontSize: 14,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        ElevatedButton(
                                                                          style:
                                                                              ElevatedButton.styleFrom(
                                                                            fixedSize:
                                                                                const Size(100, 40),
                                                                            shape:
                                                                                RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(8),
                                                                            ),
                                                                            backgroundColor:
                                                                                AppColors.secondaryColor,
                                                                          ),
                                                                          onPressed:
                                                                              () {


                                                                            BlocProvider.of<RewardTierBloc>(context).add(
                                                                              RewardTierRequestEvent(
                                                                                rewardTierRequest: RewardTierRequest(
                                                                                  sort: "",
                                                                                  eligible: eligibleFilter == "Eligible" ? "1" : "",
                                                                                  categoryId: selectedCategoryFilters.isEmpty ? "" : selectedCategoryFilters,
                                                                                  brandId: selectedBrandFilters.isEmpty ? "" : selectedBrandFilters,
                                                                                ),
                                                                              ),
                                                                            );
                                                                            context.pop();
                                                                            _scrollToBottom();
                                                                          },
                                                                          child:
                                                                              Text(
                                                                            AppLocalizations.of(context)!.apply,
                                                                            // "Apply",
                                                                            style:
                                                                                GoogleFonts.roboto(
                                                                              color: AppColors.primaryWhiteColor,
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
                                                                decoration:
                                                                    const BoxDecoration(
                                                                  color: AppColors
                                                                      .primaryWhiteColor,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            20.0),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            20.0),
                                                                  ),
                                                                ),
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          15),
                                                                  child:
                                                                      Container(
                                                                    // height: 40,
                                                                    color: AppColors
                                                                        .primaryWhiteColor,
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            Text(
                                                                              AppLocalizations.of(context)!.filterby,
                                                                              // "Filter by",
                                                                              style: GoogleFonts.roboto(
                                                                                fontSize: 16,
                                                                                fontWeight: FontWeight.w400,
                                                                                color: AppColors.primaryGrayColor,
                                                                              ),
                                                                            ),
                                                                            IconButton(
                                                                              onPressed: () {
                                                                                context.pop();
                                                                              },
                                                                              icon: const Icon(
                                                                                Icons.close,
                                                                                color: AppColors.primaryGrayColor,
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
                                                      }
                                                      return const SizedBox();
                                                    },
                                                  );
                                                },
                                              );
                                            });
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                            left: 8, right: 8),
                                        height: 20,
                                        width: 68,
                                        decoration: BoxDecoration(
                                          color: AppColors.primaryWhiteColor,
                                          borderRadius:
                                              BorderRadius.circular(5),
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
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .filter,
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
                                  ),
                                ],
                              )
                            : _isShrink && isPartnerSelected == true
                                ? Row(
                                    children: [
                                      Flexible(
                                        flex: 1,
                                        child: GestureDetector(
                                          onTap: () {
                                            showModalBottomSheet(
                                                context: context,
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20.0),
                                                    topRight:
                                                        Radius.circular(20.0),
                                                  ),
                                                ),
                                                backgroundColor:
                                                    AppColors.primaryWhiteColor,
                                                barrierColor: Colors.black38,
                                                elevation: 2,
                                                isScrollControlled: true,
                                                isDismissible: true,
                                                builder: (BuildContext bc) {
                                                  return StatefulBuilder(
                                                    builder:
                                                        (BuildContext context,
                                                            setState) {
                                                      void clearFilter() {
                                                        setState(() {
                                                          selectedSortVariants =
                                                              <String>[];
                                                        });
                                                      }

                                                      // filterWidgets.clear();
                                                      return Stack(
                                                        children: [
                                                          SizedBox(
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height /
                                                                2,
                                                            child:
                                                                SingleChildScrollView(
                                                              child: Column(
                                                                children: [
                                                                  const SizedBox(
                                                                      height:
                                                                          60),
                                                                  Column(
                                                                    children: List
                                                                        .generate(
                                                                      sort.length,
                                                                      (index) =>
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .symmetric(
                                                                            horizontal:
                                                                                8,
                                                                            vertical:
                                                                                6),
                                                                        child:
                                                                            Container(
                                                                          padding: const EdgeInsets
                                                                              .symmetric(
                                                                              horizontal: 10,
                                                                              vertical: 6),
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            children: <Widget>[
                                                                              Text(
                                                                                context.read<LanguageBloc>().state.selectedLanguage == Language.english ? sort[index] : sort_ar[index],
                                                                                softWrap: true,
                                                                                overflow: TextOverflow.ellipsis,
                                                                                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                                                                      fontSize: 15,
                                                                                    ),
                                                                              ),
                                                                              selectedSortVariants.contains(sort[index])
                                                                                  ? InkWell(
                                                                                      onTap: () {
                                                                                        setState(() {
                                                                                          selectedSortVariants.remove(sort[index]);
                                                                                        });
                                                                                      },
                                                                                      child: const CustomRoundedButton(enabled: true),
                                                                                    )
                                                                                  : InkWell(
                                                                                      onTap: () {
                                                                                        setState(() {
                                                                                          selectedSortVariants.add(
                                                                                            context.read<LanguageBloc>().state.selectedLanguage == Language.english ? sort[index] : sort_ar[index],
                                                                                          );
                                                                                          if (selectedSortVariants.length > 1) {
                                                                                            selectedSortVariants.removeAt(0);
                                                                                          }
                                                                                          selectedSortFilter = selectedSortVariants[0];
                                                                                          if (selectedSortFilter == "Recent") {
                                                                                            sortQuery = "recent";
                                                                                          }
                                                                                          if (selectedSortFilter == "Expiry First") {
                                                                                            sortQuery = "expire_first";
                                                                                          }
                                                                                          if (selectedSortFilter == "Points Low") {
                                                                                            sortQuery = "points_low";
                                                                                          }
                                                                                          if (selectedSortFilter == "Points High") {
                                                                                            sortQuery = "points_high";
                                                                                          }
                                                                                        });
                                                                                      },
                                                                                      child: const CustomRoundedButton(
                                                                                        enabled: false,
                                                                                      ),
                                                                                    ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                      height:
                                                                          80),
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
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            20,
                                                                        right:
                                                                            20,
                                                                        bottom:
                                                                            10),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        clearFilter();
                                                                        // context.pop();
                                                                        BlocProvider.of<RewardTierBloc>(context)
                                                                            .add(
                                                                          RewardTierRequestEvent(
                                                                            rewardTierRequest:
                                                                                RewardTierRequest(
                                                                              sort: "",
                                                                              eligible: "",
                                                                              categoryId: "",
                                                                              brandId: "",
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        // "Clear All",
                                                                        AppLocalizations.of(context)!
                                                                            .clearall,
                                                                        style: GoogleFonts
                                                                            .roboto(
                                                                          color:
                                                                              AppColors.primaryColor,
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                          fontSize:
                                                                              14,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    ElevatedButton(
                                                                      style: ElevatedButton
                                                                          .styleFrom(
                                                                        fixedSize: const Size(
                                                                            100,
                                                                            40),
                                                                        shape:
                                                                            RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(8),
                                                                        ),
                                                                        backgroundColor:
                                                                            AppColors.secondaryColor,
                                                                      ),
                                                                      onPressed:
                                                                          () async {

                                                                        BlocProvider.of<RewardTierBloc>(context)
                                                                            .add(
                                                                          RewardTierRequestEvent(
                                                                            rewardTierRequest:
                                                                                RewardTierRequest(
                                                                              sort: sortQuery,
                                                                              eligible: "",
                                                                              categoryId: "",
                                                                              brandId: "",
                                                                            ),
                                                                          ),
                                                                        );
                                                                        context
                                                                            .pop();
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        // "Apply",
                                                                        AppLocalizations.of(context)!
                                                                            .apply,
                                                                        style: GoogleFonts
                                                                            .roboto(
                                                                          color:
                                                                              AppColors.primaryWhiteColor,
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                          fontSize:
                                                                              14,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Positioned(
                                                            top: 0,
                                                            left: 0,
                                                            right: 0,
                                                            // bottom: 20,
                                                            child: SafeArea(
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        15),
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
                                                                          AppLocalizations.of(context)!
                                                                              .sortby,
                                                                          // "Sort by",
                                                                          style:
                                                                              GoogleFonts.roboto(
                                                                            fontSize:
                                                                                16,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            color:
                                                                                AppColors.primaryGrayColor,
                                                                          ),
                                                                        ),
                                                                        IconButton(
                                                                          onPressed:
                                                                              () {
                                                                            context.pop();
                                                                            clearFilter();
                                                                          },
                                                                          icon:
                                                                              const Icon(
                                                                            Icons.close,
                                                                            color:
                                                                                AppColors.primaryGrayColor,
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
                                                        ],
                                                      );
                                                    },
                                                  );
                                                });
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                                left: 8, right: 8),
                                            height: 20,
                                            width: 68,
                                            decoration: BoxDecoration(
                                              color:
                                                  AppColors.primaryWhiteColor,
                                              borderRadius:
                                                  BorderRadius.circular(5),
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
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .sort,
                                                  // "Sort",
                                                  style: const TextStyle(
                                                    color:
                                                        AppColors.iconGreyColor,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                                SvgPicture.asset(
                                                  Assets.SORT_SVG,
                                                  height: 10,
                                                  width: 10,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 15),
                                      Flexible(
                                        flex: 1,
                                        child: GestureDetector(
                                          onTap: () {
                                            showModalBottomSheet(
                                                context: context,
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20.0),
                                                    topRight:
                                                        Radius.circular(20.0),
                                                  ),
                                                ),
                                                backgroundColor:
                                                    AppColors.primaryWhiteColor,
                                                barrierColor: Colors.black38,
                                                elevation: 2,
                                                isScrollControlled: true,
                                                isDismissible: true,
                                                builder: (BuildContext bc) {
                                                  return StatefulBuilder(
                                                    builder:
                                                        (BuildContext context,
                                                            setState) {
                                                      void clearFilter() {
                                                        setState(() {
                                                          eligibleFilter = "";
                                                          selectedBrandVariants =
                                                              <String>[];
                                                          selectedBrandFilters =
                                                              "";
                                                          selectedCategoryVariants =
                                                              <String>[];
                                                          selectedCategoryFilters =
                                                              "";
                                                        });
                                                      }

                                                      return BlocBuilder<
                                                          FilterBloc,
                                                          FilterState>(
                                                        builder:
                                                            (context, state) {
                                                          if (state
                                                              is BrandLoading) {
                                                            return Center(
                                                              child: Lottie.asset(
                                                                  Assets
                                                                      .JUMBINGDOT,
                                                                  height: 100,
                                                                  width: 100),
                                                            );
                                                          }
                                                          if (state
                                                              is BrandLoaded) {
                                                            return Stack(
                                                              children: [
                                                                SizedBox(
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height /
                                                                      1.6,
                                                                  child:
                                                                      SingleChildScrollView(
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        const SizedBox(
                                                                            height:
                                                                                60),
                                                                        Padding(
                                                                          padding: const EdgeInsets
                                                                              .symmetric(
                                                                              horizontal: 8,
                                                                              vertical: 6),
                                                                          child:
                                                                              Container(
                                                                            padding:
                                                                                const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: <Widget>[
                                                                                Text(
                                                                                  AppLocalizations.of(context)!.eligible,
                                                                                  // "Eligible",
                                                                                  softWrap: true,
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                                                                        fontSize: 15,
                                                                                      ),
                                                                                ),
                                                                                eligibleFilter == "Eligible"
                                                                                    ? InkWell(
                                                                                        onTap: () {
                                                                                          setState(() {
                                                                                            eligibleFilter = "";
                                                                                          });
                                                                                        },
                                                                                        child: Container(
                                                                                          height: 20,
                                                                                          width: 20,
                                                                                          decoration: const BoxDecoration(
                                                                                            shape: BoxShape.rectangle,
                                                                                            image: DecorationImage(
                                                                                              image: AssetImage(Assets.DISABLED_TICK),
                                                                                              fit: BoxFit.contain,
                                                                                              scale: 6,
                                                                                            ),
                                                                                            color: AppColors.secondaryColor,
                                                                                            boxShadow: [
                                                                                              BoxShadow(blurRadius: 1.5, color: Colors.black38, offset: Offset(0, 1))
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      )
                                                                                    : InkWell(
                                                                                        onTap: () {
                                                                                          setState(() {
                                                                                            eligibleFilter = "Eligible";
                                                                                          });
                                                                                        },
                                                                                        child: Container(
                                                                                          height: 20,
                                                                                          width: 20,
                                                                                          decoration: const BoxDecoration(
                                                                                            shape: BoxShape.rectangle,
                                                                                            color: AppColors.primaryWhiteColor,
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
                                                                        GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            setState(() {
                                                                              isBrandFilterTileSelected = !isBrandFilterTileSelected;
                                                                            });
                                                                          },
                                                                          child:
                                                                              ListTile(
                                                                            trailing: !isBrandFilterTileSelected == true
                                                                                ? const ImageIcon(
                                                                                    color: AppColors.secondaryColor,
                                                                                    AssetImage(Assets.SIDE_ARROW),
                                                                                  )
                                                                                : const ImageIcon(
                                                                                    color: AppColors.secondaryColor,
                                                                                    AssetImage(Assets.DOWN_ARROW),
                                                                                  ),
                                                                            title:
                                                                                Text(AppLocalizations.of(context)!.brand),
                                                                            // Text("Brand"),
                                                                          ),
                                                                        ),
                                                                        isBrandFilterTileSelected ==
                                                                                true
                                                                            ? SingleChildScrollView(
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.only(right: 15, left: 15, bottom: 5, top: 5),
                                                                                  child: Column(
                                                                                    children: List.generate(
                                                                                      state.brandAndCategoryFilterResponse.data.brands.length,
                                                                                      (index) => Padding(
                                                                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                                                                        child: Container(
                                                                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                                                                          child: Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                            children: <Widget>[
                                                                                              Text(
                                                                                                context.read<LanguageBloc>().state.selectedLanguage == Language.english ? state.brandAndCategoryFilterResponse.data.brands[index].brandName : state.brandAndCategoryFilterResponse.data.brands[index].brandNameArabic,
                                                                                                softWrap: true,
                                                                                                overflow: TextOverflow.ellipsis,
                                                                                                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                                                                                      fontSize: 15,
                                                                                                    ),
                                                                                              ),
                                                                                              selectedBrandVariants.contains(state.brandAndCategoryFilterResponse.data.brands[index].id.toString())
                                                                                                  ? InkWell(
                                                                                                      onTap: () {
                                                                                                        setState(() {
                                                                                                          selectedBrandVariants.remove(state.brandAndCategoryFilterResponse.data.brands[index].id.toString());
                                                                                                          selectedBrandFilters = "";
                                                                                                        });
                                                                                                      },
                                                                                                      child: Container(
                                                                                                        height: 20,
                                                                                                        width: 20,
                                                                                                        decoration: const BoxDecoration(
                                                                                                          shape: BoxShape.rectangle,
                                                                                                          image: DecorationImage(
                                                                                                            image: AssetImage(Assets.DISABLED_TICK),
                                                                                                            fit: BoxFit.contain,
                                                                                                            scale: 6,
                                                                                                          ),
                                                                                                          color: AppColors.secondaryColor,
                                                                                                          boxShadow: [
                                                                                                            BoxShadow(blurRadius: 1.5, color: Colors.black38, offset: Offset(0, 1))
                                                                                                          ],
                                                                                                        ),
                                                                                                      ),
                                                                                                    )
                                                                                                  : InkWell(
                                                                                                      onTap: () {
                                                                                                        setState(() {
                                                                                                          selectedBrandVariants.add(state.brandAndCategoryFilterResponse.data.brands[index].id.toString());
                                                                                                          if (selectedBrandVariants.length > 1) {
                                                                                                            selectedBrandVariants.removeAt(0);
                                                                                                          }
                                                                                                          selectedBrandFilters = selectedBrandVariants[0].toString();
                                                                                                        });
                                                                                                      },
                                                                                                      child: Container(
                                                                                                        height: 20,
                                                                                                        width: 20,
                                                                                                        decoration: const BoxDecoration(
                                                                                                          shape: BoxShape.rectangle,
                                                                                                          color: AppColors.primaryWhiteColor,
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
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              )
                                                                            : const SizedBox(),
                                                                        GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            setState(() {
                                                                              isCategoryFilterTileSelected = !isCategoryFilterTileSelected;
                                                                            });
                                                                          },
                                                                          child:
                                                                              ListTile(
                                                                            trailing: !isCategoryFilterTileSelected == true
                                                                                ? const ImageIcon(
                                                                                    color: AppColors.secondaryColor,
                                                                                    AssetImage(Assets.SIDE_ARROW),
                                                                                  )
                                                                                : const ImageIcon(
                                                                                    color: AppColors.secondaryColor,
                                                                                    AssetImage(Assets.DOWN_ARROW),
                                                                                  ),
                                                                            title:
                                                                                Text(AppLocalizations.of(context)!.category),
                                                                            // Text("Category"),
                                                                          ),
                                                                        ),
                                                                        isCategoryFilterTileSelected ==
                                                                                true
                                                                            ? SingleChildScrollView(
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.only(right: 15, left: 15, bottom: 5, top: 5),
                                                                                  child: Column(
                                                                                    children: List.generate(
                                                                                      state.brandAndCategoryFilterResponse.data.category.length,
                                                                                      (index) => Padding(
                                                                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                                                                        child: Container(
                                                                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                                                                          child: Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                            children: <Widget>[
                                                                                              Text(
                                                                                                context.read<LanguageBloc>().state.selectedLanguage == Language.english ? state.brandAndCategoryFilterResponse.data.category[index].category : state.brandAndCategoryFilterResponse.data.category[index].categoryNameArabic,
                                                                                                softWrap: true,
                                                                                                overflow: TextOverflow.ellipsis,
                                                                                                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                                                                                      fontSize: 15,
                                                                                                    ),
                                                                                              ),
                                                                                              selectedCategoryVariants.contains(state.brandAndCategoryFilterResponse.data.category[index].id.toString())
                                                                                                  ? InkWell(
                                                                                                      onTap: () {
                                                                                                        setState(() {
                                                                                                          selectedCategoryVariants.remove(state.brandAndCategoryFilterResponse.data.category[index].id.toString());
                                                                                                          selectedCategoryFilters = "";
                                                                                                        });
                                                                                                      },
                                                                                                      child: Container(
                                                                                                        height: 20,
                                                                                                        width: 20,
                                                                                                        decoration: const BoxDecoration(
                                                                                                          shape: BoxShape.rectangle,
                                                                                                          image: DecorationImage(
                                                                                                            image: AssetImage(Assets.DISABLED_TICK),
                                                                                                            fit: BoxFit.contain,
                                                                                                            scale: 6,
                                                                                                          ),
                                                                                                          color: AppColors.secondaryColor,
                                                                                                          boxShadow: [
                                                                                                            BoxShadow(blurRadius: 1.5, color: Colors.black38, offset: Offset(0, 1))
                                                                                                          ],
                                                                                                        ),
                                                                                                      ),
                                                                                                    )
                                                                                                  : InkWell(
                                                                                                      onTap: () {
                                                                                                        setState(() {
                                                                                                          selectedCategoryVariants.add(state.brandAndCategoryFilterResponse.data.category[index].id.toString());
                                                                                                          if (selectedCategoryVariants.length > 1) {
                                                                                                            selectedCategoryVariants.removeAt(0);
                                                                                                          }
                                                                                                          selectedCategoryFilters = selectedCategoryVariants[0].toString();
                                                                                                        });
                                                                                                      },
                                                                                                      child: Container(
                                                                                                        height: 20,
                                                                                                        width: 20,
                                                                                                        decoration: const BoxDecoration(
                                                                                                          shape: BoxShape.rectangle,
                                                                                                          color: AppColors.primaryWhiteColor,
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
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              )
                                                                            : const SizedBox(),
                                                                        const SizedBox(
                                                                            height:
                                                                                80),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                Positioned(
                                                                  bottom: 0,
                                                                  right: 0,
                                                                  left: 0,
                                                                  child:
                                                                      SafeArea(
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          const BoxDecoration(
                                                                        color: AppColors
                                                                            .primaryWhiteColor,
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                            color:
                                                                                AppColors.boxShadow,
                                                                            blurRadius:
                                                                                4,
                                                                            offset:
                                                                                Offset(4, 2),
                                                                            spreadRadius:
                                                                                0,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            left:
                                                                                20,
                                                                            right:
                                                                                20,
                                                                            bottom:
                                                                                10),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            TextButton(
                                                                              onPressed: () {
                                                                                clearFilter();
                                                                              },
                                                                              child: Text(
                                                                                AppLocalizations.of(context)!.clearall,
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
                                                                                  borderRadius: BorderRadius.circular(8),
                                                                                ),
                                                                                backgroundColor: AppColors.secondaryColor,
                                                                              ),
                                                                              onPressed: () {

                                                                                BlocProvider.of<RewardTierBloc>(context).add(
                                                                                  RewardTierRequestEvent(
                                                                                    rewardTierRequest: RewardTierRequest(
                                                                                      sort: "",
                                                                                      eligible: eligibleFilter == "Eligible" ? "1" : "",
                                                                                      categoryId: selectedCategoryFilters.isEmpty ? "" : selectedCategoryFilters,
                                                                                      brandId: selectedBrandFilters.isEmpty ? "" : selectedBrandFilters,
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                                context.pop();
                                                                                _scrollToBottom();
                                                                              },
                                                                              child: Text(
                                                                                AppLocalizations.of(context)!.apply,
                                                                                // "Apply",
                                                                                style: GoogleFonts.roboto(
                                                                                  color: AppColors.primaryWhiteColor,
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
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        const BoxDecoration(
                                                                      color: AppColors
                                                                          .primaryWhiteColor,
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        topLeft:
                                                                            Radius.circular(20.0),
                                                                        topRight:
                                                                            Radius.circular(20.0),
                                                                      ),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .symmetric(
                                                                          horizontal:
                                                                              15),
                                                                      child:
                                                                          Container(
                                                                        // height: 40,
                                                                        color: Colors
                                                                            .white,
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: [
                                                                                Text(
                                                                                  AppLocalizations.of(context)!.filterby,
                                                                                  // "Filter by",
                                                                                  style: GoogleFonts.roboto(
                                                                                    fontSize: 16,
                                                                                    fontWeight: FontWeight.w400,
                                                                                    color: AppColors.primaryGrayColor,
                                                                                  ),
                                                                                ),
                                                                                IconButton(
                                                                                  onPressed: () {
                                                                                    context.pop();
                                                                                    clearFilter();
                                                                                  },
                                                                                  icon: const Icon(
                                                                                    Icons.close,
                                                                                    color: AppColors.primaryGrayColor,
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            ),
                                                                            const Divider(color: AppColors.primaryGrayColor),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            );
                                                          }
                                                          return const SizedBox();
                                                        },
                                                      );
                                                    },
                                                  );
                                                });
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                                left: 8, right: 8),
                                            height: 20,
                                            width: 68,
                                            decoration: BoxDecoration(
                                              color:
                                                  AppColors.primaryWhiteColor,
                                              borderRadius:
                                                  BorderRadius.circular(5),
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
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .filter,
                                                  // "Filter",
                                                  style: const TextStyle(
                                                    color:
                                                        AppColors.iconGreyColor,
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
                                      ),
                                    ],
                                  )
                                : null,
                    floating: false,
                    backgroundColor: AppColors.primaryColor,
                    expandedHeight: 300,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: false,
                      background: SafeArea(
                        child: Column(
                          children: [
                            SliverBackgroundWidget(
                              isLetsCollectRewardSelected:
                                  isLetsCollectSelected,
                              isPartnerSelected: isPartnerSelected,
                              isBrandSelected: isBrandSelected,
                              letsCollectTotalPoints: letsCollectTotalPoints,
                            ),
                            isRewardTierSelected && !_isShrink
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, top: 25),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            showModalBottomSheet(
                                                context: context,
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20.0),
                                                    topRight:
                                                        Radius.circular(20.0),
                                                  ),
                                                ),
                                                backgroundColor:
                                                    AppColors.primaryWhiteColor,
                                                barrierColor: Colors.black38,
                                                elevation: 2,
                                                isScrollControlled: true,
                                                isDismissible: true,
                                                builder: (BuildContext bc) {
                                                  return StatefulBuilder(
                                                    builder:
                                                        (BuildContext context,
                                                            setState) {
                                                      void clearFilter() {
                                                        setState(() {
                                                          selectedSortVariants =
                                                              <String>[];
                                                        });
                                                      }

                                                      // filterWidgets.clear();
                                                      return Stack(
                                                        children: [
                                                          SizedBox(
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height /
                                                                2,
                                                            child:
                                                                SingleChildScrollView(
                                                              child: Column(
                                                                children: [
                                                                  const SizedBox(
                                                                      height:
                                                                          60),
                                                                  Column(
                                                                    children: List
                                                                        .generate(
                                                                      sort.length,
                                                                      (index) =>
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .symmetric(
                                                                            horizontal:
                                                                                8,
                                                                            vertical:
                                                                                6),
                                                                        child:
                                                                            Container(
                                                                          padding: const EdgeInsets
                                                                              .symmetric(
                                                                              horizontal: 10,
                                                                              vertical: 6),
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            children: <Widget>[
                                                                              Text(
                                                                                context.read<LanguageBloc>().state.selectedLanguage == Language.english ? sort[index] : sort_ar[index],
                                                                                softWrap: true,
                                                                                overflow: TextOverflow.ellipsis,
                                                                                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                                                                      fontSize: 15,
                                                                                    ),
                                                                              ),
                                                                              selectedSortVariants.contains(sort[index])
                                                                                  ? InkWell(
                                                                                      onTap: () {
                                                                                        setState(() {
                                                                                          selectedSortVariants.remove(sort[index]);
                                                                                        });
                                                                                      },
                                                                                      child: const CustomRoundedButton(enabled: true),
                                                                                    )
                                                                                  : InkWell(
                                                                                      onTap: () {
                                                                                        setState(() {
                                                                                          selectedSortVariants.add(sort[index]);
                                                                                          if (selectedSortVariants.length > 1) {
                                                                                            selectedSortVariants.removeAt(0);
                                                                                          }
                                                                                          selectedSortFilter = selectedSortVariants[0];
                                                                                          if (selectedSortFilter == "Recent") {
                                                                                            sortQuery = "recent";
                                                                                          }
                                                                                          if (selectedSortFilter == "Expiry First") {
                                                                                            sortQuery = "expire_first";
                                                                                          }
                                                                                          if (selectedSortFilter == "Points Low") {
                                                                                            sortQuery = "points_low";
                                                                                          }
                                                                                          if (selectedSortFilter == "Points High") {
                                                                                            sortQuery = "points_high";
                                                                                          }
                                                                                        });
                                                                                      },
                                                                                      child: const CustomRoundedButton(
                                                                                        enabled: false,
                                                                                      ),
                                                                                    ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                      height:
                                                                          80),
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
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            20,
                                                                        right:
                                                                            20,
                                                                        bottom:
                                                                            10),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        clearFilter();
                                                                        context
                                                                            .pop();
                                                                        BlocProvider.of<RewardTierBloc>(context)
                                                                            .add(
                                                                          RewardTierRequestEvent(
                                                                            rewardTierRequest:
                                                                                RewardTierRequest(
                                                                              sort: "",
                                                                              eligible: "",
                                                                              categoryId: "",
                                                                              brandId: "",
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        AppLocalizations.of(context)!
                                                                            .clearall,
                                                                        // "Clear All",
                                                                        style: GoogleFonts
                                                                            .roboto(
                                                                          color:
                                                                              AppColors.primaryColor,
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                          fontSize:
                                                                              14,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    ElevatedButton(
                                                                      style: ElevatedButton
                                                                          .styleFrom(
                                                                        fixedSize: const Size(
                                                                            100,
                                                                            40),
                                                                        shape:
                                                                            RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(8),
                                                                        ),
                                                                        backgroundColor:
                                                                            AppColors.secondaryColor,
                                                                      ),
                                                                      onPressed:
                                                                          () async {

                                                                        BlocProvider.of<RewardTierBloc>(context)
                                                                            .add(
                                                                          RewardTierRequestEvent(
                                                                            rewardTierRequest:
                                                                                RewardTierRequest(
                                                                              sort: sortQuery,
                                                                              eligible: "",
                                                                              categoryId: "",
                                                                              brandId: "",
                                                                            ),
                                                                          ),
                                                                        );
                                                                        context
                                                                            .pop();
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        AppLocalizations.of(context)!
                                                                            .apply,
                                                                        // "Apply",
                                                                        style: GoogleFonts
                                                                            .roboto(
                                                                          color:
                                                                              AppColors.primaryWhiteColor,
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                          fontSize:
                                                                              14,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Positioned(
                                                            top: 0,
                                                            left: 0,
                                                            right: 0,
                                                            // bottom: 20,
                                                            child: SafeArea(
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        15),
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
                                                                          AppLocalizations.of(context)!
                                                                              .sortby,
                                                                          // "Sort by",
                                                                          style:
                                                                              GoogleFonts.roboto(
                                                                            fontSize:
                                                                                16,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            color:
                                                                                AppColors.primaryGrayColor,
                                                                          ),
                                                                        ),
                                                                        IconButton(
                                                                          onPressed:
                                                                              () {
                                                                            context.pop();
                                                                            clearFilter();
                                                                          },
                                                                          icon:
                                                                              const Icon(
                                                                            Icons.close,
                                                                            color:
                                                                                AppColors.primaryGrayColor,
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
                                                        ],
                                                      );
                                                    },
                                                  );
                                                });
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                                left: 8, right: 8),
                                            height: 20,
                                            width: 68,
                                            decoration: BoxDecoration(
                                              color:
                                                  AppColors.primaryWhiteColor,
                                              borderRadius:
                                                  BorderRadius.circular(5),
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
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .sort,
                                                  // "Sort",
                                                  style: const TextStyle(
                                                    color:
                                                        AppColors.iconGreyColor,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                                SvgPicture.asset(
                                                  Assets.SORT_SVG,
                                                  height: 10,
                                                  width: 10,
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
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20.0),
                                                    topRight:
                                                        Radius.circular(20.0),
                                                  ),
                                                ),
                                                backgroundColor:
                                                    AppColors.primaryWhiteColor,
                                                barrierColor: Colors.black38,
                                                elevation: 2,
                                                isScrollControlled: true,
                                                isDismissible: true,
                                                builder: (BuildContext bc) {
                                                  return StatefulBuilder(
                                                    builder:
                                                        (BuildContext context,
                                                            setState) {
                                                      void clearFilter() {
                                                        setState(() {
                                                          selectedBrandVariants =
                                                              <String>[];
                                                          selectedBrandFilters =
                                                              "";
                                                          selectedCategoryVariants =
                                                              <String>[];
                                                          selectedCategoryFilters =
                                                              "";
                                                        });
                                                      }

                                                      // filterWidgets.clear();

                                                      return BlocBuilder<
                                                          FilterBloc,
                                                          FilterState>(
                                                        builder:
                                                            (context, state) {
                                                          if (state
                                                              is BrandLoading) {
                                                            return Center(
                                                              child: Lottie.asset(
                                                                  Assets
                                                                      .JUMBINGDOT,
                                                                  height: 100,
                                                                  width: 100),
                                                            );
                                                          }
                                                          if (state
                                                              is BrandLoaded) {
                                                            return Stack(
                                                              children: [
                                                                SizedBox(
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height /
                                                                      1.6,
                                                                  child:
                                                                      SingleChildScrollView(
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        const SizedBox(
                                                                            height:
                                                                                60),
                                                                        Padding(
                                                                          padding: const EdgeInsets
                                                                              .symmetric(
                                                                              horizontal: 8,
                                                                              vertical: 6),
                                                                          child:
                                                                              Container(
                                                                            padding:
                                                                                const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: <Widget>[
                                                                                Text(
                                                                                  AppLocalizations.of(context)!.eligible,
                                                                                  // "Eligible",
                                                                                  softWrap: true,
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
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
                                                                                          decoration: const BoxDecoration(
                                                                                            shape: BoxShape.rectangle,
                                                                                            image: DecorationImage(
                                                                                              image: AssetImage(Assets.DISABLED_TICK),
                                                                                              fit: BoxFit.contain,
                                                                                              scale: 6,
                                                                                            ),
                                                                                            color: AppColors.secondaryColor,
                                                                                            boxShadow: [
                                                                                              BoxShadow(blurRadius: 1.5, color: Colors.black38, offset: Offset(0, 1))
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      )
                                                                                    : InkWell(
                                                                                        onTap: () {
                                                                                          setState(() {
                                                                                            eligibleFilter = "Eligible";
                                                                                          });
                                                                                        },
                                                                                        child: Container(
                                                                                          height: 20,
                                                                                          width: 20,
                                                                                          decoration: const BoxDecoration(
                                                                                            shape: BoxShape.rectangle,
                                                                                            color: AppColors.primaryWhiteColor,
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
                                                                        GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            setState(() {
                                                                              isBrandFilterTileSelected = !isBrandFilterTileSelected;
                                                                            });
                                                                          },
                                                                          child: ListTile(
                                                                              trailing: !isBrandFilterTileSelected == true
                                                                                  ? const ImageIcon(
                                                                                      color: AppColors.secondaryColor,
                                                                                      AssetImage(Assets.SIDE_ARROW),
                                                                                    )
                                                                                  : const ImageIcon(
                                                                                      color: AppColors.secondaryColor,
                                                                                      AssetImage(Assets.DOWN_ARROW),
                                                                                    ),
                                                                              title: Text(AppLocalizations.of(context)!.brand)
                                                                              // Text("Brand"),
                                                                              ),
                                                                        ),
                                                                        isBrandFilterTileSelected ==
                                                                                true
                                                                            ? SingleChildScrollView(
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.only(right: 15, left: 15, bottom: 5, top: 5),
                                                                                  child: Column(
                                                                                    children: List.generate(
                                                                                      state.brandAndCategoryFilterResponse.data.brands.length,
                                                                                      (index) => Padding(
                                                                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                                                                        child: Container(
                                                                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                                                                          child: Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                            children: <Widget>[
                                                                                              Text(
                                                                                                context.read<LanguageBloc>().state.selectedLanguage == Language.english ? state.brandAndCategoryFilterResponse.data.brands[index].brandName : state.brandAndCategoryFilterResponse.data.brands[index].brandNameArabic,
                                                                                                softWrap: true,
                                                                                                overflow: TextOverflow.ellipsis,
                                                                                                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                                                                                      fontSize: 15,
                                                                                                    ),
                                                                                              ),
                                                                                              selectedBrandVariants.contains(state.brandAndCategoryFilterResponse.data.brands[index].id.toString())
                                                                                                  ? InkWell(
                                                                                                      onTap: () {
                                                                                                        setState(() {
                                                                                                          selectedBrandVariants.remove(state.brandAndCategoryFilterResponse.data.brands[index].id.toString());
                                                                                                          selectedBrandFilters = "";
                                                                                                        });
                                                                                                      },
                                                                                                      child: Container(
                                                                                                        height: 20,
                                                                                                        width: 20,
                                                                                                        decoration: const BoxDecoration(
                                                                                                          shape: BoxShape.rectangle,
                                                                                                          image: DecorationImage(
                                                                                                            image: AssetImage(Assets.DISABLED_TICK),
                                                                                                            fit: BoxFit.contain,
                                                                                                            scale: 6,
                                                                                                          ),
                                                                                                          color: AppColors.secondaryColor,
                                                                                                          boxShadow: [
                                                                                                            BoxShadow(blurRadius: 1.5, color: Colors.black38, offset: Offset(0, 1))
                                                                                                          ],
                                                                                                        ),
                                                                                                      ),
                                                                                                    )
                                                                                                  : InkWell(
                                                                                                      onTap: () {
                                                                                                        setState(() {
                                                                                                          selectedBrandVariants.add(state.brandAndCategoryFilterResponse.data.brands[index].id.toString());
                                                                                                          if (selectedBrandVariants.length > 1) {
                                                                                                            selectedBrandVariants.removeAt(0);
                                                                                                          }
                                                                                                          selectedBrandFilters = selectedBrandVariants[0].toString();
                                                                                                        });
                                                                                                      },
                                                                                                      child: Container(
                                                                                                        height: 20,
                                                                                                        width: 20,
                                                                                                        decoration: const BoxDecoration(
                                                                                                          shape: BoxShape.rectangle,
                                                                                                          color: AppColors.primaryWhiteColor,
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
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              )
                                                                            : const SizedBox(),
                                                                        GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            setState(() {
                                                                              isCategoryFilterTileSelected = !isCategoryFilterTileSelected;
                                                                            });
                                                                          },
                                                                          child: ListTile(
                                                                              trailing: !isCategoryFilterTileSelected == true
                                                                                  ? const ImageIcon(
                                                                                      color: AppColors.secondaryColor,
                                                                                      AssetImage(Assets.SIDE_ARROW),
                                                                                    )
                                                                                  : const ImageIcon(
                                                                                      color: AppColors.secondaryColor,
                                                                                      AssetImage(Assets.DOWN_ARROW),
                                                                                    ),
                                                                              title: Text(AppLocalizations.of(context)!.category)
                                                                              // Text("Category"),
                                                                              ),
                                                                        ),
                                                                        isCategoryFilterTileSelected ==
                                                                                true
                                                                            ? SingleChildScrollView(
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.only(right: 15, left: 15, bottom: 5, top: 5),
                                                                                  child: Column(
                                                                                    children: List.generate(
                                                                                      state.brandAndCategoryFilterResponse.data.category.length,
                                                                                      (index) => Padding(
                                                                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                                                                        child: Container(
                                                                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                                                                          child: Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                            children: <Widget>[
                                                                                              Text(
                                                                                                context.read<LanguageBloc>().state.selectedLanguage == Language.english ? state.brandAndCategoryFilterResponse.data.category[index].category : state.brandAndCategoryFilterResponse.data.category[index].categoryNameArabic,
                                                                                                softWrap: true,
                                                                                                overflow: TextOverflow.ellipsis,
                                                                                                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                                                                                      fontSize: 15,
                                                                                                    ),
                                                                                              ),
                                                                                              selectedCategoryVariants.contains(state.brandAndCategoryFilterResponse.data.category[index].id.toString())
                                                                                                  ? InkWell(
                                                                                                      onTap: () {
                                                                                                        setState(() {
                                                                                                          selectedCategoryVariants.remove(state.brandAndCategoryFilterResponse.data.category[index].id.toString());
                                                                                                          selectedCategoryFilters = "";
                                                                                                        });
                                                                                                      },
                                                                                                      child: Container(
                                                                                                        height: 20,
                                                                                                        width: 20,
                                                                                                        decoration: const BoxDecoration(
                                                                                                          shape: BoxShape.rectangle,
                                                                                                          image: DecorationImage(
                                                                                                            image: AssetImage(Assets.DISABLED_TICK),
                                                                                                            fit: BoxFit.contain,
                                                                                                            scale: 6,
                                                                                                          ),
                                                                                                          color: AppColors.secondaryColor,
                                                                                                          boxShadow: [
                                                                                                            BoxShadow(blurRadius: 1.5, color: Colors.black38, offset: Offset(0, 1))
                                                                                                          ],
                                                                                                        ),
                                                                                                      ),
                                                                                                    )
                                                                                                  : InkWell(
                                                                                                      onTap: () {
                                                                                                        setState(() {
                                                                                                          selectedCategoryVariants.add(state.brandAndCategoryFilterResponse.data.category[index].id.toString());
                                                                                                          if (selectedCategoryVariants.length > 1) {
                                                                                                            selectedCategoryVariants.removeAt(0);
                                                                                                          }
                                                                                                          selectedCategoryFilters = selectedCategoryVariants[0].toString();
                                                                                                        });
                                                                                                      },
                                                                                                      child: Container(
                                                                                                        height: 20,
                                                                                                        width: 20,
                                                                                                        decoration: const BoxDecoration(
                                                                                                          shape: BoxShape.rectangle,
                                                                                                          color: AppColors.primaryWhiteColor,
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
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              )
                                                                            : const SizedBox(),
                                                                        const SizedBox(
                                                                            height:
                                                                                80),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                Positioned(
                                                                  bottom: 0,
                                                                  right: 0,
                                                                  left: 0,
                                                                  child:
                                                                      SafeArea(
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          const BoxDecoration(
                                                                        color: AppColors
                                                                            .primaryWhiteColor,
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                            color:
                                                                                AppColors.boxShadow,
                                                                            blurRadius:
                                                                                4,
                                                                            offset:
                                                                                Offset(4, 2),
                                                                            spreadRadius:
                                                                                0,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            left:
                                                                                20,
                                                                            right:
                                                                                20,
                                                                            bottom:
                                                                                10),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            TextButton(
                                                                              onPressed: () {
                                                                                clearFilter();
                                                                              },
                                                                              child: Text(
                                                                                // "Clear All",
                                                                                AppLocalizations.of(context)!.clearall,
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
                                                                                  borderRadius: BorderRadius.circular(8),
                                                                                ),
                                                                                backgroundColor: AppColors.secondaryColor,
                                                                              ),
                                                                              onPressed: () {

                                                                                BlocProvider.of<RewardTierBloc>(context).add(
                                                                                  RewardTierRequestEvent(
                                                                                    rewardTierRequest: RewardTierRequest(
                                                                                      sort: "",
                                                                                      eligible: "",
                                                                                      categoryId: selectedCategoryFilters.isEmpty ? "" : selectedCategoryFilters,
                                                                                      brandId: selectedBrandFilters.isEmpty ? "" : selectedBrandFilters,
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                                context.pop();
                                                                                _scrollToBottom();
                                                                              },
                                                                              child: Text(
                                                                                AppLocalizations.of(context)!.apply,
                                                                                // "Apply",
                                                                                style: GoogleFonts.roboto(
                                                                                  color: AppColors.primaryWhiteColor,
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
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        const BoxDecoration(
                                                                      color: AppColors
                                                                          .primaryWhiteColor,
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        topLeft:
                                                                            Radius.circular(20.0),
                                                                        topRight:
                                                                            Radius.circular(20.0),
                                                                      ),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .symmetric(
                                                                          horizontal:
                                                                              15),
                                                                      child:
                                                                          Container(
                                                                        // height: 40,
                                                                        color: Colors
                                                                            .white,
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              children: [
                                                                                Text(
                                                                                  AppLocalizations.of(context)!.filterby,
                                                                                  // "Filter by",
                                                                                  style: GoogleFonts.roboto(
                                                                                    fontSize: 16,
                                                                                    fontWeight: FontWeight.w400,
                                                                                    color: AppColors.primaryGrayColor,
                                                                                  ),
                                                                                ),
                                                                                IconButton(
                                                                                  onPressed: () {
                                                                                    context.pop();
                                                                                  },
                                                                                  icon: const Icon(
                                                                                    Icons.close,
                                                                                    color: AppColors.primaryGrayColor,
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            ),
                                                                            const Divider(color: AppColors.primaryGrayColor),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            );
                                                          }
                                                          return const SizedBox();
                                                        },
                                                      );
                                                    },
                                                  );
                                                });
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                                left: 8, right: 8),
                                            height: 20,
                                            width: 68,
                                            decoration: BoxDecoration(
                                              color:
                                                  AppColors.primaryWhiteColor,
                                              borderRadius:
                                                  BorderRadius.circular(5),
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
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  // "Filter",
                                                  AppLocalizations.of(context)!
                                                      .filter,
                                                  style: const TextStyle(
                                                    color:
                                                        AppColors.iconGreyColor,
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
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      ),
                    ),
                    elevation: 5,
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(70),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                                top: 10, bottom: 1, left: 15, right: 15),
                            color: AppColors.primaryWhiteColor,
                            width: MediaQuery.of(context).size.width,
                            height: 30,
                            child: Text(
                              AppLocalizations.of(context)!
                                  .pleasechoosearewardtier,
                              // "Please choose a reward tier",
                              style: GoogleFonts.openSans(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: AppColors.primaryGrayColor),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 9, bottom: 5),
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: AppColors.primaryWhiteColor,
                              border: Border.all(
                                  color: AppColors.primaryWhiteColor, width: 0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _scrollToBottom();
                                    setState(() {
                                      isRewardTierSelected = true;
                                      isLetsCollectSelected = true;
                                      isBrandSelected = false;
                                      isPartnerSelected = false;
                                    });
                                  },
                                  child: Container(
                                    height: MediaQuery.of(context).size.height,
                                    padding: const EdgeInsets.only(
                                        top: 4, bottom: 4, left: 8, right: 8),
                                    decoration: BoxDecoration(
                                      border: const Border(
                                        bottom: BorderSide(
                                            width: 1,
                                            color: AppColors.borderColor),
                                        top: BorderSide(
                                            width: 1,
                                            color: AppColors.borderColor),
                                        left: BorderSide(
                                            width: 1,
                                            color: AppColors.borderColor),
                                        right: BorderSide(
                                            width: 1,
                                            color: AppColors.borderColor),
                                      ),
                                      color: isLetsCollectSelected == true
                                          ? AppColors.secondaryColor
                                          : AppColors.primaryWhiteColor,
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
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .letscollectrewards,
                                      // "Lets Collect Reward",
                                      style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w400,
                                        fontSize: isLetsCollectSelected == true
                                            ? 15
                                            : 12,
                                        color: isLetsCollectSelected == true
                                            ? AppColors.primaryWhiteColor
                                            : AppColors.primaryBlackColor,
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _scrollToBottom();
                                    setState(() {
                                      isLetsCollectSelected = false;
                                      isBrandSelected = true;
                                      isRewardTierSelected = true;
                                      isPartnerSelected = false;
                                    });
                                  },
                                  child: Container(
                                    height: MediaQuery.of(context).size.height,
                                    padding: const EdgeInsets.only(
                                        top: 4, bottom: 4, left: 8, right: 8),
                                    decoration: BoxDecoration(
                                      border: const Border(
                                        bottom: BorderSide(
                                            width: 1,
                                            color: AppColors.borderColor),
                                        top: BorderSide(
                                            width: 1,
                                            color: AppColors.borderColor),
                                        left: BorderSide(
                                            width: 1,
                                            color: AppColors.borderColor),
                                        right: BorderSide(
                                            width: 1,
                                            color: AppColors.borderColor),
                                      ),
                                      color: isBrandSelected == true
                                          ? AppColors.secondaryColor
                                          : AppColors.primaryWhiteColor,
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
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      AppLocalizations.of(context)!.brandreward,
                                      // "Brand Reward",
                                      style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w400,
                                        fontSize:
                                            isBrandSelected == true ? 15 : 12,
                                        color: isBrandSelected == true
                                            ? AppColors.primaryWhiteColor
                                            : AppColors.primaryBlackColor,
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _scrollToBottom();
                                    setState(() {
                                      isLetsCollectSelected = false;
                                      isBrandSelected = false;
                                      isPartnerSelected = true;
                                      isRewardTierSelected = true;
                                    });
                                  },
                                  child: Container(
                                    height: MediaQuery.of(context).size.height,
                                    padding: const EdgeInsets.only(
                                        top: 4, bottom: 4, left: 8, right: 8),
                                    decoration: BoxDecoration(
                                      border: const Border(
                                        bottom: BorderSide(
                                            width: 1,
                                            color: AppColors.borderColor),
                                        top: BorderSide(
                                            width: 1,
                                            color: AppColors.borderColor),
                                        left: BorderSide(
                                            width: 1,
                                            color: AppColors.borderColor),
                                        right: BorderSide(
                                            width: 1,
                                            color: AppColors.borderColor),
                                      ),
                                      color: isPartnerSelected == true
                                          ? AppColors.secondaryColor
                                          : AppColors.primaryWhiteColor,
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
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .partnerreward,
                                      // "Partner Reward",
                                      style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w400,
                                        fontSize:
                                            isPartnerSelected == true ? 15 : 12,
                                        color: isPartnerSelected == true
                                            ? AppColors.primaryWhiteColor
                                            : AppColors.primaryBlackColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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
                          isLetsCollectSelected == true
                              ? buildLetsCollectRewardTierMethod()
                              : isBrandSelected == true
                                  ? buildBrandRewardTierMethod()
                                  : isPartnerSelected == true
                                      ? buildPartnerRewardTierMethod()
                                      : SizedBox(
                                          child: Center(
                                            child: Lottie.asset(Assets.CHOOSE),
                                          ),
                                        ),
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.only(left: 15, right: 15),
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
                  // "You are not connected to the internet",
                  AppLocalizations.of(context)!.youarenotconnectedtotheinternet,
                  style: GoogleFonts.openSans(
                    color: AppColors.primaryGrayColor,
                    fontSize: 20,
                  ),
                ).animate().scale(delay: 200.ms, duration: 300.ms),
              ],
            ),
          );
        } else if (state is NetworkInitial) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(Assets.NO_INTERNET),
                Text(
                  // "You are not connected to the internet",
                  AppLocalizations.of(context)!.youarenotconnectedtotheinternet,
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

  BlocBuilder<dynamic, dynamic> buildLetsCollectRewardTierMethod() {
    return BlocBuilder<RewardTierBloc, RewardTierState>(
      builder: (context, state) {
        if (state is RewardTierLoading) {
          return const Center(
            heightFactor: 10,
            child: RefreshProgressIndicator(
              color: AppColors.secondaryColor,
              backgroundColor: AppColors.primaryWhiteColor,
            ),
          );
        }
        if (state is RewardTierError) {
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  flex: 4,
                  child: Lottie.asset(Assets.TRY_AGAIN),
                ),
                Flexible(
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
                const Spacer(),
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
                      BlocProvider.of<RewardTierBloc>(context).add(
                        RewardTierRequestEvent(
                          rewardTierRequest: RewardTierRequest(
                              sort: "",
                              eligible: "",
                              categoryId: "",
                              brandId: ""),
                        ),
                      );
                    },
                    child: Text(
                      AppLocalizations.of(context)!.tryagain,
                      // "Try again",
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
        if (state is RewardTierLoaded) {
          if (state.rewardTierRequestResponse.data!.letsCollect!.isNotEmpty) {
            return GridView.builder(
                shrinkWrap: true,
                itemCount:
                    state.rewardTierRequestResponse.data!.letsCollect!.length,
                padding: const EdgeInsets.only(bottom: 150, top: 20),
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 15.0,
                  crossAxisSpacing: 15.0,
                  childAspectRatio: 1.1,
                  crossAxisCount: 2,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      context.push(
                        '/lets_collect_redeem',
                        extra: LetCollectRedeemScreenArguments(
                          totalPoint: state
                              .rewardTierRequestResponse.totalPoints
                              .toString(),
                          rewardId: state.rewardTierRequestResponse.data!
                              .letsCollect![index].rewardId,
                          requiredPoint: state.rewardTierRequestResponse.data!
                              .letsCollect![index].requiredPoints!
                              .toString(),
                          imageUrl: state.rewardTierRequestResponse.data!
                              .letsCollect![index].rewardImage!,
                          wereToRedeem: state.rewardTierRequestResponse.data!
                              .letsCollect![index].reedemStores!,
                          wereToRedeemAr: state.rewardTierRequestResponse.data!
                              .letsCollect![index].reedemStores!,
                          name: state.rewardTierRequestResponse.data!
                              .partner![index].brandName!,
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
                                  imageUrl: state.rewardTierRequestResponse
                                      .data!.letsCollect![index].rewardImage!,
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
                                state.rewardTierRequestResponse.data!
                                    .letsCollect![index].requiredPoints
                                    .toString(),
                                style: const TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          } else {
            return Lottie.asset(Assets.OOPS);
            //   Center(
            //   heightFactor: 0,
            //   child: Lottie.asset(Assets.NO_DATA),
            // );
          }
        }
        return const SizedBox();
      },
    );
  }

  BlocBuilder<RewardTierBloc, RewardTierState> buildBrandRewardTierMethod() {
    return BlocBuilder<RewardTierBloc, RewardTierState>(
      builder: (context, state) {
        if (state is RewardTierLoading) {
          return const Center(
            heightFactor: 10,
            child: RefreshProgressIndicator(
              color: AppColors.secondaryColor,
              backgroundColor: AppColors.primaryWhiteColor,
            ),
          );
        }
        if (state is RewardTierError) {
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  flex: 4,
                  child: Lottie.asset(Assets.TRY_AGAIN),
                ),
                Flexible(
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
                const Spacer(),
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
                      BlocProvider.of<RewardTierBloc>(context).add(
                        RewardTierRequestEvent(
                          rewardTierRequest: RewardTierRequest(
                              sort: "",
                              eligible: "",
                              categoryId: "",
                              brandId: ""),
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

        if (state is RewardTierLoaded) {
          if (state.rewardTierRequestResponse.data!.brand!.isNotEmpty) {
            return GridView.builder(
              shrinkWrap: true,
              itemCount: state.rewardTierRequestResponse.data!.brand!.length,
              padding: const EdgeInsets.only(bottom: 150, top: 20),
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 15.0,
                crossAxisSpacing: 15.0,
                childAspectRatio: 0.9,
                crossAxisCount: 2,
              ),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    context.push(
                      '/brand_products',
                      extra: LetCollectRedeemScreenArguments(
                        rewardId: state.rewardTierRequestResponse.data!
                            .brand![index].rewardId,
                        requiredPoint: state.rewardTierRequestResponse.data!
                            .brand![index].requiredPoints
                            .toString(),
                        imageUrl: state.rewardTierRequestResponse.data!
                            .brand![index].rewardImage!,
                        wereToRedeem: state.rewardTierRequestResponse.data!
                            .brand![index].reedemStores!,
                        iD: state.rewardTierRequestResponse.data!.brand![index]
                            .brandId
                            .toString(),
                        wereToRedeemAr: state.rewardTierRequestResponse.data!
                            .brand![index].reedemStores!,
                        name: context
                                    .read<LanguageBloc>()
                                    .state
                                    .selectedLanguage ==
                                Language.english
                            ? state.rewardTierRequestResponse.data!
                                .brand![index].brandName!
                            : state.rewardTierRequestResponse.data!
                                .brand![index].brandNameArabic!,
                        totalPoint: state.rewardTierRequestResponse.totalPoints
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
                      borderRadius: BorderRadius.circular(5),
                      border:
                          Border.all(color: AppColors.borderColor, width: 1),
                    ),
                    child: Center(
                      child: SizedBox(
                        width: 120,
                        height: 100,
                        child: CachedNetworkImage(
                          alignment: Alignment.center,
                          fadeInCurve: Curves.easeIn,
                          fadeInDuration: const Duration(milliseconds: 200),
                          fit: BoxFit.contain,
                          imageUrl: state.rewardTierRequestResponse.data!
                              .brand![index].brandLogo!,
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
                          errorWidget: (context, url, error) => const ImageIcon(
                            color: AppColors.hintColor,
                            AssetImage(Assets.NO_IMG),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Lottie.asset(Assets.OOPS);
          }
        }
        return const SizedBox();
      },
    );
  }

  BlocBuilder<dynamic, dynamic> buildPartnerRewardTierMethod() {
    return BlocBuilder<RewardTierBloc, RewardTierState>(
      builder: (context, state) {
        if (state is RewardTierLoading) {
          return const Center(
            heightFactor: 10,
            child: RefreshProgressIndicator(
              color: AppColors.secondaryColor,
              backgroundColor: AppColors.primaryWhiteColor,
            ),
          );
        }
        if (state is RewardTierError) {
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  flex: 4,
                  child: Lottie.asset(Assets.TRY_AGAIN),
                ),
                Flexible(
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
                const Spacer(),
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
                      BlocProvider.of<RewardTierBloc>(context).add(
                        RewardTierRequestEvent(
                          rewardTierRequest: RewardTierRequest(
                              sort: "",
                              eligible: "",
                              categoryId: "",
                              brandId: ""),
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

        if (state is RewardTierLoaded) {
          if (state.rewardTierRequestResponse.data!.partner!.isNotEmpty) {
            return GridView.builder(
              shrinkWrap: true,
              itemCount: state.rewardTierRequestResponse.data!.partner!.length,
              padding: const EdgeInsets.only(bottom: 150, top: 20),
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 15.0,
                crossAxisSpacing: 15.0,
                childAspectRatio: 0.9,
                crossAxisCount: 2,
              ),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    context.push(
                      '/partner_products',
                      extra: LetCollectRedeemScreenArguments(
                        rewardId: state.rewardTierRequestResponse.data!
                            .partner![index].rewardId,
                        requiredPoint: state.rewardTierRequestResponse.data!
                            .partner![index].requiredPoints
                            .toString(),
                        imageUrl: state.rewardTierRequestResponse.data!
                            .partner![index].rewardImage!,
                        wereToRedeem: state.rewardTierRequestResponse.data!
                            .partner![index].reedemStores!,
                        iD: state.rewardTierRequestResponse.data!
                            .partner![index].brandId
                            .toString(),
                        wereToRedeemAr: state.rewardTierRequestResponse.data!
                            .partner![index].reedemStores!,
                        name: context
                                    .read<LanguageBloc>()
                                    .state
                                    .selectedLanguage ==
                                Language.english
                            ? state.rewardTierRequestResponse.data!
                                .partner![index].brandName!
                            : state.rewardTierRequestResponse.data!
                                .partner![index].brandNameArabic!,
                        totalPoint: state.rewardTierRequestResponse.totalPoints
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
                        borderRadius: BorderRadius.circular(5),
                        border:
                            Border.all(color: AppColors.borderColor, width: 1)),
                    child: Center(
                      child: SizedBox(
                        width: 120,
                        height: 100,
                        child: CachedNetworkImage(
                          alignment: Alignment.center,
                          fadeInCurve: Curves.easeIn,
                          fadeInDuration: const Duration(milliseconds: 200),
                          fit: BoxFit.contain,
                          imageUrl: state.rewardTierRequestResponse.data!
                                  .partner![index].partnerLogo!.isEmpty
                              ? state.rewardTierRequestResponse.data!
                                  .partner![index].brandLogo!
                              : state.rewardTierRequestResponse.data!
                                  .partner![index].partnerLogo!,
                          width: MediaQuery.of(context).size.width,
                          placeholder: (context, url) => SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Lottie.asset(
                                Assets.JUMBINGDOT,
                                height: 45,
                                width: 45,
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => const ImageIcon(
                            color: AppColors.hintColor,
                            AssetImage(Assets.NO_IMG),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Lottie.asset(Assets.OOPS);
          }
        }
        return const SizedBox();
      },
    );
  }
}
