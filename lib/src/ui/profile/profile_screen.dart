import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lets_collect/src/constants/colors.dart';
import 'package:lets_collect/src/ui/profile/widgets/log_out_alert_widget.dart';
import 'package:lets_collect/src/utils/data/object_factory.dart';
import 'package:lets_collect/src/utils/screen_size/size_config.dart';
import 'package:lottie/lottie.dart';

import '../../bloc/country_bloc/country_bloc.dart';
import '../../bloc/my_profile_bloc/my_profile_bloc.dart';
import '../../bloc/nationality_bloc/nationality_bloc.dart';
import '../../constants/assets.dart';
import 'components/my_profile_screen_arguments.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _image;
  XFile? _pickedFile;
  final _picker = ImagePicker();

// Implementing the image picker
  Future<void> _pickImage() async {
    _pickedFile = (await _picker.pickImage(source: ImageSource.gallery));
    if (_pickedFile != null) {
      setState(() {
        _image = File(_pickedFile!.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<MyProfileBloc>(context).add(GetProfileDataEvent());

  }

  @override
  Widget build(BuildContext context) {
    // Get.lazyPut(() => ImageController());
    return BlocConsumer<MyProfileBloc, MyProfileState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is MyProfileLoading) {
          return const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: RefreshProgressIndicator(
                  backgroundColor: AppColors.primaryWhiteColor,
                  color: AppColors.secondaryColor,
                ),
              ),
            ],
          );
        }
        if (state is MyProfileLoaded) {
          BlocProvider.of<NationalityBloc>(context).add(GetNationality());
          BlocProvider.of<CountryBloc>(context).add(GetCountryEvent());
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
                            child: Container(
                              alignment: Alignment.center,
                              width: 130,
                              height: 130,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.shadow,
                                // borderRadius: BorderRadius.circular(100),
                              ),
                              child: const Align(
                                alignment: Alignment.center,
                                child: Text("Picture",style: TextStyle(color: AppColors.hintColor),),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Flexible(
                              flex: 1,
                              child: Text(
                                ObjectFactory().prefs.getUserName() ?? "",
                                style: GoogleFonts.openSans(
                                  color: AppColors.secondaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.fade,
                                maxLines: 3,
                                softWrap: true,
                              )),
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
                        Padding(
                          padding: const EdgeInsets.only(top: 0),
                          child: ProfileDetailsListTileWidget(
                            onPressed: () {
                              context.push("/my_profile",
                                  extra: MyProfileArguments(
                                    first_name: state.myProfileScreenResponse
                                        .data!.firstName
                                        .toString(),
                                    last_name: state.myProfileScreenResponse.data!.lastName.toString(),
                                    email:state.myProfileScreenResponse.data!.email.toString(),
                                    mobile_no:state.myProfileScreenResponse.data!.mobileNo.toString(),
                                    user_name:state.myProfileScreenResponse.data!.userName.toString(),
                                    gender:state.myProfileScreenResponse.data!.gender.toString(),
                                    dob:state.myProfileScreenResponse.data!.dob.toString(),
                                    nationality_name_en:state.myProfileScreenResponse.data!.nationalityNameEn.toString(),
                                    city_name:state.myProfileScreenResponse.data!.cityName.toString(),
                                    country_name_en:state.myProfileScreenResponse.data!.countryNameEn.toString(),
                                  ),
                              );
                              print("MyProfile tapped!");
                            },
                            labelText: 'My profile',
                            textStyle: GoogleFonts.roboto(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                              letterSpacing:
                                  0, // This is the default value for normal line height
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 18),
                          child: InkWell(
                            onTap: () {
                             context.push('/point_tracker');
                            },
                            child: ProfileDetailsListTileWidget(
                              labelText: 'Point Tracker',
                              textStyle: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                                letterSpacing:
                                    0, // This is the default value for normal line height
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 18),
                          child: InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    content: SizedBox(
                                      height: getProportionateScreenHeight(260),
                                      width: getProportionateScreenWidth(320),
                                      child: Lottie.asset(Assets.SOON),
                                    ),
                                  );
                                },
                              );
                            },
                            child: ProfileDetailsListTileWidget(
                              labelText: 'Redmeption Tracker',
                              textStyle: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                                letterSpacing:
                                    0, // This is the default value for normal line height
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 18.0),
                          child: InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    content: SizedBox(
                                      height: getProportionateScreenHeight(260),
                                      width: getProportionateScreenWidth(320),
                                      child: Lottie.asset(Assets.SOON),
                                    ),
                                  );
                                },
                              );
                            },
                            child: InkWell(
                              onTap: () {
                                context.push('/purchase_history');
                              },
                              child: ProfileDetailsListTileWidget(
                                labelText: 'Purchase History',
                                textStyle: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                  letterSpacing:
                                      0, // This is the default value for normal line height
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 18.0),
                          child: GestureDetector(
                            onTap: () {
                              context.push('/help');
                            },
                            child: ProfileDetailsListTileWidget(
                              labelText: 'Help',
                              textStyle: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                                letterSpacing:
                                    0, // This is the default value for normal line height
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 18.0),
                          child: InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(10)),
                                    content: SizedBox(
                                      height: getProportionateScreenHeight(260),
                                      width: getProportionateScreenWidth(320),
                                      child: Lottie.asset(Assets.SOON),
                                    ),
                                  );
                                },
                              );
                            },
                            child: ProfileDetailsListTileWidget(
                              labelText: 'Notification Center',
                              textStyle: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                                letterSpacing:
                                    0, // This is the default value for normal line height
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 18.0),
                          child: InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    content: SizedBox(
                                      height: getProportionateScreenHeight(260),
                                      width: getProportionateScreenWidth(320),
                                      child: Lottie.asset(Assets.SOON),
                                    ),
                                  );
                                },
                              );
                            },
                            child: ProfileDetailsListTileWidget(
                              labelText: 'Refer a Friend',
                              textStyle: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                                letterSpacing:
                                    0, // This is the default value for normal line height
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
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
                                  builder: (BuildContext context) => const LogOutAlertOverlay()
                              );

                            },
                            child: const Text(
                              "Log out",
                              style: TextStyle(
                                color: AppColors.secondaryColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]),
                ),
                padding: const EdgeInsets.only(
                    top: 25, left: 15, right: 15, bottom: 130),
              ),
            ],
          );
        }
        return const SizedBox();
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
              color: AppColors.boxShadow,
              blurRadius: 4,
              offset: Offset(-4, -2),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              top: 8.0, bottom: 8.0, right: 8.0, left: 13.0),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
