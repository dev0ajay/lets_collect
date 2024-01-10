import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  const CustomDropdown({
    Key? key,
    required this.hintText,
    required this.items,
    required this.width,
    required this.height,
    required this.onChanged,
  }) : super(key: key);

  final String hintText;
  final List<String> items;
  final double width;
  final double height;
  final void Function(String?) onChanged;

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(

        isExpanded: true,
        hint: Row(
          children: [
            Expanded(
              child: Text(
                widget.hintText,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        items: widget.items
            .map((String item) => DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
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
            widget.onChanged(selectedValue);
          });
        },
        buttonStyleData: ButtonStyleData(
          height: widget.height,
          width: widget.width,
          padding: const EdgeInsets.only(left: 14, right: 14),
          decoration: BoxDecoration(
            boxShadow:  [
              // BoxShadow(
              //   color: Colors.grey.shade600,
              //   blurRadius: 1.0, // soften the shadow
              //   spreadRadius: 0.0, //extend the shadow
              //   offset: const Offset(
              //     1.0, // Move to right 10  horizontally
              //     1.0, // Move to bottom 10 Vertically
              //   ),
              // ),
              BoxShadow(
                color: Colors.grey,
                // blurRadius: 1.0, // soften the shadow
                // spreadRadius: 0.0, //extend the shadow
                // offset: const Offset(
                //   -1.0, // Move to right 10  horizontally
                //   -1.0, // Move to bottom 10 Vertically
                // ),
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
          iconEnabledColor: Colors.pink,
          iconDisabledColor: Colors.black,
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
            thickness: MaterialStateProperty.all<double>(6),
            thumbVisibility: MaterialStateProperty.all<bool>(true),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
          padding: EdgeInsets.only(left: 14, right: 14),
        ),
      ),
    );
  }
}
