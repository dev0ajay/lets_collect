import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lets_collect/language.dart';
import 'package:lets_collect/src/bloc/city_bloc/city_bloc.dart';
import 'package:lets_collect/src/bloc/country_bloc/country_bloc.dart';
import 'package:lets_collect/src/bloc/language/language_bloc.dart';
import 'package:lets_collect/src/bloc/my_profile_bloc/my_profile_bloc.dart';
import 'package:lets_collect/src/bloc/nationality_bloc/nationality_bloc.dart';
import 'package:lets_collect/src/components/Custome_Textfiled.dart';
import 'package:lets_collect/src/components/my_button.dart';
import 'package:lets_collect/src/constants/assets.dart';
import 'package:lets_collect/src/constants/colors.dart';
import 'package:lets_collect/src/model/auth/get_city_request.dart';
import 'package:lets_collect/src/model/edit_profile/edit_profile_request.dart';
import 'package:lets_collect/src/ui/profile/components/my_profile_screen_arguments.dart';
import 'package:lets_collect/src/utils/network_connectivity/bloc/network_bloc.dart';
import 'package:lets_collect/src/utils/screen_size/size_config.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as p;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class MyProfileScreen extends StatefulWidget {
  final MyProfileArguments myProfileArguments;

  const MyProfileScreen({
    super.key,
    required this.myProfileArguments,
  });

  @override
  MyProfileScreenState createState() => MyProfileScreenState();
}

class MyProfileScreenState extends State<MyProfileScreen> {
  bool networkSuccess = false;
  DateTime? selectedDate;
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController dateInputController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController nationalityController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  final FocusNode _firstname = FocusNode();
  final FocusNode _secondname = FocusNode();
  final FocusNode _email = FocusNode();
  final FocusNode _phone = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? selectedGender;
  final List<String> Gender = ["M", "F"];
  final List<String> Gender_ar = ["م", "F"];
  List<File> selectedImages = [];
  File? galleryFile;
  String imageBase64 = "";
  String extension = "";
  String imageUploadFormated = "";
  File? _image = File("");
  final _picker = ImagePicker();
  late XFile _pickedFile;
  int? selectedCountryID;
  int? selectedNationalityID;
  String? selectedNationality;
  String? selectedNationalityValue;
  String? selectedCountryValue;
  String? selectedCountry;
  String? selectedCityID;

///Function for choosing profile image
  Future<void> _pickImage() async {
    final _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 5,
    );

    if (_pickedFile == null) {
      // User canceled picking image
      return;
    }

    final bytes = await _pickedFile.readAsBytes();

    final kb = bytes.lengthInBytes / 1024;
    double imageSizeMB = kb / 1024;

    print('SELECTED IMAGE SIZE: $imageSizeMB MB');
    Fluttertoast.showToast(
      msg: AppLocalizations.of(context)!.pleasesavetheprofilephoto,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppColors.secondaryColor, // Example color
      textColor: AppColors.primaryWhiteColor, // Example color
    );

    if (imageSizeMB > 30720) {
      // If image size is greater than 5MB
      Fluttertoast.showToast(
        msg: AppLocalizations.of(context)!.selectedimageisgreaterthan,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor:  AppColors.secondaryColor, // Example color
        textColor: AppColors.primaryWhiteColor, // Example color
      );
      return;
    }

    setState(() {
      _image = File(_pickedFile.path);
      galleryFile = File(_pickedFile.path);
      String img64 = base64Encode(bytes);
      imageBase64 = img64;
      extension = p.extension(galleryFile!.path).trim().replaceAll('.', '');
      imageUploadFormated = "data:image/$extension;base64,$imageBase64";
    });
  }


  ///Validation function for First name
  String? validateFirstname(String? value) {
    String pattern = "[a-zA-Z]";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value)) {
      // return 'Enter first name';
      return AppLocalizations.of(context)!.enterfirstname;
    } else {
      return null;
    }
  }
///Function for checking Age
  bool isAbove12YearsOld(DateTime selectedDate) {
    final DateTime now = DateTime.now();
    final DateTime twelveYearsAgo =
    now.subtract(const Duration(days: 12 * 365));
    return selectedDate.isBefore(twelveYearsAgo);
  }
///Date picker
  void _showDatePicker(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2050),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );

    if (pickedDate != null) {
      dateInputController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      selectedDate = pickedDate;
      if (selectedDate != null && !isAbove12YearsOld(selectedDate!)) {
        Fluttertoast.showToast(
          // msg: "Please select a date of birth above 12 years old!",
          msg: AppLocalizations.of(context)!.pleaseselectadateofbirthabove12,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: AppColors.primaryWhiteColor,
          textColor: AppColors.secondaryColor,
        );
      }
    }
  }
