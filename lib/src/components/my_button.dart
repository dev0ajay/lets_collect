import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyButton extends StatelessWidget {
  final String text;
  final Color color;
  final double width;
  final double height;
  final VoidCallback ?onTap;
  final Color TextColors;
  final double Textfontsize;
  final bool showImage; // Add a property to control whether to show the image or not
  final String imagePath; // Provide the image path
  final double imagewidth;
  final double imageheight;

  const MyButton({
    Key? key,
    required this.text,
    required this.color,
    required this.width,
    required this.height,
    required this.onTap,
    required this.TextColors,
    required this.Textfontsize,
    required this.showImage,
    required this.imagePath,
    required this.imagewidth,
    required this.imageheight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        fixedSize: Size(width, height),
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        // Adjust width and height here
      ),
      child: OverflowBox(
        maxWidth: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (showImage)
              Image.asset(
                imagePath,
                width: imagewidth,
                height: imageheight,
                fit: BoxFit.cover,
              ),
            SizedBox(width: showImage ? 8 : 0),
            Text(
              text,
              style: GoogleFonts.roboto(
                color: TextColors,
                fontSize: Textfontsize,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      )


    );
  }
}
