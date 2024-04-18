import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_collect/language.dart';
import 'package:lets_collect/src/bloc/language/language_bloc.dart';
import 'package:lets_collect/src/bloc/search_bloc/search_bloc.dart';
import 'package:lets_collect/src/model/search/category/search_category_request.dart';
import 'package:lets_collect/src/ui/search/components/search_screen_arguments.dart';
import 'package:lets_collect/src/utils/network_connectivity/bloc/network_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../utils/screen_size/size_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<SearchBloc>(context).add(
      GetSearchEvent(
        searchCategoryRequest: SearchCategoryRequest(searchText: ''),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: AppColors.primaryWhiteColor,
      body: BlocConsumer<NetworkBloc, NetworkState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is NetworkSuccess) {
            return NestedScrollView(
              physics: const NeverScrollableScrollPhysics(),
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  // SliverAppBar is the header that remains visible while scrolling
                  SliverAppBar(
                    elevation: 0,
                    centerTitle: false,
                    leading: const SizedBox(),
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
                    leadingWidth: 0,
                    title: Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Text(
                        AppLocalizations.of(context)!.findyourfavourite,
                        // Strings.FIND_YOUR_FAVOURITE,
                        style: GoogleFonts.openSans(
                          color: AppColors.primaryWhiteColor,
                          fontSize: 24,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    flexibleSpace: const FlexibleSpaceBar(
                      titlePadding: EdgeInsets.zero,
                      background: NestedScrollBackgroundWidget1(),
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
                                  padding:
                                      const EdgeInsets.only(left: 20, right: 20),
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
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        width: 1,
                                        color: AppColors.borderColor,
                                      ),
                                    ),
                                    child: CupertinoTextField(
                                      onSubmitted: (text) {
                                        BlocProvider.of<SearchBloc>(context).add(
                                          GetSearchEvent(
                                            searchCategoryRequest:
                                                SearchCategoryRequest(
                                              searchText: text.length != null
                                                  ? searchController.text
                                                  : "",
                                            ),
                                          ),
                                        );
                                      },
                                      onEditingComplete: () {
                                        BlocProvider.of<SearchBloc>(context).add(
                                          GetSearchEvent(
                                            searchCategoryRequest:
                                                SearchCategoryRequest(
                                              searchText: searchController.text,
                                            ),
                                          ),
                                        );
                                      },
                                      controller: searchController,
                                      placeholder: AppLocalizations.of(context)!
                                          .searchcategory,
                                      // placeholder: Strings.SEARCH_SCREEN_HINT,
                                      placeholderStyle: const TextStyle(
                                        color: AppColors.primaryGrayColor,
                                      ),
                                      onChanged: (text) {
                                        BlocProvider.of<SearchBloc>(context).add(
                                          GetSearchEvent(
                                            searchCategoryRequest:
                                                SearchCategoryRequest(
                                              searchText: text.length != null
                                                  ? searchController.text
                                                  : "",
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
                                    if (searchController.text.isNotEmpty) {
                                      BlocProvider.of<SearchBloc>(context).add(
                                        GetSearchEvent(
                                          searchCategoryRequest:
                                              SearchCategoryRequest(
                                                  searchText:
                                                      searchController.text),
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
                  if (state is SearchErrorState) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
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
                                  GetSearchEvent(
                                    searchCategoryRequest:
                                        SearchCategoryRequest(searchText: ''),
                                  ),
                                );
                              },
                              child: Text(
                                // "Try again",
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

                  if (state is SearchLoading) {
                    return const Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: RefreshProgressIndicator(
                            color: AppColors.secondaryColor,
                            backgroundColor: AppColors.primaryWhiteColor,
                          ),
                        ),
                      ],
                    );
                  } else if (state is SearchLoaded) {
                    return GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 20, bottom: 140),
                      itemCount:
                          state.searchCategoryRequestResponse.data?.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15.0,
                        mainAxisSpacing: 15.0,
                      ),
                      itemBuilder: (context, int index) {
                        return GestureDetector(
                          onTap: () {
                            if (state.searchCategoryRequestResponse.data!
                                .isNotEmpty) {
                              context.push(
                                "/search_brand",
                                extra: SearchScreenArguments(
                                  categoryId: state
                                      .searchCategoryRequestResponse
                                      .data![index]
                                      .id
                                      .toString(),
                                  category: context
                                              .read<LanguageBloc>()
                                              .state
                                              .selectedLanguage ==
                                          Language.english
                                      ? state.searchCategoryRequestResponse
                                          .data![index].departmentName!
                                      : state.searchCategoryRequestResponse
                                          .data![index].departmentNameArabic!,
                                ),
                              );
                            } else {
                              print("No data available. Cannot navigate.");
                            }
                          },
                          child: Container(
                            // padding: const EdgeInsets.all(25),
                            decoration: BoxDecoration(
                              color: AppColors.primaryWhiteColor,
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.31),
                                  blurRadius: 4.10,
                                  offset: Offset(2, 4),
                                  spreadRadius: 0,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 7,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: ClipOval(
                                      child: CachedNetworkImage(
                                        height: 90,
                                        width: 90,

                                        alignment: Alignment.center,
                                        fadeInCurve: Curves.easeIn,
                                        fadeInDuration:
                                            const Duration(milliseconds: 200),
                                        fit: BoxFit.contain,
                                        imageUrl: state
                                            .searchCategoryRequestResponse
                                            .data![index]
                                            .departmentImage!,
                                        placeholder: (context, url) => SizedBox(
                                          // height: getProportionateScreenHeight(170),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Center(
                                            child: Lottie.asset(
                                              Assets.JUMBINGDOT,
                                              height: 35,
                                              width: 35,
                                            ),
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const ImageIcon(
                                          color: AppColors.hintColor,
                                          AssetImage(Assets.NO_IMG),
                                        ),
                                      ),
                                    ),
                                    // CircleAvatar(
                                    //   radius: 60,
                                    //   backgroundColor: AppColors.secondaryColor,
                                    //   backgroundImage: NetworkImage(
                                    //       state.searchCategoryRequestResponse.data![index].departmentImage!),
                                    // ),
                                  ),
                                ),
                                // const Spacer(flex: 1),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    context
                                                .read<LanguageBloc>()
                                                .state
                                                .selectedLanguage ==
                                            Language.english
                                        ? state.searchCategoryRequestResponse
                                            .data![index].departmentName!
                                        : state.searchCategoryRequestResponse
                                            .data![index].departmentNameArabic!,
                                    style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15,
                                      color: AppColors.cardTextColor,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            );
          } else if (state is NetworkFailure) {
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
          } else if (state is NetworkInitial) {
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
          return const SizedBox();
        },
      ),
    );
    //
  }
}

class NestedScrollBackgroundWidget1 extends StatelessWidget {
  const NestedScrollBackgroundWidget1({
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
