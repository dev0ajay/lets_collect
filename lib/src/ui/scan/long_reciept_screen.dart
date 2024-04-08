import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lets_collect/src/utils/screen_size/size_config.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../bloc/scan_bloc/scan_bloc.dart';
import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../utils/network_connectivity/bloc/network_bloc.dart';
import 'components/scan_detail_screen_argument.dart';
import 'components/widgets/scan_screen_collect_button.dart';
import 'package:path/path.dart' as p;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class LongRecieptScreen extends StatefulWidget {
  const LongRecieptScreen({super.key});

  @override
  State<LongRecieptScreen> createState() => _LongRecieptScreenState();
}

class _LongRecieptScreenState extends State<LongRecieptScreen>
    with WidgetsBindingObserver {
  List<XFile>? galleryFile;
  File? _cameraImage;
  final _picker = ImagePicker();
  File? _pickedFile;
  String imageBase64 = "";
  String extension = "";
  String imageUploadFormated = "";
  List<File> selectedImages = [];

  final picker = ImagePicker();

  // Function to clear the picked image
  void _clearImage() {
    setState(() {
      galleryFile = null;
    });
  }

  void openSettings() {
    openAppSettings();
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
                  // "Cancel",
                  AppLocalizations.of(context)!.cancel,
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

  ///Runtime User Access and Permission handling
  Future<void> checkPermissionForStorage(
      Permission permission, BuildContext context) async {
    final status = await permission.request();
    if (status.isGranted) {
      print("Permission granted");
      _pickFile();
    } else if (status.isDenied) {
      print("Permission Denied");
      _showPermissionDialog(_scaffoldKey.currentContext!);
    } else if (status.isPermanentlyDenied) {
      print("Permission permanently denied");
      openSettings();
    } else if (status.isLimited) {
      print("Permission permanently denied");
      _pickFile();
    }
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

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.primaryWhiteColor,
          ),
        ),
      ),
      body: BlocConsumer<NetworkBloc, NetworkState>(
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
                    AppLocalizations.of(context)!
                        .youarenotconnectedtotheinternet,
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
                    AppLocalizations.of(context)!
                        .youarenotconnectedtotheinternet,
                    style: GoogleFonts.openSans(
                      color: AppColors.primaryGrayColor,
                      fontSize: 20,
                    ),
                  ).animate().scale(delay: 200.ms, duration: 300.ms),
                ],
              ),
            );
          } else if (state is NetworkSuccess) {
            return SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Flexible(
                    flex: 6,
                    child: Container(
                      margin:
                          const EdgeInsets.only(top: 20, left: 15, right: 15),
                      height: getProportionateScreenHeight(350),
                      // width: getProportionateScreenWidth(360),
                      decoration: BoxDecoration(
                          color: AppColors.primaryWhiteColor,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              color: AppColors.borderColor, width: 1)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
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
                            // onTap: () {
                            //   _pickedFile == null
                            //       ? showDialog(
                            //           context: context,
                            //           builder: (BuildContext context) {
                            //             return AlertDialog(
                            //               title: const Text('Choose an option'),
                            //               actions: [
                            //                 TextButton(
                            //                   onPressed: () {
                            //                     Navigator.pop(context);
                            //                     _getImage(ImageSource.gallery);
                            //                   },
                            //                   child: const Text('Gallery'),
                            //                 ),
                            //                 TextButton(
                            //                   onPressed: () {
                            //                     Navigator.pop(context);
                            //                     _getImage(ImageSource.camera);
                            //                   },
                            //                   child: const Text('Camera'),
                            //                 ),
                            //               ],
                            //             );
                            //           },
                            //         )
                            //       : ScaffoldMessenger.of(context).showSnackBar(
                            //           const SnackBar(
                            //             backgroundColor:
                            //                 AppColors.secondaryButtonColor,
                            //             content:
                            //                 Text("Please choose either one option"),
                            //           ),
                            //         );
                            //   // _showPicker(context: context);
                            // },
                            child: Center(
                              child: ImageIcon(
                                const AssetImage(Assets.SCANNER),
                                size: getProportionateScreenHeight(100),
                              ),
                            ),
                          ),
                          Text(
                            (AppLocalizations.of(context)!.or),
                            // "(Or)",
                            style: GoogleFonts.roboto(
                              color: AppColors.cardTextColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (selectedImages.isEmpty) {
                                if (Platform.isAndroid) {
                                  final androidInfo =
                                      await DeviceInfoPlugin().androidInfo;
                                  if (androidInfo.version.sdkInt <= 32) {
                                    checkPermissionForStorage(
                                        Permission.storage,
                                        _scaffoldKey.currentContext!);
                                  } else {
                                    checkPermissionForStorage(Permission.photos,
                                        _scaffoldKey.currentContext!);
                                  }
                                } else if (Platform.isIOS) {
                                  checkPermissionForStorage(Permission.storage,
                                      _scaffoldKey.currentContext!);
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor:
                                        AppColors.secondaryButtonColor,
                                    content: Text(
                                      AppLocalizations.of(context)!
                                          .pleasechooseeitheroneoption,
                                      // "Please choose either one option"
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Center(
                              child: ImageIcon(
                                const AssetImage(Assets.UPLOAD),
                                size: getProportionateScreenHeight(100),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  ///Widget Tree for Multiple image selection
                  // Flexible(
                  //   flex: 3,
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
                  //     child: SizedBox(
                  //       height: 100,
                  //       child: ListView.builder(
                  //         scrollDirection: Axis.horizontal,
                  //         itemCount: selectedImages.length + 1,
                  //         itemBuilder: (context, index) {
                  //           if (index == selectedImages.length) {
                  //             return const SizedBox();
                  //           } else {
                  //             return Stack(
                  //               children: [
                  //                 Padding(
                  //                   padding: const EdgeInsets.all(8.0),
                  //                   child: DottedBorder(
                  //                     borderType: BorderType.RRect,
                  //                     color: AppColors.cardTextColor,
                  //                     radius: const Radius.circular(10),
                  //                     child: ClipRRect(
                  //                       borderRadius: BorderRadius.circular(10),
                  //                       child: Image.file(
                  //                         selectedImages[index],
                  //                         fit: BoxFit.cover,
                  //                         height: 150,
                  //                         width: 100,
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ),
                  //                 Positioned(
                  //                   top: 0,
                  //                   right: 0,
                  //                   child: GestureDetector(
                  //                     onTap: () {
                  //                       setState(() {
                  //                         selectedImages.removeAt(index);
                  //                       });
                  //                     },
                  //                     child: Container(
                  //                       padding: const EdgeInsets.all(2),
                  //                       margin: const EdgeInsets.all(5),
                  //                       // height: 20,
                  //                       // width: 20,
                  //                       decoration: const BoxDecoration(
                  //                         color: AppColors.iconGreyColor,
                  //                         shape: BoxShape.circle,
                  //                       ),
                  //                       child: const Center(
                  //                         child: Icon(Icons.close,
                  //                             size: 17,
                  //                             color: AppColors.secondaryColor),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ],
                  //             );
                  //           }
                  //         },
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Flexible(
                    flex: 3,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 30, right: 30, top: 20),
                      child: _pickedFile == null || selectedImages.isNotEmpty
                          ? const SizedBox()
                          : Stack(
                              children: [
                                DottedBorder(
                                  borderType: BorderType.RRect,
                                  color: AppColors.cardTextColor,
                                  radius: const Radius.circular(10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: SizedBox(
                                      height: getProportionateScreenHeight(40),
                                      width: MediaQuery.of(context).size.width,
                                      child: Center(
                                        child: Text(
                                            "${AppLocalizations.of(context)!.selectedfile} : ${_pickedFile!.path.split("/").last}"
                                            // 'Selected File: ${_pickedFile!.path.split("/").last}'
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      _removeFile();
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      margin: const EdgeInsets.all(5),
                                      // height: 20,
                                      // width: 20,
                                      decoration: const BoxDecoration(
                                        color: AppColors.iconGreyColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Center(
                                        child: Icon(Icons.close,
                                            size: 17,
                                            color: AppColors.secondaryColor),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 0, bottom: 30),
                      child: InkWell(
                        splashColor: AppColors.secondaryButtonColor,
                        splashFactory: InkSplash.splashFactory,
                        onTap: () {
                          print(imageUploadFormated);
                          if (imageUploadFormated.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: AppColors.secondaryColor,
                                content: Text(
                                  // "Please choose a file.",
                                  AppLocalizations.of(context)!
                                      .pleasechooseafile,
                                  style: GoogleFonts.roboto(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.primaryWhiteColor,
                                  ),
                                ),
                              ),
                            );
                          } else {
                            _showDialogBox(context: context);
                            BlocProvider.of<ScanBloc>(context).add(
                              ScanReceiptEvent(
                                data: FormData.fromMap(
                                    {"file": imageUploadFormated}),
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
                  ),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  void _showDialogBox({
    required BuildContext context,
  }) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) {
          BlocProvider.of<ScanBloc>(context).add(
            ScanReceiptEvent(
                data: FormData.fromMap({"file": imageUploadFormated})),
          );
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
                              _removeFile();
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
                            // "We are crunching those points for you",
                            AppLocalizations.of(context)!.wearecruching,
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
                            // "Please hold tight !",
                            AppLocalizations.of(context)!.pleaseholdtight,
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
                    state.scanReceiptRequestResponse.message ==
                        "This receipt number already exists") {
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
                                  _removeFile();
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
                                    .oopslookslikeyouhavealready,
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
                } else if (state.scanReceiptRequestResponse.success == false) {
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
                                  _removeFile();
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
                                // "Oops! Looks like we’re facing some issue scanning this receipt",
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
                                  _removeFile();
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
                                "${AppLocalizations.of(context)!.totalpoints} : ${state.scanReceiptRequestResponse.data!.totalPoints.toString()}",
                                // "Total Points: ${state.scanReceiptRequestResponse.data!.totalPoints.toString()}",
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
                              child: TextButton(
                                onPressed: () {
                                  _removeFile();
                                  context.push(
                                    '/scan_history',
                                    extra: ScanDetailsScreenArgument(
                                      totalPoint: state
                                          .scanReceiptRequestResponse
                                          .data!
                                          .totalPoints!,
                                      pointId: state.scanReceiptRequestResponse
                                          .data!.pointId!,
                                    ),
                                  );
                                  context.pop();
                                },
                                child: Text(
                                  // "View Details",
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
                            // Flexible(
                            //   flex: 1,
                            //   child: Text(
                            //     "Brand points: ${state.scanReceiptRequestResponse.data!.brandPoint.toString()}",
                            //     textAlign: TextAlign.center,
                            //     style: GoogleFonts.roboto(
                            //       fontSize: 12,
                            //       fontWeight: FontWeight.w700,
                            //     ),
                            //   ),
                            // ),
                            // Flexible(
                            //   flex: 1,
                            //   child: Text(
                            //     "Partner points: ${state.scanReceiptRequestResponse.data!.letsCollectPoints.toString()}",
                            //     textAlign: TextAlign.center,
                            //     style: GoogleFonts.roboto(
                            //       fontSize: 12,
                            //       fontWeight: FontWeight.w700,
                            //     ),
                            //   ),
                            // ),
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
                                _removeFile();
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

  void _removeFile() {
    setState(() {
      _pickedFile = null;
    });
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc'],
    );

    if (result != null) {
      setState(() {
        _pickedFile = File(result.files.single.path!);
        final bytes = _pickedFile!.readAsBytesSync();
        String img64 = base64Encode(bytes);
        imageBase64 = img64;
        extension = p
            .extension(_pickedFile!.path)
            .trim()
            .toString()
            .replaceAll('.', '');
        imageUploadFormated = "data:image/$extension;base64,$imageBase64";
      });
    }
  }

  Future<void> _getImage(ImageSource source) async {
    try {
      final pickedFile = await picker.pickImage(source: source);

      if (pickedFile != null) {
        setState(() {
          selectedImages.add(File(pickedFile.path));
        });
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  ///Iamge Picker
  Future getImage(
    ImageSource img,
  ) async {
    final pickedFile = await _picker.pickMultiImage();
    List<XFile>? xfilePick = pickedFile;
    setState(
      () {
        galleryFile = pickedFile;
      },
    );
  }
}
