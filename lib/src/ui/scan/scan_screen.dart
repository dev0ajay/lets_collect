import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lets_collect/src/ui/scan/components/widgets/scan_screen_collect_button.dart';
import 'package:lets_collect/src/utils/screen_size/size_config.dart';
import '../../constants/assets.dart';
import '../../constants/colors.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  File? galleryFile;

  // XFile? _pickedFile;
  final _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            galleryFile == null
                ? Center(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      margin:
                          const EdgeInsets.only(top: 0, left: 15, right: 15),
                      height: getProportionateScreenHeight(450),
                      decoration: BoxDecoration(
                        color: AppColors.primaryWhiteColor,
                        borderRadius: BorderRadius.circular(5),
                        border:
                            Border.all(color: AppColors.borderColor, width: 1),
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
                      margin:
                          const EdgeInsets.only(top: 20, left: 15, right: 15),
                      height: getProportionateScreenHeight(450),
                      decoration: BoxDecoration(
                        color: AppColors.primaryWhiteColor,
                        borderRadius: BorderRadius.circular(5),
                        border:
                            Border.all(color: AppColors.borderColor, width: 1),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          _showPicker(context: context);
                        },
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.file(
                              galleryFile!,
                            )),
                      ),
                      // width: getProportionateScreenWidth(360),
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.only(top: 38),
              child: GestureDetector(
                onTap: () {
                  _showDialogBox(context: context);
                },
                child: const ScanScreenCollectButton(text: 'Collect'),
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
          ],
        ),
      ),
    );
  }

  void _showDialogBox({
    required BuildContext context,
  }) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
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
            ],
          ),
        ),
      ),
    );
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
        } else {
          ScaffoldMessenger.of(context).showSnackBar(// is this context <<<
              const SnackBar(content: Text('Nothing is selected')));
        }
      },
    );
  }
}
