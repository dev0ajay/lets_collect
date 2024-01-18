import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:lets_collect/src/bloc/country_bloc/country_bloc.dart';
import 'package:lets_collect/src/components/my_button.dart';
import 'package:lets_collect/src/constants/assets.dart';
import 'package:lets_collect/src/constants/strings.dart';
import 'package:lets_collect/src/ui/authentication/Signup/components/widget/firstscreen/sign_up_argument_class.dart';
import 'package:lottie/lottie.dart';
import '../../../../../../bloc/nationality_bloc/nationality_bloc.dart';
import '../../../../../../constants/colors.dart';

class SignupCalenderScreen extends StatefulWidget {
 final SignUpArgumentClass signUpArgumentClass;

   const SignupCalenderScreen({Key? key,required this.signUpArgumentClass}) : super(key: key);


  @override
  State<SignupCalenderScreen> createState() => _SignupCalenderScreenState();
}

class _SignupCalenderScreenState extends State<SignupCalenderScreen> {

  String selectedNationality = "";
  String? selectedValue ;

  bool isOneTime = false;



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
    }
  }

  String gender = "";
  String genderSelected = "";
  TextEditingController dateInputController = TextEditingController();

  final List<String> items = [
   

  ];

  @override
  void initState() {
    BlocProvider.of<NationalityBloc>(context).add(GetNationality());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Padding(
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
                    style: TextStyle(color: Colors.white, fontSize: 40, fontFamily: "Fonarto"),
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
                    const Text(
                      Strings.WELOCOM,
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "${widget.signUpArgumentClass.firsname } ${widget.signUpArgumentClass.lastName} !",
                      style: const TextStyle(color: AppColors.secondaryColor, fontSize: 25),
                    ),
                  ],
                ).animate().then(delay: 200.ms).slideX(),
                const SizedBox(
                  height: 20,
                ),
                const Center(
                  child: Text(
                    Strings.DISCRIPTION,
                    style: TextStyle(color: Colors.white, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ).animate().then(delay: 200.ms).slideX(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: GestureDetector(
                    onTap: () {
                      _showDatePicker(context);
                    },
                    child: AbsorbPointer(
                      child: TextFormField(
                        controller: dateInputController,
                        decoration: InputDecoration(
                          hintText: 'Date of Birth',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          contentPadding: const EdgeInsets.all(8),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              _showDatePicker(context);
                            },
                            child: const Icon(
                              Icons.calendar_today,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ).animate().then(delay: 200.ms).slideX(),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.only(left: 27),
                  child: const Text(
                    Strings.GENDER,
                    style: TextStyle(color: Colors.white, fontSize: 20),
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
                      fillColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                        if (states.contains(MaterialState.selected)) {
                          return AppColors.secondaryColor;
                        }
                        return Colors.white;
                      }),
                    ),
                    const Text("Female", style: TextStyle(color: Colors.white, fontSize: 18)),
                    const SizedBox(width: 30),
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
                      fillColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                        if (states.contains(MaterialState.selected)) {
                          return AppColors.secondaryColor;
                        }
                        return Colors.white;
                      }),
                    ),
                    const Text("Male", style: TextStyle(color: Colors.white, fontSize: 18)),
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
                          hint:  Row(
                            children: [
                              Expanded(
                                child:
                                  Center(
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
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade600,
                                  blurRadius: 1.0, // soften the shadow
                                  spreadRadius: 0.0, //extend the shadow
                                  offset: const Offset(
                                    1.0, // Move to right 10  horizontally
                                    1.0, // Move to bottom 10 Vertically
                                  ),
                                ),
                                BoxShadow(
                                  color: Colors.grey.shade600,
                                  blurRadius: 1.0, // soften the shadow
                                  spreadRadius: 0.0, //extend the shadow
                                  offset: const Offset(
                                    -1.0,
                                    // Move to right 10  horizontally
                                    -1.0, // Move to bottom 10 Vertically
                                  ),
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
                      //   Center(
                      //   child: Lottie.asset(Assets.JUMBINGDOT,
                      //       height: 70, width: 90),
                      // );
                    }
                    if (state is NationalityLoaded) {
                      return DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          isExpanded: true,
                          hint: const Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Nationality",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
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
                              item.nationality,
                              style: const TextStyle(
                                fontSize: 14,
                                // fontWeight: FontWeight.bold,
                                color: Colors.black,
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
                            height: 50,
                            width: 340,
                            padding: const EdgeInsets.only(
                                left: 14, right: 14),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade600,
                                  blurRadius: 1.0, // soften the shadow
                                  spreadRadius: 0.0, //extend the shadow
                                  offset: const Offset(
                                    1.0, // Move to right 10  horizontally
                                    1.0, // Move to bottom 10 Vertically
                                  ),
                                ),
                                BoxShadow(
                                  color: Colors.grey.shade600,
                                  blurRadius: 1.0, // soften the shadow
                                  spreadRadius: 0.0, //extend the shadow
                                  offset: const Offset(
                                    -1.0,
                                    // Move to right 10  horizontally
                                    -1.0, // Move to bottom 10 Vertically
                                  ),
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
                // child: CustomDropdown(
                //     hintText: Strings.NATIONALITY,
                //     items: items,
                //   width: 340,
                //     height: 50,
                //   onChanged: (selectedItem) {
                //     print("City: $selectedCity");
                //     setState(() {
                //       selectedCity = selectedItem!;
                //     });
                //   },
                // ),

                // child: MyDropDown(
                //   hint: Strings.CITY,
                //   items: items,
                //   width: 340,
                //   height: 50,
                //   onChanged: (selectedItem) {
                //     print("City: $selectedCity");
                //     setState(() {
                //       selectedCity = selectedItem!;
                //     });
                //   },
                //   isOneTime: isOneTime,
                // ),
              ).animate().then(delay: 200.ms).slideX(),
                const SizedBox(height: 30),
                Center(
                  child: MyButton(
                    Textfontsize:16,
                    TextColors: Colors.white,
                    text: Strings.SINGUP_BUTTON_TEXT,
                    color: AppColors.secondaryColor,
                    width: 340,
                    height: 40,
                    onTap: () {
                      print("Nationality:${selectedNationality}");
                      if (dateInputController.text.isNotEmpty && gender.isNotEmpty && selectedNationality.isNotEmpty)
                      {
                        context.push('/signUpCountryScreen',extra: SignUpArgumentClass(
                          firsname: widget.signUpArgumentClass.firsname,
                          lastName: widget.signUpArgumentClass.lastName,
                          confirmPassword: widget.signUpArgumentClass.confirmPassword,
                          email: widget.signUpArgumentClass.email,
                          password: widget.signUpArgumentClass.password,
                          dob: dateInputController.text,
                          gender: genderSelected,
                          nationalityID: selectedNationality,
                        ));
                        BlocProvider.of<CountryBloc>(context).add(GetCountryEvent());
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
                ).animate().then(delay: 200.ms).slideX(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
