import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lets_collect/src/constants/colors.dart';
import 'package:lets_collect/src/ui/home/components/widgets/custom_scroll_view_widget.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:lets_collect/src/ui/home/components/widgets/home_navigation.dart';
import 'package:lets_collect/src/ui/home/components/widgets/login_congrats_card.dart';
import 'package:lets_collect/src/ui/profile/profile_screen.dart';
import 'package:lets_collect/src/ui/reward/reward_screen.dart';
import 'package:lets_collect/src/ui/search/search_screen.dart';
import 'package:lets_collect/src/utils/screen_size/size_config.dart';

import '../../constants/assets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int bottomNavIndex = 0;
  List<Widget> children = [];
  List iconList = [
    // Icons.home_outlined,
    // Icons.wallet_giftcard_outlined,
    // Icons.search_outlined,
    // Icons.person_outline,
    Assets.HOME,
    Assets.REWARD,
    Assets.SEARCH,
    Assets.PROFILE,



  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    children = [
      const HomeScreenNavigation(),
      const RewardScreen(),
       SearchScreen(),
      const ProfileScreen(),
    ];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        height: 70,
        width: 70,
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: AppColors.primaryColor,
            shape: const CircleBorder(),
            onPressed: () {},
            child: const ImageIcon(AssetImage(Assets.SCAN_ICON),size: 30,color: AppColors.primaryWhiteColor,),
          ),
        ),
      ),
      bottomNavigationBar:
    AnimatedBottomNavigationBar.builder(

    itemCount: iconList.length,
    tabBuilder: (int index, bool isActive) {
      return ImageIcon(
        color: isActive ? AppColors.secondaryButtonColor : Colors.black,
        AssetImage(iconList[index])
      );
    },
      activeIndex: bottomNavIndex,
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.defaultEdge,


      onTap: (index) => setState(() => bottomNavIndex = index),
    //other params
    ),
      // AnimatedBottomNavigationBar(
      //   elevation: 10,
      //   icons: [
      //     Icon(Icons.)
      //   ],
      //   activeIndex: bottomNavIndex,
      //   gapLocation: GapLocation.center,
      //   notchSmoothness: NotchSmoothness.defaultEdge,
      //   // leftCornerRadius: 32,
      //   // rightCornerRadius: 32,
      //   onTap: (index) {
      //     setState(() {
      //       bottomNavIndex = index;
      //       print("index: ${index}");
      //     });
      //   },
      //   //other params
      // ),
      body: children[bottomNavIndex],
    );
  }
}

// class BottomNavigationWidget extends StatefulWidget {
//    BottomNavigationWidget({
//     super.key,required this.bottomNavIndex
//   });
//    int bottomNavIndex = 0;
//
//   @override
//   State<BottomNavigationWidget> createState() => _BottomNavigationWidgetState();
// }

// class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return
//       AnimatedBottomNavigationBar(
//         icons: iconList,
//         activeIndex: widget.bottomNavIndex,
//         gapLocation: GapLocation.center,
//         notchSmoothness: NotchSmoothness.softEdge,
//         // leftCornerRadius: 32,
//         // rightCornerRadius: 32,
//         onTap: (index) {
//           setState(() {
//             widget.bottomNavIndex = index;
//             print("index: ${index}");
//           });
//         },
//         //other params
//       );
//   }
// }
