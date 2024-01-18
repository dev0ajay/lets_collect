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

  const SliverBackgroundWidget(
      {super.key,
      required this.isLetsCollectRewardSelected,
      required this.isPartnerSelected,
      required this.isBrandSelected});

  @override
  Widget build(BuildContext context) {
    String tireOnePoint = "1200";
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: getProportionateScreenHeight(133),
            width: getProportionateScreenWidth(320),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.25),
                  blurRadius: 4,
                  offset: Offset(0, 4),
                  spreadRadius: 0, //extend the shadow
                ),

              ],
            ),
            child: SvgPicture.asset(Assets.CONTAINER_SVG),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            height: 140,
            width: 400,
            // color: Colors.cyan,
            child: Stack(
              children: [
                Positioned(
                  top: 10,
                  left: 20,
                  bottom: 15,
                  child: Image.asset(Assets.WALLET),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child:  isLetsCollectRewardSelected ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          tireOnePoint,
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
            ),
          ),
        ),
      ],
    );
  }
}
