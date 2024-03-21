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
  int selectedNavIndex = 0;
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
          gravity: ToastGravity.BOTTOM,
          msg: "Press again to exit the app.",
      );
      return Future.value(false);
    }
    exit(0);
  }
  bool isSortTapped = true;

  void _onItemTapped(int index) {
    setState(() {
      selectedNavIndex = index;
      print("Index: $selectedNavIndex");
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // children = [
    //   const RewardScreen(),
    //   const SearchScreen(),
    //   const ProfileScreen(),
    //   const ScanScreen(from: 'HomeNav'),
    // ];
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
                  selectedNavIndex= 4;
                  print("bottomNavindex: ${selectedNavIndex}");
                });
                // context.go('/scan');
              },
              child: ImageIcon(
                const AssetImage(Assets.SCAN_ICON),
                size: selectedNavIndex == 4 ? 29 : 25,
                color: selectedNavIndex == 4
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
            activeIndex: selectedNavIndex,
            gapLocation: GapLocation.center,
            elevation: 20,
            notchSmoothness: NotchSmoothness.defaultEdge,
            onTap: _onItemTapped,
            //other params
            ),
        body:
        selectedNavIndex == 0 ?
        HomeScreenNavigation(onIndexChanged: (index) {
          _onItemTapped(index);
        },) :
        // selectedNavIndex == 4 ? const ScanScreen(from: 'HomeNav') :
        selectedNavIndex == 1 ? const RewardScreen() :
        selectedNavIndex == 2 ? const SearchScreen() :
        selectedNavIndex == 4 ? const ScanScreen(from: "HomeNav"):
        const ProfileScreen()
            // children[
            // selectedNavIndex
            // ],
      ),
    );
  }
}


