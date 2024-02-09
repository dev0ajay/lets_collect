import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_collect/src/bloc/cms_bloc/terms_and_condition_bloc.dart';
import 'package:lets_collect/src/resources/api_providers/profile_screen_provider.dart';

import '../../../constants/colors.dart';
import '../../../resources/api_providers/auth_provider.dart';

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
    BlocProvider.of<TermsAndConditionBloc>(context).add(GetTermsAndConditionEvent());

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
      body: BlocBuilder<TermsAndConditionBloc, TermsAndConditionState>(
        builder: (context, state) {
          if(state is TermsAndConditionLoading) {
            return const Center(
              child: RefreshProgressIndicator(
                backgroundColor: AppColors.secondaryColor,
                color: AppColors.primaryWhiteColor,
              ),
            );
          }
         if(state is TermsAndConditionLoaded) {
           return SingleChildScrollView(
             child: Html(data: state.termsAndConditionResponse.data.pageContent),
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
