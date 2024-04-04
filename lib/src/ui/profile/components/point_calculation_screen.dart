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
import '../../../bloc/point_calculation/point_calculations_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PointCalculationsScreen extends StatefulWidget {
  const PointCalculationsScreen({super.key});

  @override
  State<PointCalculationsScreen> createState() =>
      _PointCalculationsScreenState();
}

class _PointCalculationsScreenState extends State<PointCalculationsScreen> {
  bool networkSuccess = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<PointCalculationsBloc>(context)
        .add(GetPointCalculationsEvent());
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
          ),
        ),
        title: Text(
          AppLocalizations.of(context)!.pointcalculations,
          // "Point Calculations",
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
          if (state is NetworkSuccess) {
            return BlocBuilder<PointCalculationsBloc, PointCalculationsState>(
              builder: (context, state) {
                if (state is PointCalculationsLoading) {
                  return const Center(
                    child: RefreshProgressIndicator(
                      backgroundColor: AppColors.secondaryColor,
                      color: AppColors.primaryWhiteColor,
                    ),
                  );
                }
                if (state is PointCalculationsLoaded) {
                  return SingleChildScrollView(
                    child: Html(
                      // data: state.pointCalculationsResponse.data.pageContent
                        data: state.pointCalculationsResponse != null
                            ? (context.read<LanguageBloc>().state.selectedLanguage == Language.english
                            ? state.pointCalculationsResponse.data.pageContent
                            : state.pointCalculationsResponse.data.pageContentArabic )
                            : ""
                    ),
                  );
                }
                return  Center(
                    child: Text(AppLocalizations.of(context)!.nodatashow)
                  // Text("No Data to show"),
                );
              },
            );
          } else if (state is NetworkFailure) {
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