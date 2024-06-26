import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_collect/src/bloc/search_bloc/search_bloc.dart';
import 'package:lets_collect/src/constants/assets.dart';
import 'package:lets_collect/src/constants/colors.dart';
import 'package:lets_collect/src/model/search/brand/search_brand_request.dart';
import 'package:lets_collect/src/utils/screen_size/size_config.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../model/search/category/search_category_request.dart';
import '../../utils/network_connectivity/bloc/network_bloc.dart';
import 'components/search_screen_arguments.dart';

class SearchDetailsScreen extends StatefulWidget {
  final SearchScreenArguments searchScreenArguments;

  const SearchDetailsScreen({super.key, required this.searchScreenArguments});

  @override
  State<SearchDetailsScreen> createState() => _SearchDetailsScreenState();
}

class _SearchDetailsScreenState extends State<SearchDetailsScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<SearchBloc>(context).add(
      GetBrandEvent(
        searchBrandRequest: SearchBrandRequest(
          departmentId: widget.searchScreenArguments.categoryId,
          searchText: '',
          page: '1',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<SearchBloc>(context).add(
          GetSearchEvent(
            searchCategoryRequest: SearchCategoryRequest(searchText: ''),
          ),
        );
        context.pop();
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.primaryWhiteColor,
        body: BlocConsumer<NetworkBloc, NetworkState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is NetworkFailure) {
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
            }
            if (state is NetworkSuccess) {
              return NestedScrollView(
                floatHeaderSlivers: false,
                physics: const NeverScrollableScrollPhysics(),
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    // SliverAppBar is the header that remains visible while scrolling
                    SliverAppBar(
                      elevation: 0,
                      leading: Padding(
                        padding: const EdgeInsets.only(top: 21),
                        child: IconButton(
                          onPressed: () {
                            BlocProvider.of<SearchBloc>(context).add(
                              GetSearchEvent(
                                searchCategoryRequest:
                                    SearchCategoryRequest(searchText: ''),
                              ),
                            );
                            context.pop();
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: AppColors.primaryWhiteColor,
                          ),
                        ),
                      ),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                        ),
                      ),
                      expandedHeight: getProportionateScreenHeight(140),
                      floating: false,
                      backgroundColor: AppColors.primaryColor,
                      pinned: true,
                      centerTitle: false,
                      title: Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: Text(
                          widget.searchScreenArguments.category,
                          style: GoogleFonts.openSans(
                            color: AppColors.primaryWhiteColor,
                            fontSize: 24,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      flexibleSpace: const FlexibleSpaceBar(
                        // expandedTitleScale: 1,
                        titlePadding: EdgeInsets.zero,
                        collapseMode: CollapseMode.pin,
                        background: NestedScrollBackgroundWidget(),
                      ),
                      bottom: PreferredSize(
                        preferredSize: const Size.fromHeight(70),
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          color: AppColors.primaryWhiteColor,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 9,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: Container(
                                        height: 40,
                                        decoration: BoxDecoration(
                                            boxShadow: const [
                                              BoxShadow(
                                                color: AppColors.boxShadow,
                                                blurRadius: 4,
                                                offset: Offset(4, 2),
                                                spreadRadius: 0,
                                              ),
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                              width: 1,
                                              color: AppColors.borderColor,
                                            )),
                                        child: CupertinoTextField(
                                          controller: _searchController,
                                          placeholder:
                                              AppLocalizations.of(context)!
                                                  .searchbrand,
                                          // placeholder: Strings.SEARCH_DETAIL_HINT,
                                          placeholderStyle: const TextStyle(
                                            color: AppColors.primaryGrayColor,
                                          ),
                                          onSubmitted: (text) {
                                            BlocProvider.of<SearchBloc>(context)
                                                .add(
                                              GetSearchEvent(
                                                searchCategoryRequest:
                                                    SearchCategoryRequest(
                                                  searchText: text.isNotEmpty
                                                      ? _searchController.text
                                                      : "",
                                                ),
                                              ),
                                            );
                                          },
                                          onChanged: (text) {
                                            BlocProvider.of<SearchBloc>(context)
                                                .add(
                                              GetBrandEvent(
                                                searchBrandRequest:
                                                    SearchBrandRequest(
                                                  searchText: text.isNotEmpty
                                                      ? _searchController.text
                                                      : "",
                                                  departmentId: widget
                                                      .searchScreenArguments
                                                      .categoryId,
                                                  page: "1",
                                                ),
                                              ),
                                            );
                                          },
                                          onEditingComplete: () {
                                            BlocProvider.of<SearchBloc>(context)
                                                .add(
                                              GetSearchEvent(
                                                searchCategoryRequest:
                                                    SearchCategoryRequest(
                                                  searchText:
                                                      _searchController.text,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: GestureDetector(
                                    onTap: () {
                                      if (_searchController.text.isNotEmpty) {
                                        BlocProvider.of<SearchBloc>(context)
                                            .add(
                                          GetBrandEvent(
                                            searchBrandRequest:
                                                SearchBrandRequest(
                                              searchText:
                                                  _searchController.text,
                                              departmentId: widget
                                                  .searchScreenArguments
                                                  .categoryId,
                                              page: "1",
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    child: const ImageIcon(
                                      AssetImage(Assets.SEARCH),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ];
                },
                body: BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state) {
                    if (state is BrandErrorState) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 4,
                              child: Lottie.asset(Assets.TRY_AGAIN),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                state.msg,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: AppColors.primaryColor),
                              ),
                            ),
                            // const Spacer(),
                            Flexible(
                              flex: 4,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(9),
                                    ),
                                    fixedSize: const Size(100, 50),
                                    backgroundColor: AppColors.primaryColor),
                                onPressed: () {
                                  BlocProvider.of<SearchBloc>(context).add(
                                    GetBrandEvent(
                                      searchBrandRequest: SearchBrandRequest(
                                        departmentId: widget
                                            .searchScreenArguments.categoryId,
                                        searchText: '',
                                        page: '1',
                                      ),
                                    ),
                                  );
                                },
                                child:  Text(
                                  AppLocalizations.of(context)!.tryagain,
                                  style: const TextStyle(
                                      color: AppColors.primaryWhiteColor),
                                ),
                              ),
                            ),
                            // const Text("state"),
                          ],
                        ),
                      );
                    }
                    if (state is BrandLoading) {
                      return const Center(
                        child: RefreshProgressIndicator(
                          color: AppColors.secondaryColor,
                          backgroundColor: AppColors.primaryWhiteColor,
                        ),
                      );
                    } else if (state is BrandLoaded) {
                      if (state.searchBrandRequestResponse.data!.isEmpty) {
                        return Center(
                          child: Lottie.asset(Assets.OOPS),
                        );
                      }
                      return Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: SizedBox(
                          height: double.maxFinite,
                          width: MediaQuery.of(context).size.width,
                          child: GridView.builder(
                            padding: EdgeInsets.zero,
                            physics: const BouncingScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 20.0,
                              mainAxisSpacing: 15.0,
                            ),
                            itemCount:
                                state.searchBrandRequestResponse.data!.length,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 100.0,
                                width: 300.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: AppColors.primaryWhiteColor,
                                  boxShadow: const [
                                    BoxShadow(
                                      spreadRadius: 0,
                                      blurRadius: 2,
                                      offset: Offset(2, 2),
                                      color: Colors.black38,
                                    )
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      String brandLink = state
                                          .searchBrandRequestResponse
                                          .data![index]
                                          .brandLink!;
                                      if (brandLink.isNotEmpty &&
                                          brandLink.isNotEmpty) {
                                        launchUrl(brandLink);
                                      }
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: CachedNetworkImage(
                                        imageUrl: state
                                            .searchBrandRequestResponse
                                            .data![index]
                                            .brandLogo!,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        fit: BoxFit.contain,
                                        alignment: Alignment.center,
                                        fadeInCurve: Curves.easeIn,
                                        fadeInDuration:
                                            const Duration(milliseconds: 200),
                                        placeholder: (context, url) => SizedBox(
                                          height: 40,
                                          width: 40,
                                          child: Lottie.asset(
                                            Assets.JUMBINGDOT,
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const ImageIcon(
                                          color: AppColors.hintColor,
                                          AssetImage(Assets.NO_IMG),
                                        ),
                                      ),
                                      // Image.network(
                                      //   state.searchBrandRequestResponse.data[index]
                                      //       .brandLogo,
                                      // ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

class NestedScrollBackgroundWidget extends StatelessWidget {
  const NestedScrollBackgroundWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.primaryWhiteColor,
            ),
          ),
        ),
        Container(
          height: getProportionateScreenHeight(130),
          decoration: const BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(5),
              bottomRight: Radius.circular(5),
            ),
          ),
        ),
      ],
    );
  }
}

void launchUrl(String url) async {
  if (!url.startsWith('http://') && !url.startsWith('https://')) {
    url = 'http://$url';
  }

  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
