import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_collect/language.dart';
import 'package:lets_collect/src/bloc/language/language_bloc.dart';
import 'package:lets_collect/src/constants/assets.dart';
import 'package:lets_collect/src/constants/colors.dart';
import 'package:lets_collect/src/utils/network_connectivity/bloc/network_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../../bloc/how_to_redeem/how_to_redeem_my_points_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HowToRedeemMyPointsScreen extends StatefulWidget {
  const HowToRedeemMyPointsScreen({super.key});

  @override
  State<HowToRedeemMyPointsScreen> createState() =>
      _HowToRedeemMyPointsScreenState();
}

class _HowToRedeemMyPointsScreenState extends State<HowToRedeemMyPointsScreen> {

  bool networkSuccess= false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HowToRedeemMyPointsBloc>(context).add(
        GetHowToRedeemMyPointsEvent());
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
          AppLocalizations.of(context)!.howtoredeemmypoints,
          // "How To Redeem My Points ?",
          style: GoogleFonts.openSans(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryWhiteColor,
          ),
        ),
      ),
      body: BlocConsumer<NetworkBloc, NetworkState>(
        listener: (context, state) {
          if (state is NetworkSuccess) {
            networkSuccess = true;
          }
        },
        builder: (context, state) {
          if(state is NetworkSuccess){
            return BlocBuilder<HowToRedeemMyPointsBloc, HowToRedeemMyPointsState>(
              builder: (context, state) {
                if (state is HowToRedeemMyPointsLoading) {
                  return const Center(
                    child: RefreshProgressIndicator(
                      backgroundColor: AppColors.primaryWhiteColor,
                      color: AppColors.secondaryColor,
                    ),
                  );
                }
                if (state is HowToRedeemMyPointsLoaded) {
                  return SingleChildScrollView(
                    child: Html(
                      // data: state.howToRedeemMyPointsResponse.data.pageContent
                        data: state.howToRedeemMyPointsResponse != null
                            ? (context.read<LanguageBloc>().state.selectedLanguage == Language.english
                            ? state.howToRedeemMyPointsResponse.data.pageContent
                            : state.howToRedeemMyPointsResponse.data.pageContentArabic )
                            : ""
                    ),
                  );
                }
                return  Center(
                  child: Text(AppLocalizations.of(context)!.nodatashow),
                  // Text("No Data to show"),
                );
              },
            );
          }else if (state is NetworkFailure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(Assets.NO_INTERNET),
                  Text(
                    AppLocalizations.of(context)!.youarenotconnectedtotheinternet,
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
    );
  }
}