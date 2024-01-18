import 'package:flutter/material.dart';

class CustomRoundedButton extends StatelessWidget {
  final bool enabled;

  const CustomRoundedButton({
    Key? key,
    required this.enabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: enabled
            ? const Border(
          bottom: BorderSide(color: Colors.red, width: 5, style: BorderStyle.solid),
          top: BorderSide(color: Colors.red, width: 5, style: BorderStyle.solid),
          left: BorderSide(color: Colors.red, width: 5, style: BorderStyle.solid),
          right: BorderSide(color: Colors.red, width: 5, style: BorderStyle.solid),
        )
            : Border.all(
          color: Colors.black,
          width: 2.0,
        ),
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      width: 20,
      height: 20,
    );
  }
}
