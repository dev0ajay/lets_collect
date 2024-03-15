import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_collect/src/bloc/cms_bloc/terms_and_condition_bloc.dart';
import 'package:lets_collect/src/constants/assets.dart';
import 'package:lets_collect/src/utils/network_connectivity/bloc/network_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../../constants/colors.dart';

class TermsAndConditionsScreen extends StatefulWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  State<TermsAndConditionsScreen> createState() =>
      _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {

  bool networkSuccess= false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<TermsAndConditionBloc>(context).add(
        GetTermsAndConditionEvent());
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
          "Terms And Conditions",
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
            return BlocBuilder<TermsAndConditionBloc, TermsAndConditionState>(
              builder: (context, state) {
                if (state is TermsAndConditionLoading) {
                  return const Center(
                    child: RefreshProgressIndicator(
                      backgroundColor: AppColors.secondaryColor,
                      color: AppColors.primaryWhiteColor,
                    ),
                  );
                }

                if (state is TermsAndConditionErrorState) {
                  return Center(
                    child: Column(
                      children: [
                        Lottie.asset(Assets.TRY_AGAIN),
                        Expanded(
                            flex: 2,
                            child: Text(state.errorMsg)),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              backgroundColor: AppColors.primaryColor),
                          onPressed: () {
                            BlocProvider.of<TermsAndConditionBloc>(context)
                                .add(GetTermsAndConditionEvent());
                          },
                          child: const Text(
                            "Try again....",
                            style: TextStyle(color: AppColors.primaryWhiteColor),
                          ),
                        )
                      ],
                    ),
                  );
                }

                if (state is TermsAndConditionLoaded) {
                  return SingleChildScrollView(
                    child: Html(
                        data: state.termsAndConditionResponse.data.pageContent
                      //    data: state.termsAndConditionResponse != null
                      //    ? (context.read<LanguageBloc>().state.selectedLanguage == Language.english
                      //    ? state.termsAndConditionResponse.data.pageContent
                      //    : state.termsAndConditionResponse.data.pageTitleArabic )
                      // : ""
                    ),
                  );
                }
                return const Center(
                  child: Text("No Data to show"),
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
                    "You are not connected to the internet",
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
