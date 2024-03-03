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
import 'package:lets_collect/src/bloc/nationality_bloc/nationality_bloc.dart';
import 'package:lets_collect/src/components/Custome_Textfiled.dart';
import 'package:lets_collect/src/components/my_button.dart';
import 'package:lets_collect/src/constants/assets.dart';
import 'package:lets_collect/src/constants/colors.dart';
import 'package:lets_collect/src/constants/strings.dart';
import 'package:lets_collect/src/model/auth/get_city_request.dart';
import 'package:lets_collect/src/utils/screen_size/size_config.dart';
import 'package:lottie/lottie.dart';

import '../../../bloc/my_profile_bloc/my_profile_bloc.dart';
import 'my_profile_screen_arguments.dart';

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
      dateInputController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
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
    if (value!.length < 8 || value.isEmpty) {
      return 'Enter a valid phone number';
    } else {
      return null;
    }
  }

  String? selectedGender;

  final List<String> Gender = ["M", "F"];

  File? _image = File("");
  final _picker = ImagePicker();
  late XFile _pickedFile;

  int? selectedCountryID;
  String? selectedNationality;
  String? selectedCountryValue;
  String? selectedCountry;
  String? selectedCity;

  myProfileArgumentData() {
    if (widget.myProfileArguments != null) {
      firstnameController.text = widget.myProfileArguments.first_name;
      print("FIRST NAME : $firstnameController.text");

      lastnameController.text = widget.myProfileArguments.last_name;
      print("LASTNAME  : $lastnameController.text");

      dateInputController.text = DateFormat('MM/dd/yyyy')
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
    });
  }

  @override
  void initState() {
    super.initState();
    // BlocProvider.of<MyProfileBloc>(context).add(GetProfileDataEvent());
    myProfileArgumentData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
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
                    Column(
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
                          padding: const EdgeInsets.symmetric(horizontal: 11),
                          child: Row(
                            children: [
                              Flexible(
                                child: MyTextField(
                                  enable: true,
                                  focusNode: _firstname,
                                  // horizontal: 10,
                                  hintText: Strings.SIGNUP_FIRSTNAME_LABEL_TEXT,
                                  obscureText: false,
                                  maxLines: 1,
                                  controller: firstnameController,
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    String? err = validateFirstname(value);
                                    if (err != null) {
                                      _firstname.requestFocus();
                                    }
                                    return err;
                                  },
                                ),
                              ).animate().then(delay: 200.ms).slideY(),
                              const SizedBox(width: 20),
                              Flexible(
                                child: MyTextField(
                                  enable: true,
                                  focusNode: _secondname,
                                  // horizontal: 10,
                                  hintText: Strings.SIGNUP_LASTNAME_LABEL_TEXT,
                                  obscureText: false,
                                  maxLines: 1,
                                  controller: lastnameController,
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    String? err = validateLastname(value);
                                    if (err != null) {
                                      _secondname.requestFocus();
                                    }
                                    return err;
                                  },
                                ),
                              ).animate().then(delay: 200.ms).slideY(),
                            ],
                          ),
                        ),
                        // SizedBox(height: 5,),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          child: GestureDetector(
                            onTap: () {
                              _showDatePicker(context);
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
                            padding: const EdgeInsets.symmetric(horizontal: 11),
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
                                        color: AppColors.primaryBlackColor,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ).toList(),
                                value: selectedGender,
                                onChanged: (String? value) {
                                  setState(() {
                                    selectedGender = value!;
                                  });
                                },
                                buttonStyleData: ButtonStyleData(
                                  width: 340,
                                  height: 50,
                                  padding: const EdgeInsets.only(
                                      left: 14, right: 14),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
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
                                  iconEnabledColor: AppColors.secondaryColor,
                                  iconDisabledColor: AppColors.primaryGrayColor,
                                ),
                                dropdownStyleData: DropdownStyleData(
                                  maxHeight: 200,
                                  width: 350,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: AppColors.primaryWhiteColor,
                                  ),
                                  offset: const Offset(-2, -5),
                                  scrollbarTheme: ScrollbarThemeData(
                                    radius: const Radius.circular(40),
                                    thickness:
                                    MaterialStateProperty.all<double>(6),
                                    thumbVisibility:
                                    MaterialStateProperty.all<bool>(true),
                                  ),
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  height: 40,
                                  padding: EdgeInsets.only(left: 14, right: 14),
                                ),
                              ),
                            ),
                          ),
                        ).animate().then(delay: 200.ms).slideY(),
              
                        const SizedBox(height: 15),
                        /// Nationality
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 11),
                            child:
                            BlocBuilder<NationalityBloc, NationalityState>(
                              builder: (context, state) {
                                if (state is NationalityLoading) {
                                  return Center(
                                    child: Lottie.asset(Assets.JUMBINGDOT,
                                        height: 70, width: 90),
                                  );
                                }
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
                                      items: state.nationalityResponse.data
                                          .map(
                                            (item) => DropdownMenuItem<String>(
                                          value: item.id.toString(),
                                          child: Text(
                                            item.nationality,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: AppColors
                                                  .primaryBlackColor,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      )
                                          .toList(),
                                      value: selectedNationality,
                                      onChanged: (String? value) {
                                        setState(() {
                                          selectedNationality = value!;
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
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              },
                            ),
                          ),
                        ).animate().then(delay: 200.ms).slideY(),
                        SizedBox(height: getProportionateScreenHeight(15)),
              
                        /// Country
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 11),
                            child: BlocBuilder<CountryBloc, CountryState>(
                              builder: (context, state) {
                                if (state is CountryLoading) {
                                  return Center(
                                    child: Lottie.asset(Assets.JUMBINGDOT,
                                        height: 70, width: 90),
                                  );
                                }
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
                                            (item) => DropdownMenuItem<String>(
                                          value:
                                          item.countriesId.toString(),
                                          child: Text(
                                            item.name,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: AppColors
                                                  .primaryBlackColor,
                                            ),
                                            overflow: TextOverflow.ellipsis,
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
                                              int.tryParse(selectedCountry!);
                                        });
                                        print(
                                            'Selected Country ID: $selectedCountryID');
                                        BlocProvider.of<CityBloc>(context).add(
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
                                  );
                                } else {
                                  return SizedBox();
                                }
                              },
                            ),
                          ),
                        ).animate().then(delay: 200.ms).slideY(),
              
                        SizedBox(height: getProportionateScreenHeight(15)),
              
                        /// City
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 11),
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
                                            (item) => DropdownMenuItem<String>(
                                          value: item.cityId.toString(),
                                          child: Text(
                                            item.city,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: AppColors
                                                  .primaryBlackColor,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      )
                                          .toList(),
                                      value: selectedCity,
                                      onChanged: (String? value) {
                                        setState(() {
                                          selectedCity = value!;
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
                          padding: const EdgeInsets.symmetric(horizontal: 11),
                          child: MyTextField(
                            enable: false,
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
                          padding: const EdgeInsets.symmetric(horizontal: 11),
                          child: MyTextField(
                            inputFormatter: [
                              LengthLimitingTextInputFormatter(8)
                            ],
                            enable: true,
                            focusNode: _phone,
                            // horizontal: 10,
                            hintText: Strings.PHONE_NUMBER,
                            obscureText: false,
                            maxLines: 1,
                            controller: mobileController,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              String? err = validatePhoneNumber(value);
                              if (err != null) {
                                _phone.requestFocus();
                              }
                              return err;
                            },
                          ),
                        ).animate().then(delay: 200.ms).slideY(),
                        const SizedBox(height: 20),
              
                        Center(
                          child: MyButton(
                            Textfontsize: 16,
                            TextColors: AppColors.primaryWhiteColor,
                            text: "save",
                            color: AppColors.secondaryColor,
                            width: 340,
                            height: 40,
                            onTap: () {
                              Fluttertoast.showToast(
                                      msg: "Sorry! This functionality is not available in this version.",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor: AppColors.secondaryColor,
                                      textColor: AppColors.primaryWhiteColor,
                                    );
                              // BlocProvider.of<MyProfileBloc>(context)
                              //     .add(GetProfileDataEvent());
                              // print('First name ${firstnameController}');
                              // print('Last name ${lastnameController}');
                              // print('Dob name ${dateInputController}');
                              // print('Gender name ${genderController}');
                              // print('Nationality ${nationalityController}');
                              // print('Country ${countryController}');
                              // print('City ${cityController}');
                              // print('Email ${emailController}');
                              // print('Mobile number ${mobileController}');
                              //
                              // if (_formKey.currentState?.validate() ?? false) {
                              //   if (firstnameController.text.isNotEmpty &&
                              //       lastnameController.text.isNotEmpty &&
                              //       dateInputController.text.isNotEmpty &&
                              //       genderController.text.isNotEmpty &&
                              //       nationalityController.text.isNotEmpty &&
                              //       countryController.text.isNotEmpty &&
                              //       cityController.text.isNotEmpty &&
                              //       emailController.text.isNotEmpty &&
                              //       mobileController.text.isNotEmpty) {
                              //     context.pop();
                              //   }
                              // } else {
                              //   Fluttertoast.showToast(
                              //     msg: "All fields are important",
                              //     toastLength: Toast.LENGTH_SHORT,
                              //     gravity: ToastGravity.BOTTOM,
                              //     backgroundColor: Colors.black87,
                              //     textColor: Colors.white,
                              //   );
                              // }
                            },
                            showImage: false,
                            imagePath: '',
                            imagewidth: 0,
                            imageheight: 0,
                          ),
                        ).animate().then(delay: 200.ms).slideY(),
                      ],
                    ),
                  ]),
                ),
                padding: const EdgeInsets.only(
                    top: 15, left: 15, right: 15, bottom: 30),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DatePickerTextField extends StatefulWidget {
  final TextEditingController controller;
  final void Function() onDateIconTap;
  final String hintText;

  const DatePickerTextField({
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
              icon:  const Icon(
                Icons.cancel_outlined,
                color: AppColors.primaryWhiteColor,
              ),
              onPressed: () {
                // BlocProvider.of<MyProfileBloc>(context)
                //     .add(GetProfileDataEvent());
                context.pop();
                if (kDebugMode) {
                  print("Profile tapped!");
                }
              },
            ),
            elevation: 0.0,
            title: Opacity(
              opacity: hideTitleWhenExpanded ? 1.0 - percent : 1.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          Text(
                            myProfileArguments.user_name,
                            style: GoogleFonts.openSans(
                              fontSize: 21,
                              fontWeight: FontWeight.w700,
                              color: AppColors.secondaryColor,
                            ),
                          ),
                          const SizedBox(height: 10),
                          GestureDetector(
                            onTap: () {
                              Fluttertoast.showToast(
                                msg: "Sorry! This functionality is not available in this version.",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: AppColors.secondaryColor,
                                textColor: AppColors.primaryWhiteColor,
                              );
                            },
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
                    Expanded(
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
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              // borderRadius: BorderRadius.circular(100),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.file(
                                File(filePath.path),
                                width: 130,
                                height: 130,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                              : Container(
                            alignment: Alignment.center,
                            width: 130,
                            height: 130,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.shadow,
                              // borderRadius: BorderRadius.circular(100),
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Add",style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,

                                ),),
                                Icon(
                                  Icons.add_a_photo_outlined,
                                  color: AppColors.secondaryColor,
                                  size: 18,
                                ),
                              ],
                            ),
                          )),
                    ),
                    // SizedBox(height: 120),
                  ],
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
