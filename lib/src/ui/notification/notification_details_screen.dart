import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_collect/src/ui/notification/components/notification_details_argument.dart';
import 'package:lottie/lottie.dart';

import '../../../language.dart';
import '../../bloc/language/language_bloc.dart';
import '../../constants/assets.dart';
import '../../constants/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../utils/network_connectivity/bloc/network_bloc.dart';

class NotificationDetailsScreen extends StatelessWidget {
  final NotificationDetailsArgument notificationDetailsArgument;

  const NotificationDetailsScreen(
      {super.key, required this.notificationDetailsArgument});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryWhiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primaryWhiteColor,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.primaryBlackColor,
          ),
        ),
        title: Text(
          AppLocalizations.of(context)!.notificationdetails,
          style: GoogleFonts.roboto(
            color: AppColors.primaryBlackColor,
            fontSize: 23,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: BlocConsumer<NetworkBloc, NetworkState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is NetworkInitial) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(Assets.NO_INTERNET),
                  Text(
                    // "You are not connected to the internet",
                    AppLocalizations.of(context)!
                        .youarenotconnectedtotheinternet,
                    style: GoogleFonts.openSans(
                      color: AppColors.primaryGrayColor,
                      fontSize: 20,
                    ),
                  ).animate().scale(delay: 200.ms, duration: 300.ms),
                ],
              ),
            );
          } else if (state is NetworkFailure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(Assets.NO_INTERNET),
                  Text(
                    AppLocalizations.of(context)!
                        .youarenotconnectedtotheinternet,
                    style: GoogleFonts.openSans(
                      color: AppColors.primaryGrayColor,
                      fontSize: 20,
                    ),
                  ).animate().scale(delay: 200.ms, duration: 300.ms),
                ],
              ),
            );
          } else if (state is NetworkSuccess) {
            return Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 3,
                    child: Text(
                      context.read<LanguageBloc>().state.selectedLanguage ==
                              Language.english
                          ? notificationDetailsArgument.title
                          : notificationDetailsArgument.title,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.openSans(
                        color: AppColors.primaryColor,
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Flexible(
                    // flex: 2,
                    child: Text(
                      context.read<LanguageBloc>().state.selectedLanguage ==
                              Language.english
                          ? notificationDetailsArgument.message
                          : notificationDetailsArgument.message,
                      style: GoogleFonts.openSans(
                        color: AppColors.primaryColor2,
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Flexible(
                    child: RichText(
                      softWrap: true,
                      maxLines: 1,
                      text: TextSpan(
                        text: AppLocalizations.of(context)!.date,
                        style: const TextStyle(
                          color: AppColors.primaryColor2,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Fonarto",
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: notificationDetailsArgument.date,
                            style: GoogleFonts.openSans(
                              color: AppColors.secondaryButtonColor,
                              fontSize: 17,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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
