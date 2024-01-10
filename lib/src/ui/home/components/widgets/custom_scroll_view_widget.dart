import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lets_collect/src/constants/colors.dart';
import '../../../../constants/assets.dart';
import '../../../../utils/screen_size/size_config.dart';

class CustomScrollViewWidget extends StatelessWidget {
  CustomScrollViewWidget({super.key});

  final List<String> offerList = [
    "https://lh3.googleusercontent.com/p/AF1QipMqqa46dLkIiz3erib-jJvTmfLfuu1Yc4KPbpqn=w1080-h608-p-no-v0",
    "https://www.graceonline.in/uploads/press-release/2021/07/15/presstips-to-buy-groceries-from-the-online-grocery-store-in-chennaiTWY1626328442.webp",
    "https://img.freepik.com/free-vector/online-grocery-store-banner-design_23-2150089538.jpg?size=626&ext=jpg&ga=GA1.1.1826414947.1699833600&semt=ais",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkZwedb3OKxvYwv_-Xq8EZY5tXaTj4bGcKhA&usqp=CAU",
    "https://www.shutterstock.com/image-vector/collection-food-sale-vertical-banner-260nw-1978888238.jpg",
  ];
  final List<String> brandList = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkXn-ER1y5GoZMhdpJbNDFwmVcF6EgNnKx2L0HLIUl4Z6FOMAKNjuFFyn-8t7Irm4VaTg&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQeBSJV5_fHf8lK_P-qzwrrSknGjOLp2tiRUFdKRlEJnIoj3aTWK2N2TVeVIwGhh35qKgY&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQNcSY2jWuEl3yWP4EaataDBwiXVfhmBXaXITE6UeLDD_hOPJJLNA648j_06wxTNV76nq0&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRrNlRN3EbfaSAcDV81Z8lgpVHMYMtWcMO5Akj_bLmcfnaCAdlIVVAo-aXZJbNnemdN1YU&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRudtbxCfi5rEfivx9St1HyF5bAaZ4ELtTAReUredMIfL98B1hcJMY1kjQo_UJXDUpdS7s&usqp=CAU",
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          leading: const SizedBox(),
          pinned: true,
          stretch: true,
          collapsedHeight: getProportionateScreenHeight(60),
          backgroundColor: AppColors.primaryColor,
          expandedHeight: getProportionateScreenHeight(80),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(9),
              bottomLeft: Radius.circular(9),
            ),
          ),
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.parallax,
            centerTitle: false,
            titlePadding: const EdgeInsets.all(10),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Hi Sarah",
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColors.primaryWhiteColor,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.mail_sharp,
                  ),
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          sliver: SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  flex: 2,
                  child: Container(
                    height: 50,
                    // width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: AppColors.primaryWhiteColor,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade400,
                          blurRadius: 1.0, // soften the shadow
                          spreadRadius: 0.0, //extend the shadow
                          offset: const Offset(
                            0.0, // Move to right 10  horizontally
                            0.0, // Move to bottom 10 Vertically
                          ),
                        ),
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 1.0, // soften the shadow
                          spreadRadius: 0.0, //extend the shadow
                          offset: const Offset(
                            -1.0, // Move to right 10  horizontally
                            -1.0, // Move to bottom 10 Vertically
                          ),
                        ),
                      ],
                    ),
                    child: SizedBox(
                      height: getProportionateScreenHeight(50),
                      child: const CupertinoTextField.borderless(
                        padding: EdgeInsets.only(
                            left: 15, top: 15, right: 6, bottom: 10),
                        placeholder: 'Referral code',
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Flexible(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 3,
                      fixedSize: const Size(120, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: AppColors.secondaryButtonColor,
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Bonus point!",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 200,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Container(
                    height: getProportionateScreenHeight(160),
                    width: getProportionateScreenWidth(150),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      gradient: const RadialGradient(
                        radius: 0.6,
                        colors: [
                          AppColors.containerRadialColor1,
                          AppColors.containerRadialColor,
                          AppColors.containerRadialColor2,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Image.asset(Assets.SCAN, scale: 6)
                              .animate()
                              .shake(
                                duration: const Duration(milliseconds: 400),
                              ),
                        ),
                        const Text(
                          "Scan",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Container(
                    height: getProportionateScreenHeight(160),
                    width: getProportionateScreenWidth(150),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      gradient: const RadialGradient(
                        radius: 0.6,
                        colors: [
                          AppColors.primaryColor2,
                          AppColors.primaryColor3,
                          AppColors.primaryColor,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Image.asset(Assets.WALLET, scale: 8)
                              .animate()
                              .shake(
                                duration: const Duration(milliseconds: 400),
                              ),
                        ),
                        const Text(
                          "Total points",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w400),
                        ),
                        const Text(
                          "1200 pts",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          sliver: SliverToBoxAdapter(
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Brands",
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      "View all",
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  // color: Colors.green,
                  height: 100,
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: brandList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: getProportionateScreenWidth(100),
                            // padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade400,
                                  blurRadius: 1.0, // soften the shadow
                                  spreadRadius: 0.0, //extend the shadow
                                  offset: const Offset(
                                    1.0, // Move to right 10  horizontally
                                    1.0, // Move to bottom 10 Vertically
                                  ),
                                ),
                                BoxShadow(
                                  color: Colors.grey.shade300,
                                  blurRadius: 1.0, // soften the shadow
                                  spreadRadius: 0.0, //extend the shadow
                                  offset: const Offset(
                                    -1.0, // Move to right 10  horizontally
                                    -1.0, // Move to bottom 10 Vertically
                                  ),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: brandList[index],
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                        colorFilter: const ColorFilter.mode(
                                            Colors.red, BlendMode.colorBurn)),
                                  ),
                                ),
                                // placeholder: (context, url) => CircularProgressIndicator(),
                                // errorWidget: (context, url, error) => Icon(Icons.error),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 8),
        ),
        const SliverPadding(
          sliver: SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Special Offers",
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  "View all",
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
          padding: EdgeInsets.only(left: 10, right: 10),
        ),
        SliverPadding(
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, index) {
                return Column(
                    children: AnimateList(
                        effects: [
                      FadeEffect(delay: 300.ms),
                    ],
                        children: List.generate(
                          offerList.length,
                          (index) => Padding(
                            padding: const EdgeInsets.all(15),
                            child: Container(
                              height: getProportionateScreenHeight(170),
                              // padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade400,
                                    blurRadius: 1.0, // soften the shadow
                                    spreadRadius: 0.0, //extend the shadow
                                    offset: const Offset(
                                      1.0, // Move to right 10  horizontally
                                      1.0, // Move to bottom 10 Vertically
                                    ),
                                  ),
                                  BoxShadow(
                                    color: Colors.grey.shade300,
                                    blurRadius: 1.0, // soften the shadow
                                    spreadRadius: 0.0, //extend the shadow
                                    offset: const Offset(
                                      -1.0,
                                      // Move to right 10  horizontally
                                      -1.0, // Move to bottom 10 Vertically
                                    ),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,

                                  imageUrl: offerList[index],
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                          colorFilter: const ColorFilter.mode(
                                              Colors.red, BlendMode.colorBurn)),
                                    ),
                                  ),
                                  // placeholder: (context, url) => CircularProgressIndicator(),
                                  // errorWidget: (context, url, error) => Icon(Icons.error),
                                ),
                              ),
                            ),
                          ),
                        )));
              },
              childCount: 1,
            ),
          ),
          padding: const EdgeInsets.only(bottom: 100,left: 10,right: 10),
        ),
      ],
    );
  }
}
