import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_collect/src/bloc/redeem/redeem_bloc.dart';
import 'package:lets_collect/src/model/redeem/qr_code_url_request.dart';
import 'package:lets_collect/src/ui/reward/components/widgets/redeem_alert_overlay_widget.dart';
import 'package:lets_collect/src/ui/scan/components/widgets/scan_screen_collect_button.dart';
import 'package:lets_collect/src/utils/screen_size/size_config.dart';
import 'package:lottie/lottie.dart';
import '../../../../constants/assets.dart';
import '../../../../constants/colors.dart';
import '../lets_collect_redeem_screen_arguments.dart';

class LetsCollectRedeemScreen extends StatefulWidget {
  final LetCollectRedeemScreenArguments redeemScreenArguments;

  const LetsCollectRedeemScreen(
      {super.key, required this.redeemScreenArguments});

  @override
  State<LetsCollectRedeemScreen> createState() =>
      _LetsCollectRedeemScreenState();
}

class _LetsCollectRedeemScreenState extends State<LetsCollectRedeemScreen> {
  @override
  void initState() {
    super.initState();
    // ObjectFactory().prefs.getLetsCollectTierData()!.data.letsCollect.forEach((element) { });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
        title: RichText(
          // Controls visual overflow
          overflow: TextOverflow.clip,
          // textAlign: TextAlign.end,
          textDirection: TextDirection.rtl,
          softWrap: true,
          maxLines: 1,
          text: TextSpan(
            text: 'Lets Collect Points  ',
            style: GoogleFonts.roboto(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            children: <TextSpan>[
              TextSpan(
                text: widget.redeemScreenArguments.requiredPoint,
                style: GoogleFonts.roboto(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
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
                        color: Colors.white,
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
                                  imageUrl:
                                      widget.redeemScreenArguments.imageUrl,
                                  fit: BoxFit.fill,
                                  placeholder: (context, url) => Lottie.asset(
                                      Assets.JUMBINGDOT,
                                      height: 10,
                                      width: 10),
                                  errorWidget: (context, url, error) =>
                                      const ImageIcon(
                                    color: AppColors.hintColor,
                                    AssetImage(Assets.NO_IMG),
                                  ),
                                ),
                                // Image.network(
                                //   widget.redeemScreenArguments.imageUrl,
                                //   fit: BoxFit.fill,
                                //
                                //   // height: 350,
                                // ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            Flexible(
                              flex: 1,
                              child: Text(
                                widget.redeemScreenArguments.requiredPoint,
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
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: GestureDetector(
                    onTap: () {
                      _showDialogBox(
                          context: context,
                          storeList: widget.redeemScreenArguments.wereToRedeem);
                    },
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
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: GestureDetector(
                    onTap: () {
                      BlocProvider.of<RedeemBloc>(context).add(
                        GetQrCodeUrlEvent(
                          qrCodeUrlRequest: QrCodeUrlRequest(rewardId: 2),
                        ),
                      );

                      showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            RedeemAlertOverlayWidget(
                          imageUrl: widget.redeemScreenArguments.imageUrl,
                          requiredPoints:
                              widget.redeemScreenArguments.requiredPoint,
                          qrUrl: '',
                        ),
                      );
                    },
                    child: const ScanScreenCollectButton(text: "Redeem"),
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
