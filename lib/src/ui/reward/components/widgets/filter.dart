import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import '../../../../bloc/filter_bloc/filter_bloc.dart';
import '../../../../constants/assets.dart';

class FilterSheet extends StatefulWidget {
  const FilterSheet({super.key});

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  double sheetHeight = 300;
  final List _selectedCategory = [];

  void _onCategorySelected(bool selected, brandId) {
    if (selected == true) {
      setState(() {
        _selectedCategory.add(brandId);
      });
    } else {
      setState(() {
        _selectedCategory.remove(brandId);
      });
    }
  }

  List<int> selectedItem = [];

  @override
  Widget build(BuildContext context) {
    // FilterState filterState = FilterInherited.of(context).filterState;

    return Scaffold(
      body: SizedBox(
        // duration: const Duration(milliseconds: 300),
        height: sheetHeight,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 33, right: 45, top: 20, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Filter by"),
                  GestureDetector(
                    onTap: () {
                      context.pop();
                    },
                    child: const Icon(Icons.cancel),
                  ),
                ],
              ),
            ),
            const Divider(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Padding(
                    //   padding:
                    //       const EdgeInsets.only(left: 15, right: 14, top: 15),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       const Text("Eligible"),
                    //       GestureDetector(
                    //         onTap: () {
                    //           setState(() {
                    //             isEligible = !isEligible;
                    //           });
                    //         },
                    //         // child:  CheckboxListTile(
                    //         //   title: const Text('Show Completed'),
                    //         //   value: filterState.showCompleted,
                    //         //   onChanged: (value) {
                    //         //     FilterInherited.of(context).filterState.showCompleted = value!;
                    //         //   },
                    //         // ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    BlocBuilder<FilterBloc, FilterState>(
                      builder: (context, state) {
                        if (state is BrandLoading) {
                          return Center(
                            child: Lottie.asset(Assets.JUMBINGDOT,
                                height: 100, width: 100),
                          );
                        }
                        if (state is BrandLoaded) {
                          return SizedBox(
                            height: 250,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                                itemCount: 8,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Container(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: CheckboxListTile(
                                            title: Text("Check Box$index"),
                                            value: selectedItem.contains(index)
                                                ? true
                                                : false,
                                            onChanged: (newValue) {

                                              setState(() {
                                                if (selectedItem
                                                    .contains(index)) {
                                                  selectedItem.remove(index);
                                                } else {
                                                  selectedItem.add(index);
                                                }
                                              });
                                            },
                                            controlAffinity: ListTileControlAffinity
                                                .leading, //  <-- leading Checkbox
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          );
                        }
                        // ListView.builder(
                        //     itemCount: state.brandFilterResponse.data.length,
                        //     itemBuilder: (BuildContext context, int index) {
                        //       return CheckboxListTile(
                        //         value: _selectedCategory.contains(
                        //             state.brandFilterResponse.data[index].id),
                        //         onChanged: (bool? selected) {
                        //           print(_selectedCategory);
                        //           _onCategorySelected(
                        //               selected!,
                        //               state.brandFilterResponse.data[index]
                        //                   .id);
                        //         },
                        //         title: Text(state.brandFilterResponse
                        //             .data[index].brandName),
                        //       );
                        //     }),

                        return const SizedBox();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
