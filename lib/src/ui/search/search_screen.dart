/// SEARCH SCREEN
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_collect/src/bloc/search_bloc/search_bloc.dart';
import 'package:lets_collect/src/constants/strings.dart';
import 'package:lets_collect/src/model/search/category/search_category_request.dart';
import 'package:lets_collect/src/ui/search/components/search_details_screen.dart';
import '../../constants/colors.dart';
import '../../utils/screen_size/size_config.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  TextEditingController searchController = TextEditingController();
  // FocusNode _searchfiled = FocusNode();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<SearchBloc>(context).add(
        GetSearchEvent(
            searchCategoryRequest:
            SearchCategoryRequest(searchText: '')
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            stretch: true,
            floating: false,
            title: Text(Strings.FIND_YOUR_FAVOURITE,style: GoogleFonts.openSans(
              color: AppColors.primaryWhiteColor,
              fontSize: 24,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w600,
            ),
            ),
            // collapsedHeight: 60,
            backgroundColor: AppColors.primaryColor,
            expandedHeight: getProportionateScreenHeight(150),
            flexibleSpace: const FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              centerTitle: false,
              titlePadding: EdgeInsets.only(bottom: 10, left: 0,top: 10),
              expandedTitleScale: 1,
            ),
            bottom:  PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: Container(
                color: AppColors.primaryWhiteColor,
                height: 80,
                child: Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 4,
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    width: 1,
                                    color: Colors.black12
                                )
                            ),
                            child:  CupertinoTextField(
                              controller: searchController,
                              placeholder: Strings.SEARCH_HINT,
                              placeholderStyle: const TextStyle(
                                color: AppColors.primaryBlackColor,
                              ),
                              onChanged: (text) {
                                BlocProvider.of<SearchBloc>(context).add(
                                    GetSearchEvent(
                                        searchCategoryRequest:
                                        SearchCategoryRequest(searchText: searchController.text)
                                    )
                                );
                              },
                            ),
                          )

                      ),
                      Expanded(
                        child: IconButton(
                          onPressed: () {
                            if (searchController.text.isNotEmpty) {
                              BlocProvider.of<SearchBloc>(context).add(
                                GetSearchEvent(
                                  searchCategoryRequest: SearchCategoryRequest(searchText: searchController.text),
                                ),
                              );
                            }
                          },
                          icon: const Icon(Icons.search),
                        ),

                      ),
                    ],
                  ),
                ),
              ),
            )
        ),
        BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            if (state is SearchLoading) {
              return const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 200, top: 200),
                  child: Center(
                    child: RefreshProgressIndicator(),
                  ),
                ),
              );
            } else if (state is SearchLoaded) {
              return SliverPadding(
                padding: const EdgeInsets.all(15.0), // Adjust the padding as needed
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: getProportionateScreenHeight(250),
                    mainAxisSpacing: 15.0,
                    crossAxisSpacing: 20.0,
                    childAspectRatio: 0.9,
                  ),
                  delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      return Container(
                        padding: const EdgeInsets.all(25),
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
                              flex: 4,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    if (state.searchCategoryRequestResponse.data.isNotEmpty) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SearchDetailsScreen(
                                            category_id: state.searchCategoryRequestResponse.data[index].id,
                                            category: state.searchCategoryRequestResponse.data[index].category,
                                          ),
                                        ),
                                      );
                                    } else {
                                      print("No data available. Cannot navigate.");
                                    }
                                  },
                                  child: CircleAvatar(
                                    radius: 60,
                                    backgroundColor: Colors.white,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: CircleAvatar(
                                        radius: 60,
                                        backgroundImage: NetworkImage(
                                          state.searchCategoryRequestResponse.data[index].categoryImage,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 2,vertical: 1),
                                child: Text(
                                  state.searchCategoryRequestResponse.data[index].category,
                                  style: const TextStyle(color: AppColors.primaryColor, fontSize: 20),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    childCount: state.searchCategoryRequestResponse.data.length,
                  ),
                ),
              );
            } else {
              return const SliverToBoxAdapter(
                child: SizedBox(),
              );
            }
          },
        ),
      ],
    );

  }

}