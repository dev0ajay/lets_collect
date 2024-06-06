import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
            text: AppLocalizations.of(context)!.letscollectpoints,
            // text: 'Lets Collect Points  ',
            style: GoogleFonts.roboto(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            children: <TextSpan>[
              TextSpan(
                text: widget.redeemScreenArguments.totalPoint,
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
                                  imageUrl:
                                      " widget.redeemScreenArguments.imageUrl",
                                  fit: BoxFit.fill,
                                  placeholder: (context, url) => SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Center(
                                      child: Lottie.asset(
                                        Assets.JUMBINGDOT,
                                        height: 45,
                                        width: 45,
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const ImageIcon(
                                    size: 200,
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
                                "widget.redeemScreenArguments.requiredPoint",
                                style: GoogleFonts.roboto(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Text(
                                // "Points",
                                AppLocalizations.of(context)!.points,
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
                      // _showDialogBox(
                      //   context: context,
                      //   storeList: context
                      //               .read<LanguageBloc>()
                      //               .state
                      //               .selectedLanguage ==
                      //           Language.english
                      //       ? widget.redeemScreenArguments.wereToRedeem
                      //       : widget.redeemScreenArguments.wereToRedeem,
                      // );
                    },
                    child: Text(
                      // " Where can i redeem this reward?",
                      AppLocalizations.of(context)!.wherecaniredeemthisreward,
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
                  child: InkWell(
                    splashColor: AppColors.secondaryButtonColor,
                    splashFactory: InkSplash.splashFactory,
                    onTap: () {
                      HapticFeedback.selectionClick();
                      if (int.tryParse(
                              widget.redeemScreenArguments.totalPoint!)! >
                          int.parse(
                              widget.redeemScreenArguments.requiredPoint!)) {
                        BlocProvider.of<RedeemBloc>(context).add(
                          GetQrCodeUrlEvent(
                            qrCodeUrlRequest: QrCodeUrlRequest(
                                rewardId:
                                    widget.redeemScreenArguments.rewardId!),
                          ),
                        );
                        showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              RedeemAlertOverlayWidget(
                            imageUrl: widget.redeemScreenArguments.imageUrl!,
                            requiredPoints:
                                widget.redeemScreenArguments.requiredPoint!,
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
                    child: SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: ScanScreenCollectButton(
                          text: AppLocalizations.of(context)!.redeem,
                          // 'Redeem'
                        ),
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
                    AppLocalizations.of(context)!.termsandconditionsapplied,
                    // "Terms and Conditions applied",
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

  ///Dialog box for supermarket list
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
                AppLocalizations.of(context)!.thisitemcanberedeemed,
                // "In Following Physical Store",
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
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
