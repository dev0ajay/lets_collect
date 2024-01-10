import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:lets_collect/src/components/Custom_sliver_delegate.dart';
import 'package:lets_collect/src/components/Custome_Textfiled.dart';
import 'package:lets_collect/src/components/custome_dropdown.dart';
import 'package:lets_collect/src/components/date_picker.dart';
import 'package:lets_collect/src/components/my_button.dart';
import 'package:lets_collect/src/constants/colors.dart';
import 'package:lets_collect/src/constants/strings.dart';
import 'package:lets_collect/src/ui/profile/profile_screen.dart';
import 'package:lets_collect/src/utils/screen_size/size_config.dart';

class MyProfileScreen extends StatefulWidget {
  @override
  MyProfileScreenState createState() => MyProfileScreenState();
}

class MyProfileScreenState extends State<MyProfileScreen> {

  void _showDatePicker(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2050),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );

    if (pickedDate != null) {
      dateInputController.text = DateFormat('MM/dd/yyyy').format(pickedDate);
    }
  }


  FocusNode _countrynumber = FocusNode();

  String? validatePhoneNumber(String? value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value)) {
      return 'Enter phone number';
    } else {
      return null;
    }
  }

  TextEditingController dateInputController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController genderController = TextEditingController();


  FocusNode _firstname = FocusNode();
  FocusNode _secondname = FocusNode();
  FocusNode _email = FocusNode();
  FocusNode _phone = FocusNode();

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

  String selectedGender = "";

  final List<String> Gender = [
    "male",
    "female"
  ];

  String selectedNationality = "";

  final List<String> Nationality = [
    'Bahrain',
    'Saudi',
    'Omanis',
    'Qatari'

  ];

  String selectedDropdownItem = '';
  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];

  final List<String> item1 = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];
  String selectedCountry = "";
  String selectedCity = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverPersistentHeader(
              pinned: true,
              floating: true,
              delegate: CustomSliverDelegate(
                expandedHeight: 150,
                // shape: ContinuousRectangleBorder(
                //   borderRadius: BorderRadius.only(
                //     bottomLeft: Radius.circular(30),
                //     bottomRight: Radius.circular(30),
                //   ),
                // ),
              ),
            ),
            SliverPadding(
              sliver: SliverList(delegate: SliverChildListDelegate([
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(height: 30,),
                    Text("About You",style: TextStyle(color: AppColors.primaryBlackColor,fontSize: 20),),
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: [
                          Flexible(
                            child: MyTextField(
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
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Flexible(
                            child: MyTextField(
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
                          ),
                        ],
                      ),
                    ),
                    // SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 11),
                      child: DatePickerTextField(
                        controller: dateInputController,
                        hintText: "Date of Birth",
                        onDateIconTap: () {
                          _showDatePicker(context);
                        },
                      ),

                    ),

                    // SizedBox(height: getProportionateScreenHeight(5)),


                    Center(
                      child: CustomDropdown(
                        hintText: Strings.GENDER,
                        items: Gender,
                        width: 340,
                        height: 50,
                        onChanged: (selectedItem) {
                          setState(() {
                            print("Gender: $selectedGender");
                            selectedGender = selectedItem!;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(15)),

                    Center(
                      child: CustomDropdown(
                        hintText: Strings.NATIONALITY,
                        items: Nationality,
                        width: 340,
                        height: 50,
                        onChanged: (selectedItem) {
                          setState(() {
                            print("Nationality: $selectedNationality");
                            selectedNationality = selectedItem!;
                          });
                        },
                      ),
                    ),

                    SizedBox(height: getProportionateScreenHeight(15)),

                    Center(

                      child: CustomDropdown(
                        hintText: Strings.CITY,
                        items: item1,
                        width: 340,
                        height: 50,
                        onChanged: (selectedItem) {
                          print("City: $selectedCity");
                          setState(() {
                            selectedCity = selectedItem!;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(15)),


                    Center(

                      child: CustomDropdown(
                        hintText: Strings.COUNTRY,
                        items: items,
                        width: 340,
                        height: 50,
                        onChanged: (selectedItem) {
                          print("Country: $selectedCountry");
                          setState(() {
                            selectedCountry = selectedItem!;
                          });
                        },
                      ),

                    ),
                    SizedBox(height: 20,),
                    Text("Contact Info",style: TextStyle(color: AppColors.primaryBlackColor,fontSize: 20),),
                    SizedBox(height: 20,),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: MyTextField(
                        focusNode: _email,
                        // horizontal: 10,
                        hintText: Strings.SIGNUP_EMAIL_LABEL_TEXT,
                        obscureText: false,
                        maxLines: 1,
                        controller: emailController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          String? err = validatePhoneNumber(value);
                          if (err != null) {
                            _email.requestFocus();
                          }
                          return err;
                        },
                      ),
                    ),

                    SizedBox(height: getProportionateScreenHeight(15)),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: MyTextField(
                        focusNode: _phone,
                        // horizontal: 10,
                        hintText: Strings.PHONE_NUMBER,
                        obscureText: false,
                        maxLines: 1,
                        controller: phoneController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          String? err = validateLastname(value);
                          if (err != null) {
                            _phone.requestFocus();
                          }
                          return err;
                        },
                      ),
                    ),
                    SizedBox(height: 20,),


                    Center(
                      child: MyButton(
                        Textfontsize:16,
                        TextColors: Colors.white,
                        text: "save",
                        color: Colors.pink.shade400,
                        width: 340,
                        height: 40,
                        onTap: () {
                          if (dateInputController.text.isNotEmpty && selectedGender.isNotEmpty && selectedNationality.isNotEmpty)
                          {
                            Navigator.pop(
                                context,
                                MaterialPageRoute(builder: (BuildContext context) =>ProfileScreen()
                                ));
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
                    ),
                  ],
                ).animate().then(delay: 200.ms).slideX(),
              ]
              ),


              ),
              padding:
              EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 100),
            ),
          ],
        ),
      ),
    );
  }
}

