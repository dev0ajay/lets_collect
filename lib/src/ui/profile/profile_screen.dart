import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lets_collect/src/bloc/home_bloc/home_bloc.dart';
import 'package:lets_collect/src/bloc/my_profile_bloc/my_profile_bloc.dart';
import 'package:lets_collect/src/constants/assets.dart';
import 'package:lets_collect/src/constants/colors.dart';
import 'package:lets_collect/src/ui/profile/widgets/delete_account_alert_widget.dart';
import 'package:lets_collect/src/ui/profile/widgets/log_out_alert_widget.dart';
import 'package:lets_collect/src/utils/network_connectivity/bloc/network_bloc.dart';
import 'package:lets_collect/src/utils/screen_size/size_config.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../bloc/country_bloc/country_bloc.dart';
import '../../bloc/nationality_bloc/nationality_bloc.dart';
import 'components/my_profile_screen_arguments.dart';



class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with WidgetsBindingObserver{
  bool networkSuccess = false;

  // void showLanguageBottomSheet(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.only(
  //         topLeft: Radius.circular(20.0),
  //         topRight: Radius.circular(20.0),
  //       ),
  //     ),
  //     builder: (context) {
  //       return Padding(
  //         padding: const EdgeInsets.all(16.0),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Text(
  //               AppLocalizations.of(context)!.changelanguage,
  //               style: GoogleFonts.openSans(
  //                 color: AppColors.secondaryColor,
  //                 fontSize: 18,
  //                 fontWeight: FontWeight.w700,
  //               ),
  //             ),
  //             const SizedBox(height: 16.0),
  //             BlocBuilder<LanguageBloc, LanguageState>(
  //               builder: (context, state) {
  //                 return ListView.separated(
  //                   shrinkWrap: true,
  //                   itemCount: Language.values.length,
  //                   itemBuilder: (context, index) {
  //                     return ListTile(
  //                       onTap: () {
  //                         context.read<LanguageBloc>().add(ChangeLanguage(
  //                             selectedLanguage: Language.values[index]));
  //                         Future.delayed(const Duration(milliseconds: 300))
  //                             .then((value) => Navigator.of(context).pop());
  //                       },
  //                       leading: ClipOval(
  //                         child: Language.values[index].image.image(
  //                           height: 32.0,
  //                           width: 32.0,
  //                         ),
  //                       ),
  //                       title: Text(Language.values[index].text),
  //                       trailing:
  //                       Language.values[index] == state.selectedLanguage
  //                           ? Icon(Icons.check_circle_rounded,
  //                           color: AppColors.secondaryColor)
  //                           : null,
  //                       shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(10.0),
  //                         side: Language.values[index] == state.selectedLanguage
  //                             ? BorderSide(color: Colors.grey, width: 1.5)
  //                             : BorderSide(color: Colors.grey[300]!),
  //                       ),
  //                       tileColor:
  //                       Language.values[index] == state.selectedLanguage
  //                           ? Colors.grey
  //                           : null,
  //                     );
  //                   },
  //                   separatorBuilder: (context, index) {
  //                     return const SizedBox(height: 16.0);
  //                   },
  //                 );
  //               },
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }




  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    BlocProvider.of<MyProfileBloc>(context).add(GetProfileDataEvent());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NetworkBloc, NetworkState>(
      builder: (context, state) {
        if (state is NetworkSuccess) {
          return BlocBuilder<MyProfileBloc, MyProfileState>(
            builder: (context, state) {
              if (state is MyProfileLoading) {
                return const Center(
                  child: RefreshProgressIndicator(
                    color: AppColors.secondaryColor,
                    backgroundColor: AppColors.primaryWhiteColor,
                  ),
                );
              }
              if (state is MyProfileErrorState) {
                return Center(
                  child: Column(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Lottie.asset(Assets.TRY_AGAIN),
                      ),
                      Flexible(
                        flex: 2,
                        child: Text(
                          state.errorMsg,
                          style: const TextStyle(
                              color: AppColors.primaryWhiteColor),
                        ),
                      ),
                      const Spacer(),
                      Flexible(
                        flex: 1,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(9),
                              ),
                              fixedSize: const Size(100, 50),
                              backgroundColor: AppColors.primaryColor),
                          onPressed: () {
                            BlocProvider.of<MyProfileBloc>(context)
                                .add(GetProfileDataEvent());
                          },
                          child: const Text(
                            "Try again",
                            style:
                                TextStyle(color: AppColors.primaryWhiteColor),
                          ),
                        ),
                      ),
                      // const Text("state"),
                    ],
                  ),
                );
              }
              if (state is MyProfileLoaded) {
                String b64 =
                    state.myProfileScreenResponse.data!.photo.toString();
                final UriData? data = Uri.parse(b64).data;
                Uint8List bytesImage = data!.contentAsBytes();
                print("PHOTO CODE : $bytesImage");
                return CustomScrollView(
                  physics: const ClampingScrollPhysics(),
                  slivers: [
                    SliverAppBar(
                      leading: const SizedBox(),
                      pinned: false,
                      stretch: true,

                      // snap: true,
                      // collapsedHeight: 60,
                      backgroundColor: AppColors.primaryColor,
                      expandedHeight: getProportionateScreenHeight(220),
                      elevation: 0,
                      systemOverlayStyle: SystemUiOverlayStyle.light,
                      shape: const ContinuousRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        background: SafeArea(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                    flex: 3,
                                    child: bytesImage != null
                                        ? Container(
                                            width: 150.0,
                                            height: 150.0,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              // border: Border.all(
                                              //   color: AppColors.secondaryColor,
                                              //   width: 2.0,
                                              // ),
                                              image: DecorationImage(
                                                alignment: Alignment.center,
                                                fit: BoxFit.cover,
                                                image: MemoryImage(bytesImage),
                                              ),
                                            ),
                                          )
                                        : Container(
                                            alignment: Alignment.center,
                                            width: 130,
                                            height: 130,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppColors.shadow,
                                              // borderRadius: BorderRadius.circular(100),
                                            ),
                                            child: const Stack(children: [
                                              Align(
                                                alignment: Alignment.center,
                                                child: Text("Add"),
                                              ),
                                              Positioned(
                                                  bottom: 8,
                                                  right: 8,
                                                  child: Icon(
                                                    Icons.add_a_photo_outlined,
                                                    color: AppColors
                                                        .secondaryColor,
                                                  )
                                                  // Image.asset(Assets.NO_PROFILE_IMG,scale: 20),
                                                  ),
                                            ]))),
                                const SizedBox(height: 10),
                                Flexible(
                                  flex: 1,
                                  child: Text(
                                    // ObjectFactory().prefs.getUserName() ??
                                    state.myProfileScreenResponse.data!.firstName
                                        .toString(),
                                    style: GoogleFonts.openSans(
                                      color: AppColors.secondaryColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.fade,
                                    maxLines: 3,
                                    softWrap: true,
                                  ),
                                ),
                                const SizedBox(width: 15),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SliverPadding(
                      sliver: SliverList(
                        delegate: SliverChildListDelegate([
                          Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),

                              ///Language Selection
                              // GestureDetector(
                              //   onTap: () {
                              //     showLanguageBottomSheet(context);
                              //   },
                              //   child: Container(
                              //     height: 40,
                              //     decoration: BoxDecoration(
                              //       borderRadius: BorderRadius.circular(10.0),
                              //       color: Colors.white,
                              //       boxShadow: const [
                              //         BoxShadow(
                              //           color: Color(0x4F000000),
                              //           blurRadius: 4.10,
                              //           offset: Offset(2, 4),
                              //           spreadRadius: 0,
                              //         ),
                              //       ],
                              //     ),
                              //     child: Padding(
                              //       padding: const EdgeInsets.only(
                              //           top: 8.0,
                              //           bottom: 8.0,
                              //           right: 8.0,
                              //           left: 8.0),
                              //       child: Row(
                              //         mainAxisAlignment:
                              //         MainAxisAlignment.spaceBetween,
                              //         children: [
                              //           Text(
                              //             AppLocalizations.of(context)!
                              //                 .changelanguage,
                              //             style: GoogleFonts.roboto(
                              //               fontSize: 16,
                              //               fontWeight: FontWeight.w500,
                              //               fontStyle: FontStyle.normal,
                              //               letterSpacing:
                              //               0, // This is the default value for normal line height
                              //             ),
                              //           ),
                              //           SizedBox(
                              //             width: 150,
                              //           ),
                              //           Container(
                              //             height: 20,
                              //             child: BlocBuilder<LanguageBloc,
                              //                 LanguageState>(
                              //               builder: (context, state) {
                              //                 return state
                              //                     .selectedLanguage.image
                              //                     .image();
                              //               },
                              //             ),
                              //           ),
                              //           const Icon(
                              //             Icons.arrow_forward_ios_sharp,
                              //             size: 19,
                              //           )
                              //         ],
                              //       ),
                              //     ),
                              //   ),
                              // ).animate().then(delay: 200.ms).slideY(),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 0),
                                child: ProfileDetailsListTileWidget(
                                  onPressed: () {
                                    context.push(
                                      "/my_profile",
                                      extra: MyProfileArguments(
                                        first_name: state
                                            .myProfileScreenResponse
                                            .data!
                                            .firstName
                                            .toString(),
                                        last_name: state.myProfileScreenResponse
                                            .data!.lastName
                                            .toString(),
                                        email: state
                                            .myProfileScreenResponse.data!.email
                                            .toString(),
                                        mobile_no: state.myProfileScreenResponse
                                            .data!.mobileNo
                                            .toString(),
                                        user_name: state.myProfileScreenResponse
                                            .data!.userName
                                            .toString(),
                                        gender: state.myProfileScreenResponse
                                            .data!.gender
                                            .toString(),
                                        dob:  state
                                            .myProfileScreenResponse.data!.dob.toString(),
                                        nationality_name_en: state
                                            .myProfileScreenResponse
                                            .data!
                                            .nationalityNameEn
                                            .toString(),
                                        city_name: state.myProfileScreenResponse
                                            .data!.cityName
                                            .toString(),
                                        country_name_en: state
                                            .myProfileScreenResponse
                                            .data!
                                            .countryNameEn
                                            .toString(),
                                        photo: state
                                            .myProfileScreenResponse.data!.photo
                                            .toString(),
                                        nationality_id: state
                                            .myProfileScreenResponse
                                            .data!
                                            .nationalityId!
                                            .toInt(),
                                        country_id: state
                                            .myProfileScreenResponse
                                            .data!
                                            .countryId!
                                            .toInt(),
                                        city: state
                                            .myProfileScreenResponse.data!.city
                                            .toString(),
                                      ),
                                    );
                                    print("MyProfile tapped!");
                                  },
                                  labelText: "My Profile",
                                  // AppLocalizations.of(context)!.myprofile,
                                  textStyle: GoogleFonts.roboto(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                    letterSpacing:
                                        0, // This is the default value for normal line height
                                  ),
                                ),
                              ).animate().then(delay: 200.ms).slideY(),
                              Padding(
                                padding: const EdgeInsets.only(top: 18),
                                child: ProfileDetailsListTileWidget(
                                  onPressed: () {
                                    context.push("/Point_Tracker");
                                    print("Point Tracker tapped!");
                                  },
                                  labelText: "Point Tracker",
                                  // AppLocalizations.of(context)!
                                  //     .pointtracker,
                                  textStyle: GoogleFonts.roboto(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                    letterSpacing:
                                        0, // This is the default value for normal line height
                                  ),
                                ),
                              ).animate().then(delay: 200.ms).slideY(),
                              Padding(
                                padding: const EdgeInsets.only(top: 18),
                                child: ProfileDetailsListTileWidget(
                                  onPressed: () {
                                    // showDialog(
                                    //   context: context,
                                    //   builder: (BuildContext context) {
                                    //     return AlertDialog(
                                    //       shape: RoundedRectangleBorder(
                                    //           borderRadius:
                                    //               BorderRadius.circular(10)),
                                    //       content: SizedBox(
                                    //         height:
                                    //             getProportionateScreenHeight(
                                    //                 260),
                                    //         width: getProportionateScreenWidth(
                                    //             320),
                                    //         child: Lottie.asset(Assets.SOON),
                                    //       ),
                                    //     );
                                    //   },
                                    // );
                                    context.push("/redemption");
                                  },
                                  labelText: "Redemption Tracker",
                                  // AppLocalizations.of(context)!
                                  //     .redemptiontracker,
                                  textStyle: GoogleFonts.roboto(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                    letterSpacing:
                                        0, // This is the default value for normal line height
                                  ),
                                ),
                              ).animate().then(delay: 200.ms).slideY(),
                              Padding(
                                padding: const EdgeInsets.only(top: 18.0),
                                child: ProfileDetailsListTileWidget(
                                  onPressed: () {
                                    context.push("/Purchase_History");
                                    print("Purchase History tapped!");
                                  },
                                  labelText: "Purchase History",
                                  // AppLocalizations.of(context)!
                                  //     .purchasehistory,
                                  textStyle: GoogleFonts.roboto(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                    letterSpacing:
                                        0, // This is the default value for normal line height
                                  ),
                                ),
                              ).animate().then(delay: 200.ms).slideY(),
                              Padding(
                                padding: const EdgeInsets.only(top: 18.0),
                                child: GestureDetector(
                                  onTap: () {
                                    context.push('/help');
                                  },
                                  child: ProfileDetailsListTileWidget(
                                    labelText: "Help",
                                    // AppLocalizations.of(context)!.help,
                                    textStyle: GoogleFonts.roboto(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal,
                                      letterSpacing:
                                          0, // This is the default value for normal line height
                                    ),
                                  ),
                                ),
                              ).animate().then(delay: 200.ms).slideY(),
                              Padding(
                                padding: const EdgeInsets.only(top: 18.0),
                                child: GestureDetector(
                                  onTap: () {
                                    context.push('/notification');
                                  },
                                  child: ProfileDetailsListTileWidget(
                                    labelText: "Notification center",
                                    // AppLocalizations.of(context)!
                                    //     .notificationcenter,
                                    textStyle: GoogleFonts.roboto(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal,
                                      letterSpacing:
                                          0, // This is the default value for normal line height
                                    ),
                                  ),
                                ),
                              ).animate().then(delay: 200.ms).slideY(),
                              Padding(
                                padding: const EdgeInsets.only(top: 18.0),
                                child: GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          content: SizedBox(
                                            height:
                                                getProportionateScreenHeight(
                                                    260),
                                            width: getProportionateScreenWidth(
                                                320),
                                            child: Lottie.asset(Assets.SOON),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: ProfileDetailsListTileWidget(
                                    labelText: "Refer a friend",
                                    // AppLocalizations.of(context)!
                                    //     .referafriend,
                                    textStyle: GoogleFonts.roboto(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal,
                                      letterSpacing:
                                          0, // This is the default value for normal line height
                                    ),
                                  ),
                                ),
                              ).animate().then(delay: 200.ms).slideY(),
                              Padding(
                                padding: const EdgeInsets.only(top: 18.0),
                                child: GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          const DeleteAccountAlertOverlay(),
                                    );
                                  },
                                  child: ProfileDetailsListTileWidget(
                                    labelText: "Delete Account",
                                    // AppLocalizations.of(context)!
                                    //     .referafriend,
                                    textStyle: GoogleFonts.roboto(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal,
                                      letterSpacing:
                                          0, // This is the default value for normal line height
                                    ),
                                  ),
                                ),
                              ).animate().then(delay: 200.ms).slideY(),
                              Padding(
                                padding: const EdgeInsets.only(top: 50),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: const Size(300, 50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    backgroundColor: AppColors.primaryColor,
                                  ),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            const LogOutAlertOverlay());
                                  },
                                  child: const Text(
                                    "Log out",
                                    style: TextStyle(
                                      color: AppColors.secondaryColor,
                                    ),
                                  ),
                                ),
                              ).animate().then(delay: 200.ms).slideY(),
                            ],
                          ),
                        ]),
                      ),
                      padding: const EdgeInsets.only(
                          top: 0, left: 15, right: 15, bottom: 110),
                    ),
                  ],
                );
              } else {
                return const SizedBox();
              }
            },
          );
        } else if (state is NetworkFailure) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(Assets.NO_INTERNET),
                Text(
                  "You are not connected to the internet",
                  style: GoogleFonts.openSans(
                    color: AppColors.primaryGrayColor,
                    fontSize: 20,
                  ),
                ).animate().scale(delay: 200.ms, duration: 300.ms),
              ],
            ),
          );
        }
        return const SizedBox();
      },
      listener: (BuildContext context, NetworkState state) {
        if (state is NetworkSuccess) {
          networkSuccess = true;
        }
      },
    );
  }


}

