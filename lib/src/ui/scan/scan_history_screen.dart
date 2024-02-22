import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_collect/src/constants/colors.dart';
import 'package:lottie/lottie.dart';
import '../../bloc/scan_bloc/scan_bloc.dart';
import '../../constants/assets.dart';
import '../../model/scan_receipt/scan_receipt_history_request.dart';
import 'components/scan_detail_screen_argument.dart';

class ScanHistoryDetailsScreen extends StatefulWidget {
  final ScanDetailsScreenArgument scanDetailsScreenArgument;

  const ScanHistoryDetailsScreen(
      {super.key, required this.scanDetailsScreenArgument});

  @override
  State<ScanHistoryDetailsScreen> createState() =>
      _ScanHistoryDetailsScreenState();
}

class _ScanHistoryDetailsScreenState extends State<ScanHistoryDetailsScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ScanBloc>(context).add(
      ScanReceiptHistoryEvent(
        scanReceiptHistoryRequest: ScanReceiptHistoryRequest(pointId: 14
            // widget.scanDetailsScreenArgument.pointId
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.pop();
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.primaryWhiteColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.primaryWhiteColor,
          title: Text(
            "Scan details",
            style: GoogleFonts.openSans(
              color: AppColors.primaryColor,
              fontSize: 25,
              fontWeight: FontWeight.w400,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon:
                const Icon(Icons.arrow_back_ios, color: AppColors.primaryColor),
          ),
        ),
        body: SafeArea(
          child: BlocBuilder<ScanBloc, ScanState>(
            builder: (context, state) {
              if (state is ScanReceiptHistoryLoading) {
                return const Center(
                  child: RefreshProgressIndicator(
                    color: AppColors.secondaryColor,
                    backgroundColor: AppColors.primaryWhiteColor,
                  ),
                );
              }
              if (state is ScanReceiptHistoryLoaded) {
                if (state.scanReceiptHistoryResponse.data!.isNotEmpty) {
                  return Stack(
                    children: [
                      CustomScrollView(
                        slivers: [
                          SliverPadding(
                            padding: const EdgeInsets.only(top: 20),
                            sliver: SliverToBoxAdapter(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Total Points",
                                        style: TextStyle(
                                          color: AppColors.primaryColor,
                                          fontSize: 30,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        widget.scanDetailsScreenArgument
                                            .totalPoint
                                            .toString(),
                                        style: const TextStyle(
                                          color: AppColors.primaryColor,
                                          fontSize: 25,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          SliverPadding(
                            padding: const EdgeInsets.only(top: 20),
                            sliver: SliverToBoxAdapter(
                              child: Column(
                                children: [
                                  ListView.builder(
                                    padding: const EdgeInsets.only(top: 10),
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: state.scanReceiptHistoryResponse
                                        .data!.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        padding: const EdgeInsets.all(20),
                                        margin: const EdgeInsets.only(
                                            left: 30,
                                            right: 30,
                                            bottom: 10,
                                            top: 0),
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
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(state
                                                    .scanReceiptHistoryResponse
                                                    .data![index]
                                                    .brandName!),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 3.0),
                                                  child: Text(state
                                                      .scanReceiptHistoryResponse
                                                      .data![index]
                                                      .productName!),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 3.0),
                                                  child: Text(
                                                      "Points: ${state.scanReceiptHistoryResponse.data![index].points.toString()}"),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.secondaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            fixedSize: Size(MediaQuery.of(context).size.width, 50)
                          ),
                          onPressed: () {

                          },
                          child: const Text("Done"),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Center(
                    child: Lottie.asset(Assets.OOPS),
                  );
                }
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
