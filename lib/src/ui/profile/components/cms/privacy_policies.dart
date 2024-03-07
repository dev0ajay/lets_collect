import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_collect/language.dart';
import 'package:lets_collect/src/bloc/cms_bloc/privacy_policies/privacy_policies_bloc.dart';
import 'package:lets_collect/src/bloc/language/language_bloc.dart';

import '../../../../constants/colors.dart';

class PrivacyPoliciesScreen extends StatefulWidget {
  const PrivacyPoliciesScreen({super.key});

  @override
  State<PrivacyPoliciesScreen> createState() => _PrivacyPoliciesScreenState();
}

class _PrivacyPoliciesScreenState extends State<PrivacyPoliciesScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<PrivacyPoliciesBloc>(context).add(GetPrivacyPolicies());

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
        "Privacy policies",
        style: GoogleFonts.openSans(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: AppColors.primaryWhiteColor,
        ),
      ),
    ),
      body: BlocBuilder<PrivacyPoliciesBloc, PrivacyPoliciesState>(
        builder: (context, state) {
          if(state is PrivacyPoliciesLaoding) {
            return const Center(
              child: RefreshProgressIndicator(
                backgroundColor: AppColors.secondaryColor,
                color: AppColors.primaryWhiteColor,
              ),
            );
          }
          if(state is PrivacyPoliciesLoaded) {
            return SingleChildScrollView(
              child: Html(
                  // data: state.privacyPoliciesResponse.data.pageContent
                data: state.privacyPoliciesResponse != null
                    ? (context.read<LanguageBloc>().state.selectedLanguage == Language.english
                    ? state.privacyPoliciesResponse.data.pageContent
                    : state.privacyPoliciesResponse.data.pageContentArabic)
                    : '',
              ),
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
