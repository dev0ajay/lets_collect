import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_collect/src/constants/assets.dart';
import 'package:lets_collect/src/utils/screen_size/size_config.dart';

import '../../../../constants/colors.dart';

class SliverBackgroundWidget extends StatelessWidget {
  final bool isLetsCollectRewardSelected;
  final bool  isBrandSelected;
  final bool isPartnerSelected;
  final String letsCollectTotalPoints;

  const SliverBackgroundWidget(
      {super.key,
      required this.isLetsCollectRewardSelected,
      required this.isPartnerSelected,
      required this.isBrandSelected,
        required this.letsCollectTotalPoints,
      });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // const SizedBox(
        //   height: 170,
        //   width: 400,
        // ),
        Padding(
          padding: const EdgeInsets.only(top: 28),
          child: Align(
            alignment: Alignment.center,
            child: Container(
              // height: getProportionateScreenHeight(183),
              // width: getProportionateScreenWidth(350),
              decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x4F000000),
                      blurRadius: 4.10,
                      offset: Offset(2, 4),
                      spreadRadius: 0,
                    ),
                  ]
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(9),
                  child: SvgPicture.asset(Assets.CONTAINER_SVG,fit: BoxFit.cover,)),
            ),
          ),
        ),
        Positioned(
          top: 25,
          left: 0,
          bottom: 15,
          child: Image.asset(Assets.WALLET),
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(left: 20,top: 60),
            child:  isLetsCollectRewardSelected ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  letsCollectTotalPoints,
                  style: GoogleFonts.openSans(
                    color: AppColors.primaryWhiteColor,
                    fontSize: 36,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  "Lets Collect Points",
                  style: GoogleFonts.roboto(
                    color: AppColors.primaryWhiteColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ) :    Text(
              "Wallet",
              style: GoogleFonts.openSans(
                color: AppColors.primaryWhiteColor,
                fontSize: 36,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),

      ],
    );
  }
}
