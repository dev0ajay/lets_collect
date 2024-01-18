import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lets_collect/src/components/Custome_Textfiled.dart';
import 'package:lets_collect/src/components/custome_dropdown.dart';
import 'package:lets_collect/src/components/my_button.dart';
import 'package:lets_collect/src/constants/colors.dart';
import 'package:lets_collect/src/constants/strings.dart';
import 'package:lets_collect/src/utils/data/object_factory.dart';
import 'package:lets_collect/src/utils/screen_size/size_config.dart';

class MyProfileScreen extends StatefulWidget {

  const MyProfileScreen({super.key});

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
              ),
            ),
            SliverPadding(
              sliver: SliverList(delegate: SliverChildListDelegate([
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(height: 30,),
                     Text("About You",style: GoogleFonts.openSans(
                      color: AppColors.primaryBlackColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 11),
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
                          const SizedBox(
                            width: 20
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

                    ),

                    // SizedBox(height: getProportionateScreenHeight(5)),


                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 11),
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
                    ),
                    const SizedBox(height: 15),

                    Center(
                      child: Padding(
                        padding:  const EdgeInsets.symmetric(horizontal: 11),
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
                    ),

                    SizedBox(height: getProportionateScreenHeight(15)),

                    Center(

                      child: Padding(
                        padding:  const EdgeInsets.symmetric(horizontal: 11),
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
                    ),
                    SizedBox(height: getProportionateScreenHeight(15)),


                    Center(

                      child: Padding(
                        padding:  const EdgeInsets.symmetric(horizontal: 11),
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

                    ),
                    const SizedBox(height: 20),
                     Text("Contact Info",style: GoogleFonts.openSans(
                       color: AppColors.primaryBlackColor,
                       fontSize: 20,
                       fontWeight: FontWeight.w700,
                     ),
                    ),
                    const SizedBox(height: 20),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 11),
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

                    const SizedBox(height: 15),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 11),
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
                    const SizedBox(height: 20),


                    Center(
                      child: MyButton(
                        Textfontsize:16,
                        TextColors: Colors.white,
                        text: "save",
                        color: AppColors.secondaryColor,
                        width: 340,
                        height: 40,
                        onTap: () {
                          if (dateInputController.text.isNotEmpty && selectedGender.isNotEmpty && selectedNationality.isNotEmpty)
                          {
                           context.pop();
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
              const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 30),
            ),
          ],
        ),
      ),
    );
  }
}


class DatePickerTextField extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return AbsorbPointer(
      child: TextFormField(
        controller: controller,
        style: GoogleFonts.openSans(
          color: AppColors.primaryBlackColor,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.openSans(
            color: AppColors.hintColor,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide:  const BorderSide(width: 1, color: Color(0xFFE6ECFF)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(color: AppColors.primaryColor2),
          ),
          fillColor: Colors.white,
          filled: true,
          contentPadding: const EdgeInsets.only(left: 15,right: 8,top: 8,bottom: 8),
          suffixIcon: GestureDetector(
            onTap: onDateIconTap,
            child: const Icon(
              Icons.calendar_today,
              color: AppColors.secondaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
class CustomSliverDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final bool hideTitleWhenExpanded;


  CustomSliverDelegate( {
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
            backgroundColor: Colors.transparent, // Set the AppBar background color to transparent
            leading: IconButton(
              icon: GestureDetector(
                  onTap:(){
                    context.pop();
                    print("MyProfile tapped!");
                  },
                  child: const Icon(Icons.cancel_outlined,color: AppColors.primaryWhiteColor,)),
              onPressed: () {},
            ),
            elevation: 0.0,
            title: Opacity(
              opacity: hideTitleWhenExpanded ? 1.0 - percent : 1.0,
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 5,
                    child: Text(
                      ObjectFactory().prefs.getUserName() ?? "",
                      style: GoogleFonts.openSans(
                         fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.secondaryColor,
                      ),
                    ),
                  ),
                  // SizedBox(width: 8), // Adjust the spacing as needed
                  const Expanded(
                    flex: 1,
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 20,
                      backgroundImage: NetworkImage(
                        "https://s3-alpha-sig.figma.com/img/d067/c913/ad868d019f92ce267e6de23af3413e5b?Expires=1706486400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=BTjjS~v0e0x44jHIWuKYMNaWYXlHG7EN3Yjq111uXWjvGWD0oPTpDDuaPCAtTv9cdqXNKlztZmY35PSEAiUohNuYoaQDt-ZI5pG5QleefSvEir~3854~O8EEXI1aGpmu5ciF9KdwvmZwK3WYpf8S150xkDq7v94NndSusDG2VpkUYejPJUr4C~qM2vO0g7lNJ33W5-bMNoCyWpW128kmLdDk36~oAJxjrLK0Vhg88eJ1ORr-A5yVpKrJaIHxw2DXQrlWbtpZvmfc4HWh09tN7Lz70hYnd8Fk4NN6UpXLiHv0DNeRp6-W3NNaRRJTpJx70RUXbcI38u4jGr9Ahd69ew__"
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
                             ObjectFactory().prefs.getUserName() ?? "",
                            style: GoogleFonts.openSans(
                              fontSize: 21,
                              fontWeight: FontWeight.w700,
                              color: AppColors.secondaryColor,
                            ),
                          ),
                          const SizedBox(height: 10),
                          GestureDetector(
                              child:  Text("Change Password",
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
                    const Expanded(
                      flex: 3,
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 50,
                        backgroundImage: NetworkImage(
                          "https://s3-alpha-sig.figma.com/img/d067/c913/ad868d019f92ce267e6de23af3413e5b?Expires=1706486400&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=BTjjS~v0e0x44jHIWuKYMNaWYXlHG7EN3Yjq111uXWjvGWD0oPTpDDuaPCAtTv9cdqXNKlztZmY35PSEAiUohNuYoaQDt-ZI5pG5QleefSvEir~3854~O8EEXI1aGpmu5ciF9KdwvmZwK3WYpf8S150xkDq7v94NndSusDG2VpkUYejPJUr4C~qM2vO0g7lNJ33W5-bMNoCyWpW128kmLdDk36~oAJxjrLK0Vhg88eJ1ORr-A5yVpKrJaIHxw2DXQrlWbtpZvmfc4HWh09tN7Lz70hYnd8Fk4NN6UpXLiHv0DNeRp6-W3NNaRRJTpJx70RUXbcI38u4jGr9Ahd69ew__"
                        ),
                      ),
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