///Initializing argument variables
  myProfileArgumentData() {
    firstnameController.text = widget.myProfileArguments.first_name;
    print("FIRST NAME : ${firstnameController.text}");

    lastnameController.text = widget.myProfileArguments.last_name;
    print("LASTNAME  : ${lastnameController.text}");

    dateInputController.text = widget.myProfileArguments.dob;

    genderController.text = widget.myProfileArguments.gender;
    print("GENDER : ${genderController.text}");

    nationalityController.text =
    context.read<LanguageBloc>().state.selectedLanguage == Language.english
        ? widget.myProfileArguments.nationality_name_en
        : widget.myProfileArguments.nationality_name_ar;
    print("NATIONALITY : ${nationalityController.text}");

    cityController.text =
    context.read<LanguageBloc>().state.selectedLanguage == Language.english
        ? widget.myProfileArguments.city_name
        : widget.myProfileArguments.city_name_ar;
    print("CITY : ${cityController.text}");

    countryController.text =
    context.read<LanguageBloc>().state.selectedLanguage == Language.english
        ? widget.myProfileArguments.country_name_en
        : widget.myProfileArguments.country_name_ar;
    print("COUNTRTY : ${countryController.text}");

    emailController.text = widget.myProfileArguments.email;
    print("EMAIL : ${emailController.text}");

    mobileController.text = widget.myProfileArguments.mobile_no == "0"
        ? ""
        : widget.myProfileArguments.mobile_no;
    print("MOBILE NUMBER : ${mobileController.text}");
  }
  ///Runtime User Access and Permission handling
  void openSettings() {
    openAppSettings();
  }
  ///Runtime User Access and Permission handling
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
  Future<void> checkPermissionForGallery(
      Permission permission, BuildContext context) async {
    final status = await permission.request();
    if (status.isGranted) {
      print("Permission granted");
      _pickImage();
    } else if (status.isDenied) {
      print("Permission Denied");
      _showPermissionDialog(_scaffoldKey.currentContext!);
    } else if (status.isPermanentlyDenied) {
      print("Permission permanently denied");
      openSettings();
    } else if (status.isLimited) {
      print("Permission permanently denied");
      _pickImage();
    }
  }


  @override
  void initState() {
    super.initState();
    myProfileArgumentData();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      key: _scaffoldKey,
      body: BlocConsumer<NetworkBloc, NetworkState>(
        builder: (context, state) {
          if (state is NetworkSuccess) {
            return BlocConsumer<MyProfileBloc, MyProfileState>(
              listener: (context, state) {
                if (state is MyEditProfileLoaded) {
                  if (state.editProfileRequestResponse.status == true &&
                      state.editProfileRequestResponse.message ==
                          "Updated Successfully") {
                    Fluttertoast.showToast(
                      // msg: "All fields are important",
                      msg: AppLocalizations.of(context)!.updatesuccessfully,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: AppColors.secondaryColor,
                      textColor: AppColors.primaryWhiteColor,
                    );
                  }
                }
              },
              builder: (context, state) {
                if (state is MyEditProfileLoading) {
                  return const Center(
                    heightFactor: 25,
                    child: RefreshProgressIndicator(
                      color: AppColors.secondaryColor,
                      backgroundColor: AppColors.primaryWhiteColor,
                    ),
                  );
                }
                if (state is MyEditProfileErrorState) {
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
                            child: Text(
                              AppLocalizations.of(context)!.tryagain,
                              // "Try again",
                              style: const TextStyle(
                                  color: AppColors.primaryWhiteColor),
                            ),
                          ),
                        ),
                        // const Text("state"),
                      ],
                    ),
                  );
                }

                if (state is MyEditProfileLoaded) {
                  if (state.editProfileRequestResponse.status == true) {
                    BlocProvider.of<MyProfileBloc>(context)
                        .add(GetProfileDataEvent());
                  }
                } else if (state is MyEditProfileLoaded) {
                  if (state.editProfileRequestResponse.status == false) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: AppColors.secondaryColor,
                        content: Text(
                          AppLocalizations.of(context)!.someerrorhappend,
                          // "Some Error Happened",
                          style: GoogleFonts.openSans(
                            color: AppColors.primaryWhiteColor,
                          ),
                        ),
                      ),
                    );
                  }
                }

                return CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverAppBar(
                      leading: IconButton(
                        icon: const Icon(
                          Icons.cancel_outlined,
                          color: AppColors.primaryWhiteColor,
                        ),
                        onPressed: () {
                          context.pop();
                        },
                      ),
                      pinned: true,
                      stretch: true,
                      collapsedHeight: getProportionateScreenHeight(160),
                      backgroundColor: AppColors.primaryColor,
                      expandedHeight: getProportionateScreenHeight(100),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(9),
                          bottomLeft: Radius.circular(9),
                        ),
                      ),
                      flexibleSpace: FlexibleSpaceBar(
                        collapseMode: CollapseMode.parallax,
                        centerTitle: false,
                        titlePadding: const EdgeInsets.only(
                            top: 60, bottom: 20, left: 50, right: 50),
                        title: BlocBuilder<MyProfileBloc, MyProfileState>(
                          builder: (context, state) {
                            if (state is MyProfileLoaded) {
                              String b64 = state
                                  .myProfileScreenResponse.data!.photo
                                  .toString();
                              final UriData? data = Uri.parse(b64).data;
                              Uint8List bytesImage = data!.contentAsBytes();
                              print("PHOTO CODE : $bytesImage");

                              return Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          state.myProfileScreenResponse.data!
                                              .firstName
                                              .toString(),
                                          // myProfileArguments.first_name,
                                          // ObjectFactory().prefs.getUserName() ?? "",
                                          style: GoogleFonts.openSans(
                                            fontSize: 21,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.secondaryColor,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        GestureDetector(
                                          onTap: () {
                                            context.push("/changePassword");
                                          },
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                .changepassword,
                                            // "Change Password",
                                            style: GoogleFonts.openSans(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              color:
                                              AppColors.primaryWhiteColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Flexible(
                                    // flex: 0,
                                    child: Stack(children: [
                                      GestureDetector(
                                        onTap: () async {

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
                                                  // "Please choose either one option"
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                        child: _image!.path.isNotEmpty
                                            ? Container(
                                          alignment: Alignment.center,
                                          width: 130,
                                          height: 130,
                                          // color: Colors.grey[300],
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            // borderRadius: BorderRadius.circular(100),
                                          ),
                                          child: Stack(
                                            children: [
                                              Align(
                                                alignment:
                                                Alignment.center,
                                                child: ClipRRect(
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(100),
                                                  child: Image.file(
                                                    File(_image!.path),
                                                    width: 130,
                                                    height: 130,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              context.read<LanguageBloc>().state.selectedLanguage == Language.english
                                                  ? const Positioned(
                                                bottom: 8,
                                                right: 1,
                                                child: Icon(
                                                  Icons
                                                      .add_a_photo_outlined,
                                                  color: AppColors
                                                      .secondaryColor,
                                                ),
                                              )
                                                  : const Positioned(
                                                bottom: 8,
                                                left: 1,
                                                child: Icon(
                                                  Icons
                                                      .add_a_photo_outlined,
                                                  color: AppColors
                                                      .secondaryColor,
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                            : Stack(children: [
                                          Container(
                                            width: 130.0,
                                            height: 130.0,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                alignment:
                                                Alignment.center,
                                                fit: BoxFit.cover,
                                                image: MemoryImage(
                                                    bytesImage),
                                              ),
                                            ),
                                          ),
                                          context.read<LanguageBloc>().state.selectedLanguage == Language.english
                                              ? const Positioned(
                                            bottom: 8,
                                            right: 1,
                                            child: Icon(
                                              Icons
                                                  .add_a_photo_outlined,
                                              color: AppColors
                                                  .secondaryColor,
                                            ),
                                          )
                                              : const Positioned(
                                            bottom: 8,
                                            left: 1,
                                            child: Icon(
                                              Icons
                                                  .add_a_photo_outlined,
                                              color: AppColors
                                                  .secondaryColor,
                                            ),
                                          )
                                        ]),

                                      )
                                    ]),
                                  ),
                                  // SizedBox(height: 120),
                                ],
                              );
                            }
                            return const SizedBox();
                          },
                        ),
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: SliverPadding(
                        sliver: SliverList(
                          delegate: SliverChildListDelegate([
                            BlocBuilder<MyProfileBloc, MyProfileState>(
                              builder: (context, state) {
                                if (state is MyProfileLoading) {
                                  return const Center(
                                    heightFactor: 9,
                                    child: RefreshProgressIndicator(
                                      color: AppColors.secondaryColor,
                                    ),
                                  );
                                }
                                if (state is MyProfileErrorState) {
                                  return Center(
                                    child: Column(
                                      children: [
                                        Lottie.asset(Assets.TRY_AGAIN),
                                        Text(state.errorMsg),
                                      ],
                                    ),
                                  );
                                }
                                if (state is MyProfileLoaded) {
                                  return Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      // SizedBox(height: 30,),
                                      Text(
                                        AppLocalizations.of(context)!.aboutyou,
                                        // "About You",
                                        style: GoogleFonts.openSans(
                                          color: AppColors.primaryBlackColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ).animate().then(delay: 200.ms).slideY(),

                                      const SizedBox(height: 20),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 11),
                                        child: Row(
                                          children: [
                                            Flexible(
                                              child: BlocBuilder<MyProfileBloc,
                                                  MyProfileState>(
                                                builder: (context, state) {
                                                  if (state
                                                  is MyProfileLoaded) {
                                                    return MyTextField(
                                                      enable: true,
                                                      focusNode: _firstname,
                                                      hintText:
                                                      AppLocalizations.of(
                                                          context)!
                                                          .firstname,
                                                      obscureText: false,
                                                      maxLines: 1,
                                                      controller:
                                                      firstnameController,
                                                      keyboardType:
                                                      TextInputType.text,
                                                      validator: (value) {
                                                        String? err =
                                                        validateFirstname(
                                                            value);
                                                        if (err != null) {
                                                          _firstname
                                                              .requestFocus();
                                                        }
                                                        return err;
                                                      },
                                                    );
                                                  } else {
                                                    return const SizedBox();
                                                  }
                                                },
                                              ),
                                            )
                                                .animate()
                                                .then(delay: 200.ms)
                                                .slideY(),
                                            const SizedBox(width: 20),
                                            Flexible(
                                              child: BlocBuilder<MyProfileBloc,
                                                  MyProfileState>(
                                                builder: (context, state) {
                                                  if (state
                                                  is MyProfileLoaded) {
                                                    return MyTextField(
                                                      enable: true,
                                                      focusNode: _secondname,
                                                      // horizontal: 10,
                                                      hintText:
                                                      AppLocalizations.of(
                                                          context)!
                                                          .lastname,
                                                      // hintText: Strings.SIGNUP_LASTNAME_LABEL_TEXT,
                                                      obscureText: false,
                                                      maxLines: 1,
                                                      controller:
                                                      lastnameController,
                                                      keyboardType:
                                                      TextInputType.text,
                                                      // validator: (value) {
                                                      //   String? err =
                                                      //       validateLastname(
                                                      //           value);
                                                      //   if (err != null) {
                                                      //     _secondname
                                                      //         .requestFocus();
                                                      //   }
                                                      //   return err;
                                                      // },
                                                    );
                                                  } else {
                                                    return const SizedBox();
                                                  }
                                                },
                                              ),
                                            )
                                                .animate()
                                                .then(delay: 200.ms)
                                                .slideY(),
                                          ],
                                        ),
                                      ),
                                      // SizedBox(height: 5,),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15, horizontal: 11),
                                        child: GestureDetector(
                                          onTap: () {
                                            _showDatePicker(context);
                                            print(
                                                "DATE OF BIRTH :$selectedDate ");
                                          },
                                          child: DatePickerTextField(
                                            controller: dateInputController,
                                            // hintText: "Date of Birth",
                                            hintText:
                                            AppLocalizations.of(context)!
                                                .dateofbirth,
                                            onDateIconTap: () {
                                              _showDatePicker(context);
                                            },
                                          ),
                                        ),
                                      ).animate().then(delay: 200.ms).slideY(),

                                      // SizedBox(height: getProportionateScreenHeight(5)),

                                      /// Gender
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 11),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton2<String>(
                                              isExpanded: true,
                                              hint: Text(
                                                genderController.text.isEmpty
                                                // ? "Gender"
                                                    ? AppLocalizations.of(
                                                    context)!
                                                    .gender
                                                    : genderController.text,
                                                style: GoogleFonts.openSans(
                                                  color: AppColors
                                                      .primaryGrayColor,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              items: context
                                                  .read<LanguageBloc>()
                                                  .state
                                                  .selectedLanguage ==
                                                  Language.english
                                                  ? Gender.map(
                                                    (item) =>
                                                    DropdownMenuItem<
                                                        String>(
                                                      value: item,
                                                      child: Text(
                                                        item,
                                                        style: GoogleFonts
                                                            .openSans(
                                                          color: AppColors
                                                              .primaryBlackColor,
                                                          fontSize: 14,
                                                        ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                              ).toList()
                                                  : Gender_ar.map(
                                                    (item) =>
                                                    DropdownMenuItem<
                                                        String>(
                                                      value: item,
                                                      child: Text(
                                                        item,
                                                        style: GoogleFonts
                                                            .openSans(
                                                          color: AppColors
                                                              .primaryBlackColor,
                                                          fontSize: 14,
                                                        ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                              ).toList(),
                                              value: selectedGender,
                                              onChanged: (String? value) {
                                                setState(() {
                                                  selectedGender = value!;
                                                  print(
                                                      "SELECTED GENDER :$selectedGender");
                                                });
                                              },
                                              buttonStyleData: ButtonStyleData(
                                                width: 340,
                                                height: 50,
                                                padding: const EdgeInsets.only(
                                                    left: 14, right: 14),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(5),
                                                  border: Border.all(
                                                    width: 1,
                                                    color:
                                                    const Color(0xFFE6ECFF),
                                                  ),
                                                  color: AppColors
                                                      .primaryWhiteColor,
                                                ),
                                                elevation: 0,
                                              ),
                                              iconStyleData:
                                              const IconStyleData(
                                                icon: Icon(
                                                  Icons.arrow_drop_down_rounded,
                                                  size: 35,
                                                ),
                                                iconSize: 14,
                                                iconEnabledColor:
                                                AppColors.secondaryColor,
                                                iconDisabledColor:
                                                AppColors.primaryGrayColor,
                                              ),
                                              dropdownStyleData:
                                              DropdownStyleData(
                                                maxHeight: 200,
                                                width: 350,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(14),
                                                  color: AppColors
                                                      .primaryWhiteColor,
                                                ),
                                                offset: const Offset(-2, -5),
                                                scrollbarTheme:
                                                ScrollbarThemeData(
                                                  radius:
                                                  const Radius.circular(40),
                                                  thickness:
                                                  MaterialStateProperty.all<
                                                      double>(6),
                                                  thumbVisibility:
                                                  MaterialStateProperty.all<
                                                      bool>(true),
                                                ),
                                              ),
                                              menuItemStyleData:
                                              const MenuItemStyleData(
                                                height: 40,
                                                padding: EdgeInsets.only(
                                                    left: 14, right: 14),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ).animate().then(delay: 200.ms).slideY(),

                                      const SizedBox(height: 15),

                                      /// Nationality
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 11),
                                          child: BlocBuilder<NationalityBloc,
                                              NationalityState>(
                                            builder: (context, state) {
                                              if (state is NationalityLoaded) {
                                                return DropdownButtonHideUnderline(
                                                  child:
                                                  DropdownButton2<String>(
                                                    isExpanded: true,
                                                    hint: Text(
                                                      nationalityController
                                                          .text.isEmpty
                                                          ? AppLocalizations.of(
                                                          context)!
                                                          .nationality
                                                      // ? "Nationality"
                                                          : nationalityController
                                                          .text,
                                                      style:
                                                      GoogleFonts.openSans(
                                                        color: AppColors
                                                            .primaryGrayColor,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    items:
                                                    state
                                                        .nationalityResponse
                                                        .data
                                                        .map(
                                                          (item) =>
                                                          DropdownMenuItem<
                                                              String>(
                                                            value: item.id
                                                                .toString(),
                                                            child: Text(
                                                              context.read<LanguageBloc>().state.selectedLanguage ==
                                                                  Language
                                                                      .english
                                                                  ? item
                                                                  .nationality
                                                                  : item
                                                                  .nationalityArabic,
                                                              style: GoogleFonts
                                                                  .openSans(
                                                                color: AppColors
                                                                    .primaryBlackColor,
                                                                fontSize:
                                                                14,
                                                              ),
                                                              overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                            ),
                                                          ),
                                                    )
                                                        .toList(),
                                                    value:
                                                    selectedNationalityValue,
                                                    onChanged: (String? value) {
                                                      setState(() {
                                                        selectedNationalityValue =
                                                        value!;
                                                        selectedNationality =
                                                        selectedNationalityValue!;
                                                        selectedNationalityID =
                                                            int.tryParse(
                                                                selectedNationality!);
                                                      });
                                                      print(
                                                          'Selected Nationality ID: $selectedNationalityID');

                                                      print(
                                                          'Selected Nationalityvalue : $selectedNationality');
                                                    },
                                                    buttonStyleData:
                                                    ButtonStyleData(
                                                      width: 340,
                                                      height: 50,
                                                      padding:
                                                      const EdgeInsets.only(
                                                          left: 14,
                                                          right: 14),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(5),
                                                        border: Border.all(
                                                          width: 1,
                                                          color: const Color(
                                                              0xFFE6ECFF),
                                                        ),
                                                        color: AppColors
                                                            .primaryWhiteColor,
                                                      ),
                                                      elevation: 0,
                                                    ),
                                                    iconStyleData:
                                                    const IconStyleData(
                                                      icon: Icon(
                                                        Icons
                                                            .arrow_drop_down_rounded,
                                                        size: 35,
                                                      ),
                                                      iconSize: 14,
                                                      iconEnabledColor:
                                                      AppColors
                                                          .secondaryColor,
                                                      iconDisabledColor:
                                                      AppColors
                                                          .primaryGrayColor,
                                                    ),
                                                    dropdownStyleData:
                                                    DropdownStyleData(
                                                      maxHeight: 200,
                                                      width: 350,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(14),
                                                        color: AppColors
                                                            .primaryWhiteColor,
                                                      ),
                                                      offset:
                                                      const Offset(-2, -5),
                                                      scrollbarTheme:
                                                      ScrollbarThemeData(
                                                        radius: const Radius
                                                            .circular(40),
                                                        thickness:
                                                        MaterialStateProperty
                                                            .all<double>(6),
                                                        thumbVisibility:
                                                        MaterialStateProperty
                                                            .all<bool>(
                                                            true),
                                                      ),
                                                    ),
                                                    menuItemStyleData:
                                                    const MenuItemStyleData(
                                                      height: 40,
                                                      padding: EdgeInsets.only(
                                                          left: 14, right: 14),
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                return const SizedBox();
                                              }
                                            },
                                          ),
                                        ),
                                      ).animate().then(delay: 200.ms).slideY(),

                                      SizedBox(
                                          height:
                                          getProportionateScreenHeight(15)),

                                      /// Country
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 11),
                                          child: BlocBuilder<CountryBloc,
                                              CountryState>(
                                            builder: (context, state) {
                                              if (state is CountryLoaded) {
                                                return DropdownButtonHideUnderline(
                                                  child:
                                                  DropdownButton2<String>(
                                                    isExpanded: true,
                                                    hint: Text(
                                                      countryController
                                                          .text.isEmpty
                                                      // ? "Country you live in"
                                                          ? AppLocalizations.of(
                                                          context)!
                                                          .countryyoulivein
                                                          : countryController
                                                          .text,
                                                      style:
                                                      GoogleFonts.openSans(
                                                        color: AppColors
                                                            .primaryGrayColor,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    items:
                                                    state.countryResponse
                                                        .data
                                                        .map(
                                                          (item) =>
                                                          DropdownMenuItem<
                                                              String>(
                                                            value: item
                                                                .countriesId
                                                                .toString(),
                                                            child: Text(
                                                              context.read<LanguageBloc>().state.selectedLanguage ==
                                                                  Language
                                                                      .english
                                                                  ? item
                                                                  .name
                                                                  : item
                                                                  .nameArabic,
                                                              style: GoogleFonts
                                                                  .openSans(
                                                                color: AppColors
                                                                    .primaryBlackColor,
                                                                fontSize:
                                                                14,
                                                              ),
                                                              overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                            ),
                                                          ),
                                                    )
                                                        .toList(),
                                                    value: selectedCountryValue,
                                                    onChanged: (String? value) {
                                                      setState(() {
                                                        selectedCountryValue =
                                                            value;
                                                        selectedCountry =
                                                        selectedCountryValue!;
                                                        selectedCountryID =
                                                            int.tryParse(
                                                                selectedCountry!);
                                                      });
                                                      print(
                                                          'Selected Country ID: $selectedCountryID');
                                                      BlocProvider.of<CityBloc>(
                                                          context)
                                                          .add(
                                                        GetCityEvent(
                                                            getCityRequest:
                                                            GetCityRequest(
                                                                countriesId:
                                                                selectedCountryID!)),
                                                      );
                                                    },
                                                    buttonStyleData:
                                                    ButtonStyleData(
                                                      width: 340,
                                                      height: 50,
                                                      padding:
                                                      const EdgeInsets.only(
                                                          left: 14,
                                                          right: 14),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(5),
                                                        border: Border.all(
                                                          width: 1,
                                                          color: const Color(
                                                              0xFFE6ECFF),
                                                        ),
                                                        color: AppColors
                                                            .primaryWhiteColor,
                                                      ),
                                                      elevation: 0,
                                                    ),
                                                    iconStyleData:
                                                    const IconStyleData(
                                                      icon: Icon(
                                                        Icons
                                                            .arrow_drop_down_rounded,
                                                        size: 35,
                                                      ),
                                                      iconSize: 14,
                                                      iconEnabledColor:
                                                      AppColors
                                                          .secondaryColor,
                                                      iconDisabledColor:
                                                      AppColors
                                                          .primaryGrayColor,
                                                    ),
                                                    dropdownStyleData:
                                                    DropdownStyleData(
                                                      maxHeight: 200,
                                                      width: 350,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(14),
                                                        color: AppColors
                                                            .primaryWhiteColor,
                                                      ),
                                                      offset:
                                                      const Offset(-2, -5),
                                                      scrollbarTheme:
                                                      ScrollbarThemeData(
                                                        radius: const Radius
                                                            .circular(40),
                                                        thickness:
                                                        MaterialStateProperty
                                                            .all<double>(6),
                                                        thumbVisibility:
                                                        MaterialStateProperty
                                                            .all<bool>(
                                                            true),
                                                      ),
                                                    ),
                                                    menuItemStyleData:
                                                    const MenuItemStyleData(
                                                      height: 40,
                                                      padding: EdgeInsets.only(
                                                          left: 14, right: 14),
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                return const SizedBox();
                                              }
                                            },
                                          ),
                                        ),
                                      ).animate().then(delay: 200.ms).slideY(),

                                      SizedBox(
                                          height:
                                          getProportionateScreenHeight(15)),

                                      /// City
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 11),
                                          child:
                                          BlocBuilder<CityBloc, CityState>(
                                            builder: (context, state) {
                                              if (state is CityLoading) {
                                                return Center(
                                                  child: Lottie.asset(
                                                    Assets.JUMBINGDOT,
                                                    height: 70,
                                                    width: 90,
                                                  ),
                                                );
                                              } else if (state is CityLoaded) {
                                                return DropdownButtonHideUnderline(
                                                  child:
                                                  DropdownButton2<String>(
                                                    isExpanded: true,
                                                    hint: Text(
                                                      cityController
                                                          .text.isEmpty
                                                      // ? "City"
                                                          ? AppLocalizations.of(
                                                          context)!
                                                          .city
                                                          : cityController.text,
                                                      style:
                                                      GoogleFonts.openSans(
                                                        color: AppColors
                                                            .primaryGrayColor,
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                    items:
                                                    state.getCityResponse
                                                        .data
                                                        .map(
                                                          (item) =>
                                                          DropdownMenuItem<
                                                              String>(
                                                            value: item
                                                                .cityId
                                                                .toString(),
                                                            child: Text(
                                                              context.read<LanguageBloc>().state.selectedLanguage ==
                                                                  Language
                                                                      .english
                                                                  ? item
                                                                  .city
                                                                  : item
                                                                  .cityArabic,
                                                              style: GoogleFonts
                                                                  .openSans(
                                                                color: AppColors
                                                                    .primaryBlackColor,
                                                                fontSize:
                                                                14,
                                                              ),
                                                              overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                            ),
                                                          ),
                                                    )
                                                        .toList(),
                                                    value: selectedCityID,
                                                    onChanged: (String? value) {
                                                      setState(() {
                                                        selectedCityID = value!;
                                                        print(
                                                            "SELECTED CITY ID :$selectedCityID");
                                                      });
                                                    },
                                                    buttonStyleData:
                                                    ButtonStyleData(
                                                      width: 340,
                                                      height: 50,
                                                      padding:
                                                      const EdgeInsets.only(
                                                          left: 14,
                                                          right: 14),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(5),
                                                        border: Border.all(
                                                          width: 1,
                                                          color: AppColors.borderColor,
                                                        ),
                                                        color: AppColors
                                                            .primaryWhiteColor,
                                                      ),
                                                      elevation: 0,
                                                    ),
                                                    iconStyleData:
                                                    const IconStyleData(
                                                      icon: Icon(
                                                        Icons
                                                            .arrow_drop_down_rounded,
                                                        size: 35,
                                                      ),
                                                      iconSize: 14,
                                                      iconEnabledColor:
                                                      AppColors
                                                          .secondaryColor,
                                                      iconDisabledColor:
                                                      AppColors
                                                          .primaryGrayColor,
                                                    ),
                                                    dropdownStyleData:
                                                    DropdownStyleData(
                                                      maxHeight: 200,
                                                      width: 350,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(14),
                                                        color: AppColors
                                                            .primaryWhiteColor,
                                                      ),
                                                      offset:
                                                      const Offset(-2, -5),
                                                      scrollbarTheme:
                                                      ScrollbarThemeData(
                                                        radius: const Radius
                                                            .circular(40),
                                                        thickness:
                                                        MaterialStateProperty
                                                            .all<double>(6),
                                                        thumbVisibility:
                                                        MaterialStateProperty
                                                            .all<bool>(
                                                            true),
                                                      ),
                                                    ),
                                                    menuItemStyleData:
                                                    const MenuItemStyleData(
                                                      height: 40,
                                                      padding: EdgeInsets.only(
                                                          left: 14, right: 14),
                                                    ),
                                                  ),
                                                );
                                              } else {
                                                return const SizedBox();
                                              }
                                            },
                                          ),
                                        ),
                                      ).animate().then(delay: 200.ms).slideY(),

                                      const SizedBox(height: 20),
                                      Text(
                                        AppLocalizations.of(context)!
                                            .contactinfo,
                                        // "Contact Info",
                                        style: GoogleFonts.openSans(
                                          color: AppColors.primaryBlackColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ).animate().then(delay: 200.ms).slideY(),
                                      const SizedBox(height: 20),

                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 11),
                                        child: MyTextField(
                                          enable: false,
                                          focusNode: _email,
                                          // horizontal: 10,
                                          // hintText: Strings.SIGNUP_EMAIL_LABEL_TEXT,
                                          hintText:
                                          AppLocalizations.of(context)!
                                              .email,
                                          obscureText: false,
                                          maxLines: 1,
                                          controller: emailController,
                                          keyboardType: TextInputType.text,
                                        ),
                                      ).animate().then(delay: 200.ms).slideY(),

                                      const SizedBox(height: 15),

                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 11),
                                        child: BlocBuilder<MyProfileBloc,
                                            MyProfileState>(
                                          builder: (context, state) {
                                            if (state is MyProfileLoaded) {
                                              return MyTextField(
                                                inputFormatter: [
                                                  LengthLimitingTextInputFormatter(
                                                      10)
                                                ],
                                                enable: true,
                                                focusNode: _phone,
                                                // horizontal: 10,
                                                // hintText: Strings.PHONE_NUMBER,
                                                hintText: AppLocalizations.of(
                                                    context)!
                                                    .phonenumber,
                                                obscureText: false,
                                                maxLines: 1,
                                                controller: mobileController,

                                                keyboardType:
                                                TextInputType.number,

                                              );
                                            } else {
                                              return const SizedBox();
                                            }
                                          },
                                        ),
                                      ).animate().then(delay: 200.ms).slideY(),
                                      const SizedBox(height: 20),

                                      BlocBuilder<MyProfileBloc,
                                          MyProfileState>(
                                        builder: (context, state) {
                                          if (state is MyEditProfileLoading) {
                                            return const Center(
                                              child: RefreshProgressIndicator(
                                                color: AppColors.secondaryColor,
                                                // backgroundColor: AppColors.secondaryColor,
                                              ),
                                            );
                                          }
                                          return Center(
                                            child: MyButton(
                                              Textfontsize: 16,
                                              TextColors:
                                              AppColors.primaryWhiteColor,
                                              // text: "save",
                                              text:
                                              AppLocalizations.of(context)!
                                                  .save,
                                              color: AppColors.secondaryColor,
                                              width: 340,
                                              height: 40,
                                              onTap: () {
                                                // BlocProvider.of<MyProfileBloc>(context)
                                                //     .add(GetProfileDataEvent());
                                                if (firstnameController.text.isEmpty) {
                                                  Fluttertoast.showToast(
                                                    msg: "please enter firstname",
                                                    // msg: AppLocalizations.of(context)!.allfieldsareimportant,
                                                    toastLength: Toast.LENGTH_LONG,
                                                    gravity: ToastGravity.BOTTOM,
                                                    backgroundColor: AppColors.secondaryColor,
                                                    textColor: AppColors.primaryWhiteColor,
                                                  );
                                                  return;
                                                }
                                                if (_formKey.currentState
                                                    ?.validate() ??
                                                    false) {
                                                  BlocProvider.of<
                                                      MyProfileBloc>(
                                                      context)
                                                      .add(
                                                    EditProfileDataEvent(
                                                      editProfileRequest:
                                                      EditProfileRequest(
                                                        firstName: firstnameController.text,
                                                        lastName: lastnameController.text,
                                                        photo: imageUploadFormated
                                                            .isNotEmpty
                                                            ? imageUploadFormated
                                                            : widget
                                                            .myProfileArguments
                                                            .photo,
                                                        dob: selectedDate !=
                                                            null &&
                                                            selectedDate
                                                                .toString()
                                                                .isNotEmpty
                                                            ? selectedDate
                                                            .toString()
                                                            : dateInputController
                                                            .text,
                                                        gender: selectedGender !=
                                                            null &&
                                                            selectedGender
                                                                .toString()
                                                                .isNotEmpty
                                                            ? selectedGender
                                                            .toString()
                                                            : genderController
                                                            .text,
                                                        mobileNo: mobileController.text,
                                                        nationalityId: (selectedNationalityID != null)
                                                            ? selectedNationalityID!.toString()
                                                            : ((widget.myProfileArguments.nationality_id.toString() == "0")
                                                            ? ""
                                                            : widget.myProfileArguments.nationality_id.toString()),

                                                        city: selectedCityID != null &&
                                                            selectedCityID
                                                                .toString()
                                                                .isNotEmpty
                                                            ? selectedCityID
                                                            .toString()
                                                            : widget
                                                            .myProfileArguments
                                                            .city
                                                            .toString(),
                                                        countryId: (selectedCountryID != null)
                                                            ? selectedCountryID!.toString()
                                                            : ((widget.myProfileArguments.country_id.toString() == "0")
                                                            ? ""
                                                            : widget.myProfileArguments.country_id.toString()),
                                                        userName: widget
                                                            .myProfileArguments
                                                            .user_name,
                                                        status: 1,
                                                      ),
                                                    ),
                                                  );
                                                  print(
                                                      'FIRST NAME = $firstnameController');
                                                  print(
                                                      'LAST NAME = $lastnameController');
                                                  print(
                                                      'DOB = ${selectedDate != null && selectedDate.toString().isNotEmpty ? selectedDate.toString() : dateInputController.text}');
                                                  print(
                                                      'GENDER = ${selectedGender != null && selectedGender.toString().isNotEmpty ? selectedGender.toString() : genderController.text}');
                                                  print(
                                                      'NATIONALITY  = ${selectedNationalityID != null ? selectedNationalityID! : int.parse(widget.myProfileArguments.nationality_id.toString())}');
                                                  print(
                                                      'COUNTRY = ${selectedCountryID != null ? selectedCountryID! : int.parse(widget.myProfileArguments.country_id.toString())}');
                                                  print(
                                                      'CITY =  ${selectedCityID != null && selectedCityID.toString().isNotEmpty ? selectedCityID.toString() : widget.myProfileArguments.city.toString()}');
                                                  print(
                                                      'Email = $emailController');
                                                  print(
                                                      'PHONE NUMBER =  $mobileController');
                                                  print(
                                                      "PHOTO  = ${imageUploadFormated.isNotEmpty ? imageUploadFormated : widget.myProfileArguments.photo}");
                                                } else {
                                                  Fluttertoast.showToast(
                                                    // msg: "All fields are important",
                                                    msg: AppLocalizations.of(
                                                        context)!
                                                        .allfieldsareimportant,
                                                    toastLength:
                                                    Toast.LENGTH_SHORT,
                                                    gravity:
                                                    ToastGravity.BOTTOM,
                                                    backgroundColor:
                                                    AppColors.secondaryColor,
                                                    textColor: AppColors.primaryWhiteColor,
                                                  );
                                                }
                                              },
                                              showImage: false,
                                              imagePath: '',
                                              imagewidth: 0,
                                              imageheight: 0,
                                            ),
                                          );
                                        },
                                      ).animate().then(delay: 200.ms).slideY(),
                                    ],
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              },
                            ),
                          ]),
                        ),
                        padding: const EdgeInsets.only(
                            top: 15, left: 15, right: 15, bottom: 30),
                      ),
                    )
                  ],
                );
              },
            );
          } else if (state is NetworkFailure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(Assets.NO_INTERNET),
                  Text(
                    AppLocalizations.of(context)!
                        .youarenotconnectedtotheinternet,
                    // "You are not connected to the internet",
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
      ),
    );
  }
}

class DatePickerTextField extends StatefulWidget {
  final TextEditingController controller;
  final void Function() onDateIconTap;
  final String hintText;

  const DatePickerTextField({
    super.key,
    required this.controller,
    required this.onDateIconTap,
    required this.hintText,
  });

  @override
  State<DatePickerTextField> createState() => _DatePickerTextFieldState();
}

class _DatePickerTextFieldState extends State<DatePickerTextField> {
  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      child: TextFormField(
        controller: widget.controller,
        style: GoogleFonts.openSans(
          color: AppColors.primaryGrayColor,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: GoogleFonts.openSans(
            color: AppColors.primaryGrayColor,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide:
            const BorderSide(width: 1, color: AppColors.borderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(color: AppColors.primaryColor2),
          ),
          fillColor: AppColors.primaryWhiteColor,
          filled: true,
          contentPadding:
          const EdgeInsets.only(left: 15, right: 8, top: 8, bottom: 8),
          suffixIcon: IconButton(
            padding: const EdgeInsets.only(right: 20, left: 20),
            color: AppColors.secondaryColor,
            icon: const Icon(Icons.calendar_today),
            onPressed: () => widget.onDateIconTap(),
          ),
        ),
      ),
    );
  }
}