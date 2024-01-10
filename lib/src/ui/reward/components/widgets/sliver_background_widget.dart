import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lets_collect/src/constants/assets.dart';

import '../../../../constants/colors.dart';

class SliverBackgroundWidget extends StatelessWidget {
  const SliverBackgroundWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Container(
            height: 123,
            width: 320,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              color: AppColors.secondaryButtonColor,
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.25),
                  blurRadius: 4,
                  offset: Offset(0, 4),
                  spreadRadius: 0, //extend the shadow

                ),

              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            height: 130,
            width: 400,
            // color: Colors.cyan,
            child: Stack(
              children: [
                Positioned(
                  top: 10,
                  left: 10,
                  bottom: 15,
                  child: Image.asset(Assets.WALLET),
                ),
                const Positioned(
                  right: 0,
                  left: 90,
                  top: 35,
                  bottom: 15,
                  child: Column(
                    children: [
                      Text(
                        "1200",
                        style: TextStyle(
                            letterSpacing: 1.8,
                            color: AppColors.primaryWhiteColor,
                            fontSize: 32,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "Total Points",
                        style: TextStyle(
                            color: AppColors.primaryWhiteColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // const SizedBox(height: 12),
        // Padding(
        //   padding: const EdgeInsets.only(left: 25),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.start,
        //     children: [
        //       Container(
        //         padding: const EdgeInsets.only(
        //             bottom: 2, top: 2, left: 12, right: 2),
        //         height: 23,
        //         width: 90,
        //         decoration: BoxDecoration(
        //             color: Colors.white,
        //             borderRadius: BorderRadius.circular(5)),
        //         child: const Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             Text("Sort"),
        //             Icon(
        //               Icons.sort,
        //               size: 18,
        //             ),
        //           ],
        //         ),
        //       ),
        //       const SizedBox(width: 15),
        //       Container(
        //         padding: const EdgeInsets.only(
        //             bottom: 2, top: 2, left: 12, right: 2),
        //         height: 23,
        //         width: 90,
        //         decoration: BoxDecoration(
        //             color: Colors.white,
        //             borderRadius: BorderRadius.circular(5)),
        //         child: const Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             Text("Filter"),
        //             Icon(Icons.account_tree, size: 18),
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        // SizedBox(height: 20),
      ],
    );
  }
}
