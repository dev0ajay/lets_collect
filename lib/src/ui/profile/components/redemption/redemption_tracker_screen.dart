import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_collect/src/bloc/redemption_history/redemption_history_bloc.dart';
import 'package:lets_collect/src/constants/assets.dart';
import 'package:lets_collect/src/constants/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lets_collect/src/ui/profile/components/redemption/redemption_details_screen.dart';
import 'package:lets_collect/src/utils/network_connectivity/bloc/network_bloc.dart';
import 'package:lets_collect/src/utils/network_connectivity/bloc/network_bloc.dart';
import 'package:lottie/lottie.dart';

class RedemptionTrackerScreen extends StatefulWidget {
  const RedemptionTrackerScreen({Key? key}) : super(key: key);

  @override
  State<RedemptionTrackerScreen> createState() =>
      _RedemptionTrackerScreenState();
}

class _RedemptionTrackerScreenState extends State<RedemptionTrackerScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<RedemptionHistoryBloc>(context).add(GetRedemptionHistory());
  }

  bool networkSuccess = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_rounded,
            color: AppColors.primaryWhiteColor,
          ),
        ),
        title: Text(
          AppLocalizations.of(context)!.redemptiontracker,
          style: GoogleFonts.openSans(
            color: AppColors.primaryWhiteColor,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: AppColors.primaryColor,
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
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
    if(state is NetworkSuccess) {
      return BlocBuilder<RedemptionHistoryBloc, RedemptionHistoryState>(
        builder: (context, state) {
          if (state is RedemptionHistoryLoading) {
            return Stack(
              children: [
                Positioned(
                  top: MediaQuery.of(context).size.height / 3,
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
          } else if (state is RedemptionHistoryLoaded) {
            if (state.redemptionHistoryResponse.data!.isEmpty) {
              return Center(
                child: Lottie.asset(Assets.OOPS),
              );
            }
            if (state is RedemptionHistoryErrorState) {
              return Center(
                child: Column(
                  children: [
                    Lottie.asset(Assets.TRY_AGAIN),
                  ],
                ),
              );
            }
            return ListView.builder(
              itemCount: state.redemptionHistoryResponse.data!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RedemptionDetailsScreen(
                          imageUrl: state.redemptionHistoryResponse.data![index].productImage.toString(),
                          itemName: state.redemptionHistoryResponse.data![index]
                              .productName.toString(),
                          points: state
                              .redemptionHistoryResponse.data![index].points!.toInt(),
                          time: state
                              .redemptionHistoryResponse.data![index].redeemDate.toString(),
                          store: state.redemptionHistoryResponse.data![index]
                              .supermarketName.toString(),
                        ),
                      ),
                    );
                  },
                  child: Container(
                      height: 110,
                      width: 325,
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 0, top: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 90,
                                  height: 70,
                                  child: CachedNetworkImage(
                                    alignment: Alignment.center,
                                    fadeInCurve: Curves.easeIn,
                                    fadeInDuration:
                                    const Duration(milliseconds: 200),
                                    fit: BoxFit.contain,
                                    imageUrl: state.redemptionHistoryResponse
                                        .data![index].productImage.toString(),
                                    width: MediaQuery.of(context).size.width,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  state.redemptionHistoryResponse.data![index]
                                      .points
                                      .toString(),
                                  style: GoogleFonts.roboto(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  AppLocalizations.of(context)!.points,
                                  style: GoogleFonts.roboto(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            const Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 15,
                              color: AppColors.secondaryColor,
                            ),
                          ],
                        ),
                      )

                    // ListTile(
                    //   contentPadding: const EdgeInsets.symmetric(
                    //       vertical: 10, horizontal: 16),
                    //   leading: SizedBox(
                    //     width: 120,
                    //     height: 100,
                    //     child:
                    //     CachedNetworkImage(
                    //       alignment: Alignment.center,
                    //       fadeInCurve: Curves.easeIn,
                    //       fadeInDuration: const Duration(milliseconds: 200),
                    //       fit: BoxFit.contain,
                    //       imageUrl: state.redemptionHistoryResponse.data[index].productImage,
                    //       width: MediaQuery.of(context).size.width,
                    //     ),
                    //   ),
                    //
                    //   trailing: const Icon(
                    //     Icons.arrow_forward_ios_rounded,
                    //     size: 15,
                    //     color: AppColors.secondaryColor,
                    //   ),
                    //   title: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.center,
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       Text(
                    //         state.redemptionHistoryResponse.data[index].points.toString(),
                    //         style: GoogleFonts.roboto(
                    //           fontSize: 24,
                    //           fontWeight: FontWeight.w600,
                    //         ),
                    //         textAlign: TextAlign.center,
                    //       ),
                    //       Text(
                    //         AppLocalizations.of(context)!.points,
                    //         style: GoogleFonts.roboto(
                    //           fontSize: 12,
                    //           fontWeight: FontWeight.w400,
                    //         ),
                    //         textAlign: TextAlign.center,
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: SizedBox(),
            );
          }
        },
      );
    }else if (state is NetworkFailure) {
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
),
    );
  }
}
