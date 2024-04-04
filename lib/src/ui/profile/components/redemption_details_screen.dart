import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_collect/language.dart';
import 'package:lets_collect/src/bloc/language/language_bloc.dart';
import 'package:lets_collect/src/bloc/redemption_history/redemption_history_bloc.dart';
import 'package:lets_collect/src/constants/assets.dart';
import 'package:lets_collect/src/constants/colors.dart';
import 'package:lets_collect/src/utils/network_connectivity/bloc/network_bloc.dart';
import 'package:lets_collect/src/utils/screen_size/size_config.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RedemptionDetailsScreen extends StatefulWidget {
  final String imageUrl;
  final String itemName;
  final int points;
  final String time;
  final String store;

  const RedemptionDetailsScreen({
    super.key,
    required this.imageUrl,
    required this.itemName,
    required this.points,
    required this.time,
    required this.store,
  });

  @override
  State<RedemptionDetailsScreen> createState() =>
      _RedemptionDetailsScreenState();
}

class _RedemptionDetailsScreenState extends State<RedemptionDetailsScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<RedemptionHistoryBloc>(context).add(GetRedemptionHistory());
  }

  bool networkSuccess = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_ios_rounded,
            color: AppColors.primaryWhiteColor,
          ),
        ),
        title: Text(
          // "Redemption Details",
          AppLocalizations.of(context)!.redemptiondetails,
          style: GoogleFonts.openSans(
            color: AppColors.primaryWhiteColor,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: AppColors.primaryColor,
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
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
          if (state is NetworkSuccess) {
            return BlocBuilder<RedemptionHistoryBloc, RedemptionHistoryState>(
              builder: (context, state) {
                if (state is RedemptionHistoryLoading) {
                  return const Center(
                    child: RefreshProgressIndicator(
                      color: AppColors.secondaryColor,
                      backgroundColor: AppColors.primaryWhiteColor,
                    ),
                  );
                }
                if (state is RedemptionHistoryLoaded) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 50, horizontal: 50),
                        child: Container(
                          width: getProportionateScreenWidth(380),
                          height: getProportionateScreenHeight(370),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                              boxShadow: const [
                                BoxShadow(
                                  color: AppColors.boxShadow,
                                  blurRadius: 8,
                                  offset: Offset(4, 2),
                                  spreadRadius: 5,
                                ),
                                BoxShadow(
                                  color: AppColors.boxShadow,
                                  blurRadius: 8,
                                  offset: Offset(-4, -2),
                                  spreadRadius: 5,
                                ),
                              ],
                              border:
                              Border.all(color: AppColors.borderColor, width: 1)
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  // "${widget.points} points",
                                  "${widget.points} ${AppLocalizations.of(context)!.points}",
                                  style: GoogleFonts.roboto(
                                    color: AppColors.primaryColor,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              // const SizedBox(height: 15),
                              Expanded(
                                flex: 4,
                                child: CachedNetworkImage(
                                  imageUrl: widget.imageUrl,
                                  fit: BoxFit.contain,
                                  width: MediaQuery.of(context).size.width,
                                  placeholder: (context, url) => SizedBox(
                                    // height: getProportionateScreenHeight(170),
                                    width: MediaQuery.of(context).size.width,
                                    child: Center(
                                      child: Lottie.asset(
                                        Assets.JUMBINGDOT,
                                        height: 45,
                                        width: 45,
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) => const ImageIcon(
                                    color: AppColors.hintColor,
                                    AssetImage(Assets.NO_IMG),
                                  ),

                                ),
                              ),
                              const SizedBox(height: 20),
                              Flexible(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            // text: "Redeemed",
                                            text :AppLocalizations.of(context)!.redeemed,
                                            style: GoogleFonts.roboto(
                                              color: AppColors.primaryColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const WidgetSpan(
                                              child: SizedBox(width: 10)),
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: widget.time,
                                                style: GoogleFonts.roboto(
                                                  color: AppColors.primaryColor,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Flexible(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      // flex: 2,
                                      child: Text(
                                        // "Store: ",
                                        AppLocalizations.of(context)!.store,
                                        style: GoogleFonts.roboto(
                                          color: AppColors.primaryColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 9),
                                    Flexible(
                                      // flex: 3,
                                      child: Text(
                                        // widget.store,
                                        context.read<LanguageBloc>().state.selectedLanguage == Language.english
                                            ? widget.store
                                            : widget.store,
                                        style: GoogleFonts.roboto(
                                          color: AppColors.primaryColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    // RichText(
                                    //   text: TextSpan(
                                    //     children: [
                                    //       TextSpan(
                                    //         text: "Store",
                                    //         // AppLocalizations.of(context)!.store,
                                    //         style: GoogleFonts.roboto(
                                    //           color: AppColors.primaryColor,
                                    //           fontSize: 12,
                                    //           fontWeight: FontWeight.w500,
                                    //         ),
                                    //       ),
                                    //       const WidgetSpan(
                                    //           child: SizedBox(width: 10)),
                                    //       TextSpan(
                                    //         text: widget.store,
                                    //         // context
                                    //         //     .read<LanguageBloc>()
                                    //         //     .state
                                    //         //     .selectedLanguage ==
                                    //         //     Language.english
                                    //         //     ? widget.store
                                    //         //     : widget.store,
                                    //         style: GoogleFonts.roboto(
                                    //           color: AppColors.primaryColor,
                                    //           fontSize: 12,
                                    //           fontWeight: FontWeight.w400,
                                    //         ),
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Center(child: SizedBox());
                }
              },
            );
          } else if (state is NetworkFailure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(Assets.NO_INTERNET),
                  Text(
                    // "You are not connected to the internet",
                    AppLocalizations.of(context)!.youarenotconnectedtotheinternet,
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