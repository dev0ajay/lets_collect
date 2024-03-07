import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_collect/src/bloc/cms_bloc/how_to_redeem_my_points/how_to_redeem_my_points_bloc.dart';
import 'package:lets_collect/src/constants/colors.dart';

class HowToRedeemMyPointsScreen extends StatefulWidget {
  const HowToRedeemMyPointsScreen({super.key});

  @override
  State<HowToRedeemMyPointsScreen> createState() => _HowToRedeemMyPointsScreenState();
}

class _HowToRedeemMyPointsScreenState extends State<HowToRedeemMyPointsScreen> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HowToRedeemMyPointsBloc>(context).add(GetHowToRedeemMyPointsEvent());

  }

  @override
  Widget build(BuildContext context) {
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
          ),),
        title: Text(
          "How To Redeem My Points ?",
          style: GoogleFonts.openSans(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryWhiteColor,
          ),
        ),
      ),
      body: BlocBuilder<HowToRedeemMyPointsBloc, HowToRedeemMyPointsState>(
        builder: (context, state) {
          if(state is HowToRedeemMyPointsLoading) {
            return const Center(
              child: RefreshProgressIndicator(
                backgroundColor: AppColors.secondaryColor,
                color: AppColors.primaryWhiteColor,
              ),
            );
          }
          if(state is HowToRedeemMyPointsLoaded) {
            return SingleChildScrollView(
              child: Html(data: state.howToRedeemMyPointsResponse.data.pageContent),
            );
          }
          return const Center(
            child: Text("No Data to show"),
          );
        },
      ),
    );
  }
}
