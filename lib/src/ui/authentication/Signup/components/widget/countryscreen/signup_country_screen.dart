import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_collect/language.dart';
import 'package:lets_collect/src/bloc/city_bloc/city_bloc.dart';
import 'package:lets_collect/src/bloc/country_bloc/country_bloc.dart';
import 'package:lets_collect/src/bloc/language/language_bloc.dart';
import 'package:lets_collect/src/components/Custome_Textfiled.dart';
import 'package:lets_collect/src/components/my_button.dart';
import 'package:lets_collect/src/constants/assets.dart';
import 'package:lets_collect/src/constants/strings.dart';
import 'package:lets_collect/src/model/auth/get_city_request.dart';
import 'package:lets_collect/src/utils/data/object_factory.dart';
import 'package:lets_collect/src/utils/screen_size/size_config.dart';
import 'package:lottie/lottie.dart';
import '../../../../../../bloc/sign_up_bloc/sign_up_bloc.dart';
import '../../../../../../constants/colors.dart';
import '../../../../../../model/auth/get_country_response.dart';
import '../../../../../../model/auth/sign_up_request.dart';
import '../../../../../../utils/network_connectivity/bloc/network_bloc.dart';
import '../firstscreen/sign_up_argument_class.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NumberVerificationScreen extends StatefulWidget {
  final SignUpArgumentClass signUpArgumentClass;

  const NumberVerificationScreen(
      {super.key, required this.signUpArgumentClass});

  @override
  State<NumberVerificationScreen> createState() =>
      _NumberVerificationScreenState();
}

class _NumberVerificationScreenState extends State<NumberVerificationScreen> {
  String selectedDropdownItem = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController countryCodeController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  // TextEditingController phonenumController = TextEditingController();

  bool isOneTime = false;

  // FocusNode _countrycode = FocusNode();
  final FocusNode _countrynumber = FocusNode();

  String? validatePhoneNumber(String? value) {
    if (value!.length < 8 || value.isEmpty) {
      return AppLocalizations.of(context)!.enteravalidphonenumber;
      // return 'Enter a valid phone number';
    } else {
      return null;
    }
  }

  String? validateCountryCodeNumber(String? value) {
    if (value!.isEmpty || value.isEmpty) {
      return '';
    } else {
      return null;
    }
  }

