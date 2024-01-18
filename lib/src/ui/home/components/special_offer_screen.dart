import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_collect/src/ui/home/components/widgets/special_offer-details_overlay_widget.dart';

import '../../../constants/colors.dart';
import '../../../utils/screen_size/size_config.dart';

class SpecialOfferScreen extends StatefulWidget {
  const SpecialOfferScreen({super.key});

  @override
  State<SpecialOfferScreen> createState() => _SpecialOfferScreenState();
}

class _SpecialOfferScreenState extends State<SpecialOfferScreen> {
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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.primaryColor,
            leading: IconButton(
              onPressed: () {
                context.go('/home');
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: AppColors.primaryWhiteColor,
              ),
            ),
            expandedHeight: 150,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              collapseMode: CollapseMode.parallax,
              titlePadding: const EdgeInsets.only(bottom: 60, top: 0),
              title: Text(
                "Special Offers",
                style: GoogleFonts.roboto(
                  fontSize: 23,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(45),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        height: 20,
                        width: 68,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: const [
                            BoxShadow(
                              color: AppColors.boxShadow,
                              blurRadius: 4,
                              offset: Offset(4, 2),
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
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x0F000000),
                              blurRadius: 4,
                              offset: Offset(4, 2),
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
              ),
            ),
          ),
          SliverFillRemaining(
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                children: AnimateList(
                  effects: [
                    FadeEffect(delay: 300.ms),
                  ],
                  children: List.generate(
                    img.length,
                    (index) => Padding(
                      padding: const EdgeInsets.all(15),
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                            const SpecialOfferDetailsOverlayWidget(),
                          );
                        },
                        child: Container(
                          height: getProportionateScreenHeight(105),
                          // padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.primaryWhiteColor,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: AppColors.borderColor,width: 1),
                            boxShadow: const [
                              BoxShadow(
                                color: AppColors.boxShadow,
                                blurRadius: 4,
                                offset: Offset(4, 2),
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Flexible(
                                flex: 2,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: SizedBox(
                                    height: 80,
                                    width: 80,
                                    child: CachedNetworkImage(
                                      imageUrl: img[index],

                                    ),
                                  ),
                                ),
                              ),
                              const Expanded(
                                flex: 5,
                                child: Text(
                                  "Special offers, 20 extra points today only",
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
