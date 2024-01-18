import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/rendering.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_collect/src/ui/reward/components/widgets/filter.dart';
import '../../constants/colors.dart';
import '../../utils/screen_size/size_config.dart';
import 'components/widgets/sliver_background_widget.dart';
import 'components/widgets/sort_sheet.dart';

class RewardScreen extends StatefulWidget {
  const RewardScreen({Key? key}) : super(key: key);

  @override
  State<RewardScreen> createState() => _RewardScreenState();
}

class _RewardScreenState extends State<RewardScreen> {
  List<String> img = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSXRugGkV8QAKSz8iW4peXztElMofvXfVEgTA&usqp=CAU",
    "https://images.unsplash.com/photo-1528750717929-32abb73d3bd9?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fGZvb2QlMjBicmFuZCUyMHByb2R1Y3RzfGVufDB8fDB8fHww",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJwOz2y3GVcAGokrAo2K68_yQ7_gPzk3K6ieJuwRvoj_kjmZ-s4lgUHVFonWsFAQUBcNg&usqp=CAU",
    "https://images.unsplash.com/photo-1525904097878-94fb15835963?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRFjhLvA2B5o0Qo6eueBjfgz7WuhF1Rhxp9EA&usqp=CAU",
    "https://images.unsplash.com/photo-1587790032594-babe1292cede?q=80&w=2519&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  ];
  List<String> brand = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTfxUBt2EtbI2IPETUYrifzoWQktIsu5crphrYu5Qzbiw52g5on9HxRZqbvdcbdtcF0YY0&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSGG9_-u0Oq3DR-LKVQ8nEVYd9kqbYUt36-YQ&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSWK7Fy3iGvJyRlR2MtQdEe7YhXzf2RKeM_OQ&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ88mjX9WUPXBejWdPwLYzgtVHvPrToa99k_g&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ1l4JWiEQKcluNXPcUF0TWDVKBUzRxQpQC_w&usqp=CAU",
  ];
  List<String> price = [
    "90",
    "80",
    "50",
    "40",
    "20",
    "234",
    "120",
    "123",
  ];

  // late bool isSelected;
  bool isLetsCollectSelected = false;
  bool isBrandSelected = false;
  bool isPartnerSelected = false;
  ScrollController scrollController = ScrollController();
  bool isScrolledToExtend = false;

  final ScrollController _scrollController = ScrollController();
  bool _isAppBarVisible = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.offset > 200 &&
        _scrollController.position.userScrollDirection ==
            ScrollDirection.reverse) {
      setState(() {
        _isAppBarVisible = true;
      });
    } else if (_scrollController.offset < 150 &&
        _scrollController.position.userScrollDirection ==
            ScrollDirection.forward) {
      setState(() {
        _isAppBarVisible = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return CustomScrollView(
      controller: _scrollController,
      // shrinkWrap: true,
      slivers: [
        SliverAppBar(
          leading: const SizedBox(),
          pinned: true,
          centerTitle: false,
          titleSpacing: 0,
          titleTextStyle: const TextStyle(fontSize: 18),
          title: _isAppBarVisible && isLetsCollectSelected == true
              ? Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return StatefulBuilder(builder:
                                    (BuildContext context,
                                        StateSetter setState) {
                                  return const SortSheet();
                                });
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
                    ),
                    const SizedBox(width: 15),
                    Flexible(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return StatefulBuilder(builder:
                                    (BuildContext context,
                                    StateSetter setState) {
                                  return const FilterSheet();
                                });
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
                    ),
                    const Spacer(flex: 1),
                    const Flexible(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "LetsCollect",
                            overflow: TextOverflow.fade,
                            softWrap: true,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15),
                          ),
                          Text("1200"),
                        ],
                      ),
                    ),
                  ],
                )
              : _isAppBarVisible && isBrandSelected == true
                  ? Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              showModalBottomSheet<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return StatefulBuilder(builder:
                                        (BuildContext context,
                                        StateSetter setState) {
                                      return const SortSheet();
                                    });
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
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                        ),
                        const SizedBox(width: 15),
                        Flexible(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              showModalBottomSheet<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return StatefulBuilder(builder:
                                        (BuildContext context,
                                        StateSetter setState) {
                                      return const FilterSheet();
                                    });
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
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                        ),
                      ],
                    )
                  : _isAppBarVisible && isPartnerSelected == true
                      ? Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () {
                                  showModalBottomSheet<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return StatefulBuilder(builder:
                                            (BuildContext context,
                                            StateSetter setState) {
                                          return const SortSheet();
                                        });
                                      });
                                },
                                child: Container(
                                  padding:
                                      const EdgeInsets.only(left: 8, right: 8),
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
                                  child: const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                            ),
                            const SizedBox(width: 15),
                            Flexible(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () {
                                  showModalBottomSheet<void>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return StatefulBuilder(builder:
                                            (BuildContext context,
                                            StateSetter setState) {
                                          return const FilterSheet();
                                        });
                                      });
                                },
                                child: Container(
                                  padding:
                                      const EdgeInsets.only(left: 8, right: 8),
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
                                  child: const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                            ),
                          ],
                        )
                      : null,
          floating: false,
          backgroundColor: AppColors.primaryColor,
          expandedHeight: getProportionateScreenHeight(290),
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: false,
            background: Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SliverBackgroundWidget(
                    isLetsCollectRewardSelected: isLetsCollectSelected,
                    isPartnerSelected: isPartnerSelected,
                    isBrandSelected: isBrandSelected,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return StatefulBuilder(builder:
                                      (BuildContext context,
                                      StateSetter setState) {
                                    return const SortSheet();
                                  });
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
                            showModalBottomSheet<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return StatefulBuilder(builder:
                                      (BuildContext context,
                                      StateSetter setState) {
                                    return const FilterSheet();
                                  });
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
                  ),
                ],
              ),
            ),
          ),
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(45),
            child: Container(
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              height: 45,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: AppColors.primaryWhiteColor,
                border:
                    Border.all(color: AppColors.primaryWhiteColor, width: 0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
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
                              width: 1, color: AppColors.borderColor),
                          top: BorderSide(
                              width: 1, color: AppColors.borderColor),
                          left: BorderSide(
                              width: 1, color: AppColors.borderColor),
                          right: BorderSide(
                              width: 1, color: AppColors.borderColor),
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
                        "Lets Collect Reward",
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w400,
                          fontSize: isLetsCollectSelected == true ? 15 : 12,
                          color: isLetsCollectSelected == true
                              ? AppColors.primaryWhiteColor
                              : AppColors.primaryBlackColor,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isLetsCollectSelected = false;
                        isBrandSelected = true;
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
                              width: 1, color: AppColors.borderColor),
                          top: BorderSide(
                              width: 1, color: AppColors.borderColor),
                          left: BorderSide(
                              width: 1, color: AppColors.borderColor),
                          right: BorderSide(
                              width: 1, color: AppColors.borderColor),
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
                        "Brand Reward",
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w400,
                          fontSize: isBrandSelected == true ? 15 : 12,
                          color: isBrandSelected == true
                              ? AppColors.primaryWhiteColor
                              : AppColors.primaryBlackColor,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isLetsCollectSelected = false;
                        isBrandSelected = false;
                        isPartnerSelected = true;
                      });
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      padding: const EdgeInsets.only(
                          top: 4, bottom: 4, left: 8, right: 8),
                      decoration: BoxDecoration(
                        border: const Border(
                          bottom: BorderSide(
                              width: 1, color: AppColors.borderColor),
                          top: BorderSide(
                              width: 1, color: AppColors.borderColor),
                          left: BorderSide(
                              width: 1, color: AppColors.borderColor),
                          right: BorderSide(
                              width: 1, color: AppColors.borderColor),
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
                        "Partner Reward",
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w400,
                          fontSize: isPartnerSelected == true ? 15 : 12,
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
                            : const SizedBox(),
              ],
            ),
          ),
          padding: const EdgeInsets.only(left: 15, right: 15),
        ),
      ],
    );
  }

  GridView buildLetsCollectRewardTierMethod() {
    return GridView.builder(
        shrinkWrap: true,
        itemCount: img.length,
        padding: const EdgeInsets.only(bottom: 120, top: 20),
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
              context.push('/lets_collect_redeem');
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
                          fadeInDuration: const Duration(milliseconds: 200),
                          fit: BoxFit.contain,
                          imageUrl: img[index],
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                    ),
                  ),
                  const Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(top: 8.0, left: 20),
                      child: Text(
                        "70 Points",
                        style: TextStyle(
                            color: AppColors.primaryColor, fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  GridView buildBrandRewardTierMethod() {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: brand.length,
      padding: const EdgeInsets.only(bottom: 120, top: 20),
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
            context.push('/brand_products');
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
              border: Border.all(color: AppColors.borderColor, width: 1),
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
                  imageUrl: brand[index],
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  GridView buildPartnerRewardTierMethod() {
    return GridView.builder(
        shrinkWrap: true,
        itemCount: brand.length,
        padding: const EdgeInsets.only(bottom: 120, top: 20),
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
              context.push('/partner_products');
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
                  border: Border.all(color: AppColors.borderColor, width: 1)),
              child: Center(
                child: SizedBox(
                  width: 120,
                  height: 100,
                  child: CachedNetworkImage(
                    alignment: Alignment.center,
                    fadeInCurve: Curves.easeIn,
                    fadeInDuration: const Duration(milliseconds: 200),
                    fit: BoxFit.contain,
                    imageUrl: brand[index],
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
              ),
            ),
          );
        },
    );
  }
}
