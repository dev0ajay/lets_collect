import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_collect/language.dart';
import 'package:lets_collect/src/bloc/cms_bloc/point_calculations/point_calculations_bloc.dart';
import 'package:lets_collect/src/bloc/language/language_bloc.dart';
import 'package:lets_collect/src/constants/assets.dart';
import 'package:lets_collect/src/constants/colors.dart';
import 'package:lets_collect/src/utils/network_connectivity/bloc/network_bloc.dart';
import 'package:lottie/lottie.dart';
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
    BlocProvider.of<PointCalculationsBloc>(context).add(
        GetPointCalculationsEvent());
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
          // "Point Calculations",
          AppLocalizations.of(context)!.pointcalculations,
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

                if (state is PointCalculationsErrorState) {
                  return Center(
                    child: Column(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Lottie.asset(Assets.TRY_AGAIN),
                        ),
                        Flexible(
                          flex: 2,
                          child: Text(
                            state.errorMsg,
                            style: const TextStyle(
                                color: AppColors.primaryWhiteColor),
                          ),
                        ),
                        const Spacer(),
                        Flexible(
                          flex: 1,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(9),
                                ),
                                fixedSize: const Size(100, 50),
                                backgroundColor: AppColors.primaryColor),
                            onPressed: () {
                              BlocProvider.of<PointCalculationsBloc>(context)
                                  .add(GetPointCalculationsEvent());
                            },
                            child:  Text(
                              // "Try again",
                              AppLocalizations.of(context)!.tryagain,
                              style:
                              const TextStyle(color: AppColors.primaryWhiteColor),
                            ),
                          ),
                        ),
                        // const Text("state"),
                      ],
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
                         : state.pointCalculationsResponse.data.pageTitleArabic )
                      : ""
                    ),
                  );
                }
                // return const Center(
                //   child: Text("No Data to show"),
                // );
                return  Center(
                  child: Text(AppLocalizations.of(context)!.nodatashow),
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
