import 'dart:convert';
import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
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
import 'package:lets_collect/src/ui/profile/components/my_profile_screen_arguments.dart';
import 'package:lets_collect/src/utils/screen_size/size_config.dart';
import 'package:lottie/lottie.dart';
import 'package:path/path.dart' as p;

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

  String? validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value)) {
      return 'Enter a new email address';
    } else {
      return null;
    }
  }

  String? validatePassword(String? value) {
    String pattern =
        r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty) {
      return 'Please enter password';
    }
    if (value.length < 8) {
      return "Length should be 8 or more";
    }
    if (!regex.hasMatch(value)) {
      return "Must contain at least 1 uppercase, 1 lowercase, 1 special character";
    }
    return null;
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

  myProfileArgumentData() {
    if (widget.myProfileArguments != null) {
      firstnameController.text = widget.myProfileArguments.first_name;
      print("FIRST NAME : $firstnameController.text");

      lastnameController.text = widget.myProfileArguments.last_name;
      print("LASTNAME  : $lastnameController.text");

      dateInputController.text = DateFormat('yyyy-MM-dd')
          .format(DateTime.parse(widget.myProfileArguments.dob));
      print("DOB : $dateInputController.text");

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

      mobileController.text = widget.myProfileArguments.mobile_no;
      print("MOBILE NUMBER : $mobileController.text");
    }
  }

  Future<void> _pickImage() async {
    _pickedFile = (await _picker.pickImage(source: ImageSource.gallery))!;
    setState(() {
      _image = File(_pickedFile.path);
      if (XFile != null) {
        galleryFile = File(_pickedFile!.path);
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
    });
  }

  @override
  void initState() {
    super.initState();
    // String b64 =
    //     "data:image/jpeg;base64,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";
    // state.myProfileScreenResponse.data!.photo.toString();
    // Uint8List bytesImage = base64Decode(b64).re;
    // print("PHOTO CODE : $b64");
    BlocProvider.of<MyProfileBloc>(context).add(GetProfileDataEvent());
    myProfileArgumentData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyProfileBloc, MyProfileState>(
      listener: (context, state) {
        if (state is MyEditProfileLoaded) {
          if (state.editProfileRequestResponse.status == true) {
            BlocProvider.of<MyProfileBloc>(context).add(GetProfileDataEvent());
          }
        }
        else if(state is MyEditProfileLoaded){
          if(state.editProfileRequestResponse.status == false ){
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
        return Scaffold(
          body: Form(
            key: _formKey,
            child: CustomScrollView(
              slivers: <Widget>[
                SliverPersistentHeader(
                  pinned: true,
                  floating: true,
                  delegate: CustomSliverDelegate(
                    pickImage: _pickImage,
                    expandedHeight: 150,
                    myProfileArguments: widget.myProfileArguments,
                    filePath: _image!,
                  ),
                ),
                SliverPadding(
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      BlocBuilder<MyProfileBloc, MyProfileState>(
                        builder: (context, state) {
                          if(state is MyProfileLoading){
                            return const Center(
                              heightFactor: 10,
                              child: RefreshProgressIndicator(
                                color: AppColors.secondaryColor,
                              ),
                            );
                          }
                          if(state is MyProfileLoaded){
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
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 11),
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: BlocBuilder<MyProfileBloc,
                                            MyProfileState>(
                                          builder: (context, state) {
                                            if (state is MyProfileLoaded) {
                                              return MyTextField(
                                                enable: false,
                                                focusNode: _firstname,
                                                // horizontal: 10,
                                                hintText: Strings
                                                    .SIGNUP_FIRSTNAME_LABEL_TEXT,
                                                obscureText: false,
                                                maxLines: 1,
                                                controller: firstnameController,
                                                keyboardType: TextInputType.text,
                                                validator: (value) {
                                                  String? err =
                                                  validateFirstname(value);
                                                  if (err != null) {
                                                    _firstname.requestFocus();
                                                  }
                                                  return err;
                                                },
                                              );
                                            } else {
                                              return SizedBox();
                                            }
                                          },
                                        ),
                                      ).animate().then(delay: 200.ms).slideY(),
                                      const SizedBox(width: 20),
                                      Flexible(
                                        child: BlocBuilder<MyProfileBloc,
                                            MyProfileState>(
                                          builder: (context, state) {
                                            if (state is MyProfileLoaded) {
                                              return MyTextField(
                                                enable: false,
                                                focusNode: _secondname,
                                                // horizontal: 10,
                                                hintText: Strings
                                                    .SIGNUP_LASTNAME_LABEL_TEXT,
                                                obscureText: false,
                                                maxLines: 1,
                                                controller: lastnameController,
                                                keyboardType: TextInputType.text,
                                                validator: (value) {
                                                  String? err =
                                                  validateLastname(value);
                                                  if (err != null) {
                                                    _secondname.requestFocus();
                                                  }
                                                  return err;
                                                },
                                              );
                                            } else {
                                              return SizedBox();
                                            }
                                          },
                                        ),
                                      ).animate().then(delay: 200.ms).slideY(),
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
                                      print("DATE OF BIRTH :$selectedDate ");
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
                                          genderController.text,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                        items: Gender.map(
                                              (item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color:
                                                AppColors.primaryBlackColor,
                                              ),
                                              overflow: TextOverflow.ellipsis,
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
                                              color: const Color(0xFFE6ECFF),
                                            ),
                                            color: AppColors.primaryWhiteColor,
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
                                        dropdownStyleData: DropdownStyleData(
                                          maxHeight: 200,
                                          width: 350,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(14),
                                            color: AppColors.primaryWhiteColor,
                                          ),
                                          offset: const Offset(-2, -5),
                                          scrollbarTheme: ScrollbarThemeData(
                                            radius: const Radius.circular(40),
                                            thickness:
                                            MaterialStateProperty.all<double>(
                                                6),
                                            thumbVisibility:
                                            MaterialStateProperty.all<bool>(
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
                                                nationalityController.text,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              items: state
                                                  .nationalityResponse.data
                                                  .map(
                                                    (item) =>
                                                    DropdownMenuItem<String>(
                                                      value: item.id.toString(),
                                                      child: Text(
                                                        item.nationality,
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          color: AppColors
                                                              .primaryBlackColor,
                                                        ),
                                                        overflow:
                                                        TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                              )
                                                  .toList(),
                                              value: selectedNationalityValue,
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
                                          );
                                        } else {
                                          return SizedBox();
                                        }
                                      },
                                    ),
                                  ),
                                ).animate().then(delay: 200.ms).slideY(),

                                SizedBox(
                                    height: getProportionateScreenHeight(15)),

                                /// Country
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 11),
                                    child: BlocBuilder<CountryBloc, CountryState>(
                                      builder: (context, state) {
                                        if (state is CountryLoaded) {
                                          return DropdownButtonHideUnderline(
                                            child: DropdownButton2<String>(
                                              isExpanded: true,
                                              hint: Text(
                                                countryController.text,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              items: state.countryResponse.data
                                                  .map(
                                                    (item) =>
                                                    DropdownMenuItem<String>(
                                                      value: item.countriesId
                                                          .toString(),
                                                      child: Text(
                                                        item.name,
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          color: AppColors
                                                              .primaryBlackColor,
                                                        ),
                                                        overflow:
                                                        TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                              )
                                                  .toList(),
                                              value: selectedCountryValue,
                                              onChanged: (String? value) {
                                                setState(() {
                                                  selectedCountryValue = value;
                                                  selectedCountry =
                                                  selectedCountryValue!;
                                                  selectedCountryID =
                                                      int.tryParse(
                                                          selectedCountry!);
                                                });
                                                print(
                                                    'Selected Country ID: $selectedCountryID');
                                                BlocProvider.of<CityBloc>(context)
                                                    .add(
                                                  GetCityEvent(
                                                      getCityRequest: GetCityRequest(
                                                          countriesId:
                                                          selectedCountryID!)),
                                                );
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
                                          );
                                        } else {
                                          return SizedBox();
                                        }
                                      },
                                    ),
                                  ),
                                ).animate().then(delay: 200.ms).slideY(),

                                SizedBox(
                                    height: getProportionateScreenHeight(15)),

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
                                                cityController.text,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              items: state.getCityResponse.data
                                                  .map(
                                                    (item) =>
                                                    DropdownMenuItem<String>(
                                                      value:
                                                      item.cityId.toString(),
                                                      child: Text(
                                                        item.city,
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          color: AppColors
                                                              .primaryBlackColor,
                                                        ),
                                                        overflow:
                                                        TextOverflow.ellipsis,
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
                                          );
                                        } else {
                                          return SizedBox();
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
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 11),
                                  child: MyTextField(
                                    enable: true,
                                    focusNode: _email,
                                    // horizontal: 10,
                                    hintText: Strings.SIGNUP_EMAIL_LABEL_TEXT,
                                    obscureText: false,
                                    maxLines: 1,
                                    controller: emailController,
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      String? err = validateEmail(value);
                                      if (err != null) {
                                        _email.requestFocus();
                                      }
                                      return err;
                                    },
                                  ),
                                ).animate().then(delay: 200.ms).slideY(),

                                const SizedBox(height: 15),

                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 11),
                                  child:
                                  BlocBuilder<MyProfileBloc, MyProfileState>(
                                    builder: (context, state) {
                                      if (state is MyProfileLoaded) {
                                        return MyTextField(
                                          inputFormatter: [
                                            LengthLimitingTextInputFormatter(10)
                                          ],
                                          enable: false,
                                          focusNode: _phone,
                                          // horizontal: 10,
                                          hintText: Strings.PHONE_NUMBER,
                                          obscureText: false,
                                          maxLines: 1,
                                          controller: mobileController,
                                          keyboardType: TextInputType.number,
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
                                        return SizedBox();
                                      }
                                    },
                                  ),
                                ).animate().then(delay: 200.ms).slideY(),
                                const SizedBox(height: 20),

                                Center(
                                  child: MyButton(
                                    Textfontsize: 16,
                                    TextColors: Colors.white,
                                    text: "save",
                                    color: AppColors.secondaryColor,
                                    width: 340,
                                    height: 40,
                                    onTap: () {
                                      // BlocProvider.of<MyProfileBloc>(context)
                                      //     .add(GetProfileDataEvent());
                                      if (_formKey.currentState?.validate() ??
                                          false) {
                                        BlocProvider.of<MyProfileBloc>(context)
                                            .add(
                                          EditProfileDataEvent(
                                            editProfileRequest:
                                            EditProfileRequest(
                                              firstName: firstnameController.text,
                                              lastName: lastnameController.text,
                                              photo: imageUploadFormated != null && imageUploadFormated.isNotEmpty ? imageUploadFormated! : widget.myProfileArguments.photo,
                                              dob: selectedDate != null && selectedDate.toString().isNotEmpty ? selectedDate.toString() : dateInputController.text,
                                              gender: selectedGender != null && selectedGender.toString().isNotEmpty ? selectedGender.toString() : genderController.text,
                                              mobileNo: int.parse(
                                                  mobileController.text),
                                              nationalityId:
                                              selectedNationalityID != null
                                                  ? selectedNationalityID!
                                                  : int.parse(widget.myProfileArguments.nationality_id
                                                  .toString()),
                                              city: selectedCityID != null && selectedCityID.toString().isNotEmpty
                                                  ? selectedCityID.toString()
                                                  : widget.myProfileArguments.city
                                                  .toString(),
                                              countryId: selectedCountryID != null
                                                  ? selectedCountryID!
                                                  : int.parse(widget.myProfileArguments.country_id.toString()),
                                              userName: widget
                                                  .myProfileArguments.user_name,
                                              status: 1,
                                            ),
                                          ),
                                        );
                                        print(
                                            'FIRST NAME = ${firstnameController}');
                                        print('LAST NAME = ${lastnameController}');
                                        print('DOB = ${selectedDate != null && selectedDate.toString().isNotEmpty ? selectedDate.toString() : dateInputController.text}');
                                        print('GENDER = ${selectedGender != null && selectedGender.toString().isNotEmpty ? selectedGender.toString() : genderController.text}');
                                        print(
                                            'NATIONALITY  = ${selectedNationalityID != null
                                                ? selectedNationalityID!
                                                : int.parse(widget.myProfileArguments.nationality_id
                                                .toString())}');
                                        print('COUNTRY = ${selectedCountryID != null
                                            ? selectedCountryID!
                                            : int.parse(widget.myProfileArguments.country_id.toString())}');
                                        print('CITY =  ${selectedCityID != null && selectedCityID.toString().isNotEmpty
                                            ? selectedCityID.toString()
                                            : widget.myProfileArguments.city
                                            .toString()}');
                                        print('Email = ${emailController}');
                                        print(
                                            'PHONE NUMBER =  ${mobileController}');
                                        print("PHOTO  = ${imageUploadFormated != null && imageUploadFormated.isNotEmpty ? imageUploadFormated! : widget.myProfileArguments.photo}");
                                      } else {
                                        Fluttertoast.showToast(
                                          msg: "All fields are important",
                                          toastLength: Toast.LENGTH_SHORT,
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
                                  ),
                                ).animate().then(delay: 200.ms).slideY(),
                              ],
                            );
                          }
                          else {
                            return SizedBox();
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
          ),
        );
      },
    );
  }
}

class DatePickerTextField extends StatefulWidget {
  final TextEditingController controller;
  final void Function() onDateIconTap;
  final String hintText;

  DatePickerTextField({
    Key? key,
    required this.controller,
    required this.onDateIconTap,
    required this.hintText,
  }) : super(key: key);

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
          color: AppColors.primaryBlackColor,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: GoogleFonts.openSans(
            color: AppColors.hintColor,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(width: 1, color: Color(0xFFE6ECFF)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(color: AppColors.primaryColor2),
          ),
          fillColor: Colors.white,
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
  final Function pickImage;
  final File filePath;

  CustomSliverDelegate({
    required this.pickImage,
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
          height: 200,
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
                                  myProfileArguments.user_name,
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
                                pickImage();
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
                      return SizedBox();
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
