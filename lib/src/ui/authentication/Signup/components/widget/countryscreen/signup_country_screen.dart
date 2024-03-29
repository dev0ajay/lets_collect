import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_collect/src/bloc/city_bloc/city_bloc.dart';
import 'package:lets_collect/src/bloc/country_bloc/country_bloc.dart';
import 'package:lets_collect/src/components/Custome_Textfiled.dart';
import 'package:lets_collect/src/components/my_button.dart';
import 'package:lets_collect/src/constants/assets.dart';
import 'package:lets_collect/src/constants/strings.dart';
import 'package:lets_collect/src/model/auth/get_city_request.dart';
import 'package:lets_collect/src/utils/data/object_factory.dart';
import 'package:lets_collect/src/utils/screen_size/size_config.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';
import '../../../../../../bloc/sign_up_bloc/sign_up_bloc.dart';
import '../../../../../../constants/colors.dart';
import '../../../../../../model/auth/sign_up_request.dart';
import '../firstscreen/sign_up_argument_class.dart';

class NumberVerificationScreen extends StatefulWidget {
  final SignUpArgumentClass signUpArgumentClass;

  const NumberVerificationScreen({Key? key, required this.signUpArgumentClass})
      : super(key: key);

  @override
  State<NumberVerificationScreen> createState() =>
      _NumberVerificationScreenState();
}

class _NumberVerificationScreenState extends State<NumberVerificationScreen> {
  String selectedDropdownItem = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController countrycodeController = TextEditingController();
  TextEditingController phonenumberController = TextEditingController();

  bool isOneTime = false;

  // FocusNode _countrycode = FocusNode();
  final FocusNode _countrynumber = FocusNode();

  String? validatePhoneNumber(String? value) {
    if (value!.length < 8 || value.isEmpty) {
      return 'Enter a valid phone number';
    } else {
      return null;
    }
  }

