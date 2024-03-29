import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_collect/src/bloc/search_bloc/search_bloc.dart';
import 'package:lets_collect/src/constants/strings.dart';
import 'package:lets_collect/src/model/search/category/search_category_request.dart';
import 'package:lets_collect/src/ui/search/components/search_details_screen.dart';
import 'package:lets_collect/src/ui/search/search_screen_arguments.dart';
import 'package:lottie/lottie.dart';
import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../utils/screen_size/size_config.dart';

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
    BlocProvider.of<SearchBloc>(context).add(GetSearchEvent(
        searchCategoryRequest: SearchCategoryRequest(searchText: '')));
  }



  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (details.delta.direction <= 0) {
          context.pop();
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.primaryWhiteColor,
        body: NestedScrollView(
          // floatHeaderSlivers: true,
          physics: const ClampingScrollPhysics(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
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
                expandedHeight: 170,
                floating: false,
                backgroundColor: AppColors.primaryColor,
                pinned: true,
                leadingWidth: 0,

                title: Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Text(
                    Strings.FIND_YOUR_FAVOURITE,
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
                  background: NestedScrollBackgroundWidget1(),
                ),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(60),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    color: AppColors.primaryWhiteColor,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
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
                                controller: searchController,
                                placeholder: Strings.SEARCH_SCREEN_HINT,
                                placeholderStyle: const TextStyle(
                                  color: AppColors.primaryGrayColor,
                                ),
                                onChanged: (text) {
                                  BlocProvider.of<SearchBloc>(context).add(
                                    GetSearchEvent(
                                      searchCategoryRequest:
                                          SearchCategoryRequest(
                                              searchText: searchController.text),
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
                                    searchCategoryRequest: SearchCategoryRequest(
                                        searchText: searchController.text),
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

            ];
          },
          body: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              if (state is SearchLoading) {
                return  const Stack(
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
                  physics: const NeverScrollableScrollPhysics(),
                  padding:
                  const EdgeInsets.only(left: 15, right: 15, top: 20,bottom: 98),
                  itemCount:
                  state.searchCategoryRequestResponse.data.length,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15.0,
                    mainAxisSpacing: 15.0,
                  ),
                  itemBuilder: (context, int index) {
                    return GestureDetector(
                      onTap: () {
                        if (state.searchCategoryRequestResponse
                            .data.isNotEmpty) {
                          context.push(
                            "/search_brand",
                            extra: SearchScreenArguments(
                                categoryId: state
                                    .searchCategoryRequestResponse
                                    .data[index]
                                    .id
                                    .toString(),
                                category: state
                                    .searchCategoryRequestResponse
                                    .data[index]
                                    .category),
                          );
                        } else {
                          print(
                              "No data available. Cannot navigate.");
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
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: CircleAvatar(
                                    radius: 60,
                                    backgroundColor: AppColors.primaryWhiteColor,
                                   child: CachedNetworkImage(
                                      imageUrl: state.searchCategoryRequestResponse
                                             .data[index].categoryImage,
                                      width: MediaQuery.of(context).size.width,
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
                                  ),
                                ),
                              ),
                            ),
                            // const Spacer(flex: 1),
                            Expanded(
                              flex: 1,
                              child: Text(
                                state.searchCategoryRequestResponse
                                    .data[index].category,
                                style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                  color: AppColors.cardTextColor,
                                ),
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

        ),
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

