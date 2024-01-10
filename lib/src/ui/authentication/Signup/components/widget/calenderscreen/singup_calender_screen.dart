import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lets_collect/src/components/custome_dropdown.dart';
import 'package:lets_collect/src/components/date_picker.dart';
import 'package:lets_collect/src/components/my_button.dart';
import 'package:lets_collect/src/constants/assets.dart';
import 'package:lets_collect/src/constants/colors.dart';
import 'package:lets_collect/src/constants/strings.dart';
import 'package:lets_collect/src/ui/authentication/Signup/components/widget/firstscreen/sign_up_argument_class.dart';
import '../countryscreen/signup_country_screen.dart';

class SignupCalenderScreen extends StatefulWidget {
 final SignUpArgumentClass signUpArgumentClass;

   const SignupCalenderScreen({Key? key,required this.signUpArgumentClass}) : super(key: key);


  @override
  State<SignupCalenderScreen> createState() => _SignupCalenderScreenState();
}

class _SignupCalenderScreenState extends State<SignupCalenderScreen> {

  String selectedNationality = "";
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
    "GCC"
  ];

  @override
  void initState() {
    // TODO: implement initState

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
                     Text(
                      Strings.WELOCOM,
                      style: GoogleFonts.openSans(
                        color: AppColors.primaryWhiteColor,
                        fontSize: 24,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "${widget.signUpArgumentClass.firsname } ${widget.signUpArgumentClass.lastName} !",
                      style: GoogleFonts.openSans(
                        color: AppColors.secondaryButtonColor,
                        fontSize: 24,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ).animate().then(delay: 200.ms).slideX(),
                const SizedBox(
                  height: 20,
                ),
                 Center(
                  child: Text(
                    Strings.DISCRIPTION,
                    style: GoogleFonts.openSans(
                      color: AppColors.primaryWhiteColor,
                      fontSize: 15,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ).animate().then(delay: 200.ms).slideX(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: DatePickerTextField(
                    controller: dateInputController,
                    hintText: "Date of Birth",
                    onDateIconTap: () {
                      _showDatePicker(context);
                    },
                  ),

                ).animate().then(delay: 200.ms).slideX(),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.only(left: 27),
                  child:  Text(
                    Strings.GENDER,
                    style: GoogleFonts.roboto(
                      color: AppColors.primaryWhiteColor,
                      fontSize: 16,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                    ),
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
                      activeColor: Colors.pink,
                      fillColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                        if (states.contains(MaterialState.selected)) {
                          return Colors.pink;
                        }
                        return Colors.white;
                      }),
                    ),
                     Text("Female",
                      style: GoogleFonts.roboto(
                      color: AppColors.primaryWhiteColor,
                      fontSize: 16,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                    ),
                    ),
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
                      activeColor: Colors.pink,
                      fillColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                        if (states.contains(MaterialState.selected)) {
                          return Colors.pink;
                        }
                        return Colors.white;
                      }),
                    ),
                     Text("Male",
                      style:GoogleFonts.roboto(
                      color: AppColors.primaryWhiteColor,
                      fontSize: 16,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                    ),),
                  ],
                ).animate().then(delay: 200.ms).slideX(),
                const SizedBox(height: 30),
                Center(
                  child: CustomDropdown(
                      hintText: Strings.NATIONALITY,
                      items: items,
                      width: 340,
                      height: 50,
                    onChanged: (selectedItem) {
                      setState(() {
                        print("Nationality: $selectedNationality");
                        selectedNationality = selectedItem!;
                      });
                    },
                  ),
                ).animate().then(delay: 200.ms).slideX(),
                const SizedBox(height: 30),
                Center(
                  child: MyButton(
                    Textfontsize:16,
                    TextColors: Colors.white,
                    text: Strings.SINGUP_BUTTON_TEXT,
                    color: Colors.pink.shade400,
                    width: 340,
                    height: 40,
                    onTap: () {
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
                        ));
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) =>  NumbereverificationScreen(
                        //       firstname: widget.firstname,
                        //       lastname: widget.lastname,
                        //       email: widget.email,
                        //       password: widget.password,
                        //     ),
                        //   ),
                        // );
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
