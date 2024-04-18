import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_collect/language.dart';
import 'package:lets_collect/src/bloc/language/language_bloc.dart';
import '../../../bloc/terms_and_conditions_bloc/terms_and_condition_bloc.dart';
import '../../../constants/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TermsAndConditionsScreen extends StatefulWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  State<TermsAndConditionsScreen> createState() =>
      _TermsAndConditionsScreenState();
}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TermsAndConditionBloc>(context)
        .add(GetTermsAndConditionEvent());
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
          AppLocalizations.of(context)!.termsandconditions,
          // "Terms And Conditions",
          style: GoogleFonts.openSans(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryWhiteColor,
          ),
        ),
      ),
      body: BlocBuilder<TermsAndConditionBloc, TermsAndConditionState>(
        builder: (context, state) {
          if (state is TermsAndConditionLoading) {
            return const Center(
              child: RefreshProgressIndicator(
                backgroundColor: AppColors.primaryWhiteColor,
                color: AppColors.secondaryColor,
              ),
            );
          }
          if (state is TermsAndConditionLoaded) {
            return SingleChildScrollView(
              child: Html(
                  // data: state.termsAndConditionResponse.data.pageContent
                  data: state.termsAndConditionResponse != null
                      ? (context.read<LanguageBloc>().state.selectedLanguage ==
                              Language.english
                          ? state.termsAndConditionResponse.data.pageContent
                          : state
                              .termsAndConditionResponse.data.pageContentArabic)
                      : ""),
            );
          }
          return Center(child: Text(AppLocalizations.of(context)!.nodatashow)
              // Text("No Data to show"),
              );
        },
      ),
    );
  }
}
