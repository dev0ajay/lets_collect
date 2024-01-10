import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final FocusNode? focusNode;
  final keyboardType;
  final bool obscureText;
  final int maxLines;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  // Added prefix text and icon
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
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(color: Colors.black), // Set the focused border color
        ),
        hintText: hintText,
        hintStyle: GoogleFonts.openSans(color: Colors.grey, fontWeight: FontWeight.normal),
        contentPadding: const EdgeInsets.all(15),
        fillColor: Colors.white,
        filled: true,

        // Added prefix
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon)
            : prefixText != null
            ? Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              right: BorderSide(
                color: Colors.grey, // Set the border color
                width: 1.0, // Set the border width
              ),
            ),
          ),
          child: Text(
            prefixText!,
            style: TextStyle(color: Colors.grey),
          ),
        )
            : null,
      ),
    );
  }
}
