import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lets_collect/language.dart';
import 'package:lets_collect/src/bloc/language/language_bloc.dart';
import 'package:lets_collect/src/components/my_button.dart';
import 'package:lets_collect/src/constants/assets.dart';
import 'package:lets_collect/src/constants/strings.dart';
import 'package:lets_collect/src/ui/authentication/Signup/components/widget/firstscreen/sign_up_argument_class.dart';
import 'package:lottie/lottie.dart';
import '../../../../../../bloc/nationality_bloc/nationality_bloc.dart';
import '../../../../../../constants/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../../utils/network_connectivity/bloc/network_bloc.dart';

class SignupCalenderScreen extends StatefulWidget {
  final SignUpArgumentClass signUpArgumentClass;

  const SignupCalenderScreen({super.key, required this.signUpArgumentClass});

  @override
  State<SignupCalenderScreen> createState() => _SignupCalenderScreenState();
}

class _SignupCalenderScreenState extends State<SignupCalenderScreen> {
  String selectedNationality = "";
  String? selectedValue;

  bool isOneTime = false;
  String gender = "";
  String genderSelected = "";
  TextEditingController dateInputController = TextEditingController();
  DateTime? selectedDate;
  DateTime? _minimumDate;

  void _showDatePicker(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1980),
      lastDate: DateTime(2050),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );

    if (pickedDate != null) {
      dateInputController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
      selectedDate = pickedDate;
      if (selectedDate != null && !isAbove12YearsOld(selectedDate!)) {
        Fluttertoast.showToast(
          msg: AppLocalizations.of(context)!.pleaseselectadateofbirthabove12,
          // msg: "Please select a date of birth above 12 years old!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: AppColors.primaryWhiteColor,
          textColor: AppColors.secondaryColor,
        );
      }
    }
  }

  ///Method for calculating Age above 12
  bool isAbove12YearsOld(DateTime selectedDate) {
    final DateTime now = DateTime.now();
    final DateTime twelveYearsAgo =
        now.subtract(const Duration(days: 12 * 365));
    return selectedDate.isBefore(twelveYearsAgo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      backgroundColor: AppColors.primaryColor,
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
          } else if (state is NetworkSuccess) {
            return Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 60,
                    ),
                    const Center(
                      child: Text(
                        Strings.LOGIN_LETS_COLLECT,
                        style: TextStyle(
                          color: AppColors.primaryWhiteColor,
                          fontSize: 40,
                        ),
                      ),
                    ).animate().then(delay: 200.ms).slideX(),
                    const Center(
                      child: Image(
                        image: AssetImage(Assets.APP_LOGO),
                        width: 100,
                        height: 80,
                      ),
                    ).animate().then(delay: 200.ms).slideX(),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.welcome,
                          // Strings.WELOCOM,
                          style: GoogleFonts.roboto(
                            color: AppColors.primaryWhiteColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 28,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "${widget.signUpArgumentClass.firsname} ${widget.signUpArgumentClass.lastName} !",
                          style: GoogleFonts.roboto(
                            color: AppColors.secondaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 28,
                          ),
                        ),
                      ],
                    ).animate().then(delay: 200.ms).slideX(),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 60),
                        child: Text(
                          AppLocalizations.of(context)!
                              .youarealmosttherewejustneedabitofinfotomakesurewecansendyoutheabsolutebestoffers,
                          // Strings.DISCRIPTION,
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primaryWhiteColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ).animate().then(delay: 200.ms).slideX(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 28),
                      child: GestureDetector(
                        onTap: () {
                          _showDatePicker(context);
                        },
                        child: AbsorbPointer(
                          child: TextFormField(
                            controller: dateInputController,
                            decoration: InputDecoration(
                              hintText:
                                  AppLocalizations.of(context)!.dateofbirth,
                              // hintText: "Date of Birth",
                              hintStyle: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: AppColors.hintColor,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: const BorderSide(
                                    color: AppColors.borderColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: const BorderSide(
                                    color: AppColors.borderColor),
                              ),
                              fillColor: AppColors.primaryWhiteColor,
                              filled: true,
                              contentPadding: const EdgeInsets.all(8),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(right: 15.0),
                                child: GestureDetector(
                                    onTap: () {
                                      _showDatePicker(context);
                                    },
                                    child: const ImageIcon(
                                      AssetImage(Assets.CALENDER),
                                      color: AppColors.secondaryColor,
                                    )),
                              ),
                            ),
                          ),
                        ),
                      ).animate().then(delay: 200.ms).slideX(),
                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.only(left: 27, right: 27),
                      child: Text(
                        AppLocalizations.of(context)!.gender,
                        // Strings.GENDER,
                        style: const TextStyle(
                            color: AppColors.primaryWhiteColor, fontSize: 20),
                      ).animate().then(delay: 200.ms).slideX(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Radio(
                          value: "female",
                          groupValue: gender,
                          onChanged: (value) {
                            setState(() {
                              gender = value.toString();
                              genderSelected = "F";
                            });
                          },
                          activeColor: AppColors.secondaryColor,
                          fillColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.selected)) {
                              return AppColors.secondaryColor;
                            }
                            return AppColors.primaryWhiteColor;
                          }),
                        ),
                        Text(
                          AppLocalizations.of(context)!.female,
                          // "Female",
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primaryWhiteColor,
                          ),
                        ),
                        const SizedBox(width: 50),
                        Radio(
                          value: "male",
                          groupValue: gender,
                          onChanged: (value) {
                            setState(() {
                              gender = value.toString();
                              genderSelected = "M";
                            });
                          },
                          activeColor: AppColors.secondaryColor,
                          fillColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.selected)) {
                              return AppColors.secondaryColor;
                            }
                            return AppColors.primaryWhiteColor;
                          }),
                        ),
                        Text(
                          AppLocalizations.of(context)!.male,
                          // "Male",
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primaryWhiteColor,
                          ),
                        ),
                      ],
                    ).animate().then(delay: 200.ms).slideX(),
                    const SizedBox(height: 30),
                    Center(
                      child: BlocBuilder<NationalityBloc, NationalityState>(
                        builder: (context, state) {
                          if (state is NationalityLoading) {
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
                                  height: 40,
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
                                  padding: EdgeInsets.only(left: 14, right: 14),
                                ),
                              ),
                            );
                            //   Center(
                            //   child: Lottie.asset(Assets.JUMBINGDOT,
                            //       height: 70, width: 90),
                            // );
                          }
                          if (state is NationalityLoaded) {
                            return DropdownButtonHideUnderline(
                              child: DropdownButton2<String>(
                                isExpanded: true,
                                hint: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .nationality,
                                        // "Nationality",
                                        style: GoogleFonts.roboto(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                items: state.nationalityResponse.data
                                    .map((item) => DropdownMenuItem<String>(
                                          value: item.id.toString(),
                                          child: Text(
                                            context
                                                        .read<LanguageBloc>()
                                                        .state
                                                        .selectedLanguage ==
                                                    Language.english
                                                ? item.nationality
                                                : item.nationalityArabic,
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
                                value: selectedValue,
                                onChanged: (String? value) {
                                  setState(() {
                                    selectedValue = value;
                                    selectedNationality = selectedValue!;
                                  });
                                },
                                buttonStyleData: ButtonStyleData(
                                  height: 47,
                                  width: 340,
                                  padding: const EdgeInsets.only(
                                      left: 14, right: 14),
                                  decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(
                                        color: AppColors.boxShadow,
                                        blurRadius: 1.0, // soften the shadow
                                        spreadRadius: 0.0, //extend the shadow
                                        offset: Offset(
                                          1.0, // Move to right 10  horizontally
                                          1.0, // Move to bottom 10 Vertically
                                        ),
                                      ),
                                      BoxShadow(
                                        color: AppColors.boxShadow,
                                        blurRadius: 1.0, // soften the shadow
                                        spreadRadius: 0.0, //extend the shadow
                                        offset: Offset(
                                          -1.0,
                                          // Move to right 10  horizontally
                                          -1.0, // Move to bottom 10 Vertically
                                        ),
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
                          if (state is NationalityLoadingServerError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: AppColors.secondaryColor,
                                content: Text(
                                  state.errorMsg,
                                  style: GoogleFonts.openSans(
                                    color: AppColors.primaryWhiteColor,
                                  ),
                                ),
                              ),
                            );
                          }
                          if (state is NationalityLoadingConnectionTimeOut) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: AppColors.secondaryColor,
                                content: Text(
                                  state.errorMsg,
                                  style: GoogleFonts.openSans(
                                    color: AppColors.primaryWhiteColor,
                                  ),
                                ),
                              ),
                            );
                          }
                          if (state is NationalityLoadingConnectionRefused) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: AppColors.secondaryColor,
                                content: Text(
                                  state.errorMsg,
                                  style: GoogleFonts.openSans(
                                    color: AppColors.primaryWhiteColor,
                                  ),
                                ),
                              ),
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                    ).animate().then(delay: 200.ms).slideX(),
                    const SizedBox(height: 30),
                    Center(
                      child: MyButton(
                        Textfontsize: 16,
                        TextColors: AppColors.primaryWhiteColor,
                        text: AppLocalizations.of(context)!.next,
                        // text: Strings.SINGUP_BUTTON_TEXT,
                        color: AppColors.secondaryColor,
                        width: 340,
                        height: 40,
                        onTap: () {
                          print("Nationality:$selectedNationality");
                          if (dateInputController.text.isNotEmpty &&
                              gender.isNotEmpty &&
                              selectedNationality.isNotEmpty &&
                              selectedDate!.isBefore(DateTime.now()) &&
                              isAbove12YearsOld(selectedDate!)) {
                            context.push('/signUpCountryScreen',
                                extra: SignUpArgumentClass(
                                  firsname: widget.signUpArgumentClass.firsname,
                                  lastName: widget.signUpArgumentClass.lastName,
                                  confirmPassword: widget
                                      .signUpArgumentClass.confirmPassword,
                                  email: widget.signUpArgumentClass.email,
                                  password: widget.signUpArgumentClass.password,
                                  dob: dateInputController.text,
                                  gender: genderSelected,
                                  nationalityID: selectedNationality,
                                ));
                            // BlocProvider.of<CountryBloc>(context)
                            //     .add(GetCountryEvent());
                          } else {
                            Fluttertoast.showToast(
                              // msg: "Please provide your correct details!",
                              msg: AppLocalizations.of(context)!
                                  .pleaseprovideyourcorrectdetails,
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: AppColors.secondaryColor,
                              textColor: AppColors.primaryWhiteColor,
                            );
                          }
                        },
                        showImage: false,
                        imagePath: '',
                        imagewidth: 0,
                        imageheight: 0,
                      ),
                    ).animate().then(delay: 200.ms).slideX(),
                  ],
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