  String selectedCountry = "";
  int? selectedCountryID;
  String selectedCity = "";
  String? selectedCityValue;
  String? selectedCountryValue;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: BlocListener<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state is SignUpLoaded) {
            if (state.signUpRequestResponse.success == true &&
                state.signUpRequestResponse.token.isNotEmpty) {
              ObjectFactory()
                  .prefs
                  .setAuthToken(token: state.signUpRequestResponse.token);
              ObjectFactory().prefs.setUserName(
                  userName: state.signUpRequestResponse.data.userName);
              ObjectFactory().prefs.setIsLoggedIn(true);
              context.go('/home');
            }
          } else if (state is SignUpErrorState) {
            if (state.signUpRequestErrorResponse.status == false) {
              if (state.signUpRequestErrorResponse.data.userName!.isNotEmpty &&
                  state.signUpRequestErrorResponse.data.userName ==
                      "The user name has already been taken.") {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: AppColors.secondaryColor,
                    content: Text(
                      state.signUpRequestErrorResponse.data.userName!,
                      style: GoogleFonts.openSans(
                        color: AppColors.primaryWhiteColor,
                      ),
                    ),
                  ),
                );
              } else if (state
                      .signUpRequestErrorResponse.data.email!.isNotEmpty &&
                  state.signUpRequestErrorResponse.data.email ==
                      "The email has already been taken.") {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: AppColors.secondaryColor,
                    content: Text(
                      state.signUpRequestErrorResponse.data.email!,
                      style: GoogleFonts.openSans(
                        color: AppColors.primaryWhiteColor,
                      ),
                    ),
                  ),
                );
              } else if (state
                      .signUpRequestErrorResponse.data.mobileNo!.isNotEmpty &&
                  state.signUpRequestErrorResponse.data.mobileNo ==
                      "The mobile no has already been taken.") {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: AppColors.secondaryColor,
                    content: Text(
                      state.signUpRequestErrorResponse.data.mobileNo!,
                      style: GoogleFonts.openSans(
                        color: AppColors.primaryWhiteColor,
                      ),
                    ),
                  ),
                );
              }
            }
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.primaryColor,
          body: Padding(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: getProportionateScreenHeight(60),
                    ),
                    const Center(
                      child: Text(
                        Strings.LOGIN_LETS_COLLECT,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                        ),
                      ),
                    ),
                    const Center(
                      child: Image(
                        image: AssetImage(Assets.APP_LOGO),
                        width: 100,
                        height: 80,
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    Center(
                      child: Text(
                        "Almost Done!",
                        style: GoogleFonts.openSans(
                          color: AppColors.primaryWhiteColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    const Center(
                      child: Text(
                        Strings.VERIFY_DISCRIPTION,
                        style: TextStyle(color: Colors.white, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    Center(
                      child: BlocBuilder<CountryBloc, CountryState>(
                        builder: (context, state) {
                          if (state is CountryLoading) {
                            return DropdownButtonHideUnderline(
                              child: DropdownButton2<String>(
                                isExpanded: true,
                                hint: Row(
                                  children: [
                                    Expanded(
                                      child: Center(
                                        child: Lottie.asset(Assets.JUMBINGDOT,
                                            height: 70, width: 90),
                                      ),
                                    ),
                                  ],
                                ),
                                items: null,
                                buttonStyleData: ButtonStyleData(
                                  height: 50,
                                  width: 340,
                                  padding: const EdgeInsets.only(
                                      left: 14, right: 14),
                                  decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(
                                        color: AppColors.boxShadow,
                                        blurRadius: 4,
                                        offset: Offset(4, 2),
                                        spreadRadius: 0,
                                      ),
                                      BoxShadow(
                                        color: AppColors.boxShadow,
                                        blurRadius: 4,
                                        offset: Offset(-4, -2),
                                        spreadRadius: 0,
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                    color: Colors.white,
                                  ),
                                  elevation: 2,
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  height: 40,
                                  padding: EdgeInsets.only(left: 14, right: 14),
                                ),
                              ),
                            );
                          }
                          if (state is CountryLoaded) {
                            return DropdownButtonHideUnderline(
                              child: DropdownButton2<String>(
                                isExpanded: true,
                                hint: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Country",
                                        style: GoogleFonts.roboto(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.hintColor,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                items: state.countryResponse.data
                                    .map((item) => DropdownMenuItem<String>(
                                          value: item.countriesId.toString(),
                                          child: Text(
                                            item.name,
                                            style: GoogleFonts.roboto(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color:
                                                  AppColors.primaryBlackColor,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ))
                                    .toList(),
                                value: selectedCountryValue,
                                onChanged: (String? value) {
                                  setState(() {
                                    selectedCountryValue = value;
                                    selectedCountry = selectedCountryValue!;
                                    selectedCountryID =
                                        int.tryParse(selectedCountry);
                                  });
                                  BlocProvider.of<CityBloc>(context).add(
                                    GetCityEvent(
                                        getCityRequest: GetCityRequest(
                                            countriesId: selectedCountryID!)),
                                  );
                                },
                                buttonStyleData: ButtonStyleData(
                                  height: 50,
                                  width: 340,
                                  padding: const EdgeInsets.only(
                                      left: 14, right: 14),
                                  decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(
                                        color: AppColors.boxShadow,
                                        blurRadius: 4,
                                        offset: Offset(4, 2),
                                        spreadRadius: 0,
                                      ),
                                      BoxShadow(
                                        color: AppColors.boxShadow,
                                        blurRadius: 4,
                                        offset: Offset(-4, -2),
                                        spreadRadius: 0,
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                    color: Colors.white,
                                  ),
                                  elevation: 2,
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
                                    color: Colors.white,
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
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                    ).animate().then(delay: 200.ms).slideX(),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    Center(
                      child: BlocBuilder<CityBloc, CityState>(
                        builder: (context, state) {
                          if (state is CityLoading) {
                            return DropdownButtonHideUnderline(
                              child: DropdownButton2<String>(
                                isExpanded: true,
                                hint: Row(
                                  children: [
                                    Expanded(
                                      child: Center(
                                        child: Lottie.asset(Assets.JUMBINGDOT,
                                            height: 70, width: 90),
                                      ),
                                    ),
                                  ],
                                ),
                                items: null,
                                buttonStyleData: ButtonStyleData(
                                  height: 50,
                                  width: 340,
                                  padding: const EdgeInsets.only(
                                      left: 14, right: 14),
                                  decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(
                                        color: AppColors.boxShadow,
                                        blurRadius: 4,
                                        offset: Offset(4, 2),
                                        spreadRadius: 0,
                                      ),
                                      BoxShadow(
                                        color: AppColors.boxShadow,
                                        blurRadius: 4,
                                        offset: Offset(-4, -2),
                                        spreadRadius: 0,
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                    color: Colors.white,
                                  ),
                                  elevation: 2,
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  height: 40,
                                  padding: EdgeInsets.only(left: 14, right: 14),
                                ),
                              ),
                            );
                          }
                          if (state is CityLoaded) {
                            return DropdownButtonHideUnderline(
                              child: DropdownButton2<String>(
                                isExpanded: true,
                                hint: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "City",
                                        style: GoogleFonts.roboto(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.hintColor,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                items: state.getCityResponse.data
                                    .map((item) => DropdownMenuItem<String>(
                                          value: item.cityId.toString(),
                                          child: Text(
                                            item.city,
                                            style: GoogleFonts.roboto(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color:
                                                  AppColors.primaryBlackColor,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ))
                                    .toList(),
                                value: selectedCityValue,
                                onChanged: (String? value) {
                                  setState(() {
                                    selectedCityValue = value;
                                    selectedCity = selectedCityValue!;
                                  });
                                },
                                buttonStyleData: ButtonStyleData(
                                  height: 50,
                                  width: 340,
                                  padding: const EdgeInsets.only(
                                      left: 14, right: 14),
                                  decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(
                                        color: AppColors.boxShadow,
                                        blurRadius: 4,
                                        offset: Offset(4, 2),
                                        spreadRadius: 0,
                                      ),
                                      BoxShadow(
                                        color: AppColors.boxShadow,
                                        blurRadius: 4,
                                        offset: Offset(-4, -2),
                                        spreadRadius: 0,
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                    color: Colors.white,
                                  ),
                                  elevation: 2,
                                ),
                                iconStyleData: const IconStyleData(
                                  icon: Icon(
                                    Icons.arrow_drop_down_rounded,
                                    size: 35,
                                  ),
                                  iconSize: 14,
                                  iconEnabledColor: AppColors.secondaryColor,
                                  iconDisabledColor:
                                      AppColors.primaryBlackColor,
                                ),
                                dropdownStyleData: DropdownStyleData(
                                  maxHeight: 200,
                                  width: 350,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: Colors.white,
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
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: MyTextField(
                        inputFormatter: [LengthLimitingTextInputFormatter(8)],
                        focusNode: _countrynumber,
                        // horizontal: 10,
                        hintText: Strings.PHONE_NUMBER,
                        obscureText: false,
                        maxLines: 1,
                        controller: phonenumberController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          String? err = validatePhoneNumber(value);
                          if (err != null) {
                            _countrynumber.requestFocus();
                          }
                          return err;
                        },
                      ).animate().then(delay: 200.ms).slideX(),
                    ),
                    SizedBox(height: getProportionateScreenHeight(30)),
                    BlocBuilder<SignUpBloc, SignUpState>(
                      builder: (context, state) {
                        if (state is SignUpLoading) {
                          return Center(
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 1000),
                              child: const RefreshProgressIndicator(
                                color: AppColors.primaryWhiteColor,
                                backgroundColor: AppColors.secondaryButtonColor,
                              ),
                            ),
                          );
                        }
                        return Center(
                          child: MyButton(
                            Textfontsize: 16,
                            TextColors: Colors.white,
                            text: Strings.SINGUP_BUTTON_SUBMIT,
                            color: AppColors.secondaryColor,
                            width: getProportionateScreenHeight(340),
                            height: getProportionateScreenWidth(40),
                            onTap: () {
                              print(selectedCity);
                              if (_formKey.currentState?.validate() ?? false) {
                                if (selectedCountry.isNotEmpty &&
                                    selectedCity.isNotEmpty) {
                                  BlocProvider.of<SignUpBloc>(context).add(
                                    SignUpRequestEvent(
                                      signupRequest: SignupRequest(
                                        firstName: widget
                                            .signUpArgumentClass.firsname!,
                                        lastName: widget
                                            .signUpArgumentClass.lastName!,
                                        email:
                                            widget.signUpArgumentClass.email!,
                                        mobileNo: phonenumberController.text,
                                        userName: widget
                                            .signUpArgumentClass.firsname!,
                                        password: widget
                                            .signUpArgumentClass.password!,
                                        gender:
                                            widget.signUpArgumentClass.gender!,
                                        dob: widget.signUpArgumentClass.dob!,
                                        nationalityId: widget
                                            .signUpArgumentClass.nationalityID!,
                                        city: selectedCity,
                                        countryId: selectedCountry,
                                      ),
                                    ),
                                  );
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => const HomeScreen(),
                                  //   ),
                                  // );
                                }
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
                        );
                      },
                    ),
                    SizedBox(height: getProportionateScreenHeight(20)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
