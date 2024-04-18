/// Password View/Hide
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_collect/src/constants/colors.dart';
import 'package:lets_collect/src/utils/screen_size/size_config.dart';

import '../../language.dart';
import '../bloc/language/language_bloc.dart';

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
    this.focusNode,
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
      // height: 55,
      child: TextFormField(
        style: GoogleFonts.openSans(
          color: AppColors.primaryGrayColor,
        ),
        enabled: widget.enable,
        inputFormatters: widget.inputFormatter,
        focusNode: widget.focusNode,
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        maxLines: widget.maxLines,
        obscureText: widget.obscureText && !_passwordVisible,
        validator: widget.validator,
        decoration: InputDecoration(
          border: InputBorder.none,
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
              color: AppColors.hintColor,
              fontWeight: FontWeight.w400,
              fontSize: 16),
          hintStyle: GoogleFonts.roboto(
              color: AppColors.hintColor,
              fontWeight: FontWeight.w400,
              fontSize: 16),
          contentPadding: EdgeInsets.only(
            left: context.read<LanguageBloc>().state.selectedLanguage ==
                    Language.english
                ? 15
                : 0,
            right: context.read<LanguageBloc>().state.selectedLanguage ==
                    Language.arabic
                ? 15
                : 0,
          ),
          fillColor: AppColors.primaryWhiteColor,
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
                            color: AppColors.hintColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 16),
                      ),
                    )
                  : null,
          suffixIcon: widget.obscureText
              ? IconButton(
                  icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
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
