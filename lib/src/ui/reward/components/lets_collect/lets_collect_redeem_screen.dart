import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_collect/src/ui/reward/components/widgets/redeem_alert_overlay_widget.dart';
import 'package:lets_collect/src/ui/scan/components/widgets/scan_screen_collect_button.dart';
import 'package:lets_collect/src/utils/screen_size/size_config.dart';
import '../../../../constants/assets.dart';
import '../../../../constants/colors.dart';

class LetsCollectRedeemScreen extends StatefulWidget {
  const LetsCollectRedeemScreen({super.key});

  @override
  State<LetsCollectRedeemScreen> createState() =>
      _LetsCollectRedeemScreenState();
}

class _LetsCollectRedeemScreenState extends State<LetsCollectRedeemScreen> {


  @override
  void initState() {
    super.initState();
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
                text: '1200',
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
                                child: Image.network(
                                  "https://images.unsplash.com/photo-1525904097878-94fb15835963?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                                  fit: BoxFit.fill,
                                  // height: 350,
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            Flexible(
                              flex: 1,
                              child: Text(
                                "60",
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
                    _showDialogBox(context: context);
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
                  child: GestureDetector(
                    onTap: () {
                      showDialog(context: context, builder: (BuildContext context)
                      => const RedeemAlertOverlayWidget(),);
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
  }) {
    showDialog(

      context: context,
      builder: (ctx) => AlertDialog(
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
              const Flexible(
                flex: 3,
                child: Center(
                  child: Text("In Following Physical Store")
                ),
              ),
              const SizedBox(height: 20),

              Flexible(
                flex: 2,
                child:
               Column(
                 children: [
                   Text('\u2022 Bullet Text'),
                   Text('\u2022 Bullet Text'),
                   Text('\u2022 Bullet Text'),

                 ],
               ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
