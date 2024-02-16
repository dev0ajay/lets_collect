import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lets_collect/src/bloc/scan_bloc/scan_bloc.dart';
import 'package:lets_collect/src/ui/scan/components/scan_detail_screen_argument.dart';
import 'package:lets_collect/src/ui/scan/components/widgets/scan_screen_collect_button.dart';
import 'package:lets_collect/src/utils/screen_size/size_config.dart';
import 'package:lottie/lottie.dart';
import '../../constants/assets.dart';
import '../../constants/colors.dart';
import 'package:path/path.dart' as p;

class ScanScreen extends StatefulWidget {
  final String from;
  const ScanScreen({super.key,required this.from});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  File? galleryFile;
  String imageBase64 = "";
  String extension = "";
  String imageUploadFormated = "";

  // XFile? _pickedFile;
  final _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
                                    color: AppColors.borderColor, width: 1),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  _showPicker(context: context);
                                },
                                child: Center(
                                  child: ImageIcon(
                                    const AssetImage(Assets.UPLOAD),
                                    size: getProportionateScreenHeight(100),
                                  ),
                                ),
                              ),
                              // width: getProportionateScreenWidth(360),
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
                                    color: AppColors.borderColor, width: 1),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  _showPicker(context: context);
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
                        // print(galleryFile!.path.split("/").last);
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
                                  "E-Reciept (or) Reciept too long?",
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
                        if(galleryFile != null) {
                          BlocProvider.of<ScanBloc>(context).add(
                            ScanReceiptEvent(
                                data: FormData.fromMap({"file": imageUploadFormated})),
                          );
                          _showDialogBox(context: context);
                        }else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: AppColors.secondaryColor,
                              content: Text(
                                "Please choose a file.",
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
                        child: const SizedBox(
                          child: Padding(
                            padding: EdgeInsets.all(3.0),
                            child: ScanScreenCollectButton(text: 'Collect'),
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

  void _showDialogBox({
    required BuildContext context,
  }) {
    showDialog(
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
                            "We are crunching those points for you",
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
                            "Please hold tight !",
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
                if (state.scanReceiptRequestResponse.success == false
                   ) {
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
                                "Total Points: ${state.scanReceiptRequestResponse.data!.totalPoints.toString()}",
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
                                  context.push(
                                    '/scan_history',
                                    extra: ScanDetailsScreenArgument(
                                      totalPoint: state
                                          .scanReceiptRequestResponse
                                          .data!
                                          .totalPoints!,
                                        pointId: state
                                            .scanReceiptRequestResponse
                                            .data!
                                            .pointId!),
                                  );
                                  context.pop();
                                },
                                child: Text(
                                  "View Details",
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
                              "Oops Something went wrong!.",
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

  void _showPicker({
    required BuildContext context,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                  getImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  getImage(ImageSource.camera);
                  Navigator.of(context).pop();
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
          ScaffoldMessenger.of(context).showSnackBar(// is this context <<<
              const SnackBar(content: Text('Nothing is selected')));
        }
      },
    );
  }
}
