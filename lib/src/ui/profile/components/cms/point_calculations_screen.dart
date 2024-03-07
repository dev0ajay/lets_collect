import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_collect/src/bloc/cms_bloc/point_calculations/point_calculations_bloc.dart';
import 'package:lets_collect/src/constants/colors.dart';

class PointCalculationsScreen extends StatefulWidget {
  const PointCalculationsScreen({super.key});

  @override
  State<PointCalculationsScreen> createState() => _PointCalculationsScreenState();
}

class _PointCalculationsScreenState extends State<PointCalculationsScreen> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<PointCalculationsBloc>(context).add(GetPointCalculationsEvent());
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
          "Point Calculations",
          style: GoogleFonts.openSans(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryWhiteColor,
          ),
        ),
      ),
      body: BlocBuilder<PointCalculationsBloc, PointCalculationsState>(
        builder: (context, state) {
          if(state is PointCalculationsLoading) {
            return const Center(
              child: RefreshProgressIndicator(
                backgroundColor: AppColors.secondaryColor,
                color: AppColors.primaryWhiteColor,
              ),
            );
          }
          if(state is PointCalculationsLoaded) {
            return SingleChildScrollView(
              child: Html(data: state.pointCalculationsResponse.data.pageContent),
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
