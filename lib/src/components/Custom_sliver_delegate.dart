import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lets_collect/src/constants/colors.dart';

class CustomSliverDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final bool hideTitleWhenExpanded;
  // final String TitleTest;
  // final String profilename;
  // final String changepassword;


  CustomSliverDelegate( {
    required this.expandedHeight,
  // required this.profilename,
  // required this.TitleTest,
  // required this.changepassword,
    this.hideTitleWhenExpanded = true,
  });

  @override
  Widget build(
      BuildContext context,
      double shrinkOffset,
      bool overlapsContent,
      ) {
    final appBarSize = expandedHeight - shrinkOffset;
    // final cardTopPosition = expandedHeight / 7 - shrinkOffset;
    final proportion = 2 - (expandedHeight / appBarSize);
    final percent = proportion < 0 || proportion > 1 ? 0.0 : proportion;
    return Stack(
      children: [
        Container(
          height: 200,
          decoration: const BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10.0), // Adjust the radius as needed
              bottomRight: Radius.circular(10.0), // Adjust the radius as needed
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent, // Set the AppBar background color to transparent
            leading: IconButton(
              icon: GestureDetector(
                  onTap:(){
                    context.pop("/myProfile");
                    print("MyProfile tapped!");
                  },
                  child: const Icon(Icons.cancel_outlined,color: AppColors.primaryWhiteColor,)),
              onPressed: () {},
            ),
            elevation: 0.0,
            title: Opacity(
              opacity: hideTitleWhenExpanded ? 1.0 - percent : 1.0,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 5,
                    child: Text("Sarahhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh",
                    style: TextStyle(color: AppColors.primaryWhiteColor),),
                  ),
                  // SizedBox(width: 8), // Adjust the spacing as needed
                  Expanded(
                    flex: 1,
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 20,
                      backgroundImage: NetworkImage(
                        "https://s3-alpha-sig.figma.com/img/d067/c913/ad868d019f92ce267e6de23af3413e5b?Expires=1705276800&Signature=MwbzwPFm9CnAjE7oHBByXiNvOJEUR~pvprZnzXtocbYZYSoqBMXiO4LEfr1sMACBDUfVZeJzHzJ-vlDN8yCk~0BSRgDjsYzRxM6MaoG97Mq65xC~hvQ0nH-zZR-VPdqF5d0Wy2MmG-QaEA46hNZu3Wn08uUD0XmC0BcmD~BKPsz7Wkl3qGn6sB-S9j6duqNIdGzkfVIv6j~KB9IhpYJl5pGL2Yk1rxfDdskfVoOEhguhrIIul3QCOlKVZcRI6MpV3Bda~MaY-VJ~o1bFtaR8Ru0R0fpMoa8VxjSOZlHAtpaUOB9Qg-frB~hRVg-xEdrv60DctNjJpKzRBlWt~Xbu~w__&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4"
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        Opacity(
          opacity: percent,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          const Text(
                            "Saraha",
                            style: TextStyle(color: Colors.pink),
                          ),
                          const SizedBox(height: 10,),
                          GestureDetector(
                              child: const Text("Change Password",
                                style: TextStyle(color: Colors.white),)
                          ),
                        ],
                      ),
                    ),
                    const Expanded(
                      flex: 3,
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 50,
                        backgroundImage: NetworkImage(
                          "https://s3-alpha-sig.figma.com/img/d067/c913/ad868d019f92ce267e6de23af3413e5b?Expires=1705276800&Signature=MwbzwPFm9CnAjE7oHBByXiNvOJEUR~pvprZnzXtocbYZYSoqBMXiO4LEfr1sMACBDUfVZeJzHzJ-vlDN8yCk~0BSRgDjsYzRxM6MaoG97Mq65xC~hvQ0nH-zZR-VPdqF5d0Wy2MmG-QaEA46hNZu3Wn08uUD0XmC0BcmD~BKPsz7Wkl3qGn6sB-S9j6duqNIdGzkfVIv6j~KB9IhpYJl5pGL2Yk1rxfDdskfVoOEhguhrIIul3QCOlKVZcRI6MpV3Bda~MaY-VJ~o1bFtaR8Ru0R0fpMoa8VxjSOZlHAtpaUOB9Qg-frB~hRVg-xEdrv60DctNjJpKzRBlWt~Xbu~w__&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4"
                        ),
                      ),
                    ),
                    // SizedBox(height: 120),
                  ],
                ),
              ],
            ),
          ),
        ),

      ],
    );
  }

  @override
  double get maxExtent => expandedHeight + expandedHeight / 2;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
