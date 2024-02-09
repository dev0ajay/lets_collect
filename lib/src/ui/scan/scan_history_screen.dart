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
  // final ScanDetailsScreenArgument scanDetailsScreenArgument;

  const ScanHistoryDetailsScreen(
      {super.key});

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
        scanReceiptHistoryRequest:
        ScanReceiptHistoryRequest(
            pointId: 14
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
        body: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.only(top: 20),
                  sliver: SliverAppBar(
                    // backgroundColor: AppColors.primaryColor,
                    automaticallyImplyLeading: false,
                    expandedHeight: 300.0,
                    floating: false,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Center(
                        child: Container(
                          margin: const EdgeInsets.only(top: 70),
                          width: 350,
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: const Offset(3, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                " ${"state."} ${"state"}",
                                style: GoogleFonts.openSans(
                                  color: AppColors.primaryColor,
                                  fontSize: 36,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 0,
                                    child: Text(
                                      "",
                                      // AppLocalizations.of(context)!.date,
                                      style: GoogleFonts.roboto(
                                        color: AppColors.primaryColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: Text(
                                      "",
                                      style: GoogleFonts.roboto(
                                        color: AppColors.primaryColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 0,
                                    child: Text(
                                      "",
                                      // AppLocalizations.of(context)!
                                      //     .supermarket,
                                      style: GoogleFonts.roboto(
                                        color: AppColors.primaryColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: Text(
                                      "",
                                      // "  context.read<LanguageBloc>().state.selectedLanguage == Language.english
                                      //       ?state.purchaseHistoryDetailsResponse.data.receiptData.branch
                                      //       :state.purchaseHistoryDetailsResponse.data.receiptData.branch,"
                                      style: GoogleFonts.roboto(
                                        color: AppColors.primaryColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 0,
                                    child: Text(
                                      "",
                                      // AppLocalizations.of(context)!
                                      //     .totalitem,
                                      style: GoogleFonts.roboto(
                                        color: AppColors.primaryColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: Text(
                                      "",
                                      style: GoogleFonts.roboto(
                                        color: AppColors.primaryColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: BlocBuilder<ScanBloc, ScanState>(
                    builder: (context, state) {
                      if(state is ScanReceiptHistoryLoading) {
                        return const Center(
                          child: RefreshProgressIndicator(
                            backgroundColor: AppColors.primaryWhiteColor,
                            color: AppColors.secondaryColor,
                          ),
                        );
                      }
                      if(state is ScanReceiptHistoryLoaded) {
                        if(state.scanReceiptHistoryResponse.data!.isNotEmpty) {
                          return Column(
                            children: [
                              ListView.builder(
                                padding: const EdgeInsets.only(top: 10),
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: 1,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: const EdgeInsets.only(
                                        left: 30, right: 30, bottom: 10, top: 0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 1,
                                          offset: const Offset(
                                              3, 3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        Column(
                                          children: [
                                            Text(state.scanReceiptHistoryResponse.data![index].productName.toString()),
                                            Text(""),
                                            Text(""),

                                          ],
                                        ),
                                        Text(state.scanReceiptHistoryResponse.data![index].points.toString()),
                                      ],
                                    ),

                                  );
                                },
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
              ],
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
                padding: const EdgeInsets.only(top: 30),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios_rounded,
                          size: 18, color: AppColors.primaryWhiteColor),
                    ),
                    Text(
                      "",
                      style: GoogleFonts.openSans(
                        fontStyle: FontStyle.normal,
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
