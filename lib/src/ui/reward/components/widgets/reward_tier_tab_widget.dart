import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';

class RewardTierTabWidget extends StatefulWidget {
  final Function(int) onTabChanged;

  const RewardTierTabWidget({Key? key, required this.onTabChanged}) : super(key: key);

  @override
  State<RewardTierTabWidget> createState() => _RewardTierTabWidgetState();
}

class _RewardTierTabWidgetState extends State<RewardTierTabWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      widget.onTabChanged(_tabController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> tab = [
      "Lets Collect Reward",
      "Partner Rewards",
      "Brand Rewards",
    ];

    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child:
      SizedBox(
        height: 53,
        width: double.infinity,
        child: ListView.builder(

          shrinkWrap: true,
          padding: const EdgeInsets.only(left: 10),
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            bool isSelected = _tabController.index == index;

            return GestureDetector(
              onTap: () {
                _tabController.animateTo(index);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding:
                    const EdgeInsets.only(left: 8, right: 8, top: 3, bottom: 3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: isSelected ? AppColors.secondaryButtonColor: AppColors.primaryWhiteColor,
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x0F000000),
                          blurRadius: 4,
                          offset: Offset(4, 2),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        tab[index],
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
