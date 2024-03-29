/// Password View/Hide


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_collect/src/constants/colors.dart';
import 'package:lets_collect/src/utils/screen_size/size_config.dart';

class MyTextField extends StatefulWidget {
   String? hintText;
  final FocusNode? focusNode;
  final keyboardType;
  final bool obscureText;
   bool? enable;
  final int maxLines;
   TextEditingController? controller;
  final String? Function(String?)? validator;
  final String? prefixText;
  final IconData? prefixIcon;
  final List<TextInputFormatter>? inputFormatter;

   MyTextField({
    super.key,
     this.hintText,
    required this.obscureText,
    required this.maxLines,
     this.controller,
    this.validator,
    required this.keyboardType,
    required this.focusNode,
    this.prefixText,
    this.prefixIcon,
    this.inputFormatter,
     this.enable,
  });

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
   bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SizedBox(
      // height: getProportionateScreenHeight(55),
      child: TextFormField(
        enabled: widget.enable,
        inputFormatters: widget.inputFormatter,
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
          labelStyle: GoogleFonts.roboto(
              color: AppColors.hintColor, fontWeight: FontWeight.w400,fontSize: 16),
          hintStyle: GoogleFonts.roboto(
              color: AppColors.hintColor, fontWeight: FontWeight.w400,fontSize: 16),
          contentPadding: const EdgeInsets.all(15),
          fillColor: Colors.white,
          filled: true,
          prefixIcon: widget.prefixIcon != null
              ? Icon(widget.prefixIcon)
              : widget.prefixText != null
              ? Container(
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
              color: AppColors.primaryWhiteColor,
              border: Border(
                right: BorderSide(
                  color: AppColors.borderColor,
                  width: 1.0,
                ),
              ),
            ),
            child: Text(
              widget.prefixText!,
              style: GoogleFonts.roboto(
                  color: AppColors.hintColor, fontWeight: FontWeight.w400,fontSize: 16),
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
