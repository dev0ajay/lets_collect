import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_month_picker/flutter_custom_month_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_collect/language.dart';
import 'package:lets_collect/src/bloc/filter_bloc/filter_bloc.dart';
import 'package:lets_collect/src/bloc/language/language_bloc.dart';
import 'package:lets_collect/src/bloc/point_tracker_bloc/point_tracker_bloc.dart';
import 'package:lets_collect/src/constants/assets.dart';
import 'package:lets_collect/src/constants/colors.dart';
import 'package:lets_collect/src/model/point_tracker/point_tracker_request.dart';
import 'package:lets_collect/src/ui/profile/widgets/point_tracker_chart.dart';
import 'package:lets_collect/src/ui/reward/components/widgets/custome_rounded_button.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PointTrackerScreen extends StatefulWidget {
  const PointTrackerScreen({super.key});

  @override
  State<PointTrackerScreen> createState() => _PointTrackerScreenState();
}

class _PointTrackerScreenState extends State<PointTrackerScreen> {
  TextEditingController _pointMonthController = TextEditingController();
  TextEditingController _pointYearController = TextEditingController();

  void showMonthPickerDialog(BuildContext context,
      TextEditingController monthController, yearController) {
    showMonthPicker(
      context,
      onSelected: (int month, int year) {
        if (kDebugMode) {
          print('Selected month: $month, year: $year');
        }
        setState(() {
          _pointMonthController.text = month.toString();
          _pointYearController.text = year.toString();
        });
      },
      initialSelectedMonth:
          int.tryParse(_pointMonthController.text) ?? DateTime.now().month,
      initialSelectedYear:
          int.tryParse(_pointYearController.text) ?? DateTime.now().year,
      firstEnabledMonth: 3,
      lastEnabledMonth: 10,
      firstYear: 2000,
      lastYear: 2025,
      selectButtonText: AppLocalizations.of(context)!.ok,
      // selectButtonText: 'OK',
      cancelButtonText: AppLocalizations.of(context)!.cancel,
      // cancelButtonText: 'Cancel',
      highlightColor: AppColors.secondaryColor,
      textColor: AppColors.primaryBlackColor,
      contentBackgroundColor: AppColors.primaryWhiteColor,
      dialogBackgroundColor: AppColors.primaryGrayColor,
    );
  }

  List<String> selectedSortVariants = <String>[];
  String selectedSortFilter = "";
  String sortQuery = "";
  bool isSuperMarketFilterTileSelected = false;
  bool isMonthFilterTileSelected = false;
  String selectedSuperMarketFilters = "";
  String selectedMonthAndYearFilters = "";
  List<String> selectedSuperMarketVariants = <String>[];
  List<String> selectedMonthAndYearVariants = <String>[];

  List<String> sort = <String>[
    "Recent",
    "Expiry First",
  ];

  List<String> sort_ar = <String>[
    "الأحدث",
    "الانتهاء أولا",
  ];

  @override
  void initState() {
    super.initState();
    _pointMonthController = TextEditingController();
    _pointYearController = TextEditingController();
    BlocProvider.of<FilterBloc>(context).add(GetFilterList());
    BlocProvider.of<PointTrackerBloc>(context).add(GetPointTrackerEvent(
        pointTrackerRequest: PointTrackerRequest(
            sort: '', superMarketId: '', month: '', year: '')));
  }