  String selectedCountry = "";
  int? selectedCountryID;
  String selectedCity = "";
  String selectedCountryCode = "";
  String? selectedCityValue;
  String? selectedCountryValue;
  late List<CountryData> countryList = [];
  final String initialValue = 'Bahrain';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpLoadingServerError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.secondaryColor,
              content: Text(
                context.read<LanguageBloc>().state.selectedLanguage ==
                        Language.english
                    ? state.errorMsg
                    : AppLocalizations.of(context)!
                        .oopsitlooksliketheserverisnot,
                style: GoogleFonts.openSans(
                  color: AppColors.primaryWhiteColor,
                ),
              ),
            ),
          );
        }
        if (state is SignUpLoadingTimeoutError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.secondaryColor,
              content: Text(
                context.read<LanguageBloc>().state.selectedLanguage ==
                        Language.english
                    ? state.errorMsg
                    : AppLocalizations.of(context)!.oopslookslikewearefacing,
                style: GoogleFonts.openSans(
                  color: AppColors.primaryWhiteColor,
                ),
              ),
            ),
          );
        }
        if (state is SignUpLoadingConnectionRefusedError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.secondaryColor,
              content: Text(
                context.read<LanguageBloc>().state.selectedLanguage ==
                        Language.english
                    ? state.errorMsg
                    : AppLocalizations.of(context)!
                        .connectionrefusedthisindicates,
                style: GoogleFonts.openSans(
                  color: AppColors.primaryWhiteColor,
                ),
              ),
            ),
          );
        }
        if (state is SignUpLoaded) {
          if (state.signUpRequestResponse.success == true &&
              state.signUpRequestResponse.token.isNotEmpty) {
            ObjectFactory()
                .prefs
                .setAuthToken(token: state.signUpRequestResponse.token);
            ObjectFactory().prefs.setUserName(
                userName: state.signUpRequestResponse.data.firstName);
            ObjectFactory().prefs.setIsLoggedIn(true);
            context.go('/home');
          }
        } else if (state is SignUpErrorState) {
          if (state.signUpRequestErrorResponse.success == false) {
            if (state.signUpRequestErrorResponse.data.userName!.isNotEmpty &&
                state.signUpRequestErrorResponse.data.userName ==
                    "The user name has already been taken.") {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: AppColors.secondaryColor,
                  content: Text(
                    context.read<LanguageBloc>().state.selectedLanguage ==
                            Language.english
                        ? state.signUpRequestErrorResponse.data.userName!
                        : AppLocalizations.of(context)!
                            .theusernamehasalreadybeentaken,
                    // state.signUpRequestErrorResponse.data.userName!,
                    style: GoogleFonts.openSans(
                      color: AppColors.primaryWhiteColor,
                    ),
                  ),
                ),
              );
              context.pop();
              context.pop();
            } else if (state
                    .signUpRequestErrorResponse.data.email!.isNotEmpty &&
                state.signUpRequestErrorResponse.data.email ==
                    "The email has already been taken.") {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: AppColors.secondaryColor,
                  content: Text(
                    context.read<LanguageBloc>().state.selectedLanguage ==
                            Language.english
                        ? state.signUpRequestErrorResponse.data.email!
                        : AppLocalizations.of(context)!
                            .theemailhasalreadybeentaken,
                    // state.signUpRequestErrorResponse.data.email!,
                    style: GoogleFonts.openSans(
                      color: AppColors.primaryWhiteColor,
                    ),
                  ),
                ),
              );
              context.pop();
              context.pop();
            } else if (state
                        .signUpRequestErrorResponse.data.email!.isNotEmpty &&
                    state.signUpRequestErrorResponse.data.email ==
                        "The email has already been taken." ||
                state.signUpRequestErrorResponse.data.userName ==
                    "The user name has already been taken." ||
                state.signUpRequestErrorResponse.data.mobileNo ==
                    "The mobile no has already been taken.") {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: AppColors.secondaryColor,
                  content: Text(
                    context.read<LanguageBloc>().state.selectedLanguage ==
                            Language.english
                        ? state.signUpRequestErrorResponse.data.email!
                        : AppLocalizations.of(context)!
                            .themobilenohasalreadybeentaken,
                    // state.signUpRequestErrorResponse.data.email!,
                    style: GoogleFonts.openSans(
                      color: AppColors.primaryWhiteColor,
                    ),
                  ),
                ),
              );
              context.pop();
              context.pop();
            } else if (state
                    .signUpRequestErrorResponse.data.mobileNo!.isNotEmpty &&
                state.signUpRequestErrorResponse.data.mobileNo ==
                    "The mobile no has already been taken.") {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: AppColors.secondaryColor,
                  content: Text(
                    context.read<LanguageBloc>().state.selectedLanguage ==
                            Language.english
                        ? state.signUpRequestErrorResponse.data.mobileNo!
                        : AppLocalizations.of(context)!
                            .themobilenohasalreadybeentaken,
                    // state.signUpRequestErrorResponse.data.mobileNo!,
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
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                context.pop();
              },
              icon: const Icon(Icons.arrow_back_ios),
              color: AppColors.primaryWhiteColor),
        ),
        body: BlocConsumer<NetworkBloc, NetworkState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is NetworkInitial) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(Assets.NO_INTERNET),
                    Text(
                      // "You are not connected to the internet",
                      AppLocalizations.of(context)!
                          .youarenotconnectedtotheinternet,
                      style: GoogleFonts.openSans(
                        color: AppColors.primaryGrayColor,
                        fontSize: 20,
                      ),
                    ).animate().scale(delay: 200.ms, duration: 300.ms),
                  ],
                ),
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
                      style: GoogleFonts.openSans(
                        color: AppColors.primaryGrayColor,
                        fontSize: 20,
                      ),
                    ).animate().scale(delay: 200.ms, duration: 300.ms),
                  ],
                ),
              );
            } else if (state is NetworkSuccess) {
              return Padding(
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
                              color: AppColors.primaryWhiteColor,
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
                            AppLocalizations.of(context)!.almostdone,
                            // "Almost Done!",
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
                        Center(
                          child: Text(
                            AppLocalizations.of(context)!.justthisone,
                            // Strings.VERIFY_DISCRIPTION,
                            style: const TextStyle(
                                color: AppColors.primaryWhiteColor,
                                fontSize: 14),
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
                                            child: Lottie.asset(
                                                Assets.JUMBINGDOT,
                                                height: 70,
                                                width: 90),
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
                                          color: AppColors.primaryGrayColor,
                                        ),
                                        color: AppColors.primaryWhiteColor,
                                      ),
                                      elevation: 2,
                                    ),
                                    menuItemStyleData: const MenuItemStyleData(
                                      height: 40,
                                      padding:
                                          EdgeInsets.only(left: 14, right: 14),
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
                                            AppLocalizations.of(context)!
                                                .countryyoulivein,
                                            // "Country you live in",
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
                                        .map(
                                          (item) => DropdownMenuItem<String>(
                                            value: item.countriesId.toString(),
                                            child: Text(
                                              context
                                                          .read<LanguageBloc>()
                                                          .state
                                                          .selectedLanguage ==
                                                      Language.english
                                                  ? item.name
                                                  : item.nameArabic,
                                              style: GoogleFonts.roboto(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color:
                                                    AppColors.primaryBlackColor,
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
                                        selectedCountry = selectedCountryValue!;
                                        selectedCountryID =
                                            int.tryParse(selectedCountry);
                                        for (var item
                                            in state.countryResponse.data) {
                                          if (item.countriesId ==
                                              selectedCountryID) {
                                            selectedCountryCode =
                                                item.countryCode;
                                            countryCodeController.text =
                                                selectedCountryCode;
                                          }
                                        }
                                      });

                                      BlocProvider.of<CityBloc>(context).add(
                                        GetCityEvent(
                                            getCityRequest: GetCityRequest(
                                                countriesId:
                                                    selectedCountryID!)),
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
                                      iconEnabledColor:
                                          AppColors.secondaryColor,
                                      iconDisabledColor:
                                          AppColors.primaryGrayColor,
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                      direction:  context.read<LanguageBloc>().state.selectedLanguage == Language.english ?
                                      DropdownDirection.left : DropdownDirection.right,
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
                                            WidgetStateProperty.all<double>(
                                                6),
                                        thumbVisibility:
                                            WidgetStateProperty.all<bool>(
                                                true),
                                      ),
                                    ),
                                    menuItemStyleData: const MenuItemStyleData(
                                      height: 40,
                                      padding:
                                          EdgeInsets.only(left: 14, right: 14),
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
                                            child: Lottie.asset(
                                                Assets.JUMBINGDOT,
                                                height: 70,
                                                width: 90),
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
                                          color: AppColors.borderColor,
                                        ),
                                        color: AppColors.primaryWhiteColor,
                                      ),
                                      elevation: 2,
                                    ),
                                    menuItemStyleData: const MenuItemStyleData(
                                      height: 40,
                                      padding:
                                          EdgeInsets.only(left: 14, right: 14),
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
                                            AppLocalizations.of(context)!.city,
                                            // "City",
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
                                                context
                                                            .read<
                                                                LanguageBloc>()
                                                            .state
                                                            .selectedLanguage ==
                                                        Language.english
                                                    ? item.city
                                                    : item.cityArabic,
                                                style: GoogleFonts.roboto(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors
                                                      .primaryBlackColor,
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
                                          color: AppColors.primaryGrayColor,
                                        ),
                                        color: AppColors.primaryWhiteColor,
                                      ),
                                      elevation: 2,
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
                                          AppColors.primaryBlackColor,
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                      direction:  context.read<LanguageBloc>().state.selectedLanguage == Language.english ?
                                      DropdownDirection.left : DropdownDirection.right,
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
                                            WidgetStateProperty.all<double>(
                                                6),
                                        thumbVisibility:
                                            WidgetStateProperty.all<bool>(
                                                true),
                                      ),
                                    ),
                                    menuItemStyleData: const MenuItemStyleData(
                                      height: 40,
                                      padding:
                                          EdgeInsets.only(left: 14, right: 14),
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
                          padding: const EdgeInsets.only(
                              left: 30, right: 30, bottom: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Flexible(
                                flex: 1,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    bottomRight: Radius.circular(5),
                                    bottomLeft: Radius.circular(5),
                                  ),
                                  child: MyTextField(
                                    obscureText: false,
                                    maxLines: 1,
                                    keyboardType: TextInputType.none,
                                    controller: countryCodeController,
                                    enable: false,
                                    hintText: "+xx",
                                    // controller: ,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 5),
                              Expanded(
                                flex: 5,
                                child: MyTextField(
                                  inputFormatter: [
                                    selectedCountryID == 18
                                        ? LengthLimitingTextInputFormatter(8)
                                        : LengthLimitingTextInputFormatter(10)
                                  ],
                                  focusNode: _countrynumber,
                                  hintText:
                                      AppLocalizations.of(context)!.phonenumber,
                                  // hintText: Strings.PHONE_NUMBER,
                                  obscureText: false,
                                  maxLines: 1,
                                  controller: phoneNumberController,
                                  keyboardType: TextInputType.number,
                                ).animate().then(delay: 200.ms).slideX(),
                              ),
                            ],
                          ),
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
                                    backgroundColor:
                                        AppColors.secondaryButtonColor,
                                  ),
                                ),
                              );
                            }
                            return Center(
                              child: MyButton(
                                Textfontsize: 16,
                                TextColors: AppColors.primaryWhiteColor,
                                text: AppLocalizations.of(context)!.submit,
                                color: AppColors.secondaryColor,
                                width: getProportionateScreenHeight(340),
                                height: getProportionateScreenWidth(40),
                                onTap: () {
                                  // print(
                                  //     "SELECTED COUNTRY ID: $selectedCountry");
                                  // print(
                                  //     "SELECTED COUNTRY CODE: ${countryCodeController.text}");
                                  // print("SELECTED CITY: $selectedCity");
                                  // print(
                                  //     "MOBILE: ${countryCodeController.text + phoneNumberController.text}");
                                    if (selectedCountry.isNotEmpty &&
                                        selectedCity.isNotEmpty && phoneNumberController.text.isNotEmpty) {
                                      BlocProvider.of<SignUpBloc>(context).add(
                                        SignUpRequestEvent(
                                          signupRequest: SignupRequest(
                                            firstName: widget
                                                .signUpArgumentClass.firsname!,
                                            lastName: widget
                                                .signUpArgumentClass.lastName!,
                                            email: widget
                                                .signUpArgumentClass.email!,
                                            mobileNo:
                                                countryCodeController.text +
                                                    phoneNumberController.text,
                                            userName: widget
                                                .signUpArgumentClass.firsname!,
                                            password: widget
                                                .signUpArgumentClass.password!,
                                            gender: widget
                                                .signUpArgumentClass.gender!,
                                            dob:
                                                widget.signUpArgumentClass.dob!,
                                            nationalityId: widget
                                                .signUpArgumentClass
                                                .nationalityID!,
                                            city: selectedCity,
                                            countryId: selectedCountry,
                                            deviceToken: ObjectFactory()
                                                .prefs
                                                .getFcmToken()!,
                                            deviceType:
                                                Platform.isAndroid ? "A" : "I",
                                          ),
                                        ),
                                      );
                                    }
                                   else {
                                    Fluttertoast.showToast(
                                      msg: AppLocalizations.of(context)!
                                          .allfieldsareimportant,
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor: AppColors.primaryWhiteColor,
                                      textColor: AppColors.secondaryColor,
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
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