class ProfileDetailsListTileWidget extends StatelessWidget {
  final String labelText;
  final TextStyle? textStyle;

  final VoidCallback? onPressed;

  const ProfileDetailsListTileWidget({
    super.key,
    this.textStyle,
    required this.labelText,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: AppColors.primaryWhiteColor,
          boxShadow: const [
            BoxShadow(
              color: AppColors.boxShadow,
              blurRadius: 4,
              offset: Offset(4, 2),
              spreadRadius: 0,
            ),
            BoxShadow(
              color: Color(0x4F000000),
              blurRadius: 2,
              offset: Offset(4, 2),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              top: 8.0, bottom: 8.0, right: 8.0, left: 13.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                labelText,
                style: textStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// void _showDialogBox({
//   required BuildContext context,
// }) {
//   showDialog(
//     context: context,
//     builder: (ctx) => SizedBox(
//       width: 700,
//       child: AlertDialog(
//         backgroundColor: AppColors.primaryWhiteColor,
//         // elevation: 5,
//         alignment: Alignment.center,
//         content: SizedBox(
//           height: getProportionateScreenHeight(170),
//           width: getProportionateScreenWidth(500),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Align(
//                 alignment: Alignment.topLeft,
//                 child: IconButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   icon: const Icon(Icons.close),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               Text(
//                 AppLocalizations.of(context)!.areyousureyouwanttologout,
//                 textAlign: TextAlign.center,
//                 style: GoogleFonts.openSans(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//               const SizedBox(height: 40),
//               Padding(
//                 padding: const EdgeInsets.only(left: 10, right: 10),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Expanded(
//                       child: MyButton(
//                         Textfontsize: 16,
//                         TextColors: Colors.white,
//                         text: AppLocalizations.of(context)!.yes,
//                         color: AppColors.secondaryColor,
//                         height: 5,
//                         onTap: () {
//                           ObjectFactory().prefs.setIsLoggedIn(false);
//                           ObjectFactory().prefs.clearPrefs();
//                           context.go('/login');
//                         },
//                         showImage: false,
//                         imagePath: '',
//                         imagewidth: 0,
//                         imageheight: 0,
//                         width: 120,
//                       ),
//                     ),
//                     SizedBox(
//                       width: 20,
//                     ),
//                     Expanded(
//                       child: MyButton(
//                         Textfontsize: 16,
//                         TextColors: Colors.white,
//                         text: ""
//                         // AppLocalizations.of(context)!.no,
//                         color: AppColors.secondaryColor,
//                         height: 5,
//                         onTap: () {
//                           Navigator.of(context).pop();
//                         },
//                         showImage: false,
//                         imagePath: '',
//                         imagewidth: 0,
//                         imageheight: 0,
//                         width: 120,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ),
//   );
// }
