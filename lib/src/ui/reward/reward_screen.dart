import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../constants/colors.dart';
import '../../utils/screen_size/size_config.dart';
import 'components/widgets/reward_tier_tab_widget.dart';
import 'components/widgets/sliver_background_widget.dart';

class RewardScreen extends StatefulWidget {
  const RewardScreen({Key? key}) : super(key: key);

  @override
  State<RewardScreen> createState() => _RewardScreenState();
}

class _RewardScreenState extends State<RewardScreen>
    with SingleTickerProviderStateMixin {
  List<String> img = [
    "https://s3-alpha-sig.figma.com/img/ae7b/2899/43e39e7e83821d0c9eaeee0e1bc235dd?Expires=1704067200&Signature=McKCZZbnsH8cxr8~~TaWpN~Jt2bNm4NFQrLyiR~NY~IgE1SRZO0mUgUgtH5qF7gUABAblSqM8cJ8ENZ3IrK-pXreSdp-EoZLQu726uQN23t3Mt~ATrwSlVN1lb8WNEGozlTWxzs~xzXWvTANYPir6yZwVKiGWOR2clCizNIL7S~Z7yo5pSbSw2KugAHIKQ-dugDVoVqKL95lIlxNXLua0P0iwZEIDRRT0M3exhDZdaKQVv~XBtukHbasItrGF-kmKyu99ImPZBuHTGhlzpXhQLQLVPJ5vUzuicZW-EIMGUHw5H-CqdgytB1Vb0bKkg3HLmBDnZkAlOLlxlkGmc57aw__&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4",
    "https://s3-alpha-sig.figma.com/img/75ba/f613/0c285d1373857a55145b6421ca319a31?Expires=1704067200&Signature=Asj3DCzyuSlIpIl3oH~GiO5ws9ce5kampb3km-F18gQzirBm5ZI~6dR-Pf0D8mZiUj-ZvOEwHoStC4IR3G7Xq3xTr91PRGwSCijz72LWjvYDutVYFq1JhSAgo80zMDnRj7U3ASfkxpNb9fK7lJWbGAeAPl3pSPmtoGVmVmXiZHc3bP-AvRsGjftC5buQFG0WIdBPEJrlAUZUhJNdXkSaIsvlqymQ2magPm1I3iFy2Kcz6gawscz3xvVD-3hjafvBBFdr~TE25ChsOcg7c4MI~Xn4wS98KH-ZK1Kp8MAVmjzrmlOfBqVD1gZlbWlq1bKC1rgbAe5xvxaEdMZUErFUNA__&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4",
    "https://images.unsplash.com/photo-1524638067-feba7e8ed70f?q=80&w=1536&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://s3-alpha-sig.figma.com/img/1cab/a966/0c75907042d03beb552d3211a10bbe9d?Expires=1704067200&Signature=onDLaeVg8jWc~Hsp-PfaVDLx5O4ESYHACEmB0M8AJPAsisjikzecjqZfJsyhK7~ioRNiRqRGHfurdNcCR-4CSozmR1SkCo3RVpJaypYOwwCPnNAaX3TGO7eUL6heg1BESmp3GE58491DLlq7n7RCupsFaSYBdJtHVK6q1QzOeC8NDC2Qsy95Vl9G0Os6XGmyoOZ9FXcOqK3JlnxHLuSpbJLSSYm5on0NwQbIclh251is0QM6NaHwY67JXTHjchD2K8wReLyvWMn4AJfXZIKmTX2lz~fNeRFW~L~V4g6wXrCjlkxAzy13dDexMZYa6XYOLRIsy5Wvn-oKg64JoK8DrA__&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4",
    "https://images.unsplash.com/photo-1525904097878-94fb15835963?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://s3-alpha-sig.figma.com/img/176e/33c0/5c1c2f9df805bf3b5a0986dbe3650bac?Expires=1704067200&Signature=da1vNhyjsx3MfV9Sc2RPVCkOXojPWHQwDpkW99Al7e00E~25FxzfHc41CTUDOusiWndgxDQf1Gn3~-NWXOY9CBc~hNMCmzQnW0k4xmtAYyf8ssjNvgoCIDJdC3-v4-pzB~QnMLHslhggeOfwLFWotiLNAyH1oPojIuOSrXH5YXcQKia4y0RE2U0maPkjnPRpvrOc0z9My1SyVe8Bl6PmeOSWzL6OaFzpQPVHPSJnsL9s-~T6NgFCqEI5ypyvICo2d6Xqtd1UncQJlinV3ERFYnZDRZ0H1aOmsvDM92vfPnFc--4nshOZ4n0dFToTDdT7EbSSA5Py-Pw6YsaBqvccXA__&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4",
    "https://images.unsplash.com/photo-1524638067-feba7e8ed70f?q=80&w=1536&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    "https://images.unsplash.com/photo-1587790032594-babe1292cede?q=80&w=2519&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  ];
  List<String> price = [
    "90",
    "80",
    "50",
    "40",
    "20",
    "234",
    "120",
    "123",
  ];

  late TabController _tabController;
  int _currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: const SizedBox(),
            pinned: true,
            stretch: true,
            floating: true,
            backgroundColor: AppColors.primaryColor,
            expandedHeight: getProportionateScreenHeight(200),
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              centerTitle: false,
              titlePadding: const EdgeInsets.only(bottom: 10, left: 20, top: 10),
              expandedTitleScale: 1.2,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children : [
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
                            "Sort",
                            style: TextStyle(
                              color: Color(0xFF989898),
                              fontSize: 13,
                            ),
                          ),
                          Icon(
                            Icons.sort,
                            size: 18,
                            color: Color(0xFF989898),
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
                              color: Color(0xFF989898),
                              fontSize: 13,
                            ),
                          ),
                          Icon(
                            Icons.sort,
                            size: 18,
                            color: Color(0xFF989898),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              background: const SliverBackgroundWidget(),
            ),
          ),
          SliverToBoxAdapter(
            child: RewardTierTabWidget(
              onTabChanged: (index) {
                setState(() {
                  _currentTabIndex = index;
                  _tabController.index = index;
                }
                );
              },
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(15),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: getProportionateScreenHeight(250),
                mainAxisSpacing: 15.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 0.9,
              ),
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return TabBarView(
                    controller: _tabController,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.primaryWhiteColor,
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.31),
                              blurRadius: 4.10,
                              offset: Offset(2, 4),
                              spreadRadius: 0,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              flex: 4,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
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
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  "${price[index]} " " Points",
                                  style: const TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Your second tab content
                      Container(
                        child: Center(
                          child: Text("Partner Rewards"),
                        ),
                      ),
                      // Your third tab content
                      Container(
                        child: Center(
                          child: Text("Brand Rewards"),
                        ),
                      ),
                    ],
                  );
                },
                childCount: img.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
