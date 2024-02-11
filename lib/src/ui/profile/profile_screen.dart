import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lets_collect/src/constants/colors.dart';
import 'package:lets_collect/src/utils/data/object_factory.dart';
import 'package:lets_collect/src/utils/screen_size/size_config.dart';

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
  Widget build(BuildContext context) {
    // Get.lazyPut(() => ImageController());
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
                      child: GestureDetector(
                          onTap: () {
                            _pickImage();
                          },
                          child: _pickedFile != null
                              ? Container(
                            alignment: Alignment.center,
                            width: 130,
                            height: 130,
                            // color: Colors.grey[300],
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              // borderRadius: BorderRadius.circular(100),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.file(
                                File(_pickedFile!.path),
                                width: 130,
                                height: 130,
                                fit: BoxFit.cover,
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
                            child: const Stack(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Text("Add"),
                                ),
                                Positioned(
                                    bottom: 8,
                                    right: 8,
                                    child: Icon(
                                      Icons.add_a_photo_outlined,
                                      color: AppColors.secondaryColor,
                                    )
                                  // Image.asset(Assets.NO_PROFILE_IMG,scale: 20),
                                ),
                              ],
                            ),
                          )),
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
                        context.push("/my_profile");
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
                  Padding(
                    padding: const EdgeInsets.only(top: 18),
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
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
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
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
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
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: GestureDetector(
                      onTap: () {
                        ObjectFactory().prefs.setIsLoggedIn(false);
                        ObjectFactory().prefs.clearPrefs();
                        context.go('/login');
                      },
                      child: ProfileDetailsListTileWidget(
                        labelText: 'Log Out',
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
                ],
              ),
            ]),
          ),
          padding:
              const EdgeInsets.only(top: 25, left: 15, right: 15, bottom: 110),
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
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Color(0x4F000000),
              blurRadius: 4.10,
              offset: Offset(2, 4),
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
              const Icon(
                Icons.arrow_forward_ios_sharp,
                size: 19,
              )
            ],
          ),
        ),
      ),
    );
  }
}
