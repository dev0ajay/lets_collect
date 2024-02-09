/// Updated Date Picker

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constants/assets.dart';
import '../../constants/colors.dart';

class DatePickerWidget extends StatefulWidget {
  final TextEditingController dateController;
  const DatePickerWidget({super.key, required this.dateController});

  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  final TextEditingController dateInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return
      GestureDetector(
      onTap: () {
        _showDatePicker(context);
      },
      child: AbsorbPointer(
        child: TextFormField(
          controller: widget.dateController,
          decoration: InputDecoration(
            hintText: "Date of Birth",
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: const BorderSide(color: AppColors.borderColor),
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
                child: const ImageIcon(AssetImage(Assets.CALENDER),color: AppColors.secondaryColor,)
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showDatePicker(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2050),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );

    if (pickedDate != null) {
      widget.dateController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
    }
  }
}
