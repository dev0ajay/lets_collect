import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_collect/src/bloc/offer_bloc/offer_bloc.dart';
import 'package:lets_collect/src/model/offer/offer_list_request.dart';
import 'package:lets_collect/src/ui/special_offer/components/offer_details_arguments.dart';
import 'package:lottie/lottie.dart';
import '../../bloc/filter_bloc/filter_bloc.dart';
import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../utils/screen_size/size_config.dart';
import '../reward/components/widgets/custome_rounded_button.dart';

class SpecialOfferScreen extends StatefulWidget {
  const SpecialOfferScreen({super.key});

  @override
  State<SpecialOfferScreen> createState() => _SpecialOfferScreenState();
}

class _SpecialOfferScreenState extends State<SpecialOfferScreen> {
  int itemsPerPage = 10;
  int currentPage = 1;
  List<String> sort = <String>[
    "Recent",
    "Expiry First",
    "Points Low",
    "Points High",
  ];
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

  @override
  void initState() {
    super.initState();
    BlocProvider.of<FilterBloc>(context).add(GetBrandAndCategoryFilterList());
    BlocProvider.of<OfferBloc>(context).add(
      GetOfferListEvent(
        offerListRequest: OfferListRequest(
          sort: "",
          brandId: "",
          categoryId: "",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.primaryColor,
            leading: IconButton(
              onPressed: () {
                context.go('/home');
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: AppColors.primaryWhiteColor,
              ),
            ),
            expandedHeight: 150,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              collapseMode: CollapseMode.parallax,
              titlePadding: const EdgeInsets.only(bottom: 60, top: 0),
              title: Text(
                "Special Offers",
                style: GoogleFonts.roboto(
                  fontSize: 23,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(45),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "Sort by",
                                                      style: GoogleFonts.roboto(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w400,
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
                                                    color: AppColors
                                                        .primaryGrayColor,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                2,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              const SizedBox(height: 60),
                                              Column(
                                                children: List.generate(
                                                  sort.length,
                                                  (index) => Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 8,
                                                        vertical: 6),
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10,
                                                          vertical: 6),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        mainAxisSize:
                                                            MainAxisSize.max,
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
                                                                  fontSize: 15,
                                                                ),
                                                          ),
                                                          selectedSortVariants
                                                                  .contains(sort[
                                                                      index])
                                                              ? InkWell(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      selectedSortVariants
                                                                          .remove(
                                                                              sort[index]);
                                                                    });
                                                                  },
                                                                  child: const CustomRoundedButton(
                                                                      enabled:
                                                                          true),
                                                                )
                                                              : InkWell(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      selectedSortVariants
                                                                          .add(sort[
                                                                              index]);
                                                                      if (selectedSortVariants
                                                                              .length >
                                                                          1) {
                                                                        selectedSortVariants
                                                                            .removeAt(0);
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
                                                    BlocProvider.of<OfferBloc>(
                                                            context)
                                                        .add(
                                                      GetOfferListEvent(
                                                        offerListRequest:
                                                            OfferListRequest(
                                                          sort: "",
                                                          brandId: "",
                                                          categoryId: "",
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: Text(
                                                    "Clear All",
                                                    style: GoogleFonts.roboto(
                                                      color: AppColors
                                                          .primaryColor,
                                                      fontWeight:
                                                          FontWeight.w400,
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
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    backgroundColor: AppColors
                                                        .secondaryColor,
                                                  ),
                                                  onPressed: () async {
                                                    print(selectedSortFilter);
                                                    BlocProvider.of<OfferBloc>(
                                                            context)
                                                        .add(
                                                      GetOfferListEvent(
                                                        offerListRequest:
                                                            OfferListRequest(
                                                          sort: sortQuery,
                                                          brandId: "",
                                                          categoryId: "",
                                                        ),
                                                      ),
                                                    );
                                                    context.pop();
                                                  },
                                                  child: Text(
                                                    "Apply",
                                                    style: GoogleFonts.roboto(
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
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: const [
                            BoxShadow(
                              color: AppColors.boxShadow,
                              blurRadius: 4,
                              offset: Offset(4, 2),
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Sort",
                              style: TextStyle(
                                color: AppColors.iconGreyColor,
                                fontSize: 13,
                              ),
                            ),
                            SvgPicture.asset(Assets.SORT_SVG,height: 10,width: 10,),

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
                                      selectedBrandVariants = <String>[];
                                      selectedCategoryVariants = <String>[];
                                    });
                                  }

                                  // filterWidgets.clear();

                                  return BlocBuilder<FilterBloc, FilterState>(
                                    builder: (context, state) {
                                      if (state is BrandLoading) {
                                        return Center(
                                          child: Lottie.asset(Assets.JUMBINGDOT,
                                              height: 100, width: 100),
                                        );
                                      }
                                      if (state is BrandLoaded) {
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
                                                    const SizedBox(height: 60),
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          isBrandFilterTileSelected =
                                                              !isBrandFilterTileSelected;
                                                        });
                                                      },
                                                      child: ListTile(
                                                        trailing:
                                                            !isBrandFilterTileSelected ==
                                                                    true
                                                                ? const ImageIcon(
                                                                    color: AppColors
                                                                        .secondaryColor,
                                                                    AssetImage(
                                                                        Assets
                                                                            .SIDE_ARROW),
                                                                  )
                                                                : const ImageIcon(
                                                                    color: AppColors
                                                                        .secondaryColor,
                                                                    AssetImage(
                                                                        Assets
                                                                            .DOWN_ARROW),
                                                                  ),
                                                        title:
                                                            const Text("Brand"),
                                                      ),
                                                    ),
                                                    isBrandFilterTileSelected ==
                                                            true
                                                        ? SingleChildScrollView(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      right: 15,
                                                                      left: 15,
                                                                      bottom: 5,
                                                                      top: 5),
                                                              child: Column(
                                                                children: List
                                                                    .generate(
                                                                  state
                                                                      .brandAndCategoryFilterResponse
                                                                      .data
                                                                      .brands
                                                                      .length,
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
                                                                            state.brandAndCategoryFilterResponse.data.brands[index].brandName,
                                                                            softWrap:
                                                                                true,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                                                                  fontSize: 15,
                                                                                ),
                                                                          ),
                                                                          selectedBrandVariants.contains(state.brandAndCategoryFilterResponse.data.brands[index].id.toString())
                                                                              ? InkWell(
                                                                                  onTap: () {
                                                                                    setState(() {
                                                                                      selectedBrandVariants.remove(state.brandAndCategoryFilterResponse.data.brands[index].id.toString());
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
                                                                                      color: Color(0xFFD9D9D9),
                                                                                      image: DecorationImage(
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
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        : const SizedBox(),
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          isCategoryFilterTileSelected =
                                                              !isCategoryFilterTileSelected;
                                                        });
                                                      },
                                                      child: ListTile(
                                                        trailing:
                                                            !isCategoryFilterTileSelected ==
                                                                    true
                                                                ? const ImageIcon(
                                                                    color: AppColors
                                                                        .secondaryColor,
                                                                    AssetImage(
                                                                        Assets
                                                                            .SIDE_ARROW),
                                                                  )
                                                                : const ImageIcon(
                                                                    color: AppColors
                                                                        .secondaryColor,
                                                                    AssetImage(
                                                                        Assets
                                                                            .DOWN_ARROW),
                                                                  ),
                                                        title: const Text(
                                                            "Category"),
                                                      ),
                                                    ),
                                                    isCategoryFilterTileSelected ==
                                                            true
                                                        ? SingleChildScrollView(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      right: 15,
                                                                      left: 15,
                                                                      bottom: 5,
                                                                      top: 5),
                                                              child: Column(
                                                                children: List
                                                                    .generate(
                                                                  state
                                                                      .brandAndCategoryFilterResponse
                                                                      .data
                                                                      .category
                                                                      .length,
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
                                                                            state.brandAndCategoryFilterResponse.data.category[index].category,
                                                                            softWrap:
                                                                                true,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                                                                  fontSize: 15,
                                                                                ),
                                                                          ),
                                                                          selectedCategoryVariants.contains(state.brandAndCategoryFilterResponse.data.category[index].id.toString())
                                                                              ? InkWell(
                                                                                  onTap: () {
                                                                                    setState(() {
                                                                                      selectedCategoryVariants.remove(state.brandAndCategoryFilterResponse.data.category[index].id.toString());
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
                                                                                      selectedCategoryFilters = selectedCategoryVariants.join(",");
                                                                                    });
                                                                                  },
                                                                                  child: Container(
                                                                                    height: 20,
                                                                                    width: 20,
                                                                                    decoration: const BoxDecoration(
                                                                                      shape: BoxShape.rectangle,
                                                                                      color: Color(0xFFD9D9D9),
                                                                                      image: DecorationImage(
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
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        : const SizedBox(),
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
                                                child: Container(
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
                                                    ],
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
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
                                                            style: GoogleFonts
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
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            fixedSize:
                                                                const Size(
                                                                    100, 40),
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
                                                            print(
                                                                "Selected Category: $selectedCategoryFilters");
                                                            print(
                                                                "Selected Brand: $selectedBrandFilters");

                                                            BlocProvider.of<
                                                                        OfferBloc>(
                                                                    context)
                                                                .add(
                                                              GetOfferListEvent(
                                                                offerListRequest:
                                                                    OfferListRequest(
                                                                  sort: "",
                                                                  brandId:
                                                                      selectedBrandFilters,
                                                                  categoryId:
                                                                      selectedCategoryFilters,
                                                                ),
                                                              ),
                                                            );
                                                            context.pop();
                                                          },
                                                          child: Text(
                                                            "Apply",
                                                            style: GoogleFonts
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
                                                decoration: const BoxDecoration(
                                                  color: AppColors
                                                      .primaryWhiteColor,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20.0),
                                                    topRight:
                                                        Radius.circular(20.0),
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
                                                              style: GoogleFonts
                                                                  .roboto(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
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
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        height: 20,
                        width: 68,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x0F000000),
                              blurRadius: 4,
                              offset: Offset(4, 2),
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Filter",
                              style: TextStyle(
                                color: AppColors.iconGreyColor,
                                fontSize: 13,
                              ),
                            ),
                            SvgPicture.asset(Assets.FILTER_SVG,height: 10,width: 10,),

                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: BlocBuilder<OfferBloc, OfferState>(
              builder: (context, state) {
                if (state is OfferLoading) {
                  return const Center(
                    heightFactor: 13,
                    child: RefreshProgressIndicator(
                      color: AppColors.secondaryColor,
                      backgroundColor: AppColors.primaryWhiteColor,
                    ),
                  );
                }
                if (state is OfferErrorState) {
                  return Center(
                    heightFactor: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset(Assets.TRY_AGAIN, height: 180, width: 500),
                        Text(state.errorMsg),
                      ],
                    ),
                  );
                }
                if (state is OfferLoaded) {
                  if (state.offerListRequestResponse.data!.isNotEmpty) {
                    return SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      child: Column(
                        children: AnimateList(
                          effects: [
                            FadeEffect(delay: 300.ms),
                          ],
                          children: List.generate(
                            state.offerListRequestResponse.data!.length,
                            (index) => Padding(
                              padding: const EdgeInsets.all(15),
                              child: GestureDetector(
                                onTap: () {
                                  context.push('/special_offer_details',
                                      extra: OfferDetailsArguments(
                                          offerHeading: state.offerListRequestResponse.data![index].offerHeading!,
                                          endDate: state.offerListRequestResponse.data![index].endDate!,
                                          offerDetailText: state.offerListRequestResponse.data![index].offerDetails!,
                                          offerImgUrl: state.offerListRequestResponse.data![index].offerImage!,
                                          startDate: state.offerListRequestResponse.data![index].startDate!,
                                        storeList: state.offerListRequestResponse.data![index].superMartketName!,
                                      ),
                                  );
                                },
                                child: Container(
                                  height: getProportionateScreenHeight(105),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryWhiteColor,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        color: AppColors.borderColor, width: 1),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: AppColors.boxShadow,
                                        blurRadius: 4,
                                        offset: Offset(4, 2),
                                        spreadRadius: 0,
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Flexible(
                                        flex: 2,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: SizedBox(
                                            height: 80,
                                            width: 80,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: CachedNetworkImage(
                                                fadeInCurve: Curves.easeIn,
                                                imageUrl: state
                                                    .offerListRequestResponse
                                                    .data![index]
                                                    .offerImage!,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 5,
                                        child: Text(
                                          state.offerListRequestResponse
                                              .data![index].offerHeading!,
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Center(
                      // heightFactor: 13,
                      child: Lottie.asset(Assets.OOPS),
                    );
                  }
                }
                return const SizedBox();
              },
            ),
          )
        ],
      ),
    );
  }
}
