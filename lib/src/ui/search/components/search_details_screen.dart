/// New Brand Search
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_collect/src/bloc/brand_bloc/brand_bloc.dart';
import 'package:lets_collect/src/constants/assets.dart';
import 'package:lets_collect/src/constants/colors.dart';
import 'package:lets_collect/src/constants/strings.dart';
import 'package:lets_collect/src/model/search/brand/search_brand_request.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart'; // Import the url_launcher package

class SearchDetailsScreen extends StatefulWidget {
  final int category_id;
  final String category;


  const SearchDetailsScreen({super.key,
    required this.category_id, required this.category,
  });

  @override
  State<SearchDetailsScreen> createState() => _SearchDetailsScreenState();
}

class _SearchDetailsScreenState extends State<SearchDetailsScreen> {


  final TextEditingController _searchController = TextEditingController();


  @override
  void initState() {
    print("ID: ${widget.category_id}");
    super.initState();
    BlocProvider.of<BrandBloc>(context).add(
        GetBrandEvent(searchBrandRequest: SearchBrandRequest(categoryId: widget.category_id.toString(), searchText: '', page: '1'))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primaryColor,
        toolbarHeight: 80,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded,color: AppColors.primaryWhiteColor,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        titleSpacing: 0.0,
        title: Text(
          widget.category.toString(),
          style: GoogleFonts.openSans(
            color: AppColors.primaryWhiteColor,
            fontSize: 24,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              const SizedBox(width: 20),
              Expanded(
                flex: 4,
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      width: 1,
                      color: Colors.black12,
                    ),
                  ),
                  child: CupertinoTextField(
                    controller: _searchController,
                    placeholder: Strings.SEARCH_HINT,
                    placeholderStyle: const TextStyle(
                      color: AppColors.primaryBlackColor,
                    ),
                    onChanged: (text) {
                      BlocProvider.of<BrandBloc>(context).add(
                        GetBrandEvent(
                          searchBrandRequest: SearchBrandRequest(
                            searchText: _searchController.text,
                            categoryId: widget.category_id.toString(),
                            page: "1",
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                child: IconButton(
                  onPressed: () {
                    if (_searchController.text.isNotEmpty) {
                      BlocProvider.of<BrandBloc>(context).add(
                        GetBrandEvent(
                          searchBrandRequest: SearchBrandRequest(
                            searchText: _searchController.text,
                            categoryId: widget.category_id.toString(),
                            page: "1",
                          ),
                        ),
                      );
                    }
                  },
                  icon: const Icon(Icons.search),
                ),
              ),
            ],
          ),
          Expanded(
            child: BlocBuilder<BrandBloc, BrandState>(
              builder: (context, state) {
                if (state is BrandLoading) {
                  return const Center(
                    child: RefreshProgressIndicator(),
                  );
                } else if (state is BrandLoaded) {
                  if (state.searchBrandRequestResponse.data.isEmpty) {
                    return Center(
                      child: Lottie.asset(Assets.NO_DATA),
                    );
                  }
                  return SizedBox(
                    height: 300,
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 20.0,
                          mainAxisSpacing: 15.0,
                        ),
                        itemCount: state.searchBrandRequestResponse.data.length,
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
                                  String brandLink = state.searchBrandRequestResponse.data[index].brandLink;
                                  if (brandLink != null && brandLink.isNotEmpty) {
                                    launchUrl(brandLink);
                                  }
                                },

                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.network(
                                    state.searchBrandRequestResponse.data[index].brandLogo,
                                  ),
                                ),
                              ),

                            ),
                          );
                        },
                      ),
                    ),
                  );
                } else {
                  return const Center(
                    child: Text("Error"),
                  );
                }
              },
            ),
          ),
        ],
      ),
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

