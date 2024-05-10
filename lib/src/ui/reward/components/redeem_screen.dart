import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_collect/src/ui/reward/components/brand_and_partner_redeem_arguments.dart';
import 'package:lets_collect/src/ui/reward/components/widgets/redeem_alert_overlay_widget.dart';
import 'package:lets_collect/src/ui/scan/components/widgets/scan_screen_collect_button.dart';
import 'package:lets_collect/src/utils/screen_size/size_config.dart';
import 'package:lottie/lottie.dart';
import '../../../bloc/redeem/redeem_bloc.dart';
import '../../../constants/assets.dart';
import '../../../constants/colors.dart';
import '../../../model/redeem/qr_code_url_request.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RedeemScreen extends StatefulWidget {
  final BrandAndPartnerRedeemArguments brandAndPartnerRedeemArguments;

  const RedeemScreen({super.key, required this.brandAndPartnerRedeemArguments});

  @override
  State<RedeemScreen> createState() => _RedeemScreenState();
}

class _RedeemScreenState extends State<RedeemScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
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
        title: Text(
          "Redeem",
          style: GoogleFonts.roboto(
            color: AppColors.primaryWhiteColor,
            fontSize: 23,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: buildBrandProductRedeemScreenBody(context),
      // widget.brandAndPartnerRedeemArguments.from == "brand_products"
      //     ? buildBrandProductRedeemScreenBody(context)
      //     : widget.brandAndPartnerRedeemArguments.from == "partner_products"
      //         ? buildPartnerProductRedeemScreenBody(context)
      //         : const SizedBox(),
    );
  }

  SingleChildScrollView buildBrandProductRedeemScreenBody(
      BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Center(
                  child: Container(
                    width: getProportionateScreenWidth(242),
                    height: getProportionateScreenHeight(280),
                    decoration: BoxDecoration(
                      color: AppColors.primaryWhiteColor,
                      borderRadius: BorderRadius.circular(5),
                      border: const Border(
                          right: BorderSide(
                              width: 1, color: AppColors.borderColor),
                          top: BorderSide(
                              width: 1, color: AppColors.borderColor),
                          left: BorderSide(
                              width: 1, color: AppColors.borderColor),
                          bottom: BorderSide(
                              width: 1, color: AppColors.borderColor)),
                      boxShadow: const [
                        BoxShadow(
                          color: AppColors.boxShadow,
                          blurRadius: 3.80,
                          offset: Offset(4, 2),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 10, right: 10),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            flex: 4,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: CachedNetworkImage(
                                alignment: Alignment.center,
                                fadeInCurve: Curves.easeIn,
                                fadeInDuration:
                                    const Duration(milliseconds: 200),
                                fit: BoxFit.contain,
                                imageUrl: widget.brandAndPartnerRedeemArguments
                                    .productImageUrl,
                                width: MediaQuery.of(context).size.width,
                                placeholder: (context, url) => Lottie.asset(
                                  Assets.JUMBINGDOT,
                                  height: 10,
                                  width: 10,
                                ),
                                errorWidget: (context, url, error) =>
                                    const ImageIcon(
                                  size: 250,
                                  color: AppColors.hintColor,
                                  AssetImage(Assets.NO_IMG),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Flexible(
                            flex: 1,
                            child: Text(
                              widget.brandAndPartnerRedeemArguments
                                  .requiredPoints,
                              style: GoogleFonts.roboto(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Text(
                              "Points",
                              style: GoogleFonts.roboto(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  _showDialogBox(
                      context: context,
                      storeList:
                          widget.brandAndPartnerRedeemArguments.whereToRedeem);
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    " Where can i redeem this reward?",
                    style: GoogleFonts.roboto(
                      color: AppColors.underlineColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.underlineColor,
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(top: 0),
                child: InkWell(
                  splashColor: AppColors.secondaryButtonColor,
                  splashFactory: InkSplash.splashFactory,
                  onTap: () {
                    if (int.tryParse(
                            widget.brandAndPartnerRedeemArguments.totalPoint)! >
                        int.parse(widget
                            .brandAndPartnerRedeemArguments.requiredPoints)) {
                      BlocProvider.of<RedeemBloc>(context).add(
                        GetQrCodeUrlEvent(
                          qrCodeUrlRequest: QrCodeUrlRequest(
                              rewardId: widget
                                  .brandAndPartnerRedeemArguments.rewardId),
                        ),
                      );
                      showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            RedeemAlertOverlayWidget(
                          imageUrl: widget
                              .brandAndPartnerRedeemArguments.productImageUrl,
                          requiredPoints: widget
                              .brandAndPartnerRedeemArguments.requiredPoints,
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: AppColors.secondaryColor,
                        content: Text(
                          AppLocalizations.of(context)!
                              .youdonthaveenoughpointstoreddemthisitem,
                          // "You don't have enough points to redeem this item.",
                          style: const TextStyle(
                            color: AppColors.primaryWhiteColor,
                          ),
                        ),
                      ));
                    }
                  },
                  child: const SizedBox(
                    child: Padding(
                      padding: EdgeInsets.all(3.0),
                      child: ScanScreenCollectButton(text: 'Redeem'),
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  "Terms and Conditions applied",
                  style: GoogleFonts.openSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDialogBox({
    required BuildContext context,
    required List<String> storeList,
  }) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9),
            side: const BorderSide(color: AppColors.borderColor)),
        backgroundColor: AppColors.primaryWhiteColor,
        elevation: 5,
        alignment: Alignment.center,
        content: SizedBox(
          height: getProportionateScreenHeight(260),
          width: getProportionateScreenWidth(320),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: const Icon(Icons.close),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                  child: Text(
                "In Following Physical Store",
                style: GoogleFonts.roboto(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              )),
              const SizedBox(height: 20),
              Expanded(
                flex: 2,
                child: Column(
                    children: List.generate(
                  storeList.length,
                  (index) => Text(
                    "\u2022 ${storeList[index]}",
                    style: GoogleFonts.openSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
