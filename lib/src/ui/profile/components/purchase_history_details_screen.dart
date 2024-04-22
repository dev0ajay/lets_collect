import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_collect/language.dart';
import 'package:lets_collect/src/bloc/language/language_bloc.dart';
import 'package:lets_collect/src/bloc/purchase_history_bloc/purchase_history_bloc.dart';
import 'package:lets_collect/src/constants/assets.dart';
import 'package:lets_collect/src/constants/colors.dart';
import 'package:lets_collect/src/model/purchase_history/purchase_history_request.dart';
import 'package:lets_collect/src/utils/network_connectivity/bloc/network_bloc.dart';
import 'package:lets_collect/src/utils/screen_size/size_config.dart';
import 'package:lottie/lottie.dart';
import '../../../model/purchase_history/purchase_history_details_request.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PurchaseHistoryDetailsScreen extends StatefulWidget {
  final String receiptId;

  const PurchaseHistoryDetailsScreen({super.key, required this.receiptId});

  @override
  State<PurchaseHistoryDetailsScreen> createState() =>
      _PurchaseHistoryDetailsScreenState();
}

class _PurchaseHistoryDetailsScreenState
    extends State<PurchaseHistoryDetailsScreen> {
  bool networkSuccess = false;

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
        body: BlocConsumer<NetworkBloc, NetworkState>(
          listener: (context, state) {
            if (state is NetworkSuccess) {
              networkSuccess = true;
            }
          },
          builder: (context, state) {
            if (state is NetworkSuccess) {
              return Stack(
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
                        // if (state.purchaseHistoryDetailsResponse.data.itemData.isEmpty) {
                        //   return Center(
                        //     child: Lottie.asset(Assets.OOPS),
                        //   );
                        // }
                        return CustomScrollView(
                          slivers: [
                            SliverPadding(
                              padding: const EdgeInsets.only(top: 20),
                              sliver: SliverAppBar(
                                backgroundColor: AppColors.primaryWhiteColor,
                                automaticallyImplyLeading: false,
                                expandedHeight: 300.0,
                                floating: false,
                                pinned: true,
                                flexibleSpace: FlexibleSpaceBar(
                                  background: Center(
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 70),
                                      width: getProportionateScreenWidth(350),
                                      height: getProportionateScreenHeight(200),
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryWhiteColor,
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        boxShadow: const [
                                          BoxShadow(
                                            color:
                                                Color.fromRGBO(0, 0, 0, 0.31),
                                            blurRadius: 4.10,
                                            offset: Offset(2, 4),
                                            spreadRadius: 0,
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        children: [
                                          const SizedBox(height: 20),
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
                                                  // "Date",
                                                  "${AppLocalizations.of(context)!
                                                      .date}:  ",
                                                  style: GoogleFonts.roboto(
                                                    color:
                                                        AppColors.primaryColor,
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
                                                      .receiptDate
                                                      .toString(),
                                                  style: GoogleFonts.roboto(
                                                    color:
                                                        AppColors.primaryColor,
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
                                                  // "Super market",
                                                  AppLocalizations.of(context)!
                                                      .supermarket,
                                                  style: GoogleFonts.roboto(
                                                    color:
                                                        AppColors.primaryColor,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                flex: 1,
                                                child: Text(
                                                  context
                                                              .read<
                                                                  LanguageBloc>()
                                                              .state
                                                              .selectedLanguage ==
                                                          Language.english
                                                      ? state
                                                          .purchaseHistoryDetailsResponse
                                                          .data
                                                          .receiptData
                                                          .branch
                                                      : state
                                                          .purchaseHistoryDetailsResponse
                                                          .data
                                                          .receiptData
                                                          .branch,
                                                  style: GoogleFonts.roboto(
                                                    color:
                                                        AppColors.primaryColor,
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
                                                  // "Total item",
                                                  AppLocalizations.of(context)!
                                                      .totalitem,
                                                  style: GoogleFonts.roboto(
                                                    color:
                                                        AppColors.primaryColor,
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
                                                    color:
                                                        AppColors.primaryColor,
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
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: state
                                        .purchaseHistoryDetailsResponse
                                        .data
                                        .itemData
                                        .length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        margin: const EdgeInsets.only(
                                            left: 30,
                                            right: 30,
                                            bottom: 10,
                                            top: 0),
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
                                        child: ListTile(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 15, horizontal: 16),
                                          leading: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                // state.purchaseHistoryDetailsResponse.data.itemData[index].itemName,
                                                context
                                                            .read<
                                                                LanguageBloc>()
                                                            .state
                                                            .selectedLanguage ==
                                                        Language.english
                                                    ? state
                                                        .purchaseHistoryDetailsResponse
                                                        .data
                                                        .itemData[index]
                                                        .itemName
                                                    : state
                                                        .purchaseHistoryDetailsResponse
                                                        .data
                                                        .itemData[index]
                                                        .itemName,
                                                style: GoogleFonts.roboto(
                                                  color: AppColors
                                                      .primaryBlackColor,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Text(
                                                state
                                                    .purchaseHistoryDetailsResponse
                                                    .data
                                                    .itemData[index]
                                                    .code,
                                                style: GoogleFonts.roboto(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              Text(
                                                "Point Tier",
                                                // AppLocalizations.of(context)!.pointtier,
                                                style: GoogleFonts.roboto(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                          trailing: Text(
                                            // "${AppLocalizations.of(context)!.bhd} ${state.purchaseHistoryDetailsResponse.data.itemData[index].itemPrice}",
                                            "${state.purchaseHistoryDetailsResponse.data.receiptData.currencyCode} ${state.purchaseHistoryDetailsResponse.data.itemData[index].itemPrice}",
                                            style: GoogleFonts.openSans(
                                              color: AppColors
                                                  .secondaryButtonColor,
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
                                  purchaseHistoryRequest:
                                      PurchaseHistoryRequest(
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
                            AppLocalizations.of(context)!.purchasehistory,
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
              );
            } else if (state is NetworkFailure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(Assets.NO_INTERNET),
                    Text(
                      AppLocalizations.of(context)!
                          .youarenotconnectedtotheinternet,
                      // "You are not connected to the internet",
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
      ),
    );
  }
}
