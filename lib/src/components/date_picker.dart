import 'package:flutter/material.dart';

class DatePickerTextField extends StatelessWidget {
  final TextEditingController controller;
  final void Function() onDateIconTap;
  String hintText;

   DatePickerTextField({
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
        decoration: InputDecoration(
          hintText: hintText,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(color: Colors.black),
          ),
          fillColor: Colors.white,
          filled: true,
          contentPadding: const EdgeInsets.all(8),
          suffixIcon: GestureDetector(
            onTap: onDateIconTap,
            child: const Icon(
              Icons.calendar_today,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
