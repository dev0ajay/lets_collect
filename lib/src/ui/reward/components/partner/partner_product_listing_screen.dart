import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants/colors.dart';

class PartnerProductListingScreen extends StatefulWidget {
  const PartnerProductListingScreen({super.key});

  @override
  State<PartnerProductListingScreen> createState() =>
      _PartnerProductListingScreenState();
}

class _PartnerProductListingScreenState
    extends State<PartnerProductListingScreen> {
  bool isLetsCollectSelected = false;
  bool isBrandSelected = false;
  bool isPartnerSelected = false;
  List<String> img = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTfxUBt2EtbI2IPETUYrifzoWQktIsu5crphrYu5Qzbiw52g5on9HxRZqbvdcbdtcF0YY0&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSGG9_-u0Oq3DR-LKVQ8nEVYd9kqbYUt36-YQ&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSWK7Fy3iGvJyRlR2MtQdEe7YhXzf2RKeM_OQ&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ88mjX9WUPXBejWdPwLYzgtVHvPrToa99k_g&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ1l4JWiEQKcluNXPcUF0TWDVKBUzRxQpQC_w&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSXRugGkV8QAKSz8iW4peXztElMofvXfVEgTA&usqp=CAU",
    "https://images.unsplash.com/photo-1528750717929-32abb73d3bd9?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fGZvb2QlMjBicmFuZCUyMHByb2R1Y3RzfGVufDB8fDB8fHww",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJwOz2y3GVcAGokrAo2K68_yQ7_gPzk3K6ieJuwRvoj_kjmZ-s4lgUHVFonWsFAQUBcNg&usqp=CAU",
    "https://images.unsplash.com/photo-1525904097878-94fb15835963?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRFjhLvA2B5o0Qo6eueBjfgz7WuhF1Rhxp9EA&usqp=CAU",
    "https://images.unsplash.com/photo-1587790032594-babe1292cede?q=80&w=2519&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(5),
          bottomRight: Radius.circular(5),
        )),
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.primaryWhiteColor,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.only(left: 8, right: 8),
                height: 20,
                width: 68,
                decoration: BoxDecoration(
                  color: AppColors.primaryWhiteColor,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x4F000000),
                      blurRadius: 4.10,
                      offset: Offset(2, 4),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Sort",
                      style: TextStyle(
                        color: AppColors.iconGreyColor,
                        fontSize: 13,
                      ),
                    ),
                    Icon(
                      Icons.sort,
                      size: 18,
                      color: AppColors.iconGreyColor,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 15),
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.only(left: 8, right: 8),
                height: 20,
                width: 68,
                decoration: BoxDecoration(
                  color: AppColors.primaryWhiteColor,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x4F000000),
                      blurRadius: 4.10,
                      offset: Offset(2, 4),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Filter",
                      style: TextStyle(
                        color: AppColors.iconGreyColor,
                        fontSize: 13,
                      ),
                    ),
                    Icon(
                      Icons.sort,
                      size: 18,
                      color: AppColors.iconGreyColor,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Column(
              children: [
                Text(
                  "Brand",
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryWhiteColor,
                  ),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '800',
                        style: GoogleFonts.openSans(
                          color: AppColors.primaryWhiteColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                      TextSpan(
                        text: 'pts',
                        style: GoogleFonts.openSans(
                          color: AppColors.primaryWhiteColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
            child: buildPartnerProductGridMethod(),
          )),
    );
  }

  GridView buildPartnerProductGridMethod() {
    return GridView.builder(
        shrinkWrap: true,
        itemCount: img.length,
        padding: const EdgeInsets.only(bottom: 60, top: 20),
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 15.0,
          crossAxisSpacing: 10.0,
          childAspectRatio: 1,
          crossAxisCount: 2,
        ),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              context.push('/brand_products');
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primaryWhiteColor,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x4F000000),
                    blurRadius: 4.10,
                    offset: Offset(2, 4),
                    spreadRadius: 0,
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              child:
              Column(
                children: [
                  Expanded(
                    flex: 4,
                    child: Center(
                      child: SizedBox(
                        width: 120,
                        height: 100,
                        child: CachedNetworkImage(
                          alignment: Alignment.center,
                          fadeInCurve: Curves.easeIn,
                          fadeInDuration: const Duration(milliseconds: 200),
                          fit: BoxFit.contain,
                          imageUrl: img[index],
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                    ),
                  ),
                  const Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(top: 8.0, left: 20),
                      child: Text(
                        "60 points",
                        style: TextStyle(
                            color: AppColors.primaryColor, fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),

            ),
          );
        },
    );
  }
}
