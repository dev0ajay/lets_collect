import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_collect/src/bloc/contact_us_bloc/contact_us_bloc.dart';
import 'package:lets_collect/src/components/Custome_Textfiled.dart';
import 'package:lets_collect/src/components/my_button.dart';
import 'package:lets_collect/src/constants/assets.dart';
import 'package:lets_collect/src/constants/colors.dart';
import 'package:lets_collect/src/model/contact_us/contact_us_request.dart';
import 'package:lets_collect/src/utils/screen_size/size_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:path/path.dart' as p;

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  final FocusNode _subjectFocus = FocusNode();

  File? _pickedFile;
  String imageBase64 = "";
  String extension = "";
  String imageUploadFormated = "";

  void _removeFile() {
    setState(() {
      _pickedFile = null;
    });
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'png',
        'jpg',
        'jpeg',
        'gif',
        'tiff',
        'bmp',
        'pdf',
        'doc',
        'csv',
        'docx',
        'mp4',
        'tiff',
        'tif',
        'txt',
        'webp',
        'xls',
        'xlsx'
      ],
    );

    if (result != null) {
      setState(() {
        // _pickedFile = File(result.files.single.name);
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

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocConsumer<ContactUsBloc, ContactUsState>(
      listener: (context, state) {
        if (state is ContactUsLoading) {
          const Center(
            heightFactor: 10,
            child: RefreshProgressIndicator(
              color: AppColors.secondaryColor,
            ),
          );
        }
        if (state is ContactUsLoaded) {
          if (state.contactUsRequestResponse.success == true) {
            _showDialogBox(context: context);
          }
        }
        if (state is ContactUsLoaded) {
          if (state.contactUsRequestResponse.success == false) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: AppColors.secondaryColor,
                content: Text(
                  "Some Error Happened",
                  style: GoogleFonts.openSans(
                    color: AppColors.primaryWhiteColor,
                  ),
                ),
              ),
            );
          }
        }
      },
      builder: (context, state) {
        return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: AppColors.primaryColor,
                leading: IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_outlined,
                      color: AppColors.primaryWhiteColor,
                    )),
                title: Text(
                  AppLocalizations.of(context)!.contactus,
                  style: GoogleFonts.openSans(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryWhiteColor,
                  ),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        Center(
                          child: SvgPicture.asset(
                            Assets.CONTACT_US_SVG,
                            fit: BoxFit.cover,
                            height: 130,
                          ),
                        ),
                        Center(
                          child: ClipOval(
                            child: SvgPicture.asset(
                              Assets.SHADE_SVG,
                              fit: BoxFit.cover,
                              height: 12,
                            ),
                          ),
                        ),
                        const SizedBox(height: 35),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: const Offset(3, 3),
                              ),
                            ],
                          ),
                          child: MyTextField(
                            hintText: AppLocalizations.of(context)!.subject,
                            obscureText: false,
                            maxLines: 1,
                            controller: subjectController,
                            keyboardType: TextInputType.text,
                            focusNode: _subjectFocus,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 35),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: const Offset(3, 3),
                              ),
                            ],
                          ),
                          child: SizedBox(
                            height: 150,
                            child: MyTextField(
                              hintText: AppLocalizations.of(context)!.message,
                              obscureText: false,
                              controller: messageController,
                              maxLines: 10,
                              keyboardType: TextInputType.multiline,
                              focusNode: null,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "";
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: _pickFile,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: DottedBorder(
                              borderType: BorderType.RRect,
                              color: AppColors.cardTextColor,
                              radius: const Radius.circular(10),
                              child: _pickedFile == null
                                  ? SizedBox(
                                      height: getProportionateScreenHeight(60),
                                      width: getProportionateScreenWidth(320),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!
                                                .supportingimage,
                                            style: GoogleFonts.roboto(
                                              color:
                                                  AppColors.primaryBlackColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          const SizedBox(width: 20),
                                          const ImageIcon(
                                            AssetImage(Assets.UPLOAD),
                                            size: 20,
                                          ),
                                        ],
                                      ),
                                    )
                                  : Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: SizedBox(
                                            height:
                                                getProportionateScreenHeight(
                                                    60),
                                            width: getProportionateScreenWidth(
                                                300),
                                            child: Center(
                                              child: Text(
                                                  '${AppLocalizations.of(context)!.selectedfile} ${_pickedFile!.path.split("/").last}'),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _pickedFile = null;
                                            });
                                          },
                                          child: const CircleAvatar(
                                            radius: 12,
                                            backgroundColor:
                                                AppColors.secondaryColor,
                                            child: Icon(
                                              Icons.delete,
                                              color: Colors.white,
                                              size: 16,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: BlocBuilder<ContactUsBloc, ContactUsState>(
                            builder: (context, state) {
                              if (state is ContactUsLoading) {
                                return const Center(
                                  child: RefreshProgressIndicator(
                                    color: AppColors.primaryWhiteColor,
                                    backgroundColor: AppColors.secondaryColor,
                                  ),
                                );
                              }
                              return MyButton(
                                Textfontsize: 16,
                                TextColors: Colors.white,
                                text: AppLocalizations.of(context)!
                                    .singupbuttonsubmit,
                                color: AppColors.secondaryColor,
                                width: 340,
                                height: 40,
                                onTap: () {
                                  if (_formKey.currentState!.validate() &&
                                      _pickedFile != null) {
                                    BlocProvider.of<ContactUsBloc>(context).add(
                                      GetContactUsEvent(
                                        contactUsRequest: ContactUsRequest(
                                            subject: subjectController.text,
                                            message: messageController.text,
                                            supportPicture:
                                                imageUploadFormated),
                                      ),
                                    );
                                    print("Subject = $subjectController");
                                    print("Message = $messageController");
                                    print("Photo = $imageUploadFormated");


                                  } else {
                                    Fluttertoast.showToast(
                                      msg: AppLocalizations.of(context)!
                                          .allfieldsareimportant,
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor: Colors.black87,
                                      textColor: Colors.white,
                                    );
                                  }
                                },
                                showImage: false,
                                imagePath: '',
                                imagewidth: 0,
                                imageheight: 0,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
      },
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
          height: getProportionateScreenHeight(230),
          width: getProportionateScreenWidth(500),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                AppLocalizations.of(context)!.thankyouforcontactingus,
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppColors.secondaryColor,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                AppLocalizations.of(context)!.wewillgetbackto,
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 50, right: 50),
                child: MyButton(
                  Textfontsize: 16,
                  TextColors: Colors.white,
                  text: AppLocalizations.of(context)!.ok,
                  color: AppColors.secondaryColor,
                  height: 40,
                  // Adjust the height as needed
                  onTap: () {
                    subjectController.clear();
                    messageController.clear();
                    _removeFile();
                    context.pop();
                  },
                  showImage: false,
                  imagePath: '',
                  imagewidth: 0,
                  imageheight: 0,
                  width: 0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
