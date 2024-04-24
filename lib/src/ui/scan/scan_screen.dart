// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lets_collect/src/bloc/scan_bloc/scan_bloc.dart';
import 'package:lets_collect/src/ui/scan/components/scan_detail_screen_argument.dart';
import 'package:lets_collect/src/ui/scan/components/widgets/scan_screen_collect_button.dart';
import 'package:lets_collect/src/utils/screen_size/size_config.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../constants/assets.dart';
import '../../constants/colors.dart';
import 'package:path/path.dart' as p;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../utils/network_connectivity/bloc/network_bloc.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class ScanScreen extends StatefulWidget {
  final String from;

  const ScanScreen({super.key, required this.from});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> with WidgetsBindingObserver {
  File? galleryFile;
  String imageBase64 = "";
  String extension = "";
  String imageUploadFormated = "";
  final _picker = ImagePicker();

  // Function to clear the picked image
  void _clearImage() {
    setState(() {
      galleryFile = null;
    });
  }

  void openSettings() {
    openAppSettings();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  ///Runtime User Access and Permission handling

  Future<void> checkPermissionForGallery(
      Permission permission, BuildContext context) async {
    final status = await permission.request();
    if (status.isGranted) {
      print("Permission granted");
      getImage(ImageSource.gallery);
    } else if (status.isDenied) {
      print("Permission Denied");
      _showPermissionDialog(_scaffoldKey.currentContext!);
    } else if (status.isPermanentlyDenied) {
      print("Permission permanently denied");

      openSettings();
    } else if (status.isLimited) {
      print("Permission permanently denied");
      getImage(ImageSource.gallery);
    }
  }

  Future<void> checkPermissionForCamera(
      Permission permission, BuildContext context) async {
    final status = await permission.request();
    if (status.isGranted) {
      // _showPicker(context: context);
      print("Granted permission");
      getImage(ImageSource.camera);
      // getImage(ImageSource.camera);
    } else if (status.isDenied) {
      print("Permission denied");
      // ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(content: Text("Permission is not Granted")));
      _showPermissionDialog(context);
    } else if (status.isPermanentlyDenied) {
      openSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocConsumer<NetworkBloc, NetworkState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is NetworkFailure) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(Assets.NO_INTERNET),
                Text(
                  // "You are not connected to the internet",
                  AppLocalizations.of(context)!.youarenotconnectedtotheinternet,
                  style: GoogleFonts.openSans(
                    color: AppColors.primaryGrayColor,
                    fontSize: 20,
                  ),
                ).animate().scale(delay: 200.ms, duration: 300.ms),
              ],
            ),
          );
        } else if (state is NetworkInitial) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(Assets.NO_INTERNET),
                Text(
                  // "You are not connected to the internet",
                  AppLocalizations.of(context)!.youarenotconnectedtotheinternet,
                  style: GoogleFonts.openSans(
                    color: AppColors.primaryGrayColor,
                    fontSize: 20,
                  ),
                ).animate().scale(delay: 200.ms, duration: 300.ms),
              ],
            ),
          );
        } else if (state is NetworkSuccess) {
          return BlocConsumer<ScanBloc, ScanState>(
            listener: (context, state) {
              if (state is ScanLoaded) {}
            },
            builder: (context, state) {
              return GestureDetector(
                onHorizontalDragUpdate: (details) {
                  if (widget.from == "Home" && details.delta.direction <= 0) {
                    context.pop();
                  }
                },
                child: Scaffold(
                  key: _scaffoldKey,
                  backgroundColor: AppColors.primaryWhiteColor,
                  resizeToAvoidBottomInset: false,
                  body: SingleChildScrollView(
                    child: SafeArea(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          galleryFile == null
                              ? Center(
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    margin: const EdgeInsets.only(
                                        top: 20, left: 15, right: 15),
                                    height: getProportionateScreenHeight(450),
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryWhiteColor,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: AppColors.borderColor,
                                          width: 1),
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        _showPicker(
                                            context:
                                                _scaffoldKey.currentContext!);
                                      },
                                      child: Center(
                                        child: ImageIcon(
                                          const AssetImage(Assets.UPLOAD),
                                          size:
                                              getProportionateScreenHeight(100),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Center(
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    margin: const EdgeInsets.only(
                                        top: 20, left: 15, right: 15),
                                    height: getProportionateScreenHeight(450),
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryWhiteColor,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: AppColors.borderColor,
                                          width: 1),
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        _showPicker(
                                            context:
                                                _scaffoldKey.currentContext!);
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Image.file(
                                          galleryFile!,
                                        ),
                                      ),
                                    ),
                                    // width: getProportionateScreenWidth(360),
                                  ),
                                ),
                          GestureDetector(
                            onTap: () {
                              context.push('/long_receipt');
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: DottedBorder(
                                borderType: BorderType.RRect,
                                color: AppColors.cardTextColor,
                                radius: const Radius.circular(10),
                                child: SizedBox(
                                  height: getProportionateScreenHeight(60),
                                  width: getProportionateScreenWidth(320),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!.ereciept,
                                        // "E-Reciept (or) Reciept too long?",
                                        style: GoogleFonts.roboto(
                                          color: AppColors.cardTextColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      const Icon(
                                        Icons.camera_alt,
                                        color: AppColors.cardTextColor,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 20),
                            child: InkWell(
                              splashColor: AppColors.secondaryButtonColor,
                              splashFactory: InkSplash.splashFactory,
                              onTap: () {
                                if (galleryFile != null) {
                                  BlocProvider.of<ScanBloc>(context).add(
                                    ScanReceiptEvent(
                                        data: FormData.fromMap(
                                            {"file": imageUploadFormated})),
                                  );
                                  _showDialogBox(context: context);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: AppColors.secondaryColor,
                                      content: Text(
                                        AppLocalizations.of(context)!
                                            .pleasechooseafile,
                                        // "Please choose a file.",
                                        style: GoogleFonts.roboto(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.primaryWhiteColor,
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: SizedBox(
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: ScanScreenCollectButton(
                                    text: AppLocalizations.of(context)!.collect,
                                    // 'Collect'
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
        return const SizedBox();
      },
    );
  }

  void _showDialogBox({
    required BuildContext context,
  }) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (ctx) {
          return BlocBuilder<ScanBloc, ScanState>(
            builder: (context, state) {
              if (state is ScanLoading) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: AppColors.primaryWhiteColor,
                  elevation: 5,
                  alignment: Alignment.center,
                  content: SizedBox(
                    height: getProportionateScreenHeight(260),
                    width: getProportionateScreenWidth(320),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            onPressed: () {
                              context.pop();
                              _clearImage();
                            },
                            icon: const Icon(Icons.close),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Flexible(
                          flex: 3,
                          child: Center(
                            child: Image.asset(
                              Assets.APP_LOGO,
                              height: 95,
                              width: 150,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Flexible(
                          flex: 2,
                          child: Text(
                            AppLocalizations.of(context)!.wearecruching,
                            // "We are crunching those points for you",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.openSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Flexible(
                          flex: 1,
                          child: Text(
                            AppLocalizations.of(context)!.pleaseholdtight,
                            // "Please hold tight !",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Flexible(
                          flex: 3,
                          child: Lottie.asset(Assets.SCANING),
                        ),
                      ],
                    ),
                  ),
                );
              }
              if (state is ScanLoaded) {
                if (state.scanReceiptRequestResponse.success == false &&
                    state.scanReceiptRequestResponse.statusCode == 400) {
                  return AlertDialog(
                    backgroundColor: AppColors.primaryWhiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5,
                    alignment: Alignment.center,
                    content: SizedBox(
                      height: getProportionateScreenHeight(260),
                      width: getProportionateScreenWidth(320),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: IconButton(
                              onPressed: () {
                                context.pop();
                                _clearImage();
                              },
                              icon: const Icon(Icons.close),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Flexible(
                            flex: 3,
                            child: Center(
                              child: Image.asset(
                                Assets.APP_LOGO,
                                height: 95,
                                width: 150,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Flexible(
                            flex: 2,
                            child: Text(
                              AppLocalizations.of(context)!
                                  .oopslookslikewearefacing,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.openSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                if (state.scanReceiptRequestResponse.success == false) {
                  return AlertDialog(
                    backgroundColor: AppColors.primaryWhiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5,
                    alignment: Alignment.center,
                    content: SizedBox(
                        height: getProportionateScreenHeight(260),
                        width: getProportionateScreenWidth(320),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: IconButton(
                                onPressed: () {
                                  context.pop();
                                  _clearImage();
                                },
                                icon: const Icon(Icons.close),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Flexible(
                              flex: 3,
                              child: Center(
                                child: Image.asset(
                                  Assets.APP_LOGO,
                                  height: 95,
                                  width: 150,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Flexible(
                              flex: 2,
                              child: Text(
                                state.scanReceiptRequestResponse.message!,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.openSans(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        )),
                  );
                } else {
                  return AlertDialog(
                    backgroundColor: AppColors.primaryWhiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5,
                    alignment: Alignment.center,
                    content: SizedBox(
                        height: getProportionateScreenHeight(260),
                        width: getProportionateScreenWidth(320),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: IconButton(
                                onPressed: () {
                                  context.pop();
                                  _clearImage();
                                },
                                icon: const Icon(Icons.close),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Flexible(
                              flex: 2,
                              child: Center(
                                child: Image.asset(
                                  Assets.APP_LOGO,
                                  height: 95,
                                  width: 150,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Flexible(
                              flex: 1,
                              child: Text(
                                "${AppLocalizations.of(context)!.totalpoints} : ${state.scanReceiptRequestResponse.data!.totalPoints.toString()} ",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.openSans(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Flexible(
                              flex: 2,
                              child: Visibility(
                                visible: state.scanReceiptRequestResponse.data!
                                        .totalPoints !=
                                    0,
                                child: TextButton(
                                  onPressed: () {
                                    _clearImage();
                                    context.push("/point_tracker_details",
                                        extra: state.scanReceiptRequestResponse
                                            .data!.pointId);
                                    context.pop();
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)!.viewdetails,
                                    style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.underlineColor,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  );
                }
              }
              if (state is ScanError) {
                return AlertDialog(
                  backgroundColor: AppColors.primaryWhiteColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5,
                  alignment: Alignment.center,
                  content: SizedBox(
                      height: getProportionateScreenHeight(260),
                      width: getProportionateScreenWidth(320),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: IconButton(
                              onPressed: () {
                                context.pop();
                                _clearImage();
                              },
                              icon: const Icon(Icons.close),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Flexible(
                            flex: 3,
                            child: Center(
                              child: Image.asset(
                                Assets.APP_LOGO,
                                height: 95,
                                width: 150,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Flexible(
                            flex: 2,
                            child: Text(
                              state.errorMsg,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.openSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      )),
                );
              }

              return const SizedBox();
            },
          );
        });
  }

  void _showPermissionDialog(BuildContext permissionDialogContext) {
    showDialog(
        context: _scaffoldKey.currentContext!,
        builder: (BuildContext permissionDialogContext) {
          return AlertDialog(
            title: Text(
              AppLocalizations.of(context)!.permissiondenied,
              // "Permission Denied!",
              style: GoogleFonts.openSans(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            content: Text(
              AppLocalizations.of(context)!
                  .tocontinuefileuploadallowaccesstofilesandstorage,
              // "To continue file upload allow access to files and storage.",
              style: GoogleFonts.openSans(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  context.pop();
                },
                child: Text(
                  AppLocalizations.of(context)!.cancel,
                  // "Cancel",
                  style: GoogleFonts.roboto(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  openSettings();
                  context.pop();
                },
                child: Text(
                  AppLocalizations.of(context)!.settings,
                  // "Settings",
                  style: GoogleFonts.roboto(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          );
        });
  }

  void _showPicker({
    required BuildContext context,
  }) {
    showModalBottomSheet(
      context: _scaffoldKey.currentContext!,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: Text(
                  AppLocalizations.of(context)!.photolibrary,
                  // 'Photo Library'
                ),
                onTap: () async {
                  if (Platform.isAndroid) {
                    final androidInfo = await DeviceInfoPlugin().androidInfo;
                    if (androidInfo.version.sdkInt <= 32) {
                      checkPermissionForGallery(Permission.storage, context);
                    } else {
                      checkPermissionForGallery(Permission.photos, context);
                    }
                  } else if (Platform.isIOS) {
                    checkPermissionForGallery(Permission.photos, context);
                  }
                  context.pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: Text(
                  AppLocalizations.of(context)!.camera,
                  // 'Camera'
                ),
                onTap: () async {
                  await checkPermissionForCamera(Permission.camera, context);
                  // if(Platform.isAndroid) {
                  //   final androidInfo = await DeviceInfoPlugin().androidInfo;
                  //   if (androidInfo.version.sdkInt <= 32) {
                  //     checkPermissionForGallery(Permission.camera, context);
                  //   } else {
                  //     checkPermissionForGallery(Permission.camera, context);
                  //   }
                  // }else if(Platform.isIOS) {
                  //   checkPermissionForGallery(Permission.camera, context);
                  // }
                  context.pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future getImage(
    ImageSource img,
  ) async {
    try {
      final pickedFile = await _picker.pickImage(source: img);
      XFile? xfilePick = pickedFile;
      setState(
        () {
          if (xfilePick != null) {
            galleryFile = File(pickedFile!.path);
            final bytes = galleryFile!.readAsBytesSync();
            String img64 = base64Encode(bytes);
            setState(() {
              imageBase64 = img64;
              extension = p
                  .extension(galleryFile!.path)
                  .trim()
                  .toString()
                  .replaceAll('.', '');
              imageUploadFormated = "data:image/$extension;base64,$imageBase64";
            });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              // is this context <<<
              SnackBar(
                backgroundColor: AppColors.secondaryColor,
                content: Text(
                  AppLocalizations.of(context)!.nothingisselected,
                  style: GoogleFonts.openSans(
                    color: AppColors.primaryWhiteColor,
                  ),
                  // 'Nothing is selected'
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      print('Exception occured!');
    }
  }
}
