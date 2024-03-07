import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_collect/language.dart';
import 'package:lets_collect/src/bloc/language/language_bloc.dart';
import 'package:lets_collect/src/bloc/redemption_history/redemption_history_bloc.dart';
import 'package:lets_collect/src/constants/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RedemptionDetailsScreen extends StatefulWidget {
  final String imageUrl;
  final String itemName;
  final int points;
  final String time;
  final String store;

  const RedemptionDetailsScreen({
    Key? key,
    required this.imageUrl,
    required this.itemName,
    required this.points,
    required this.time,
    required this.store,
  }) : super(key: key);

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
      body: BlocBuilder<RedemptionHistoryBloc, RedemptionHistoryState>(
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 80, horizontal: 80),
                  child: Container(
                    width: 280,
                    height: 300,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          "${widget.points} ${AppLocalizations.of(context)!.points}",
                          style: GoogleFonts.roboto(
                            color: AppColors.primaryColor,
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          height: 150,
                          width: 100,
                          child: CachedNetworkImage(
                            imageUrl: widget.imageUrl,
                            fit: BoxFit.fill,
                            width: MediaQuery.of(context).size.width,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: AppLocalizations.of(context)!.redeemed,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: AppLocalizations.of(context)!.store,
                                    style: GoogleFonts.roboto(
                                      color: AppColors.primaryColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const WidgetSpan(
                                      child: SizedBox(width: 10)),
                                  TextSpan(
                                    text: context.read<LanguageBloc>().state.selectedLanguage == Language.english
                                    ? widget.store
                                    :widget.store,
                                    style: GoogleFonts.roboto(
                                      color: AppColors.primaryColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
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
      ),
    );
  }
}
