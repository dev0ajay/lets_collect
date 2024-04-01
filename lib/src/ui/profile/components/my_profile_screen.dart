import 'dart:convert';
import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lets_collect/src/bloc/city_bloc/city_bloc.dart';
import 'package:lets_collect/src/bloc/country_bloc/country_bloc.dart';
import 'package:lets_collect/src/bloc/my_profile_bloc/my_profile_bloc.dart';
import 'package:lets_collect/src/bloc/nationality_bloc/nationality_bloc.dart';
import 'package:lets_collect/src/components/Custome_Textfiled.dart';
import 'package:lets_collect/src/components/my_button.dart';
import 'package:lets_collect/src/constants/assets.dart';
import 'package:lets_collect/src/constants/colors.dart';
import 'package:lets_collect/src/constants/strings.dart';
import 'package:lets_collect/src/model/auth/get_city_request.dart';
import 'package:lets_collect/src/model/edit_profile/edit_profile_request.dart';
import 'package:lets_collect/src/utils/network_connectivity/bloc/network_bloc.dart';
import 'package:lets_collect/src/utils/screen_size/size_config.dart';
import 'package:lottie/lottie.dart';
import 'package:path/path.dart' as p;
import 'package:permission_handler/permission_handler.dart';
import 'my_profile_screen_arguments.dart';

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

  bool isAbove12YearsOld(DateTime selectedDate) {
    final DateTime now = DateTime.now();
    final DateTime twelveYearsAgo =
        now.subtract(const Duration(days: 12 * 365));
    return selectedDate.isBefore(twelveYearsAgo);
  }

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
          msg: "Please select a date of birth above 12 years old!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: AppColors.primaryWhiteColor,
          textColor: AppColors.secondaryColor,
        );
      }
    }
  }

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

  String? validateFirstname(String? value) {
    String pattern = "[a-zA-Z]";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value)) {
      return 'Enter first name';
    } else {
      return null;
    }
  }

  String? validateLastname(String? value) {
    String pattern = "["
        "a-zA-Z]";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value)) {
      return 'Enter last name';
    } else {
      return null;
    }
  }

  String? validatePhoneNumber(String? value) {
    if (value!.length < 10 || value.isEmpty) {
      return 'Enter a valid phone number';
    } else {
      return null;
    }
  }

  String? selectedGender;

  final List<String> Gender = ["M", "F"];

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

  // Future<void> _pickImage() async {
  //   final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
  //
  //   if (pickedFile == null) {
  //     // No image selected
  //     ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('Nothing is selected'))
  //     );
  //     return;
  //   }
  //
  //   final File pickedImage = File(pickedFile.path);
  //   final bytes = await pickedImage.readAsBytes();
  //   final decodedImage = await decodeImageFromList(bytes);
  //
  //   // Check if image dimensions exceed 2MP
  //   if (decodedImage.width! * decodedImage.height! > 2 * 1024 * 1024) {
  //     // Image exceeds 2MP limit
  //     ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('Selected image exceeds 2MP limit'))
  //     );
  //     return;
  //   }
  //
  //   setState(() {
  //     _pickedFile = pickedFile;
  //     _image = pickedImage;
  //     imageBase64 = base64Encode(bytes);
  //     extension = p.extension(pickedFile.path).trim().replaceAll('.', '');
  //     imageUploadFormated = "data:image/$extension;base64,$imageBase64";
  //   });
  // }

  Future<void> _pickImage() async {
    _pickedFile = (await _picker.pickImage(
        source: ImageSource.gallery, imageQuality: 5))!;
    final bytes = await _pickedFile.readAsBytes();
    final image = await decodeImageFromList(bytes);

    // Calculate the dimensions of the image
    int imageWidth = image.width;
    int imageHeight = image.height;
    // Calculate the total number of megapixels
    double megapixels = (imageWidth * imageHeight) / 1000000;

    print('SELECTED IMAGE HAS $megapixels MP.');

    if (megapixels > 5) {
      Fluttertoast.showToast(
        msg:
            "Selected image is greater than 5MP, Please Choose an image size less than 5MP",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppColors.secondaryColor,
        textColor: AppColors.primaryWhiteColor,
      );
      return;
    }

    setState(() {
      _image = File(_pickedFile.path);
      galleryFile = File(_pickedFile.path);
      String img64 = base64Encode(bytes);
      imageBase64 = img64;
      extension = p
          .extension(galleryFile!.path)
          .trim()
          .toString()
          .replaceAll('.', '');
      imageUploadFormated = "data:image/$extension;base64,$imageBase64";
    });
    }

  // Future<void> _pickImage() async {
  //   _pickedFile = (await _picker.pickImage(source: ImageSource.gallery))!;
  //   setState(() {
  //     _image = File(_pickedFile.path);
  //     if (XFile != null) {
  //       galleryFile = File(_pickedFile.path);
  //       final bytes = galleryFile!.readAsBytesSync();
  //       String img64 = base64Encode(bytes);
  //       setState(() {
  //         imageBase64 = img64;
  //         extension = p
  //             .extension(galleryFile!.path)
  //             .trim()
  //             .toString()
  //             .replaceAll('.', '');
  //         imageUploadFormated = "data:image/$extension;base64,$imageBase64";
  //       });
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(// is this context <<<
  //           const SnackBar(content: Text('Nothing is selected')));
  //     }
  //   });
  // }

  myProfileArgumentData() {
    firstnameController.text = widget.myProfileArguments.first_name;
    print("FIRST NAME : $firstnameController.text");

    lastnameController.text = widget.myProfileArguments.last_name;
    print("LASTNAME  : $lastnameController.text");

    dateInputController.text = widget.myProfileArguments.dob;

    genderController.text = widget.myProfileArguments.gender;
    print("GENDER : $genderController.text");

    nationalityController.text =
        widget.myProfileArguments.nationality_name_en;
    print("NATIONALITY : $nationalityController.text");

    cityController.text = widget.myProfileArguments.city_name;
    print("CITY : $cityController.text");

    countryController.text = widget.myProfileArguments.country_name_en;
    print("COUNTRTY : $countryController.text");

    emailController.text = widget.myProfileArguments.email;
    print("EMAIL : $emailController.text");

    mobileController.text = widget.myProfileArguments.mobile_no == "0"
        ? "Mobile Number"
        : widget.myProfileArguments.mobile_no;
    print("MOBILE NUMBER : $mobileController.text");
    }

  ///Runtime User Access and Permission handling

  void openSettings() {
    openAppSettings();
  }

  void _showPermissionDialog(BuildContext permissionDialogContext) {
    showDialog(
        context: _scaffoldKey.currentContext!,
        builder: (BuildContext permissionDialogContext) {
          return AlertDialog(
            title: Text(
              "Permission Denied!",
              style: GoogleFonts.openSans(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            content: Text(
              "To continue file upload allow access to files and storage.",
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
                  "Cancel",
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
                  "Settings",
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

  Future<void> checkPermissionForGallery(BuildContext context) async {
    final status = await Permission.photos.request();
    if (status.isGranted) {
      print("Permission granted");
      _pickImage();
    } else if (status.isDenied) {
      print("Permission Denied");
      _showPermissionDialog(context);
    } else if (status.isPermanentlyDenied) {
      print("Permission permanently denied");

      openSettings();
    } else if (status.isLimited) {
      print("Permission is Limitted");
      _pickImage();
    }
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<MyProfileBloc>(context).add(GetProfileDataEvent());
    myProfileArgumentData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<NetworkBloc, NetworkState>(
          listener: (BuildContext context, NetworkState state) {
        if (state is NetworkSuccess) {
          networkSuccess = true;
        }
      }, builder: (context, state) {
        if (state is NetworkSuccess) {
          return BlocConsumer<MyProfileBloc, MyProfileState>(
            listener: (context, state) {},
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
                          child: const Text(
                            "Try again",
                            style:
                                TextStyle(color: AppColors.primaryWhiteColor),
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
                        "Some Error Happened",
                        style: GoogleFonts.openSans(
                          color: AppColors.primaryWhiteColor,
                        ),
                      ),
                    ),
                  );
                }
              }
              return Form(
                key: _formKey,
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverPersistentHeader(
                      pinned: true,
                      floating: true,
                      delegate: CustomSliverDelegate(
                        checkPermission: checkPermissionForGallery,
                        expandedHeight: 190,
                        myProfileArguments: widget.myProfileArguments,
                        filePath: _image!,
                      ),
                    ),
                    SliverPadding(
                      sliver: SliverList(
                        delegate: SliverChildListDelegate([
                          BlocBuilder<MyProfileBloc, MyProfileState>(
                            builder: (context, state) {
                              if (state is MyProfileLoading) {
                                return const Center(
                                  heightFactor: 10,
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
                                      const Text("state"),
                                    ],
                                  ),
                                );
                              }
                              if (state is MyProfileLoaded) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // SizedBox(height: 30,),
                                    Text(
                                      "About You",
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
                                                if (state is MyProfileLoaded) {
                                                  return MyTextField(
                                                    enable: true,
                                                    focusNode: _firstname,
                                                    // horizontal: 10,
                                                    hintText: Strings
                                                        .SIGNUP_FIRSTNAME_LABEL_TEXT,
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
                                                if (state is MyProfileLoaded) {
                                                  return MyTextField(
                                                    enable: true,
                                                    focusNode: _secondname,
                                                    // horizontal: 10,
                                                    hintText: Strings
                                                        .SIGNUP_LASTNAME_LABEL_TEXT,
                                                    obscureText: false,
                                                    maxLines: 1,
                                                    controller:
                                                        lastnameController,
                                                    keyboardType:
                                                        TextInputType.text,
                                                    validator: (value) {
                                                      String? err =
                                                          validateLastname(
                                                              value);
                                                      if (err != null) {
                                                        _secondname
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
                                          hintText: "Date of Birth",
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
                                                  ? "Gender"
                                                  : genderController.text,
                                              style: GoogleFonts.openSans(
                                                color:
                                                    AppColors.primaryGrayColor,
                                                fontSize: 14,
                                              ),
                                            ),
                                            items: Gender.map(
                                              (item) =>
                                                  DropdownMenuItem<String>(
                                                value: item,
                                                child: Text(
                                                  item,
                                                  style: GoogleFonts.openSans(
                                                    color: AppColors
                                                        .primaryBlackColor,
                                                    fontSize: 14,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                                color:
                                                    AppColors.primaryWhiteColor,
                                              ),
                                              elevation: 0,
                                            ),
                                            iconStyleData: const IconStyleData(
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
                                                color:
                                                    AppColors.primaryWhiteColor,
                                              ),
                                              offset: const Offset(-2, -5),
                                              scrollbarTheme:
                                                  ScrollbarThemeData(
                                                radius:
                                                    const Radius.circular(40),
                                                thickness: MaterialStateProperty
                                                    .all<double>(6),
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
                                                child: DropdownButton2<String>(
                                                  isExpanded: true,
                                                  hint: Text(
                                                    nationalityController
                                                            .text.isEmpty
                                                        ? "Nationality"
                                                        : nationalityController
                                                            .text,
                                                    style: GoogleFonts.openSans(
                                                      color: AppColors
                                                          .primaryGrayColor,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  items: state
                                                      .nationalityResponse.data
                                                      .map(
                                                        (item) =>
                                                            DropdownMenuItem<
                                                                String>(
                                                          value: item.id
                                                              .toString(),
                                                          child: Text(
                                                            item.nationality,
                                                            style: GoogleFonts
                                                                .openSans(
                                                              color: AppColors
                                                                  .primaryBlackColor,
                                                              fontSize: 14,
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
                                                          BorderRadius.circular(
                                                              5),
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
                                                    iconEnabledColor: AppColors
                                                        .secondaryColor,
                                                    iconDisabledColor: AppColors
                                                        .primaryGrayColor,
                                                  ),
                                                  dropdownStyleData:
                                                      DropdownStyleData(
                                                    maxHeight: 200,
                                                    width: 350,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              14),
                                                      color: AppColors
                                                          .primaryWhiteColor,
                                                    ),
                                                    offset:
                                                        const Offset(-2, -5),
                                                    scrollbarTheme:
                                                        ScrollbarThemeData(
                                                      radius:
                                                          const Radius.circular(
                                                              40),
                                                      thickness:
                                                          MaterialStateProperty
                                                              .all<double>(6),
                                                      thumbVisibility:
                                                          MaterialStateProperty
                                                              .all<bool>(true),
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
                                                child: DropdownButton2<String>(
                                                  isExpanded: true,
                                                  hint: Text(
                                                    countryController
                                                            .text.isEmpty
                                                        ? "Country you live in"
                                                        : countryController
                                                            .text,
                                                    style: GoogleFonts.openSans(
                                                      color: AppColors
                                                          .primaryGrayColor,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  items:
                                                      state.countryResponse.data
                                                          .map(
                                                            (item) =>
                                                                DropdownMenuItem<
                                                                    String>(
                                                              value: item
                                                                  .countriesId
                                                                  .toString(),
                                                              child: Text(
                                                                item.name,
                                                                style: GoogleFonts
                                                                    .openSans(
                                                                  color: AppColors
                                                                      .primaryBlackColor,
                                                                  fontSize: 14,
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
                                                          BorderRadius.circular(
                                                              5),
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
                                                    iconEnabledColor: AppColors
                                                        .secondaryColor,
                                                    iconDisabledColor: AppColors
                                                        .primaryGrayColor,
                                                  ),
                                                  dropdownStyleData:
                                                      DropdownStyleData(
                                                    maxHeight: 200,
                                                    width: 350,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              14),
                                                      color: AppColors
                                                          .primaryWhiteColor,
                                                    ),
                                                    offset:
                                                        const Offset(-2, -5),
                                                    scrollbarTheme:
                                                        ScrollbarThemeData(
                                                      radius:
                                                          const Radius.circular(
                                                              40),
                                                      thickness:
                                                          MaterialStateProperty
                                                              .all<double>(6),
                                                      thumbVisibility:
                                                          MaterialStateProperty
                                                              .all<bool>(true),
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
                                        child: BlocBuilder<CityBloc, CityState>(
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
                                                child: DropdownButton2<String>(
                                                  isExpanded: true,
                                                  hint: Text(
                                                    cityController.text.isEmpty
                                                        ? "City"
                                                        : cityController.text,
                                                    style: GoogleFonts.openSans(
                                                      color: AppColors
                                                          .primaryGrayColor,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  items:
                                                      state.getCityResponse.data
                                                          .map(
                                                            (item) =>
                                                                DropdownMenuItem<
                                                                    String>(
                                                              value: item.cityId
                                                                  .toString(),
                                                              child: Text(
                                                                item.city,
                                                                style: GoogleFonts
                                                                    .openSans(
                                                                  color: AppColors
                                                                      .primaryBlackColor,
                                                                  fontSize: 14,
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
                                                          BorderRadius.circular(
                                                              5),
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
                                                    iconEnabledColor: AppColors
                                                        .secondaryColor,
                                                    iconDisabledColor: AppColors
                                                        .primaryGrayColor,
                                                  ),
                                                  dropdownStyleData:
                                                      DropdownStyleData(
                                                    maxHeight: 200,
                                                    width: 350,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              14),
                                                      color: AppColors
                                                          .primaryWhiteColor,
                                                    ),
                                                    offset:
                                                        const Offset(-2, -5),
                                                    scrollbarTheme:
                                                        ScrollbarThemeData(
                                                      radius:
                                                          const Radius.circular(
                                                              40),
                                                      thickness:
                                                          MaterialStateProperty
                                                              .all<double>(6),
                                                      thumbVisibility:
                                                          MaterialStateProperty
                                                              .all<bool>(true),
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
                                      "Contact Info",
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
                                        hintText:
                                            Strings.SIGNUP_EMAIL_LABEL_TEXT,
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
                                              hintText: Strings.PHONE_NUMBER,
                                              obscureText: false,
                                              maxLines: 1,
                                              controller: mobileController,

                                              keyboardType:
                                                  TextInputType.number,
                                              validator: (value) {
                                                String? err =
                                                    validatePhoneNumber(value);
                                                if (err != null) {
                                                  _phone.requestFocus();
                                                }
                                                return err;
                                              },
                                            );
                                          } else {
                                            return const SizedBox();
                                          }
                                        },
                                      ),
                                    ).animate().then(delay: 200.ms).slideY(),
                                    const SizedBox(height: 20),

                                    BlocBuilder<MyProfileBloc, MyProfileState>(
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
                                            text: "save",
                                            color: AppColors.secondaryColor,
                                            width: 340,
                                            height: 40,
                                            onTap: () {
                                              // BlocProvider.of<MyProfileBloc>(context)
                                              //     .add(GetProfileDataEvent());
                                              if (_formKey.currentState
                                                      ?.validate() ??
                                                  false) {
                                                BlocProvider.of<MyProfileBloc>(
                                                        context)
                                                    .add(
                                                  EditProfileDataEvent(
                                                    editProfileRequest:
                                                        EditProfileRequest(
                                                      firstName:
                                                          firstnameController
                                                              .text,
                                                      lastName:
                                                          lastnameController
                                                              .text,
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
                                                      mobileNo: int.parse(
                                                          mobileController
                                                              .text),
                                                      nationalityId:
                                                          selectedNationalityID !=
                                                                  null
                                                              ? selectedNationalityID!
                                                              : int.parse(widget
                                                                  .myProfileArguments
                                                                  .nationality_id
                                                                  .toString()),
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
                                                      countryId: selectedCountryID !=
                                                              null
                                                          ? selectedCountryID!
                                                          : int.parse(widget
                                                              .myProfileArguments
                                                              .country_id
                                                              .toString()),
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
                                                  msg:
                                                      "All fields are important",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  backgroundColor:
                                                      Colors.black87,
                                                  textColor: Colors.white,
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
                    )
                  ],
                ),
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
                  "You are not connected to the internet",
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
      }),
    );

    // BlocConsumer<NetworkBloc, NetworkState>(
    //   listener: (BuildContext context, NetworkState state) {
    //     if (state is NetworkSuccess) {
    //       networkSuccess = true;
    //     }
    //   },
    //   builder: (context, state) {
    //     if (state is NetworkSuccess) {
    //       return BlocConsumer<MyProfileBloc, MyProfileState>(
    //         listener: (context, state) {
    //           // if (state is MyEditProfileLoaded) {
    //           //   if (state.editProfileRequestResponse.status == true) {
    //           //     BlocProvider.of<MyProfileBloc>(context).add(GetProfileDataEvent());
    //           //   }
    //           // } else if (state is MyEditProfileLoaded) {
    //           //   if (state.editProfileRequestResponse.status == false) {
    //           //     ScaffoldMessenger.of(context).showSnackBar(
    //           //       SnackBar(
    //           //         backgroundColor: AppColors.secondaryColor,
    //           //         content: Text(
    //           //           "Some Error Happened",
    //           //           style: GoogleFonts.openSans(
    //           //             color: AppColors.primaryWhiteColor,
    //           //           ),
    //           //         ),
    //           //       ),
    //           //     );
    //           //   }
    //           // }
    //         },
    //         builder: (context, state) {
    //           if (state is MyEditProfileLoading) {
    //             return const Center(
    //               child: RefreshProgressIndicator(
    //                 color: AppColors.secondaryColor,
    //                 backgroundColor: AppColors.primaryWhiteColor,
    //               ),
    //             );
    //           }
    //           if (state is MyEditProfileLoading) {
    //             return Center(
    //               child: Column(
    //                 children: [
    //                   Lottie.asset(Assets.TRY_AGAIN),
    //                   const Text("state"),
    //                 ],
    //               ),
    //             );
    //           }
    //
    //           if (state is MyEditProfileLoaded) {
    //             if (state.editProfileRequestResponse.status == true) {
    //               BlocProvider.of<MyProfileBloc>(context)
    //                   .add(GetProfileDataEvent());
    //             }
    //           } else if (state is MyEditProfileLoaded) {
    //             if (state.editProfileRequestResponse.status == false) {
    //               ScaffoldMessenger.of(context).showSnackBar(
    //                 SnackBar(
    //                   backgroundColor: AppColors.secondaryColor,
    //                   content: Text(
    //                     "Some Error Happened",
    //                     style: GoogleFonts.openSans(
    //                       color: AppColors.primaryWhiteColor,
    //                     ),
    //                   ),
    //                 ),
    //               );
    //             }
    //           }
    //
    //           return Scaffold(
    //             body: Form(
    //               key: _formKey,
    //               child: CustomScrollView(
    //                 slivers: <Widget>[
    //                   SliverPersistentHeader(
    //                     pinned: true,
    //                     floating: true,
    //                     delegate: CustomSliverDelegate(
    //                       pickImage: _pickImage,
    //                       expandedHeight: 150,
    //                       myProfileArguments: widget.myProfileArguments,
    //                       filePath: _image!,
    //                     ),
    //                   ),
    //                   SliverPadding(
    //                     sliver: SliverList(
    //                       delegate: SliverChildListDelegate([
    //                         BlocBuilder<MyProfileBloc, MyProfileState>(
    //                           builder: (context, state) {
    //                             if (state is MyProfileLoading) {
    //                               return const Center(
    //                                 heightFactor: 10,
    //                                 child: RefreshProgressIndicator(
    //                                   color: AppColors.secondaryColor,
    //                                 ),
    //                               );
    //                             }
    //                             if (state is MyProfileErrorState) {
    //                               return Center(
    //                                 child: Column(
    //                                   children: [
    //                                     Lottie.asset(Assets.TRY_AGAIN),
    //                                     const Text("state"),
    //                                   ],
    //                                 ),
    //                               );
    //                             }
    //                             if (state is MyProfileLoaded) {
    //                               return Column(
    //                                 crossAxisAlignment:
    //                                     CrossAxisAlignment.start,
    //                                 children: [
    //                                   // SizedBox(height: 30,),
    //                                   Text(
    //                                     "About You",
    //                                     style: GoogleFonts.openSans(
    //                                       color: AppColors.primaryBlackColor,
    //                                       fontSize: 20,
    //                                       fontWeight: FontWeight.w700,
    //                                     ),
    //                                   ).animate().then(delay: 200.ms).slideY(),
    //
    //                                   const SizedBox(height: 20),
    //                                   Padding(
    //                                     padding: const EdgeInsets.symmetric(
    //                                         horizontal: 11),
    //                                     child: Row(
    //                                       children: [
    //                                         Flexible(
    //                                           child: BlocBuilder<MyProfileBloc,
    //                                               MyProfileState>(
    //                                             builder: (context, state) {
    //                                               if (state
    //                                                   is MyProfileLoaded) {
    //                                                 return MyTextField(
    //                                                   enable: true,
    //                                                   focusNode: _firstname,
    //                                                   // horizontal: 10,
    //                                                   hintText: Strings
    //                                                       .SIGNUP_FIRSTNAME_LABEL_TEXT,
    //                                                   obscureText: false,
    //                                                   maxLines: 1,
    //                                                   controller:
    //                                                       firstnameController,
    //                                                   keyboardType:
    //                                                       TextInputType.text,
    //                                                   validator: (value) {
    //                                                     String? err =
    //                                                         validateFirstname(
    //                                                             value);
    //                                                     if (err != null) {
    //                                                       _firstname
    //                                                           .requestFocus();
    //                                                     }
    //                                                     return err;
    //                                                   },
    //                                                 );
    //                                               } else {
    //                                                 return SizedBox();
    //                                               }
    //                                             },
    //                                           ),
    //                                         )
    //                                             .animate()
    //                                             .then(delay: 200.ms)
    //                                             .slideY(),
    //                                         const SizedBox(width: 20),
    //                                         Flexible(
    //                                           child: BlocBuilder<MyProfileBloc,
    //                                               MyProfileState>(
    //                                             builder: (context, state) {
    //                                               if (state
    //                                                   is MyProfileLoaded) {
    //                                                 return MyTextField(
    //                                                   enable: true,
    //                                                   focusNode: _secondname,
    //                                                   // horizontal: 10,
    //                                                   hintText: Strings
    //                                                       .SIGNUP_LASTNAME_LABEL_TEXT,
    //                                                   obscureText: false,
    //                                                   maxLines: 1,
    //                                                   controller:
    //                                                       lastnameController,
    //                                                   keyboardType:
    //                                                       TextInputType.text,
    //                                                   validator: (value) {
    //                                                     String? err =
    //                                                         validateLastname(
    //                                                             value);
    //                                                     if (err != null) {
    //                                                       _secondname
    //                                                           .requestFocus();
    //                                                     }
    //                                                     return err;
    //                                                   },
    //                                                 );
    //                                               } else {
    //                                                 return SizedBox();
    //                                               }
    //                                             },
    //                                           ),
    //                                         )
    //                                             .animate()
    //                                             .then(delay: 200.ms)
    //                                             .slideY(),
    //                                       ],
    //                                     ),
    //                                   ),
    //                                   // SizedBox(height: 5,),
    //                                   Padding(
    //                                     padding: const EdgeInsets.symmetric(
    //                                         vertical: 15, horizontal: 11),
    //                                     child: GestureDetector(
    //                                       onTap: () {
    //                                         _showDatePicker(context);
    //                                         print(
    //                                             "DATE OF BIRTH :$selectedDate ");
    //                                       },
    //                                       child: DatePickerTextField(
    //                                         controller: dateInputController,
    //                                         hintText: "Date of Birth",
    //                                         onDateIconTap: () {
    //                                           _showDatePicker(context);
    //                                         },
    //                                       ),
    //                                     ),
    //                                   ).animate().then(delay: 200.ms).slideY(),
    //
    //                                   // SizedBox(height: getProportionateScreenHeight(5)),
    //
    //                                   /// Gender
    //                                   Center(
    //                                     child: Padding(
    //                                       padding: const EdgeInsets.symmetric(
    //                                           horizontal: 11),
    //                                       child: DropdownButtonHideUnderline(
    //                                         child: DropdownButton2<String>(
    //                                           isExpanded: true,
    //                                           hint: Text(
    //                                             genderController.text,
    //                                             style: const TextStyle(
    //                                               fontSize: 14,
    //                                               color: Colors.black,
    //                                             ),
    //                                           ),
    //                                           items: Gender.map(
    //                                             (item) =>
    //                                                 DropdownMenuItem<String>(
    //                                               value: item,
    //                                               child: Text(
    //                                                 item,
    //                                                 style: const TextStyle(
    //                                                   fontSize: 14,
    //                                                   color: AppColors
    //                                                       .primaryBlackColor,
    //                                                 ),
    //                                                 overflow:
    //                                                     TextOverflow.ellipsis,
    //                                               ),
    //                                             ),
    //                                           ).toList(),
    //                                           value: selectedGender,
    //                                           onChanged: (String? value) {
    //                                             setState(() {
    //                                               selectedGender = value!;
    //                                               print(
    //                                                   "SELECTED GENDER :$selectedGender");
    //                                             });
    //                                           },
    //                                           buttonStyleData: ButtonStyleData(
    //                                             width: 340,
    //                                             height: 50,
    //                                             padding: const EdgeInsets.only(
    //                                                 left: 14, right: 14),
    //                                             decoration: BoxDecoration(
    //                                               borderRadius:
    //                                                   BorderRadius.circular(5),
    //                                               border: Border.all(
    //                                                 width: 1,
    //                                                 color:
    //                                                     const Color(0xFFE6ECFF),
    //                                               ),
    //                                               color: AppColors
    //                                                   .primaryWhiteColor,
    //                                             ),
    //                                             elevation: 0,
    //                                           ),
    //                                           iconStyleData:
    //                                               const IconStyleData(
    //                                             icon: Icon(
    //                                               Icons.arrow_drop_down_rounded,
    //                                               size: 35,
    //                                             ),
    //                                             iconSize: 14,
    //                                             iconEnabledColor:
    //                                                 AppColors.secondaryColor,
    //                                             iconDisabledColor:
    //                                                 AppColors.primaryGrayColor,
    //                                           ),
    //                                           dropdownStyleData:
    //                                               DropdownStyleData(
    //                                             maxHeight: 200,
    //                                             width: 350,
    //                                             decoration: BoxDecoration(
    //                                               borderRadius:
    //                                                   BorderRadius.circular(14),
    //                                               color: AppColors
    //                                                   .primaryWhiteColor,
    //                                             ),
    //                                             offset: const Offset(-2, -5),
    //                                             scrollbarTheme:
    //                                                 ScrollbarThemeData(
    //                                               radius:
    //                                                   const Radius.circular(40),
    //                                               thickness:
    //                                                   MaterialStateProperty.all<
    //                                                       double>(6),
    //                                               thumbVisibility:
    //                                                   MaterialStateProperty.all<
    //                                                       bool>(true),
    //                                             ),
    //                                           ),
    //                                           menuItemStyleData:
    //                                               const MenuItemStyleData(
    //                                             height: 40,
    //                                             padding: EdgeInsets.only(
    //                                                 left: 14, right: 14),
    //                                           ),
    //                                         ),
    //                                       ),
    //                                     ),
    //                                   ).animate().then(delay: 200.ms).slideY(),
    //
    //                                   const SizedBox(height: 15),
    //
    //                                   /// Nationality
    //                                   Center(
    //                                     child: Padding(
    //                                       padding: const EdgeInsets.symmetric(
    //                                           horizontal: 11),
    //                                       child: BlocBuilder<NationalityBloc,
    //                                           NationalityState>(
    //                                         builder: (context, state) {
    //                                           if (state is NationalityLoaded) {
    //                                             return DropdownButtonHideUnderline(
    //                                               child:
    //                                                   DropdownButton2<String>(
    //                                                 isExpanded: true,
    //                                                 hint: Text(
    //                                                   nationalityController
    //                                                       .text,
    //                                                   style: const TextStyle(
    //                                                     fontSize: 14,
    //                                                     color: Colors.black,
    //                                                   ),
    //                                                 ),
    //                                                 items: state
    //                                                     .nationalityResponse
    //                                                     .data
    //                                                     .map(
    //                                                       (item) =>
    //                                                           DropdownMenuItem<
    //                                                               String>(
    //                                                         value: item.id
    //                                                             .toString(),
    //                                                         child: Text(
    //                                                           item.nationality,
    //                                                           style:
    //                                                               const TextStyle(
    //                                                             fontSize: 14,
    //                                                             color: AppColors
    //                                                                 .primaryBlackColor,
    //                                                           ),
    //                                                           overflow:
    //                                                               TextOverflow
    //                                                                   .ellipsis,
    //                                                         ),
    //                                                       ),
    //                                                     )
    //                                                     .toList(),
    //                                                 value:
    //                                                     selectedNationalityValue,
    //                                                 onChanged: (String? value) {
    //                                                   setState(() {
    //                                                     selectedNationalityValue =
    //                                                         value!;
    //                                                     selectedNationality =
    //                                                         selectedNationalityValue!;
    //                                                     selectedNationalityID =
    //                                                         int.tryParse(
    //                                                             selectedNationality!);
    //                                                   });
    //                                                   print(
    //                                                       'Selected Nationality ID: $selectedNationalityID');
    //
    //                                                   print(
    //                                                       'Selected Nationalityvalue : $selectedNationality');
    //                                                 },
    //                                                 buttonStyleData:
    //                                                     ButtonStyleData(
    //                                                   width: 340,
    //                                                   height: 50,
    //                                                   padding:
    //                                                       const EdgeInsets.only(
    //                                                           left: 14,
    //                                                           right: 14),
    //                                                   decoration: BoxDecoration(
    //                                                     borderRadius:
    //                                                         BorderRadius
    //                                                             .circular(5),
    //                                                     border: Border.all(
    //                                                       width: 1,
    //                                                       color: const Color(
    //                                                           0xFFE6ECFF),
    //                                                     ),
    //                                                     color: AppColors
    //                                                         .primaryWhiteColor,
    //                                                   ),
    //                                                   elevation: 0,
    //                                                 ),
    //                                                 iconStyleData:
    //                                                     const IconStyleData(
    //                                                   icon: Icon(
    //                                                     Icons
    //                                                         .arrow_drop_down_rounded,
    //                                                     size: 35,
    //                                                   ),
    //                                                   iconSize: 14,
    //                                                   iconEnabledColor:
    //                                                       AppColors
    //                                                           .secondaryColor,
    //                                                   iconDisabledColor:
    //                                                       AppColors
    //                                                           .primaryGrayColor,
    //                                                 ),
    //                                                 dropdownStyleData:
    //                                                     DropdownStyleData(
    //                                                   maxHeight: 200,
    //                                                   width: 350,
    //                                                   decoration: BoxDecoration(
    //                                                     borderRadius:
    //                                                         BorderRadius
    //                                                             .circular(14),
    //                                                     color: AppColors
    //                                                         .primaryWhiteColor,
    //                                                   ),
    //                                                   offset:
    //                                                       const Offset(-2, -5),
    //                                                   scrollbarTheme:
    //                                                       ScrollbarThemeData(
    //                                                     radius: const Radius
    //                                                         .circular(40),
    //                                                     thickness:
    //                                                         MaterialStateProperty
    //                                                             .all<double>(6),
    //                                                     thumbVisibility:
    //                                                         MaterialStateProperty
    //                                                             .all<bool>(
    //                                                                 true),
    //                                                   ),
    //                                                 ),
    //                                                 menuItemStyleData:
    //                                                     const MenuItemStyleData(
    //                                                   height: 40,
    //                                                   padding: EdgeInsets.only(
    //                                                       left: 14, right: 14),
    //                                                 ),
    //                                               ),
    //                                             );
    //                                           } else {
    //                                             return SizedBox();
    //                                           }
    //                                         },
    //                                       ),
    //                                     ),
    //                                   ).animate().then(delay: 200.ms).slideY(),
    //
    //                                   SizedBox(
    //                                       height:
    //                                           getProportionateScreenHeight(15)),
    //
    //                                   /// Country
    //                                   Center(
    //                                     child: Padding(
    //                                       padding: const EdgeInsets.symmetric(
    //                                           horizontal: 11),
    //                                       child: BlocBuilder<CountryBloc,
    //                                           CountryState>(
    //                                         builder: (context, state) {
    //                                           if (state is CountryLoaded) {
    //                                             return DropdownButtonHideUnderline(
    //                                               child:
    //                                                   DropdownButton2<String>(
    //                                                 isExpanded: true,
    //                                                 hint: Text(
    //                                                   countryController.text,
    //                                                   style: const TextStyle(
    //                                                     fontSize: 14,
    //                                                     color: Colors.black,
    //                                                   ),
    //                                                 ),
    //                                                 items: state
    //                                                     .countryResponse.data
    //                                                     .map(
    //                                                       (item) =>
    //                                                           DropdownMenuItem<
    //                                                               String>(
    //                                                         value: item
    //                                                             .countriesId
    //                                                             .toString(),
    //                                                         child: Text(
    //                                                           item.name,
    //                                                           style:
    //                                                               const TextStyle(
    //                                                             fontSize: 14,
    //                                                             color: AppColors
    //                                                                 .primaryBlackColor,
    //                                                           ),
    //                                                           overflow:
    //                                                               TextOverflow
    //                                                                   .ellipsis,
    //                                                         ),
    //                                                       ),
    //                                                     )
    //                                                     .toList(),
    //                                                 value: selectedCountryValue,
    //                                                 onChanged: (String? value) {
    //                                                   setState(() {
    //                                                     selectedCountryValue =
    //                                                         value;
    //                                                     selectedCountry =
    //                                                         selectedCountryValue!;
    //                                                     selectedCountryID =
    //                                                         int.tryParse(
    //                                                             selectedCountry!);
    //                                                   });
    //                                                   print(
    //                                                       'Selected Country ID: $selectedCountryID');
    //                                                   BlocProvider.of<CityBloc>(
    //                                                           context)
    //                                                       .add(
    //                                                     GetCityEvent(
    //                                                         getCityRequest:
    //                                                             GetCityRequest(
    //                                                                 countriesId:
    //                                                                     selectedCountryID!)),
    //                                                   );
    //                                                 },
    //                                                 buttonStyleData:
    //                                                     ButtonStyleData(
    //                                                   width: 340,
    //                                                   height: 50,
    //                                                   padding:
    //                                                       const EdgeInsets.only(
    //                                                           left: 14,
    //                                                           right: 14),
    //                                                   decoration: BoxDecoration(
    //                                                     borderRadius:
    //                                                         BorderRadius
    //                                                             .circular(5),
    //                                                     border: Border.all(
    //                                                       width: 1,
    //                                                       color: const Color(
    //                                                           0xFFE6ECFF),
    //                                                     ),
    //                                                     color: AppColors
    //                                                         .primaryWhiteColor,
    //                                                   ),
    //                                                   elevation: 0,
    //                                                 ),
    //                                                 iconStyleData:
    //                                                     const IconStyleData(
    //                                                   icon: Icon(
    //                                                     Icons
    //                                                         .arrow_drop_down_rounded,
    //                                                     size: 35,
    //                                                   ),
    //                                                   iconSize: 14,
    //                                                   iconEnabledColor:
    //                                                       AppColors
    //                                                           .secondaryColor,
    //                                                   iconDisabledColor:
    //                                                       AppColors
    //                                                           .primaryGrayColor,
    //                                                 ),
    //                                                 dropdownStyleData:
    //                                                     DropdownStyleData(
    //                                                   maxHeight: 200,
    //                                                   width: 350,
    //                                                   decoration: BoxDecoration(
    //                                                     borderRadius:
    //                                                         BorderRadius
    //                                                             .circular(14),
    //                                                     color: AppColors
    //                                                         .primaryWhiteColor,
    //                                                   ),
    //                                                   offset:
    //                                                       const Offset(-2, -5),
    //                                                   scrollbarTheme:
    //                                                       ScrollbarThemeData(
    //                                                     radius: const Radius
    //                                                         .circular(40),
    //                                                     thickness:
    //                                                         MaterialStateProperty
    //                                                             .all<double>(6),
    //                                                     thumbVisibility:
    //                                                         MaterialStateProperty
    //                                                             .all<bool>(
    //                                                                 true),
    //                                                   ),
    //                                                 ),
    //                                                 menuItemStyleData:
    //                                                     const MenuItemStyleData(
    //                                                   height: 40,
    //                                                   padding: EdgeInsets.only(
    //                                                       left: 14, right: 14),
    //                                                 ),
    //                                               ),
    //                                             );
    //                                           } else {
    //                                             return SizedBox();
    //                                           }
    //                                         },
    //                                       ),
    //                                     ),
    //                                   ).animate().then(delay: 200.ms).slideY(),
    //
    //                                   SizedBox(
    //                                       height:
    //                                           getProportionateScreenHeight(15)),
    //
    //                                   /// City
    //                                   Center(
    //                                     child: Padding(
    //                                       padding: const EdgeInsets.symmetric(
    //                                           horizontal: 11),
    //                                       child:
    //                                           BlocBuilder<CityBloc, CityState>(
    //                                         builder: (context, state) {
    //                                           if (state is CityLoading) {
    //                                             return Center(
    //                                               child: Lottie.asset(
    //                                                 Assets.JUMBINGDOT,
    //                                                 height: 70,
    //                                                 width: 90,
    //                                               ),
    //                                             );
    //                                           } else if (state is CityLoaded) {
    //                                             return DropdownButtonHideUnderline(
    //                                               child:
    //                                                   DropdownButton2<String>(
    //                                                 isExpanded: true,
    //                                                 hint: Text(
    //                                                   cityController.text,
    //                                                   style: const TextStyle(
    //                                                     fontSize: 14,
    //                                                     color: Colors.black,
    //                                                   ),
    //                                                 ),
    //                                                 items: state
    //                                                     .getCityResponse.data
    //                                                     .map(
    //                                                       (item) =>
    //                                                           DropdownMenuItem<
    //                                                               String>(
    //                                                         value: item.cityId
    //                                                             .toString(),
    //                                                         child: Text(
    //                                                           item.city,
    //                                                           style:
    //                                                               const TextStyle(
    //                                                             fontSize: 14,
    //                                                             color: AppColors
    //                                                                 .primaryBlackColor,
    //                                                           ),
    //                                                           overflow:
    //                                                               TextOverflow
    //                                                                   .ellipsis,
    //                                                         ),
    //                                                       ),
    //                                                     )
    //                                                     .toList(),
    //                                                 value: selectedCityID,
    //                                                 onChanged: (String? value) {
    //                                                   setState(() {
    //                                                     selectedCityID = value!;
    //                                                     print(
    //                                                         "SELECTED CITY ID :$selectedCityID");
    //                                                   });
    //                                                 },
    //                                                 buttonStyleData:
    //                                                     ButtonStyleData(
    //                                                   width: 340,
    //                                                   height: 50,
    //                                                   padding:
    //                                                       const EdgeInsets.only(
    //                                                           left: 14,
    //                                                           right: 14),
    //                                                   decoration: BoxDecoration(
    //                                                     borderRadius:
    //                                                         BorderRadius
    //                                                             .circular(5),
    //                                                     border: Border.all(
    //                                                       width: 1,
    //                                                       color: const Color(
    //                                                           0xFFE6ECFF),
    //                                                     ),
    //                                                     color: AppColors
    //                                                         .primaryWhiteColor,
    //                                                   ),
    //                                                   elevation: 0,
    //                                                 ),
    //                                                 iconStyleData:
    //                                                     const IconStyleData(
    //                                                   icon: Icon(
    //                                                     Icons
    //                                                         .arrow_drop_down_rounded,
    //                                                     size: 35,
    //                                                   ),
    //                                                   iconSize: 14,
    //                                                   iconEnabledColor:
    //                                                       AppColors
    //                                                           .secondaryColor,
    //                                                   iconDisabledColor:
    //                                                       AppColors
    //                                                           .primaryGrayColor,
    //                                                 ),
    //                                                 dropdownStyleData:
    //                                                     DropdownStyleData(
    //                                                   maxHeight: 200,
    //                                                   width: 350,
    //                                                   decoration: BoxDecoration(
    //                                                     borderRadius:
    //                                                         BorderRadius
    //                                                             .circular(14),
    //                                                     color: AppColors
    //                                                         .primaryWhiteColor,
    //                                                   ),
    //                                                   offset:
    //                                                       const Offset(-2, -5),
    //                                                   scrollbarTheme:
    //                                                       ScrollbarThemeData(
    //                                                     radius: const Radius
    //                                                         .circular(40),
    //                                                     thickness:
    //                                                         MaterialStateProperty
    //                                                             .all<double>(6),
    //                                                     thumbVisibility:
    //                                                         MaterialStateProperty
    //                                                             .all<bool>(
    //                                                                 true),
    //                                                   ),
    //                                                 ),
    //                                                 menuItemStyleData:
    //                                                     const MenuItemStyleData(
    //                                                   height: 40,
    //                                                   padding: EdgeInsets.only(
    //                                                       left: 14, right: 14),
    //                                                 ),
    //                                               ),
    //                                             );
    //                                           } else {
    //                                             return SizedBox();
    //                                           }
    //                                         },
    //                                       ),
    //                                     ),
    //                                   ).animate().then(delay: 200.ms).slideY(),
    //
    //                                   const SizedBox(height: 20),
    //                                   Text(
    //                                     "Contact Info",
    //                                     style: GoogleFonts.openSans(
    //                                       color: AppColors.primaryBlackColor,
    //                                       fontSize: 20,
    //                                       fontWeight: FontWeight.w700,
    //                                     ),
    //                                   ).animate().then(delay: 200.ms).slideY(),
    //                                   const SizedBox(height: 20),
    //
    //                                   Padding(
    //                                     padding: const EdgeInsets.symmetric(
    //                                         horizontal: 11),
    //                                     child: MyTextField(
    //                                       enable: false,
    //                                       focusNode: _email,
    //                                       // horizontal: 10,
    //                                       hintText:
    //                                           Strings.SIGNUP_EMAIL_LABEL_TEXT,
    //                                       obscureText: false,
    //                                       maxLines: 1,
    //                                       controller: emailController,
    //                                       keyboardType: TextInputType.text,
    //                                     ),
    //                                   ).animate().then(delay: 200.ms).slideY(),
    //
    //                                   const SizedBox(height: 15),
    //
    //                                   Padding(
    //                                     padding: const EdgeInsets.symmetric(
    //                                         horizontal: 11),
    //                                     child: BlocBuilder<MyProfileBloc,
    //                                         MyProfileState>(
    //                                       builder: (context, state) {
    //                                         if (state is MyProfileLoaded) {
    //                                           return MyTextField(
    //                                             inputFormatter: [
    //                                               LengthLimitingTextInputFormatter(
    //                                                   10)
    //                                             ],
    //                                             enable: true,
    //                                             focusNode: _phone,
    //                                             // horizontal: 10,
    //                                             hintText: Strings.PHONE_NUMBER,
    //                                             obscureText: false,
    //                                             maxLines: 1,
    //                                             controller: mobileController,
    //                                             keyboardType:
    //                                                 TextInputType.number,
    //                                             validator: (value) {
    //                                               String? err =
    //                                                   validatePhoneNumber(
    //                                                       value);
    //                                               if (err != null) {
    //                                                 _phone.requestFocus();
    //                                               }
    //                                               return err;
    //                                             },
    //                                           );
    //                                         } else {
    //                                           return SizedBox();
    //                                         }
    //                                       },
    //                                     ),
    //                                   ).animate().then(delay: 200.ms).slideY(),
    //                                   const SizedBox(height: 20),
    //
    //                                   BlocBuilder<MyProfileBloc,
    //                                       MyProfileState>(
    //                                     builder: (context, state) {
    //                                       if (state is MyEditProfileLoading) {
    //                                         return const Center(
    //                                           child: RefreshProgressIndicator(
    //                                             color: AppColors.secondaryColor,
    //                                             // backgroundColor: AppColors.secondaryColor,
    //                                           ),
    //                                         );
    //                                       }
    //                                       return Center(
    //                                         child: MyButton(
    //                                           Textfontsize: 16,
    //                                           TextColors: Colors.white,
    //                                           text: "save",
    //                                           color: AppColors.secondaryColor,
    //                                           width: 340,
    //                                           height: 40,
    //                                           onTap: () {
    //                                             // BlocProvider.of<MyProfileBloc>(context)
    //                                             //     .add(GetProfileDataEvent());
    //                                             if (_formKey.currentState
    //                                                     ?.validate() ??
    //                                                 false) {
    //                                               BlocProvider.of<
    //                                                           MyProfileBloc>(
    //                                                       context)
    //                                                   .add(
    //                                                 EditProfileDataEvent(
    //                                                   editProfileRequest:
    //                                                       EditProfileRequest(
    //                                                     firstName:
    //                                                         firstnameController
    //                                                             .text,
    //                                                     lastName:
    //                                                         lastnameController
    //                                                             .text,
    //                                                     photo: imageUploadFormated !=
    //                                                                 null &&
    //                                                             imageUploadFormated
    //                                                                 .isNotEmpty
    //                                                         ? imageUploadFormated!
    //                                                         : widget
    //                                                             .myProfileArguments
    //                                                             .photo,
    //                                                     dob: selectedDate !=
    //                                                                 null &&
    //                                                             selectedDate
    //                                                                 .toString()
    //                                                                 .isNotEmpty
    //                                                         ? selectedDate
    //                                                             .toString()
    //                                                         : dateInputController
    //                                                             .text,
    //                                                     gender: selectedGender !=
    //                                                                 null &&
    //                                                             selectedGender
    //                                                                 .toString()
    //                                                                 .isNotEmpty
    //                                                         ? selectedGender
    //                                                             .toString()
    //                                                         : genderController
    //                                                             .text,
    //                                                     mobileNo: int.parse(
    //                                                         mobileController
    //                                                             .text),
    //                                                     nationalityId: selectedNationalityID !=
    //                                                             null
    //                                                         ? selectedNationalityID!
    //                                                         : int.parse(widget
    //                                                             .myProfileArguments
    //                                                             .nationality_id
    //                                                             .toString()),
    //                                                     city: selectedCityID != null &&
    //                                                             selectedCityID
    //                                                                 .toString()
    //                                                                 .isNotEmpty
    //                                                         ? selectedCityID
    //                                                             .toString()
    //                                                         : widget
    //                                                             .myProfileArguments
    //                                                             .city
    //                                                             .toString(),
    //                                                     countryId: selectedCountryID !=
    //                                                             null
    //                                                         ? selectedCountryID!
    //                                                         : int.parse(widget
    //                                                             .myProfileArguments
    //                                                             .country_id
    //                                                             .toString()),
    //                                                     userName: widget
    //                                                         .myProfileArguments
    //                                                         .user_name,
    //                                                     status: 1,
    //                                                   ),
    //                                                 ),
    //                                               );
    //                                               print(
    //                                                   'FIRST NAME = ${firstnameController}');
    //                                               print(
    //                                                   'LAST NAME = ${lastnameController}');
    //                                               print(
    //                                                   'DOB = ${selectedDate != null && selectedDate.toString().isNotEmpty ? selectedDate.toString() : dateInputController.text}');
    //                                               print(
    //                                                   'GENDER = ${selectedGender != null && selectedGender.toString().isNotEmpty ? selectedGender.toString() : genderController.text}');
    //                                               print(
    //                                                   'NATIONALITY  = ${selectedNationalityID != null ? selectedNationalityID! : int.parse(widget.myProfileArguments.nationality_id.toString())}');
    //                                               print(
    //                                                   'COUNTRY = ${selectedCountryID != null ? selectedCountryID! : int.parse(widget.myProfileArguments.country_id.toString())}');
    //                                               print(
    //                                                   'CITY =  ${selectedCityID != null && selectedCityID.toString().isNotEmpty ? selectedCityID.toString() : widget.myProfileArguments.city.toString()}');
    //                                               print(
    //                                                   'Email = ${emailController}');
    //                                               print(
    //                                                   'PHONE NUMBER =  ${mobileController}');
    //                                               print(
    //                                                   "PHOTO  = ${imageUploadFormated != null && imageUploadFormated.isNotEmpty ? imageUploadFormated! : widget.myProfileArguments.photo}");
    //                                             } else {
    //                                               Fluttertoast.showToast(
    //                                                 msg:
    //                                                     "All fields are important",
    //                                                 toastLength:
    //                                                     Toast.LENGTH_SHORT,
    //                                                 gravity:
    //                                                     ToastGravity.BOTTOM,
    //                                                 backgroundColor:
    //                                                     Colors.black87,
    //                                                 textColor: Colors.white,
    //                                               );
    //                                             }
    //                                           },
    //                                           showImage: false,
    //                                           imagePath: '',
    //                                           imagewidth: 0,
    //                                           imageheight: 0,
    //                                         ),
    //                                       );
    //                                     },
    //                                   ).animate().then(delay: 200.ms).slideY(),
    //                                 ],
    //                               );
    //                             } else {
    //                               return SizedBox();
    //                             }
    //                           },
    //                         ),
    //                       ]),
    //                     ),
    //                     padding: const EdgeInsets.only(
    //                         top: 15, left: 15, right: 15, bottom: 30),
    //                   )
    //                 ],
    //               ),
    //             ),
    //           );
    //         },
    //       );
    //     } else if (state is NetworkFailure) {
    //       return Center(
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             Lottie.asset(Assets.NO_INTERNET),
    //             Text(
    //               "You are not connected to the internet",
    //               style: GoogleFonts.openSans(
    //                 color: AppColors.primaryGrayColor,
    //                 fontSize: 20,
    //               ),
    //             ).animate().scale(delay: 200.ms, duration: 300.ms),
    //           ],
    //         ),
    //       );
    //     }
    //     return const SizedBox();
    //   },
    // );
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
            borderSide: const BorderSide(width: 1, color: AppColors.borderColor),
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

class CustomSliverDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final bool hideTitleWhenExpanded;
  final MyProfileArguments myProfileArguments;
  Function checkPermission;
  final File filePath;

  CustomSliverDelegate({
    required this.checkPermission,
    required this.filePath,

    // required this.setState,
    required this.myProfileArguments,
    required this.expandedHeight,
    this.hideTitleWhenExpanded = true,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final appBarSize = expandedHeight - shrinkOffset;
    // final cardTopPosition = expandedHeight / 7 - shrinkOffset;
    final proportion = 2 - (expandedHeight / appBarSize);
    final percent = proportion < 0 || proportion > 1 ? 0.0 : proportion;
    return Stack(
      children: [
        Container(
          height: 250,
          decoration: const BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10.0), // Adjust the radius as needed
              bottomRight: Radius.circular(10.0), // Adjust the radius as needed
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            // Set the AppBar background color to transparent
            leading: IconButton(
              icon: GestureDetector(
                  onTap: () {
                    BlocProvider.of<MyProfileBloc>(context)
                        .add(GetProfileDataEvent());
                    context.pop();
                    print("Profile tapped!");
                  },
                  child: const Icon(
                    Icons.cancel_outlined,
                    color: AppColors.primaryWhiteColor,
                  )),
              onPressed: () {},
            ),
            elevation: 0.0,
            title: Opacity(
              opacity: hideTitleWhenExpanded ? 1.0 - percent : 1.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 5,
                    child: Text(
                      "My Profile",
                      // myProfileArguments.user_name,
                      // ObjectFactory().prefs.getUserName() ?? "",
                      style: GoogleFonts.openSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.secondaryColor,
                      ),
                    ),
                  ),
                  // SizedBox(width: 8), // Adjust the spacing as needed
                  //  Expanded(
                  //   flex: 1,
                  //   child: Flexible(
                  //     flex: 3,
                  //     child: _pickedFile != null
                  //         ? Container(
                  //       alignment: Alignment.center,
                  //       width: 50,
                  //       height: 50,
                  //       // color: Colors.grey[300],
                  //       decoration: const BoxDecoration(
                  //         shape: BoxShape.circle,
                  //         // borderRadius: BorderRadius.circular(100),
                  //       ),
                  //       child: ClipRRect(
                  //         borderRadius:
                  //         BorderRadius.circular(100),
                  //         child: Image.file(
                  //           File(_pickedFile!.path),
                  //           width: 50,
                  //           height: 50,
                  //           fit: BoxFit.cover,
                  //         ),
                  //       ),
                  //     )
                  //         : Container(
                  //       alignment: Alignment.center,
                  //       width: 50,
                  //       height: 50,
                  //       decoration: const BoxDecoration(
                  //         shape: BoxShape.circle,
                  //         color: AppColors.shadow,
                  //         // borderRadius: BorderRadius.circular(100),
                  //       ),
                  //       child: const Stack(
                  //         children: [
                  //           // Align(
                  //           //   alignment: Alignment.center,
                  //           //   child: Text("Add"),
                  //           // ),
                  //           Positioned(
                  //               bottom: 8,
                  //               right: 8,
                  //               child: Icon(
                  //                 Icons.add_a_photo_outlined,
                  //                 color:
                  //                 AppColors.secondaryColor,
                  //               )
                  //             // Image.asset(Assets.NO_PROFILE_IMG,scale: 20),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  //  )
                ],
              ),
            ),
          ),
        ),
        Opacity(
          opacity: percent,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<MyProfileBloc, MyProfileState>(
                  builder: (context, state) {
                    if (state is MyProfileLoaded) {
                      String b64 =
                          state.myProfileScreenResponse.data!.photo.toString();
                      final UriData? data = Uri.parse(b64).data;
                      Uint8List bytesImage = data!.contentAsBytes();
                      print("PHOTO CODE : $bytesImage");

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              children: [
                                Text(
                                  myProfileArguments.first_name,
                                  // ObjectFactory().prefs.getUserName() ?? "",
                                  style: GoogleFonts.openSans(
                                    fontSize: 21,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.secondaryColor,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                GestureDetector(
                                  child: Text(
                                    "Change Password",
                                    style: GoogleFonts.openSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.primaryWhiteColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            flex: 3,
                            child: GestureDetector(
                              onTap: () {
                                checkPermission(context);
                                // pickImage();
                              },
                              child: filePath.path.isNotEmpty
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
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Image.file(
                                          File(filePath.path),
                                          width: 130,
                                          height: 130,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )
                                  : Container(
                                      width: 130.0,
                                      height: 130.0,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        // border: Border.all(
                                        //   color: AppColors.secondaryColor,
                                        //   width: 2.0,
                                        // ),
                                        image: DecorationImage(
                                          alignment: Alignment.center,
                                          fit: BoxFit.cover,
                                          image: MemoryImage(bytesImage),
                                        ),
                                      ),
                                    ),
                              // Container(
                              //         alignment: Alignment.center,
                              //         width: 130,
                              //         height: 130,
                              //         decoration: const BoxDecoration(
                              //           shape: BoxShape.circle,
                              //           color: AppColors.shadow,
                              //           // borderRadius: BorderRadius.circular(100),
                              //         ),
                              //         child: const Stack(
                              //           children: [
                              //             Align(
                              //               alignment:
                              //                   Alignment.center,
                              //               child: Text("Add"),
                              //             ),
                              //             Positioned(
                              //                 bottom: 8,
                              //                 right: 8,
                              //                 child: Icon(
                              //                   Icons
                              //                       .add_a_photo_outlined,
                              //                   color: AppColors
                              //                       .secondaryColor,
                              //                 )
                              //                 // Image.asset(Assets.NO_PROFILE_IMG,scale: 20),
                              //                 ),
                              //           ],
                              //         ),
                              //       )
                            ),

                            // CircleAvatar(
                            //   backgroundColor: Colors.transparent,
                            //   radius: 50,
                            //   backgroundImage: NetworkImage(
                            //       "https://s3-alpha-sig.figma.com/img/d067/c913/ad868d019f92ce267e6de23af3413e5b?Expires=1706486400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=BTjjS~v0e0x44jHIWuKYMNaWYXlHG7EN3Yjq111uXWjvGWD0oPTpDDuaPCAtTv9cdqXNKlztZmY35PSEAiUohNuYoaQDt-ZI5pG5QleefSvEir~3854~O8EEXI1aGpmu5ciF9KdwvmZwK3WYpf8S150xkDq7v94NndSusDG2VpkUYejPJUr4C~qM2vO0g7lNJ33W5-bMNoCyWpW128kmLdDk36~oAJxjrLK0Vhg88eJ1ORr-A5yVpKrJaIHxw2DXQrlWbtpZvmfc4HWh09tN7Lz70hYnd8Fk4NN6UpXLiHv0DNeRp6-W3NNaRRJTpJx70RUXbcI38u4jGr9Ahd69ew__"),
                            // ),
                          ),
                          // SizedBox(height: 120),
                        ],
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight + expandedHeight / 2;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
