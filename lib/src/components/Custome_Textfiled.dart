/// Password View/Hide


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_collect/src/constants/colors.dart';
import 'package:lets_collect/src/utils/screen_size/size_config.dart';

class MyTextField extends StatefulWidget {
  final String hintText;
  final FocusNode? focusNode;
  final keyboardType;
  final bool obscureText;
  final int maxLines;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? prefixText;
  final IconData? prefixIcon;

  const MyTextField({
    Key? key,
    required this.hintText,
    required this.obscureText,
    required this.maxLines,
    required this.controller,
    this.validator,
    required this.keyboardType,
    required this.focusNode,
    this.prefixText,
    this.prefixIcon,
  }) : super(key: key);

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
   bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SizedBox(
      height: getProportionateScreenHeight(55),
      child: TextFormField(
        focusNode: widget.focusNode,
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        maxLines: widget.maxLines,
        obscureText: widget.obscureText && !_passwordVisible,
        validator: widget.validator,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(color: AppColors.borderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: const BorderSide(color: AppColors.borderColor),

          ),
          hintText: widget.hintText,
          hintStyle: GoogleFonts.openSans(
              color: Colors.grey, fontWeight: FontWeight.normal),
          contentPadding: const EdgeInsets.all(15),
          fillColor: Colors.white,
          filled: true,
          prefixIcon: widget.prefixIcon != null
              ? Icon(widget.prefixIcon)
              : widget.prefixText != null
              ? Container(
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                right: BorderSide(
                  color: AppColors.borderColor,
                  width: 1.0,
                ),
              ),
            ),
            child: Text(
              widget.prefixText!,
              style: const TextStyle(color: Colors.grey),
            ),
          )
              : null,
          suffixIcon: widget.obscureText
              ? IconButton(
            icon: Icon(
              _passwordVisible
                  ? Icons.visibility
                  : Icons.visibility_off,
              color: AppColors.primaryGrayColor,
            ),
            onPressed: () {
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
          )
              : null,
        ),
      ),
    );
  }
}
