import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_month_picker/flutter_custom_month_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_collect/language.dart';
import 'package:lets_collect/src/bloc/language/language_bloc.dart';
import 'package:lets_collect/src/constants/assets.dart';
import 'package:lets_collect/src/constants/colors.dart';
import 'package:lets_collect/src/model/purchase_history/purchase_history_request.dart';
import 'package:lottie/lottie.dart';
import '../../../bloc/filter_bloc/filter_bloc.dart';
import '../../../bloc/purchase_history_bloc/purchase_history_bloc.dart';
import '../../../model/purchase_history/purchase_history_response.dart';
import '../../reward/components/widgets/custome_rounded_button.dart';
import '../widgets/purchase_history_bar_chart_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PurchaseHistoryScreen extends StatefulWidget {
  const PurchaseHistoryScreen({super.key});

  @override
  State<PurchaseHistoryScreen> createState() => _PurchaseHistoryScreenState();
}

class _PurchaseHistoryScreenState extends State<PurchaseHistoryScreen> {
  TextEditingController _purchaseMonthController = TextEditingController();
  TextEditingController _purchaseYearController = TextEditingController();

  void showMonthPickerDialog(BuildContext context,
      TextEditingController monthController, yearController) {
    showMonthPicker(
      context,
      onSelected: (int month, int year) {
        if (kDebugMode) {
          print('Selected month: $month, year: $year');
        }
        setState(() {
          _purchaseMonthController.text = month.toString();
          _purchaseYearController.text = year.toString();
        });
      },
      initialSelectedMonth:
          int.tryParse(_purchaseMonthController.text) ?? DateTime.now().month,
      initialSelectedYear:
          int.tryParse(_purchaseYearController.text) ?? DateTime.now().year,
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
      dialogBackgroundColor: AppColors.primaryColor,
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
  late String totalAmount = "0";
  Map<String, dynamic> dateAmountMap = {};

  List<String> sort = <String>[
    "Recent",
  ];
  List<String> sort_ar = <String>[
    "الأحدث",
  ];

  List<PurchaseData> purchaseList = [];

  void checkSameDate(PurchaseHistoryResponse jsonData) {
    for (int i = 0; i < jsonData.data.length; i++) {
      String currentDate = jsonData.data[i].receiptDate.toString();

      for (int j = i + 1; j < jsonData.data.length; j++) {
        if (currentDate == jsonData.data[j].receiptDate) {
          totalAmount =
              (jsonData.data[i].totalAmount + jsonData.data[j].totalAmount);
          print(
              "Date ${jsonData.data[j].receiptDate} found at indexes $i and $j");
          print("Total amount: $totalAmount of indexes $i and $j");
          // You can do further processing here if needed
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _purchaseMonthController = TextEditingController();
    _purchaseYearController = TextEditingController();
    BlocProvider.of<FilterBloc>(context).add(GetFilterList());
    BlocProvider.of<PurchaseHistoryBloc>(context).add(
      GetPurchaseHistory(
        purchaseHistoryRequest: PurchaseHistoryRequest(
            sort: '', supermarketId: '', month: '', year: '', page: '1'),
      ),
    );
  }

  @override
  void dispose() {
    _purchaseMonthController.dispose();
    _purchaseYearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverAppBar(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
            ),
            expandedHeight: 80.0,
            floating: false,
            pinned: true,
            leading: GestureDetector(
              onTap: () {
                context.pop();
              },
              child: const Padding(
                padding: EdgeInsets.only(top: 15.0),
                child: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: AppColors.primaryWhiteColor,
                  size: 20,
                ),
              ),
            ),
            backgroundColor: AppColors.primaryColor,
            title: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text(
                // "Purchase history",
                AppLocalizations.of(context)!.purchasehistory,
                style: GoogleFonts.openSans(
                  color: AppColors.primaryWhiteColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SliverPadding(
            sliver: SliverToBoxAdapter(
              child: BlocBuilder<PurchaseHistoryBloc, PurchaseHistoryState>(
                builder: (context, state) {
                  if (state is PurchaseHistoryLoading) {
                    print('PurchaseHistoryLoading state detected');
                    return const Center(
                      heightFactor: 12,
                      child: RefreshProgressIndicator(
                        color: AppColors.secondaryColor,
                        backgroundColor: AppColors.primaryWhiteColor,
                      ),
                    );
                  }
                  if (state is PurchaseHistoryLoaded) {
                    return Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 0),
                            child: PurchaseHistoryBarChartWidget(),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        state.purchaseHistoryResponse.data.isEmpty
                            ? const SizedBox()
                            : Padding(
                                padding: const EdgeInsets.only(left: 15.0),
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
                                                                            selectedSortVariants.contains(
                                                                              context.read<LanguageBloc>().state.selectedLanguage == Language.english ? sort[index] : sort_ar[index],
                                                                            )
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
                                                                      context
                                                                          .pop();
                                                                      BlocProvider.of<PurchaseHistoryBloc>(
                                                                              context)
                                                                          .add(
                                                                        GetPurchaseHistory(
                                                                          purchaseHistoryRequest:
                                                                              PurchaseHistoryRequest(
                                                                            sort:
                                                                                '',
                                                                            supermarketId:
                                                                                '',
                                                                            month:
                                                                                '',
                                                                            year:
                                                                                '',
                                                                            page:
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

                                                                      BlocProvider.of<PurchaseHistoryBloc>(
                                                                              context)
                                                                          .add(
                                                                        GetPurchaseHistory(
                                                                          purchaseHistoryRequest:
                                                                              PurchaseHistoryRequest(
                                                                            sort:
                                                                                sortQuery,
                                                                            month:
                                                                                '',
                                                                            year:
                                                                                '',
                                                                            supermarketId:
                                                                                '',
                                                                            page:
                                                                                '',
                                                                          ),
                                                                        ),
                                                                      );
                                                                      context
                                                                          .pop();
                                                                    },
                                                                    child: Text(
                                                                      // "Apply",
                                                                      AppLocalizations.of(
                                                                              context)!
                                                                          .apply,
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
                                                        _purchaseMonthController
                                                            .clear();
                                                        _purchaseYearController
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
                                                                        child: ListTile(
                                                                            trailing: !isSuperMarketFilterTileSelected == true
                                                                                ? const ImageIcon(
                                                                                    color: AppColors.secondaryColor,
                                                                                    AssetImage(Assets.SIDE_ARROW),
                                                                                  )
                                                                                : const ImageIcon(
                                                                                    color: AppColors.secondaryColor,
                                                                                    AssetImage(Assets.DOWN_ARROW),
                                                                                  ),
                                                                            title: Text(AppLocalizations.of(context)!.supermarket)
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
                                                                                                          BoxShadow(blurRadius: 1.5, color: Colors.black38, offset: Offset(0, 1))
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
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                  children: [
                                                                                    Flexible(child: Text(AppLocalizations.of(context)!.month)),
                                                                                    // Text('Month: '),
                                                                                    Flexible(
                                                                                      child: SizedBox(
                                                                                        width: 50,
                                                                                        child: TextField(
                                                                                          readOnly: true,
                                                                                          controller: _purchaseMonthController,
                                                                                          keyboardType: TextInputType.number,
                                                                                          textAlign: TextAlign.center,
                                                                                          onChanged: (value) {
                                                                                            // Add any validation or formatting if needed
                                                                                          },
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    // const SizedBox(width: 20),
                                                                                    Flexible(child: Text(AppLocalizations.of(context)!.monthandyear)),
                                                                                    // const Text('Year: '),
                                                                                    Flexible(
                                                                                      child: SizedBox(
                                                                                        width: 70,
                                                                                        child: TextField(
                                                                                          readOnly: true,
                                                                                          controller: _purchaseYearController,
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
                                                                                            showMonthPickerDialog(context, _purchaseMonthController, _purchaseYearController);
                                                                                          },
                                                                                          child: const ImageIcon(
                                                                                            AssetImage(Assets.CALENDER),
                                                                                            color: AppColors.secondaryColor,
                                                                                          )),
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
                                                                              BlocProvider.of<PurchaseHistoryBloc>(context).add(
                                                                                GetPurchaseHistory(
                                                                                  purchaseHistoryRequest: PurchaseHistoryRequest(
                                                                                    sort: "",
                                                                                    supermarketId: selectedSuperMarketFilters.isEmpty ? "" : selectedSuperMarketFilters,
                                                                                    month: _purchaseMonthController.text,
                                                                                    year: _purchaseYearController.text,
                                                                                    page: '1',
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
                                                                      color: AppColors
                                                                          .primaryWhiteColor,
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
                                                                                  clearFilter();
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
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            children: [
                              Text(
                                // "Transaction Log",
                                AppLocalizations.of(context)!.transactionlog,
                                style: GoogleFonts.openSans(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        state is PurchaseHistoryLoaded
                            ? state.purchaseHistoryResponse.data.isNotEmpty
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: state
                                        .purchaseHistoryResponse.data.length,
                                    padding: const EdgeInsets.only(
                                        bottom: 120, top: 10),
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return GestureDetector(
                                        onTap: () {
                                          context.push(
                                              '/purchase_history_details',
                                              extra: state
                                                  .purchaseHistoryResponse
                                                  .data[index]
                                                  .receiptId
                                                  .toString());
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          margin: const EdgeInsets.only(
                                              left: 5,
                                              right: 5,
                                              bottom: 10,
                                              top: 10),
                                          decoration: BoxDecoration(
                                              color:
                                                  AppColors.primaryWhiteColor,
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: AppColors.boxShadow,
                                                  blurRadius: 8,
                                                  offset: Offset(4, 2),
                                                  spreadRadius: 0,
                                                ),
                                                BoxShadow(
                                                  color: AppColors.boxShadow,
                                                  blurRadius: 8,
                                                  offset: Offset(-4, -2),
                                                  spreadRadius: 0,
                                                ),
                                              ],
                                              border: Border.all(
                                                  color: AppColors.borderColor,
                                                  width: 1)),
                                          child: ListTile(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                              vertical: 5,
                                              horizontal: 16,
                                            ),
                                            title: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  // state.purchaseHistoryResponse.data[index].supermarketName,
                                                  context
                                                              .read<
                                                                  LanguageBloc>()
                                                              .state
                                                              .selectedLanguage ==
                                                          Language.english
                                                      ? state
                                                          .purchaseHistoryResponse
                                                          .data[index]
                                                          .supermarketName
                                                      : state
                                                          .purchaseHistoryResponse
                                                          .data[index]
                                                          .supermarketName,
                                                  style: GoogleFonts.roboto(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors
                                                        .secondaryButtonColor,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 2,
                                                ),
                                                Text(
                                                  // "Total amount"
                                                  "${AppLocalizations.of(context)!.totalamount} "
                                                  "  ${state.purchaseHistoryResponse.data[index].totalAmount} "
                                                  "${AppLocalizations.of(context)!.bhd} ",
                                                  // "${state.purchaseHistoryResponse.data[index].currencyCode}",
                                                  style: GoogleFonts.roboto(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                const SizedBox(height: 2),
                                                Text(
                                                  state.purchaseHistoryResponse
                                                      .data[index].receiptDate
                                                      .toString(),
                                                  style: GoogleFonts.roboto(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            trailing: const Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              size: 15,
                                              color: AppColors.secondaryColor,
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
                    return const Center(
                      child: SizedBox(),
                    );
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
