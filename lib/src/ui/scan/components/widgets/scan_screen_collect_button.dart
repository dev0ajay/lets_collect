import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_collect/src/utils/screen_size/size_config.dart';

import '../../../../constants/colors.dart';

class ScanScreenCollectButton extends StatelessWidget {
  final String text;
  const ScanScreenCollectButton({
    super.key,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      height: getProportionateScreenHeight(40),
      width: getProportionateScreenWidth(312),
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
          borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(
            color: Color(0x4F000000),
            blurRadius: 4.10,
            offset: Offset(2, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Center(
        child: Text(
          text,
          style: GoogleFonts.roboto(
            color: AppColors.primaryWhiteColor,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}



