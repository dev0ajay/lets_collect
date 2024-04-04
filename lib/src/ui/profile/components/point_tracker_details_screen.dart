import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_collect/language.dart';
import 'package:lets_collect/src/bloc/language/language_bloc.dart';
import 'package:lets_collect/src/bloc/point_tracker_bloc/point_tracker_bloc.dart';
import 'package:lets_collect/src/constants/assets.dart';
import 'package:lets_collect/src/constants/colors.dart';
import 'package:lets_collect/src/model/point_tracker/point_tracker_request.dart';
import 'package:lottie/lottie.dart';
import '../../../model/point_tracker/point_tracker_details_request.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PointTrackerDetailsScreen extends StatefulWidget {
  final int pointId;

  const PointTrackerDetailsScreen({super.key, required this.pointId});

  @override
  State<PointTrackerDetailsScreen> createState() =>
      _PointTrackerDetailsScreenState();
}

class _PointTrackerDetailsScreenState extends State<PointTrackerDetailsScreen> {
  String totalPoints = "";
  String expiryDate = "";
  String supermarkerName = "";

  @override
  void initState() {
    print("id:${widget.pointId}");
    super.initState();
    BlocProvider.of<PointTrackerBloc>(context).add(
      GetPointTrackerDetailEvent(
        pointTrackerDetailsRequest:
        PointTrackerDetailsRequest(pointId: widget.pointId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<PointTrackerBloc>(context).add(GetPointTrackerEvent(
            pointTrackerRequest: PointTrackerRequest(
                sort: '', superMarketId: '', month: '', year: '')));
        context.pop();
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.primaryWhiteColor,
        body: Stack(
          children: [
            BlocBuilder<PointTrackerBloc, PointTrackerState>(
              builder: (context, state) {
                if (state is PointTrackerDetailsLoading) {
                  return Stack(
                    children: [
                      Positioned(
                        top: MediaQuery.of(context).size.height / 2,
                        left: MediaQuery.of(context).size.width / 3,
                        right: MediaQuery.of(context).size.width / 3,
                        child: const Center(
                          child: RefreshProgressIndicator(
                            color: AppColors.secondaryColor,
                            backgroundColor: AppColors.primaryWhiteColor,
                          ),
                        ),
                      ),
                    ],
                  );
                }
                if (state is PointTrackerDetailsLoaded) {
                  if (state.pointTrackerDetailsRequestResponse.success ==
                      false) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset(Assets.OOPS),
                        ],
                      ),
                    );
                  }
                  print("PointTrackerDetailsLoaded state detected");
                  for (var element in state.pointTrackerDetailsRequestResponse.data!) {
                    totalPoints = element.totalPoints.toString();
                    expiryDate = element.expiryDate.toString();
                    supermarkerName = element.supermarketName!;
                  }
                  return CustomScrollView(
                    physics: const ClampingScrollPhysics(),
                    slivers: [
                      SliverPadding(
                        padding: const EdgeInsets.only(top: 90),
                        sliver: SliverAppBar(
                          backgroundColor: AppColors.primaryWhiteColor,
                          // backgroundColor: AppColors.primaryColor,
                          automaticallyImplyLeading: false,
                          expandedHeight: 250.0,
                          floating: false,
                          pinned: true,
                          flexibleSpace: FlexibleSpaceBar(
                            background: Center(
                              child: Container(
                                // margin: const EdgeInsets.only(top: 70),
                                width: 350,
                                height: 220,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryWhiteColor,
                                  borderRadius: BorderRadius.circular(8.0),
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
                                child: Column(
                                  children: [
                                    const Expanded(
                                      flex: 5,
                                      child: Image(
                                        // height: 200,
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                            "assets/png_icons/gift_icon.png"),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Flexible(
                                      flex: 3,
                                      child: Text(
                                        totalPoints,
                                        style: GoogleFonts.openSans(
                                          color: AppColors.primaryColor,
                                          fontSize: 36,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Flexible(
                                      flex: 1,
                                      child: Text(
                                        // "Total points earned!",
                                        AppLocalizations.of(context)!.totalpointearned,
                                        style: GoogleFonts.roboto(
                                          color: AppColors.primaryColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    Flexible(
                                      flex: 1,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            // "Date ",
                                            AppLocalizations.of(context)!.date,
                                            style: GoogleFonts.roboto(
                                              color: AppColors.primaryColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            expiryDate,
                                            style: GoogleFonts.roboto(
                                              color: AppColors.primaryColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Flexible(
                                      flex: 1,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            // "Supermarket ",
                                            AppLocalizations.of(context)!.supermarket,
                                            style: GoogleFonts.roboto(
                                              color: AppColors.primaryColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            supermarkerName,
                                            style: GoogleFonts.roboto(
                                              color: AppColors.primaryColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Container(
                            padding:
                            const EdgeInsets.only(top: 5, bottom: 5),
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: AppColors.primaryWhiteColor,
                              border: Border.all(
                                  color: AppColors.primaryWhiteColor,
                                  width: 0),
                            ),
                            child: ListView.builder(
                              padding: const EdgeInsets.only(left: 10,right: 10),
                              scrollDirection: Axis.horizontal,
                              itemCount: state
                                  .pointTrackerDetailsRequestResponse
                                  .brandPoints!
                                  .length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  margin: const EdgeInsets.only(
                                      left: 15, right: 15),
                                  height: MediaQuery.of(context).size.height,
                                  padding: const EdgeInsets.only(
                                      top: 2, bottom: 2, left: 25, right: 25),
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
                                  ),
                                  // alignment: Alignment.center,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            // state.pointTrackerDetailsRequestResponse.brandPoints![index].brandName!,
                                            context.read<LanguageBloc>().state.selectedLanguage == Language.english
                                                ? state.pointTrackerDetailsRequestResponse.brandPoints![index].brandName!
                                                : state.pointTrackerDetailsRequestResponse.brandPoints![index].brandNameArabic!,
                                            style: GoogleFonts.roboto(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              color:
                                              AppColors.primaryBlackColor,
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          flex: 2,
                                          child: Text(
                                            state.pointTrackerDetailsRequestResponse.brandPoints![index].points.toString(),
                                            style: GoogleFonts.roboto(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              color: AppColors
                                                  .secondaryButtonColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )),
                      ),
                      SliverToBoxAdapter(
                        child: BlocBuilder<PointTrackerBloc, PointTrackerState>(
                          builder: (context, state) {
                            if (state is PointTrackerDetailsLoaded) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 25,right: 25),
                                child: Column(
                                  children: [
                                    ListView.builder(
                                      padding: const EdgeInsets.only(top: 20),
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: state.pointTrackerDetailsRequestResponse.pointDetails!.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          margin: const EdgeInsets.all(
                                              10
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors.primaryWhiteColor,
                                            borderRadius:
                                            BorderRadius.circular(8.0),
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
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 16),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Flexible(
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        overflow: TextOverflow.ellipsis,
                                                        // state.pointTrackerDetailsRequestResponse.pointDetails![index].productName!,
                                                        context.read<LanguageBloc>().state.selectedLanguage == Language.english
                                                            ? state.pointTrackerDetailsRequestResponse.pointDetails![index].productName!
                                                            :  state.pointTrackerDetailsRequestResponse.pointDetails![index].productNameAr!,
                                                        style: GoogleFonts.roboto(
                                                          color: AppColors
                                                              .primaryBlackColor,
                                                          fontSize: 16,
                                                          fontWeight:
                                                          FontWeight.w500,
                                                        ),
                                                      ),
                                                      const Divider(
                                                        height: 7,
                                                        color: Colors.transparent,
                                                      ),
                                                      Text(
                                                        overflow: TextOverflow.ellipsis,
                                                        // state.pointTrackerDetailsRequestResponse.pointDetails![index].brandName!,
                                                        context.read<LanguageBloc>().state.selectedLanguage == Language.english
                                                            ? state.pointTrackerDetailsRequestResponse.pointDetails![index].brandName!
                                                            : state.pointTrackerDetailsRequestResponse.pointDetails![index].brandNameAr!,
                                                        style: GoogleFonts.roboto(
                                                          fontSize: 13,
                                                          fontWeight:
                                                          FontWeight.w400,
                                                        ),
                                                      ),
                                                      const Divider(
                                                        height: 5,
                                                        color: Colors.transparent,
                                                      ),
                                                      Text(
                                                        // state.pointTrackerDetailsRequestResponse.pointDetails![index].pointTierName!,
                                                        overflow: TextOverflow.ellipsis,
                                                        context.read<LanguageBloc>().state.selectedLanguage == Language.english
                                                            ? state.pointTrackerDetailsRequestResponse.pointDetails![index].pointTierName!
                                                            : state.pointTrackerDetailsRequestResponse.pointDetails![index].pointTierName!,
                                                        style: GoogleFonts.roboto(
                                                          fontSize: 12,
                                                          fontWeight:
                                                          FontWeight.w400,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Flexible(
                                                  child: Text(
                                                    state.pointTrackerDetailsRequestResponse.pointDetails![index].points.toString(),
                                                    overflow: TextOverflow.ellipsis,
                                                    style: GoogleFonts.openSans(
                                                      color: AppColors
                                                          .secondaryButtonColor,
                                                      fontSize: 19,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return const SizedBox();
                            }
                          },
                        ),
                      ),
                    ],
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10)),
                color: AppColors.primaryColor,
              ),
              height: 100,
              child: Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        BlocProvider.of<PointTrackerBloc>(context).add(
                          GetPointTrackerEvent(
                            pointTrackerRequest: PointTrackerRequest(
                              sort: '', superMarketId: '', month: '', year: '',),),);
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios_rounded,
                          size: 18, color: AppColors.primaryWhiteColor),
                    ),
                    Text(
                      // "Point Tracker",
                      AppLocalizations.of(context)!.pointtracker,
                      style: GoogleFonts.openSans(
                        color: AppColors.primaryWhiteColor,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}