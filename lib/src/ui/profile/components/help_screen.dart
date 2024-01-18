import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_collect/src/ui/profile/profile_screen.dart';
import 'package:lets_collect/src/utils/screen_size/size_config.dart';

import '../../../constants/assets.dart';
import '../../../constants/colors.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_outlined,
              color: AppColors.primaryWhiteColor,
            )),
        title: Text(
          "Help Center",
          style: GoogleFonts.openSans(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryWhiteColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
          child: Column(
            children: [
              Center(
                  child: SvgPicture.asset(
                Assets.HELP_SVG,
                fit: BoxFit.cover,
                height: 200,
              )),
              const SizedBox(height: 35),
              const ProfileDetailsListTileWidget(
                  labelText: "How to redeem my points ?"),
              const SizedBox(height: 15),
              const ProfileDetailsListTileWidget(
                  labelText: "Point Calculations"),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  context.push('/terms_and_condition');
                },
                child: const ProfileDetailsListTileWidget(
                    labelText: "Terms and Conditions"),
              ),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  context.push('/privacy_policies');
                },
                child: const ProfileDetailsListTileWidget(
                    labelText: "Privacy policies"),
              ),
              const SizedBox(height: 15),
              const ProfileDetailsListTileWidget(labelText: "Need more Help?"),
            ],
          ),
        ),
      ),
    );
  }
}
