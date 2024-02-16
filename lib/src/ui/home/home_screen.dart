import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lets_collect/src/constants/colors.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:lets_collect/src/ui/home/components/widgets/home_navigation.dart';
import 'package:lets_collect/src/ui/profile/profile_screen.dart';
import 'package:lets_collect/src/ui/reward/components/lets_collect_redeem_screen_arguments.dart';
import 'package:lets_collect/src/ui/reward/reward_screen.dart';
import 'package:lets_collect/src/ui/scan/scan_screen.dart';
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
    Assets.HOME,
    Assets.REWARD,
    Assets.SEARCH,
    Assets.PROFILE,
  ];
  DateTime? currentBackPressTime;
  LetCollectRedeemScreenArguments? letCollectRedeemScreenArguments;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 3)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        backgroundColor: AppColors.secondaryColor,
          textColor: AppColors.primaryWhiteColor,
          gravity: ToastGravity.TOP,
          msg: "Press again to exit the app.",
      );
      return Future.value(false);
    }
    exit(0);
  }
  bool isSortTapped = true;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    children = [
      const HomeScreenNavigation(),
      const RewardScreen(),
      const SearchScreen(),
      const ProfileScreen(),
      const ScanScreen(from: 'HomeNav'),
    ];
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        key: _scaffoldKey,
        backgroundColor: AppColors.primaryWhiteColor,
        extendBody: true,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: SizedBox(
          height: 70,
          width: 70,
          child: FittedBox(
            child: FloatingActionButton(
              elevation: 10,
              backgroundColor: AppColors.primaryColor,
              shape: const CircleBorder(),
              onPressed: () {
                setState(() {
                  bottomNavIndex = 4;
                  print("bottomNavindex: $bottomNavIndex");
                });
                // context.go('/scan');
              },
              child: ImageIcon(
                const AssetImage(Assets.SCAN_ICON),
                size: bottomNavIndex == 4 ? 29 : 25,
                color: bottomNavIndex == 4
                    ? AppColors.secondaryColor
                    : AppColors.primaryWhiteColor,
              ),
            ),
          ),
        ),
        bottomNavigationBar: AnimatedBottomNavigationBar.builder(
            itemCount: iconList.length,
            tabBuilder: (int index, bool isActive) {
              return ImageIcon(
                  // size: isActive ? 30 : 18,
                  color:
                      isActive ? AppColors.secondaryButtonColor : Colors.black,
                  AssetImage(iconList[index]));
            },
            activeIndex: bottomNavIndex,
            gapLocation: GapLocation.center,
            elevation: 10,
            notchSmoothness: NotchSmoothness.defaultEdge,
            onTap: (index) {
              print("Index: ${index}");
              setState(
                () => bottomNavIndex = index,
              );
            }
            //other params
            ),
        body:
            bottomNavIndex == 4 ? const ScanScreen(from: 'HomeNav') : children[bottomNavIndex],
      ),
    );
  }
}


