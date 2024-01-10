import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_collect/src/constants/colors.dart';
import 'package:lets_collect/src/utils/screen_size/size_config.dart';

class ProfileScreen extends StatelessWidget {

  const ProfileScreen({super.key});



  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          leading: const SizedBox(),
          pinned: true,
          stretch: true,
          floating: true,
          // collapsedHeight: 60,
          backgroundColor: AppColors.primaryColor,
          expandedHeight: getProportionateScreenHeight(200),
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          flexibleSpace: const FlexibleSpaceBar(
            collapseMode: CollapseMode.parallax,
            centerTitle: false,
            titlePadding: EdgeInsets.only(bottom: 10, left: 20,top: 10),
            expandedTitleScale: 1.2,


            title: Center(
              child: Column(
                children: [
                  SizedBox(height: 70,),
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 50,
                    backgroundImage:  NetworkImage(
                      "https://s3-alpha-sig.figma.com/img/d067/c913/ad868d019f92ce267e6de23af3413e5b?Expires=1705276800&Signature=MwbzwPFm9CnAjE7oHBByXiNvOJEUR~pvprZnzXtocbYZYSoqBMXiO4LEfr1sMACBDUfVZeJzHzJ-vlDN8yCk~0BSRgDjsYzRxM6MaoG97Mq65xC~hvQ0nH-zZR-VPdqF5d0Wy2MmG-QaEA46hNZu3Wn08uUD0XmC0BcmD~BKPsz7Wkl3qGn6sB-S9j6duqNIdGzkfVIv6j~KB9IhpYJl5pGL2Yk1rxfDdskfVoOEhguhrIIul3QCOlKVZcRI6MpV3Bda~MaY-VJ~o1bFtaR8Ru0R0fpMoa8VxjSOZlHAtpaUOB9Qg-frB~hRVg-xEdrv60DctNjJpKzRBlWt~Xbu~w__&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4"
                    ),
                  ),

                  Text("Sarah",style: TextStyle(color: Colors.pink),),
                  SizedBox(width: 15),
                ],
              ),
            ),
          ),
        ),
        SliverPadding(
          sliver: SliverList(delegate: SliverChildListDelegate([
            Column(
              children: [
                SizedBox(height: 30,),
                ProfileDetailsListTileWidget(
                  onPressed: () {
                    context.push("/myProfile");
                    print("MyProfile tapped!");
                  },
                  labelText: 'My profile',
                  textStyle: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  letterSpacing: 0, // This is the default value for normal line height
                ),),
                SizedBox(height:10,),
                ProfileDetailsListTileWidget(labelText: 'Point Tracker',
                  textStyle: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  letterSpacing: 0, // This is the default value for normal line height
                ),
                ),
                SizedBox(height:10,),
                ProfileDetailsListTileWidget(labelText: 'Redmeption Tracker',
                  textStyle: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  letterSpacing: 0, // This is the default value for normal line height
                ),),
                SizedBox(height:10,),
                ProfileDetailsListTileWidget(labelText: 'Purchase History',
                  textStyle: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    letterSpacing: 0, // This is the default value for normal line height
                  ),),
                SizedBox(height:10,),
                ProfileDetailsListTileWidget(labelText: 'Help',
                  textStyle: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    letterSpacing: 0, // This is the default value for normal line height
                  ),),
                SizedBox(height:10,),
                ProfileDetailsListTileWidget(labelText: 'Notification Center',
                  textStyle: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    letterSpacing: 0, // This is the default value for normal line height
                  ),),
                SizedBox(height:10,),
                ProfileDetailsListTileWidget(labelText: 'Refer a Friend',
                  textStyle: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    letterSpacing: 0, // This is the default value for normal line height
                  ),),
                SizedBox(height:10,),
                ProfileDetailsListTileWidget(labelText: 'Log Out',
                  textStyle: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    letterSpacing: 0, // This is the default value for normal line height
                  ),
                ),
              ],
            ),
          ]),

          ),
          padding:
          const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 100),
        ),
      ],
    );

  }
}




class ProfileDetailsListTileWidget extends StatelessWidget {
  final String labelText;
  final TextStyle? textStyle;

  final VoidCallback? onPressed;

  const ProfileDetailsListTileWidget({
    Key? key,
    this.textStyle,
    required this.labelText,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(labelText,
              style: textStyle,),
              Icon(Icons.arrow_forward_ios_sharp)
            ],
          ),
        ),
      ),
    );
  }
}