  @override
  void dispose() {
    _pointMonthController.dispose();
    _pointYearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryWhiteColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 190.0,
            floating: false,
            pinned: true,
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios_rounded,
                color: AppColors.primaryWhiteColor,
                size: 20,
              ),
            ),
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.primaryColor,
            title: Text(
              AppLocalizations.of(context)!.pointtracker,
              // "Point Tracker",
              style: GoogleFonts.openSans(
                color: AppColors.primaryWhiteColor,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            flexibleSpace: const FlexibleSpaceBar(
              background: Padding(
                padding: EdgeInsets.only(top: 35.0),
                child: Image(
                  // fit: BoxFit.contain,
                  image: AssetImage("assets/png_icons/point.png"),
                  width: 80,
                  height: 80,
                ),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(55),
              child: BlocBuilder<PointTrackerBloc, PointTrackerState>(
                builder: (context, state) {
                  if (state is PointTrackerLoaded) {
                    return Container(
                        padding: const EdgeInsets.only(top: 10, bottom: 5),
                        height: 55,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: AppColors.primaryWhiteColor,
                          border: Border.all(
                              color: AppColors.primaryWhiteColor, width: 0),
                        ),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state
                              .pointTrackerRequestResponse.brandPoints.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin:
                                  const EdgeInsets.only(left: 15, right: 15),
                              height: MediaQuery.of(context).size.height,
                              padding: const EdgeInsets.only(
                                  top: 2, bottom: 2, left: 25, right: 25),
                              decoration: BoxDecoration(
                                border: const Border(
                                  bottom: BorderSide(
                                      width: 1, color: AppColors.borderColor),
                                  top: BorderSide(
                                      width: 1, color: AppColors.borderColor),
                                  left: BorderSide(
                                      width: 1, color: AppColors.borderColor),
                                  right: BorderSide(
                                      width: 1, color: AppColors.borderColor),
                                ),
                                color: AppColors.primaryWhiteColor,
                                boxShadow: const [
                                  BoxShadow(
                                    color: AppColors.boxShadow,
                                    blurRadius: 4,
                                    offset: Offset(4, 2),
                                    spreadRadius: 0,
                                  ),
                                  BoxShadow(
                                    color: AppColors.boxShadow,
                                    blurRadius: 4,
                                    offset: Offset(-4, -2),
                                    spreadRadius: 0,
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(5),
                              ),
                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      // state.pointTrackerRequestResponse.brandPoints[index].brandName,
                                      context
                                                  .read<LanguageBloc>()
                                                  .state
                                                  .selectedLanguage ==
                                              Language.english
                                          ? state.pointTrackerRequestResponse
                                              .brandPoints[index].brandName
                                          : state
                                              .pointTrackerRequestResponse
                                              .brandPoints[index]
                                              .brandNameArabic,
                                      style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        color: AppColors.primaryBlackColor,
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 2,
                                    child: Text(
                                      state.pointTrackerRequestResponse
                                          .brandPoints[index].points
                                          .toString(),
                                      style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        color: AppColors.secondaryButtonColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ));
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
          ),
          SliverPadding(
            sliver: SliverToBoxAdapter(
              child: BlocBuilder<PointTrackerBloc, PointTrackerState>(
                builder: (context, state) {
                  if (state is PointTrackerLoading) {
                    return const Center(
                      heightFactor: 10,
                      child: RefreshProgressIndicator(
                        color: AppColors.secondaryColor,
                      ),
                    );
                  } else if (state is PointTrackerLoaded) {
                    print("PointTrackerLoaded state open");
                    return Column(
                      children: [
                        const SizedBox(height: 15),
                        const Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: PointTrackerChart(),
                        ),
                        const SizedBox(height: 15),
                        state.pointTrackerRequestResponse.data.isEmpty
                            ? const SizedBox()
                            : Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 15),
                                child: Row(
                                  children: [
                                    /// sort
                                    Flexible(
                                      flex: 1,
                                      child: GestureDetector(
                                        onTap: () {
                                          showModalBottomSheet(
                                              context: context,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(20.0),
                                                  topRight:
                                                      Radius.circular(20.0),
                                                ),
                                              ),
                                              backgroundColor:
                                                  AppColors.primaryWhiteColor,
                                              barrierColor: Colors.black38,
                                              elevation: 2,
                                              isScrollControlled: true,
                                              isDismissible: true,
                                              builder: (BuildContext bc) {
                                                return StatefulBuilder(
                                                  builder:
                                                      (BuildContext context,
                                                          setState) {
                                                    void clearFilter() {
                                                      setState(() {
                                                        selectedSortVariants =
                                                            <String>[];
                                                      });
                                                    }

                                                    // filterWidgets.clear();
                                                    return Stack(
                                                      children: [
                                                        SizedBox(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height /
                                                              3,
                                                          child:
                                                              SingleChildScrollView(
                                                            child: Column(
                                                              children: [
                                                                const SizedBox(
                                                                    height: 60),
                                                                Column(
                                                                  children: List
                                                                      .generate(
                                                                    sort.length,
                                                                    (index) =>
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .symmetric(
                                                                          horizontal:
                                                                              8,
                                                                          vertical:
                                                                              6),
                                                                      child:
                                                                          Container(
                                                                        padding: const EdgeInsets
                                                                            .symmetric(
                                                                            horizontal:
                                                                                10,
                                                                            vertical:
                                                                                6),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children: <Widget>[
                                                                            Text(
                                                                              context.read<LanguageBloc>().state.selectedLanguage == Language.english ? sort[index] : sort_ar[index],
                                                                              softWrap: true,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                                                                    fontSize: 15,
                                                                                  ),
                                                                            ),
                                                                            selectedSortVariants.contains(sort[index])
                                                                                ? InkWell(
                                                                                    onTap: () {
                                                                                      setState(() {
                                                                                        selectedSortVariants.remove(sort[index]);
                                                                                      });
                                                                                    },
                                                                                    child: const CustomRoundedButton(enabled: true),
                                                                                  )
                                                                                : InkWell(
                                                                                    onTap: () {
                                                                                      setState(() {
                                                                                        selectedSortVariants.add(sort[index]);
                                                                                        if (selectedSortVariants.length > 1) {
                                                                                          selectedSortVariants.removeAt(0);
                                                                                        }
                                                                                        selectedSortFilter = selectedSortVariants[0];
                                                                                        if (selectedSortFilter == "Recent") {
                                                                                          sortQuery = "recent";
                                                                                        }
                                                                                        if (selectedSortFilter == "Expiry First") {
                                                                                          sortQuery = "expire_first";
                                                                                        }
                                                                                      });
                                                                                    },
                                                                                    child: const CustomRoundedButton(
                                                                                      enabled: false,
                                                                                    ),
                                                                                  ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    height: 80),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          bottom: 0,
                                                          right: 0,
                                                          left: 0,
                                                          child: SafeArea(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 20,
                                                                      right: 20,
                                                                      bottom:
                                                                          10),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      clearFilter();
                                                                      BlocProvider.of<PointTrackerBloc>(
                                                                              context)
                                                                          .add(
                                                                        GetPointTrackerEvent(
                                                                          pointTrackerRequest:
                                                                              PointTrackerRequest(
                                                                            sort:
                                                                                '',
                                                                            superMarketId:
                                                                                '',
                                                                            month:
                                                                                '',
                                                                            year:
                                                                                '',
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                    child: Text(
                                                                      AppLocalizations.of(
                                                                              context)!
                                                                          .clearall,
                                                                      // "Clear All",
                                                                      style: GoogleFonts
                                                                          .roboto(
                                                                        color: AppColors
                                                                            .primaryColor,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        fontSize:
                                                                            14,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  ElevatedButton(
                                                                    style: ElevatedButton
                                                                        .styleFrom(
                                                                      fixedSize:
                                                                          const Size(
                                                                              100,
                                                                              40),
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(8),
                                                                      ),
                                                                      backgroundColor:
                                                                          AppColors
                                                                              .secondaryColor,
                                                                    ),
                                                                    onPressed:
                                                                        () async {
                                                                      print(
                                                                          selectedSortFilter);

                                                                      BlocProvider.of<PointTrackerBloc>(
                                                                              context)
                                                                          .add(
                                                                        GetPointTrackerEvent(
                                                                          pointTrackerRequest:
                                                                              PointTrackerRequest(
                                                                            sort:
                                                                                sortQuery,
                                                                            superMarketId:
                                                                                '',
                                                                            month:
                                                                                '',
                                                                            year:
                                                                                '',
                                                                          ),
                                                                        ),
                                                                      );
                                                                      context
                                                                          .pop();
                                                                    },
                                                                    child: Text(
                                                                      AppLocalizations.of(
                                                                              context)!
                                                                          .apply,
                                                                      // "Apply",
                                                                      style: GoogleFonts
                                                                          .roboto(
                                                                        color: AppColors
                                                                            .primaryWhiteColor,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        fontSize:
                                                                            14,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          top: 0,
                                                          left: 0,
                                                          right: 0,
                                                          // bottom: 20,
                                                          child: SafeArea(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          15),
                                                              child: Column(
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                        AppLocalizations.of(context)!
                                                                            .sortby,
                                                                        // "Sort by",
                                                                        style: GoogleFonts
                                                                            .roboto(
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                          color:
                                                                              AppColors.primaryGrayColor,
                                                                        ),
                                                                      ),
                                                                      IconButton(
                                                                        onPressed:
                                                                            () {
                                                                          context
                                                                              .pop();
                                                                        },
                                                                        icon:
                                                                            const Icon(
                                                                          Icons
                                                                              .close,
                                                                          color:
                                                                              AppColors.primaryGrayColor,
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  const Divider(
                                                                      color: AppColors
                                                                          .primaryGrayColor),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              });
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.only(
                                              left: 8, right: 8),
                                          height: 20,
                                          width: 68,
                                          decoration: BoxDecoration(
                                            color: AppColors.primaryWhiteColor,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: AppColors.boxShadow,
                                                blurRadius: 4,
                                                offset: Offset(4, 2),
                                                spreadRadius: 0,
                                              ),
                                              BoxShadow(
                                                color: AppColors.boxShadow,
                                                blurRadius: 4,
                                                offset: Offset(-4, -2),
                                                spreadRadius: 0,
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)!
                                                    .sort,
                                                // "Sort",
                                                style: const TextStyle(
                                                  color:
                                                      AppColors.iconGreyColor,
                                                  fontSize: 13,
                                                ),
                                              ),
                                              SvgPicture.asset(
                                                Assets.SORT_SVG,
                                                height: 10,
                                                width: 10,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 15),

                                    /// filter
                                    Flexible(
                                      flex: 1,
                                      child: GestureDetector(
                                        onTap: () {
                                          print("filter tapped");
                                          showModalBottomSheet(
                                              context: context,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(20.0),
                                                  topRight:
                                                      Radius.circular(20.0),
                                                ),
                                              ),
                                              backgroundColor:
                                                  AppColors.primaryWhiteColor,
                                              barrierColor: Colors.black38,
                                              elevation: 2,
                                              isScrollControlled: true,
                                              isDismissible: true,
                                              builder: (BuildContext bc) {
                                                return StatefulBuilder(
                                                  builder:
                                                      (BuildContext context,
                                                          setState) {
                                                    void clearFilter() {
                                                      setState(() {
                                                        _pointMonthController
                                                            .clear();
                                                        _pointYearController
                                                            .clear();
                                                        selectedSuperMarketVariants =
                                                            <String>[];
                                                        selectedMonthAndYearVariants =
                                                            <String>[];
                                                        selectedSuperMarketFilters =
                                                            "";
                                                      });
                                                    }

                                                    return BlocBuilder<
                                                        FilterBloc,
                                                        FilterState>(
                                                      builder:
                                                          (context, state) {
                                                        if (state
                                                            is SupermarketFilterLoading) {
                                                          return Center(
                                                            child: Lottie.asset(
                                                                Assets
                                                                    .JUMBINGDOT,
                                                                height: 100,
                                                                width: 100),
                                                          );
                                                        }
                                                        if (state
                                                            is SupermarketFilterLoaded) {
                                                          return Stack(
                                                            children: [
                                                              SizedBox(
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height /
                                                                    1.6,
                                                                child:
                                                                    SingleChildScrollView(
                                                                  child: Column(
                                                                    children: [
                                                                      const SizedBox(
                                                                          height:
                                                                              60),
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            isSuperMarketFilterTileSelected =
                                                                                !isSuperMarketFilterTileSelected;
                                                                          });
                                                                        },
                                                                        child:
                                                                            ListTile(
                                                                          trailing: !isSuperMarketFilterTileSelected == true
                                                                              ? const ImageIcon(
                                                                                  color: AppColors.secondaryColor,
                                                                                  AssetImage(Assets.SIDE_ARROW),
                                                                                )
                                                                              : const ImageIcon(
                                                                                  color: AppColors.secondaryColor,
                                                                                  AssetImage(Assets.DOWN_ARROW),
                                                                                ),
                                                                          title:
                                                                              Text(AppLocalizations.of(context)!.supermarket),
                                                                          // Text("SuperMarket"),
                                                                        ),
                                                                      ),
                                                                      isSuperMarketFilterTileSelected ==
                                                                              true
                                                                          ? SingleChildScrollView(
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.only(right: 15, left: 15, bottom: 5, top: 5),
                                                                                child: Column(
                                                                                  children: List.generate(
                                                                                    state.superMarketListResponse.data!.length,
                                                                                    (index) => Padding(
                                                                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                                                                      child: Container(
                                                                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                                                                        child: Row(
                                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          children: <Widget>[
                                                                                            Text(
                                                                                              context.read<LanguageBloc>().state.selectedLanguage == Language.english ? state.superMarketListResponse.data![index].supermarketName.toString() : state.superMarketListResponse.data![index].supermarketName.toString(),
                                                                                              softWrap: true,
                                                                                              overflow: TextOverflow.ellipsis,
                                                                                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                                                                                    fontSize: 15,
                                                                                                  ),
                                                                                            ),
                                                                                            selectedSuperMarketVariants.contains(state.superMarketListResponse.data![index].id.toString())
                                                                                                ? InkWell(
                                                                                                    onTap: () {
                                                                                                      setState(() {
                                                                                                        selectedSuperMarketVariants.remove(state.superMarketListResponse.data![index].id.toString());
                                                                                                        selectedSuperMarketFilters = "";
                                                                                                      });
                                                                                                    },
                                                                                                    child: Container(
                                                                                                      height: 20,
                                                                                                      width: 20,
                                                                                                      decoration: const BoxDecoration(
                                                                                                        shape: BoxShape.rectangle,
                                                                                                        image: DecorationImage(
                                                                                                          image: AssetImage(Assets.DISABLED_TICK),
                                                                                                          fit: BoxFit.contain,
                                                                                                          scale: 6,
                                                                                                        ),
                                                                                                        color: AppColors.secondaryColor,
                                                                                                        boxShadow: [
                                                                                                          BoxShadow(blurRadius: 1.5, color: Colors.black38, offset: Offset(0, 1))
                                                                                                        ],
                                                                                                      ),
                                                                                                    ),
                                                                                                  )
                                                                                                : InkWell(
                                                                                                    onTap: () {
                                                                                                      setState(() {
                                                                                                        selectedSuperMarketVariants.add(state.superMarketListResponse.data![index].id.toString());
                                                                                                        if (selectedSuperMarketVariants.length > 1) {
                                                                                                          selectedSuperMarketVariants.removeAt(0);
                                                                                                        }
                                                                                                        selectedSuperMarketFilters = selectedSuperMarketVariants[0].toString();
                                                                                                      });
                                                                                                    },
                                                                                                    child: Container(
                                                                                                      height: 20,
                                                                                                      width: 20,
                                                                                                      decoration: const BoxDecoration(
                                                                                                        shape: BoxShape.rectangle,
                                                                                                        color: AppColors.primaryWhiteColor,
                                                                                                        boxShadow: [
                                                                                                          BoxShadow(
                                                                                                            blurRadius: 1.5,
                                                                                                            color: Colors.black38,
                                                                                                            offset: Offset(0, 1),
                                                                                                          ),
                                                                                                        ],
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            )
                                                                          : const SizedBox(),
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            isMonthFilterTileSelected =
                                                                                !isMonthFilterTileSelected;
                                                                          });
                                                                        },
                                                                        child:
                                                                            ListTile(
                                                                          trailing: !isMonthFilterTileSelected == true
                                                                              ? const ImageIcon(
                                                                                  color: AppColors.secondaryColor,
                                                                                  AssetImage(Assets.SIDE_ARROW),
                                                                                )
                                                                              : const ImageIcon(
                                                                                  color: AppColors.secondaryColor,
                                                                                  AssetImage(Assets.DOWN_ARROW),
                                                                                ),
                                                                          title:
                                                                              Text(AppLocalizations.of(context)!.monthandyear),
                                                                          // Text("Month and Year"),
                                                                        ),
                                                                      ),
                                                                      isMonthFilterTileSelected ==
                                                                              true
                                                                          ? SingleChildScrollView(
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.only(right: 15, left: 15, bottom: 5, top: 5),
                                                                                child: Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  children: [
                                                                                    Flexible(child: Text(AppLocalizations.of(context)!.month)),
                                                                                    Flexible(
                                                                                      child: SizedBox(
                                                                                        width: 50,
                                                                                        child: TextField(
                                                                                          readOnly: true,
                                                                                          controller: _pointMonthController,
                                                                                          keyboardType: TextInputType.number,
                                                                                          textAlign: TextAlign.center,
                                                                                          onChanged: (value) {
                                                                                            // Add any validation or formatting if needed
                                                                                          },
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    // const SizedBox(width: 20),
                                                                                    Flexible(child: Text(AppLocalizations.of(context)!.year)),
                                                                                    // const Text('Year: '),
                                                                                    Flexible(
                                                                                      child: SizedBox(
                                                                                        width: 70,
                                                                                        child: TextField(
                                                                                          readOnly: true,
                                                                                          controller: _pointYearController,
                                                                                          keyboardType: TextInputType.number,
                                                                                          textAlign: TextAlign.center,
                                                                                          onChanged: (value) {
                                                                                            // Add any validation or formatting if needed
                                                                                          },
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    // const SizedBox(width: 100),
                                                                                    Flexible(
                                                                                      child: GestureDetector(
                                                                                        onTap: () {
                                                                                          showMonthPickerDialog(context, _pointMonthController, _pointYearController);
                                                                                        },
                                                                                        child: const ImageIcon(
                                                                                          AssetImage(Assets.CALENDER),
                                                                                          color: AppColors.secondaryColor,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            )
                                                                          : const SizedBox(),
                                                                      const SizedBox(
                                                                          height:
                                                                              80),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              Positioned(
                                                                bottom: 0,
                                                                right: 0,
                                                                left: 0,
                                                                child: SafeArea(
                                                                  child:
                                                                      Container(
                                                                    decoration:
                                                                        const BoxDecoration(
                                                                      color: AppColors
                                                                          .primaryWhiteColor,
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                          color:
                                                                              AppColors.boxShadow,
                                                                          blurRadius:
                                                                              4,
                                                                          offset: Offset(
                                                                              4,
                                                                              2),
                                                                          spreadRadius:
                                                                              0,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              20,
                                                                          right:
                                                                              20,
                                                                          bottom:
                                                                              10),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          TextButton(
                                                                            onPressed:
                                                                                () {
                                                                              clearFilter();
                                                                            },
                                                                            child:
                                                                                Text(
                                                                              AppLocalizations.of(context)!.clearall,
                                                                              // "Clear All",
                                                                              style: GoogleFonts.roboto(
                                                                                color: AppColors.underlineColor,
                                                                                fontWeight: FontWeight.w400,
                                                                                fontSize: 14,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          ElevatedButton(
                                                                            style:
                                                                                ElevatedButton.styleFrom(
                                                                              fixedSize: const Size(100, 40),
                                                                              shape: RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius.circular(8),
                                                                              ),
                                                                              backgroundColor: AppColors.secondaryColor,
                                                                            ),
                                                                            onPressed:
                                                                                () {
                                                                              print("Selected SuperMarket: $selectedSuperMarketFilters");
                                                                              print("Selected Month: $selectedMonthAndYearFilters");
                                                                              BlocProvider.of<PointTrackerBloc>(context).add(
                                                                                GetPointTrackerEvent(
                                                                                  pointTrackerRequest: PointTrackerRequest(
                                                                                    sort: "",
                                                                                    superMarketId: selectedSuperMarketFilters.isEmpty ? "" : selectedSuperMarketFilters,
                                                                                    month: _pointMonthController.text,
                                                                                    year: _pointYearController.text,
                                                                                  ),
                                                                                ),
                                                                              );
                                                                              context.pop();
                                                                            },
                                                                            child:
                                                                                Text(
                                                                              AppLocalizations.of(context)!.apply,
                                                                              // "Apply",
                                                                              style: GoogleFonts.roboto(
                                                                                color: AppColors.primaryWhiteColor,
                                                                                fontWeight: FontWeight.w400,
                                                                                fontSize: 14,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Positioned(
                                                                top: 0,
                                                                left: 0,
                                                                right: 0,
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    color: AppColors
                                                                        .primaryWhiteColor,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .only(
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              20.0),
                                                                      topRight:
                                                                          Radius.circular(
                                                                              20.0),
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                            15),
                                                                    child:
                                                                        Container(
                                                                      // height: 40,
                                                                      color: Colors
                                                                          .white,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              Text(
                                                                                AppLocalizations.of(context)!.filterby,
                                                                                // "Filter by",
                                                                                style: GoogleFonts.roboto(
                                                                                  fontSize: 16,
                                                                                  fontWeight: FontWeight.w400,
                                                                                  color: AppColors.primaryGrayColor,
                                                                                ),
                                                                              ),
                                                                              IconButton(
                                                                                onPressed: () {
                                                                                  context.pop();
                                                                                },
                                                                                icon: const Icon(
                                                                                  Icons.close,
                                                                                  color: AppColors.primaryGrayColor,
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ),
                                                                          const Divider(
                                                                              color: AppColors.primaryGrayColor),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          );
                                                        } else {
                                                          return Lottie.asset(
                                                              Assets.OOPS);
                                                        }
                                                      },
                                                    );
                                                  },
                                                );
                                              });
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.only(
                                              left: 8, right: 8),
                                          height: 20,
                                          width: 68,
                                          decoration: BoxDecoration(
                                            color: AppColors.primaryWhiteColor,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: AppColors.boxShadow,
                                                blurRadius: 4,
                                                offset: Offset(4, 2),
                                                spreadRadius: 0,
                                              ),
                                              BoxShadow(
                                                color: AppColors.boxShadow,
                                                blurRadius: 4,
                                                offset: Offset(-4, -2),
                                                spreadRadius: 0,
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)!
                                                    .filter,
                                                // "Filter",
                                                style: const TextStyle(
                                                  color:
                                                      AppColors.iconGreyColor,
                                                  fontSize: 13,
                                                ),
                                              ),
                                              SvgPicture.asset(
                                                Assets.FILTER_SVG,
                                                height: 10,
                                                width: 10,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Spacer(flex: 1),
                                  ],
                                )),
                        const SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            children: [
                              Text(
                                // "Transaction log",
                                AppLocalizations.of(context)!.transactionlog,
                                style: GoogleFonts.openSans(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        state is PointTrackerLoaded
                            ? state.pointTrackerRequestResponse.data.isNotEmpty
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: state.pointTrackerRequestResponse
                                        .data.length,
                                    padding: const EdgeInsets.only(
                                        bottom: 120, top: 10),
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return GestureDetector(
                                        onTap: () {
                                          context.push("/point_tracker_details",
                                              extra: state
                                                  .pointTrackerRequestResponse
                                                  .data[index]
                                                  .id);
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          margin: const EdgeInsets.only(
                                              left: 5,
                                              right: 5,
                                              bottom: 10,
                                              top: 10),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            boxShadow: const [
                                              BoxShadow(
                                                color: AppColors.boxShadow,
                                                blurRadius: 4,
                                                offset: Offset(4, 2),
                                                spreadRadius: 0,
                                              ),
                                              BoxShadow(
                                                color: AppColors.boxShadow,
                                                blurRadius: 4,
                                                offset: Offset(-4, -2),
                                                spreadRadius: 0,
                                              ),
                                            ],
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20, horizontal: 16),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      // "${state.pointTrackerRequestResponse.data[index].totalPoints} "
                                                      // "points",
                                                      "${state.pointTrackerRequestResponse.data[index].totalPoints} "
                                                      "${AppLocalizations.of(context)!.points}",
                                                      style: GoogleFonts.roboto(
                                                        fontSize: 19,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    const Divider(
                                                      color: Colors.transparent,
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      state
                                                          .pointTrackerRequestResponse
                                                          .data[index]
                                                          .expiryDate,
                                                      style: GoogleFonts.roboto(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const Icon(
                                                  Icons
                                                      .arrow_forward_ios_rounded,
                                                  size: 15,
                                                  color:
                                                      AppColors.secondaryColor,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                : Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Lottie.asset(Assets.OOPS,
                                            width: 300, height: 310),
                                      ],
                                    ),
                                  )
                            : const SizedBox(),
                      ],
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
            padding: const EdgeInsets.only(left: 15, right: 15),
          ),
        ],
      ),
    );
  }
}
