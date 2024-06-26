import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_collect/language.dart';
import 'package:lets_collect/src/bloc/contact_us_bloc/contact_us_bloc.dart';
import 'package:lets_collect/src/bloc/language/language_bloc.dart';
import 'package:lets_collect/src/components/Custome_Textfiled.dart';
import 'package:lets_collect/src/components/my_button.dart';
import 'package:lets_collect/src/constants/assets.dart';
import 'package:lets_collect/src/constants/colors.dart';
import 'package:lets_collect/src/model/contact_us/contact_us_request.dart';
import 'package:lets_collect/src/utils/network_connectivity/bloc/network_bloc.dart';
import 'package:lets_collect/src/utils/screen_size/size_config.dart';
import 'package:lottie/lottie.dart';
import 'package:path/path.dart' as p;
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen>
    with WidgetsBindingObserver {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  final FocusNode _subjectFocus = FocusNode();

  File? _pickedFile;
  String imageBase64 = "";
  String extension = "";
  String imageUploadFormated = "";
  List<File> selectedImages = [];
  bool networkSuccess = false;

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
              AppLocalizations.of(context)!.tocontinuefileuploadallowaccesstofilesandstorage,
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

  ///Runtime User Access and Permission handling

  Future<void> checkPermissionForGallery(
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
      // openSettings();
      _showPermissionDialog(_scaffoldKey.currentContext!);
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
    return BlocConsumer<NetworkBloc, NetworkState>(
      listener: (context, state) {
        if (state is NetworkSuccess) {
          networkSuccess = true;
        }
      },
      builder: (context, state) {
        if (state is NetworkSuccess) {
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
                        AppLocalizations.of(context)!.someerroroccurred,
                        style: GoogleFonts.openSans(
                          color: AppColors.primaryWhiteColor,
                        ),
                      ),
                    ),
                  );
                }
              }
              if (state is ContactUsErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: AppColors.secondaryColor,
                    content: Text(
                      context.read<LanguageBloc>().state.selectedLanguage ==
                          Language.english
                          ? state.errorMsg
                          : AppLocalizations.of(context)!.oopslookslikewearefacing,
                      style: const TextStyle(color: AppColors.primaryWhiteColor),
                    ),
                  ),
                );
              }
            },
            builder: (context, state) {
              return GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: Scaffold(
                    key: _scaffoldKey,
                    appBar: AppBar(
                      backgroundColor: AppColors.primaryColor,
                      leading: IconButton(
                        onPressed: () {
                          context.pop();
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_outlined,
                          color: AppColors.primaryWhiteColor,
                        ),
                      ),
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
                              const SizedBox(
                                height: 40,
                              ),
                              Center(
                                child: SvgPicture.asset(
                                  Assets.CONTACT_US_SVG,
                                  fit: BoxFit.cover,
                                  height: 130,
                                ),
                              )
                                  .animate()
                                  .scale(delay: 200.ms, duration: 300.ms),
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
                                  color: AppColors.primaryWhiteColor,
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
                                  // hintText: "Subject",
                                  hintText : AppLocalizations.of(context)!.subject,
                                  obscureText: false,
                                  maxLines: 1,
                                  controller: subjectController,
                                  keyboardType: TextInputType.text,
                                  focusNode: _subjectFocus,
                                ),
                              )
                                  .animate()
                                  .scale(delay: 200.ms, duration: 300.ms),
                              const SizedBox(height: 35),
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.primaryWhiteColor,
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
                                    // hintText: "Message",
                                    hintText : AppLocalizations.of(context)!.message,
                                    obscureText: false,
                                    controller: messageController,
                                    maxLines: 10,
                                    keyboardType: TextInputType.multiline,
                                    focusNode: null,
                                  ),
                                ),
                              )
                                  .animate()
                                  .scale(delay: 200.ms, duration: 300.ms),
                              const SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: () async{
                                  if (selectedImages.isEmpty) {
                                    if (Platform.isAndroid) {
                                      final androidInfo =
                                      await DeviceInfoPlugin().androidInfo;
                                      if (androidInfo.version.sdkInt <= 32) {
                                        checkPermissionForGallery(Permission.storage,
                                            _scaffoldKey.currentContext!);
                                      } else {
                                        checkPermissionForGallery(Permission.photos,
                                            _scaffoldKey.currentContext!);
                                      }
                                    } else if (Platform.isIOS) {
                                      checkPermissionForGallery(Permission.storage,
                                          _scaffoldKey.currentContext!);
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: AppColors.secondaryButtonColor,
                                        content:
                                        Text(
                                          AppLocalizations.of(context)!.pleasechooseeitheroneoption,
                                        ),
                                      ),
                                    );
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: DottedBorder(
                                    borderType: BorderType.RRect,
                                    color: AppColors.cardTextColor,
                                    radius: const Radius.circular(10),
                                    child: _pickedFile == null
                                        ? SizedBox(
                                      height:
                                      getProportionateScreenHeight(
                                          60),
                                      width: getProportionateScreenWidth(
                                          320),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            // "Supporting image",
                                            AppLocalizations.of(context)!.supportingimage,
                                            style: GoogleFonts.roboto(
                                              color: AppColors
                                                  .primaryBlackColor,
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
                                        // SizedBox(
                                        //   height:
                                        //   getProportionateScreenHeight(
                                        //       100),
                                        //   width: getProportionateScreenWidth(
                                        //       300),
                                        //   child: ClipRRect(
                                        //     borderRadius: BorderRadius.circular(5),
                                        //     child: Image.file(
                                        //       _pickedFile!,
                                        //     ),
                                        //   ),
                                        // ),
                                        ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          child: SizedBox(
                                            height: getProportionateScreenHeight(150),
                                            width: getProportionateScreenWidth(300),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                Text("${AppLocalizations.of(context)!.selectedfile} "),
                                                SizedBox(height: getProportionateScreenHeight(120),
                                                  width: getProportionateScreenWidth(120),
                                                  child: Image.file(_pickedFile!),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () async {
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
                                              color: AppColors.primaryWhiteColor,
                                              size: 16,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                                  .animate()
                                  .scale(delay: 200.ms, duration: 300.ms),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child:
                                BlocBuilder<ContactUsBloc, ContactUsState>(
                                  builder: (context, state) {
                                    if (state is ContactUsLoading) {
                                      return const Center(
                                        child: RefreshProgressIndicator(
                                          color: AppColors.primaryWhiteColor,
                                          backgroundColor:
                                          AppColors.secondaryColor,
                                        ),
                                      );
                                    }
                                    return MyButton(
                                      Textfontsize: 16,
                                      TextColors: AppColors.primaryWhiteColor,
                                      // text: "Submit",
                                      text : AppLocalizations.of(context)!.submit,
                                      color: AppColors.secondaryColor,
                                      width: 340,
                                      height: 40,
                                      onTap: () {
                                        if (subjectController.text.isEmpty ||
                                            messageController.text.isEmpty) {
                                          Fluttertoast.showToast(
                                            msg: AppLocalizations.of(context)!.allfieldsareimportant,
                                            toastLength: Toast.LENGTH_LONG,
                                            gravity: ToastGravity.BOTTOM,
                                            backgroundColor: AppColors.primaryBlackColor,
                                            textColor: AppColors.primaryWhiteColor,
                                          );
                                          return;
                                        }
                                        if (_formKey.currentState!.validate() &&
                                            _pickedFile != null) {
                                          BlocProvider.of<ContactUsBloc>(context).add(
                                            GetContactUsEvent(contactUsRequest: ContactUsRequest(
                                                subject: subjectController
                                                    .text,
                                                message: messageController
                                                    .text,
                                                supportPicture:
                                                imageUploadFormated),
                                            ),
                                          );
                                          print("Subject = $subjectController");
                                          print("Message = $messageController");
                                          print("Photo = $imageUploadFormated");
                                        } else {
                                          Fluttertoast.showToast(
                                            // msg: "All Fields are important",
                                            msg:  AppLocalizations.of(context)!
                                                .allfieldsareimportant,
                                            toastLength: Toast.LENGTH_LONG,
                                            gravity: ToastGravity.BOTTOM,
                                            backgroundColor:
                                            AppColors.primaryBlackColor,
                                            textColor:
                                            AppColors.primaryWhiteColor,
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
                              )
                                  .animate()
                                  .scale(delay: 200.ms, duration: 300.ms),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ));
            },
          );
        } else if (state is NetworkFailure) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(Assets.NO_INTERNET),
                Text(
                  AppLocalizations.of(context)!.youarenotconnectedtotheinternet,
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
    );
  }



  void _showDialogBox({
    required BuildContext context,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => WillPopScope(
        onWillPop: () async {
          subjectController.clear();
          messageController.clear();
          _removeFile();
          context.pop();
          return false;
        },
        child: AlertDialog(
          backgroundColor: AppColors.primaryWhiteColor,
          elevation: 5,
          alignment: Alignment.center,
          content: SizedBox(
            height: getProportionateScreenHeight(240),
            width: getProportionateScreenWidth(500),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: () {
                      subjectController.clear();
                      messageController.clear();
                      _removeFile();
                      context.pop();
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
                    TextColors: AppColors.primaryWhiteColor,
                    // text: "Ok",
                    text : AppLocalizations.of(context)!.ok,
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
      ),
    );
  }
}