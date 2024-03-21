import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_collect/src/bloc/purchase_history_bloc/purchase_history_bloc.dart';
import 'package:lets_collect/src/constants/assets.dart';
import 'package:lets_collect/src/constants/colors.dart';
import 'package:lets_collect/src/model/purchase_history/purchase_history_details_request.dart';
import 'package:lets_collect/src/model/purchase_history/purchase_history_request.dart';
import 'package:lottie/lottie.dart';

class PurchaseHistoryDetailsScreen extends StatefulWidget {
  final String receiptId;

  const PurchaseHistoryDetailsScreen({super.key, required this.receiptId});

  @override
  State<PurchaseHistoryDetailsScreen> createState() =>
      _PurchaseHistoryDetailsScreenState();
}

class _PurchaseHistoryDetailsScreenState
    extends State<PurchaseHistoryDetailsScreen> {
  @override
  void initState() {
    super.initState();
    print("ReceiptID: ${widget.receiptId}");
    BlocProvider.of<PurchaseHistoryBloc>(context).add(
      GetPurchaseHistoryDetails(
        purchaseHistoryDetailsRequest:
            PurchaseHistoryDetailsRequest(purchaseId: widget.receiptId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<PurchaseHistoryBloc>(context).add(
          GetPurchaseHistory(
            purchaseHistoryRequest: PurchaseHistoryRequest(
                sort: '', supermarketId: '', month: '', year: '', page: '1'),
          ),
        );
        context.pop();
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            BlocBuilder<PurchaseHistoryBloc, PurchaseHistoryState>(
              builder: (context, state) {
                if (state is PurchaseHistoryDetailsLoading) {
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
                } else if (state is PurchaseHistoryDetailsLoaded) {
                  if (state
                      .purchaseHistoryDetailsResponse.data.itemData.isEmpty) {
                    return Center(
                      child: Lottie.asset(Assets.OOPS),
                    );
                  }
                  return CustomScrollView(
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
                                  color: AppColors.primaryWhiteColor,
                                  borderRadius: BorderRadius.circular(8.0),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: AppColors.boxShadow,
                                      spreadRadius: 1,
                                      blurRadius: 1,
                                      offset: Offset(3, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      " ${state.purchaseHistoryDetailsResponse.data.receiptData.currencyCode} ${state.purchaseHistoryDetailsResponse.data.receiptData.totalAmount}",
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
                                            "Date",
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
                                            state.purchaseHistoryDetailsResponse
                                                .data.receiptData.receiptDate
                                                .toString(),
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
                                            "Super market",
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
                                            state.purchaseHistoryDetailsResponse
                                                .data.receiptData.branch,
                                            // context
                                            //     .read<LanguageBloc>()
                                            //     .state
                                            //     .selectedLanguage ==
                                            //     Language.english
                                            //     ? state
                                            //     .purchaseHistoryDetailsResponse
                                            //     .data
                                            //     .receiptData
                                            //     .branch
                                            //     : state
                                            //     .purchaseHistoryDetailsResponse
                                            //     .data
                                            //     .receiptData
                                            //     .branch,
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
                                            "Total item",
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
                                            state
                                                .purchaseHistoryDetailsResponse
                                                .data
                                                .receiptData
                                                .totalNoOfProducts
                                                .toString(),
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
                        child: Column(
                          children: [
                            ListView.builder(
                              padding: const EdgeInsets.only(top: 10),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state.purchaseHistoryDetailsResponse
                                  .data.itemData.length,
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
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 16),
                                    leading: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state.purchaseHistoryDetailsResponse
                                              .data.itemData[index].itemName,
                                          // context
                                          //     .read<LanguageBloc>()
                                          //     .state
                                          //     .selectedLanguage ==
                                          //     Language.english
                                          //     ? state
                                          //     .purchaseHistoryDetailsResponse
                                          //     .data
                                          //     .itemData[index]
                                          //     .itemName
                                          //     : state
                                          //     .purchaseHistoryDetailsResponse
                                          //     .data
                                          //     .itemData[index]
                                          //     .itemName,
                                          style: GoogleFonts.roboto(
                                            color: AppColors.primaryBlackColor,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          state.purchaseHistoryDetailsResponse
                                              .data.itemData[index].code,
                                          style: GoogleFonts.roboto(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          "Point Tier",
                                          style: GoogleFonts.roboto(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                    trailing: Text(
                                      "${state.purchaseHistoryDetailsResponse.data.receiptData.currencyCode} ${state.purchaseHistoryDetailsResponse.data.itemData[index].itemPrice}",
                                      style: GoogleFonts.openSans(
                                        color: AppColors.secondaryButtonColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Center(
                    child: SizedBox(),
                  );
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
                padding: const EdgeInsets.only(top: 30),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        BlocProvider.of<PurchaseHistoryBloc>(context).add(
                          GetPurchaseHistory(
                            purchaseHistoryRequest: PurchaseHistoryRequest(
                              sort: '',
                              supermarketId: '',
                              month: '',
                              year: '',
                              page: '1',
                            ),
                          ),
                        );
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios_rounded,
                          size: 18, color: AppColors.primaryWhiteColor),
                    ),
                    Text(
                      "Purchase History",
                      // AppLocalizations.of(context)!.purchasehistory,
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
