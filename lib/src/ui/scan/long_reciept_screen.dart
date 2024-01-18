import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lets_collect/src/utils/screen_size/size_config.dart';

import '../../constants/assets.dart';
import '../../constants/colors.dart';
import 'components/widgets/scan_screen_collect_button.dart';

class LongRecieptScreen extends StatefulWidget {
  const LongRecieptScreen({super.key});

  @override
  State<LongRecieptScreen> createState() => _LongRecieptScreenState();
}

class _LongRecieptScreenState extends State<LongRecieptScreen> {
  List<XFile>? galleryFile;
  File? _cameraImage;
  final _picker = ImagePicker();
  File? _pickedFile;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc'],
    );

    if (result != null) {
      setState(() {
        _pickedFile = File(result.files.single.name);
      });
    }
  }

  List<File> selectedImages = [];

  final picker = ImagePicker();

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

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
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
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(top: 20, left: 15, right: 15),
              height: getProportionateScreenHeight(250),
              // width: getProportionateScreenWidth(360),
              decoration: BoxDecoration(
                  color: AppColors.primaryWhiteColor,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: AppColors.borderColor, width: 1)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Choose an option'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  _getImage(ImageSource.gallery);
                                },
                                child: const Text('Gallery'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  _getImage(ImageSource.camera);
                                },
                                child: const Text('Camera'),
                              ),
                            ],
                          );
                        },
                      );
                      // _showPicker(context: context);
                    },
                    child: Center(
                      child: ImageIcon(
                        const AssetImage(Assets.SCANNER),
                        size: getProportionateScreenHeight(100),
                      ),
                    ),
                  ),
                  Text(
                    "(Or)",
                    style: GoogleFonts.roboto(
                      color: AppColors.cardTextColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  GestureDetector(
                    onTap: _pickFile,
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
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
              child: SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: selectedImages.length + 1,
                  itemBuilder: (context, index) {
                    if (index == selectedImages.length) {
                      return const SizedBox();
                    } else {
                      return Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DottedBorder(
                              borderType: BorderType.RRect,
                              color: AppColors.cardTextColor,
                              radius: const Radius.circular(10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  selectedImages[index],
                                  fit: BoxFit.cover,
                                  height: 150,
                                  width: 100,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedImages.removeAt(index);
                                });
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
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
              child: DottedBorder(
                borderType: BorderType.RRect,
                color: AppColors.cardTextColor,
                radius: const Radius.circular(10),
                child: _pickedFile == null
                    ? const SizedBox()
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                          height: getProportionateScreenHeight(40),
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: Text('Selected File: ${_pickedFile!.path}'),
                          ),
                        ),
                      ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 40),
              child: ScanScreenCollectButton(text: 'Collect'),
            ),
          ],
        ));
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
                  (context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  getImage(ImageSource.camera);
                  (context).pop();
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
    final pickedFile = await _picker.pickMultiImage();
    List<XFile>? xfilePick = pickedFile;
    setState(
      () {
        if (xfilePick != null) {
          galleryFile = pickedFile;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            // is this context <<<
            const SnackBar(
              content: Text('Nothing is selected'),
            ),
          );
        }
      },
    );
  }
}
