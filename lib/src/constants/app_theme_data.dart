import 'package:flutter/material.dart';
import 'colors.dart';

class AppTheme {
  AppTheme._();

//  static Color _iconColor = Color(0xFF72C2A6);

  static const Color _lightPrimaryColor = Colors.black;
  static const Color _lightPrimaryVariantColor = Color(0xFFF4F4F4);

  // static const Color _lightPrimaryVariantColor = Color(0xFFFFFFFF);
  static const Color _lightAccentColor = Color(0xFF787676);

  // static const Color _lightSecondaryColor = Color(0xFF72C2A6);
  static const Color _lightOnPrimaryColor = Color(0xFF787676);
  static const Color _lightPrimarySwatch = Color(0xFF111C3E);

  static const Color _darkPrimaryColor = Colors.white24;
  static const Color _darkPrimaryVariantColor = Colors.black;
  static const Color _darkSecondaryColor = Colors.white;
  static const Color _darkOnPrimaryColor = Colors.white;

  static final ThemeData lightTheme = ThemeData(
    cardTheme: const CardTheme(color: AppColors.primaryWhiteColor),
    fontFamily: "Fonarto",
    visualDensity: VisualDensity.adaptivePlatformDensity,
    useMaterial3: false,
    // primaryColor: _lightPrimarySwatch,
    // scaffoldBackgroundColor: _lightPrimaryVariantColor,

    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 72,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: TextStyle(
          // fontSize: 72,
          // fontWeight: FontWeight.bold,

          ),
      displaySmall: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        color: AppColors.secondaryColor

          ),
    ),


    // ···

    // iconTheme: IconThemeData(
    //   color: _iconColor,
    // ),
    // textTheme: _lightTextTheme,
    // fontFamily: FontFamily.sfProDisplay, textSelectionTheme: TextSelectionThemeData(cursorColor: _iconColor),
  );

// static final ThemeData darkTheme = ThemeData(
//   scaffoldBackgroundColor: _lightPrimaryVariantColor,
//   // appBarTheme: const AppBarTheme(
//   //   color: _darkPrimaryVariantColor,
//   //   iconTheme: IconThemeData(color: _darkOnPrimaryColor),
//   // ),
//   colorScheme: const ColorScheme.light(
//     primary: _darkPrimaryColor,
//     secondary: _darkSecondaryColor,
//     onPrimary: _darkOnPrimaryColor,
//   ),
//   iconTheme: IconThemeData(
//     color: _iconColor,
//   ),
//   // textTheme: _darkTextTheme,
//   // fontFamily: FontFamily.sfProDisplay,
// );

// static final TextTheme _lightTextTheme = TextTheme(
//     headline1: _lightScreenHeading1TextStyle,
//     headline2: _lightScreenHeading2TextStyle,
//     headline3: _lightScreenHeading3TextStyle,
//     headline4: _lightScreenHeading4TextStyle,
//     headline5: _lightScreenHeading5TextStyle,
//     headline6: _lightScreenHeading6TextStyle,
//     subtitle1: _lightScreenSubTitle1TextStyle,
//     subtitle2: _lightScreenSubTitle2TextStyle,
//     bodyText1: _lightScreenBody1TextStyle,
//     bodyText2: _lightScreenBody2TextStyle,
//     button: _lightScreenButtonTextStyle,
//     caption: _lightScreenCaptionTextStyle,
//     overline: _lightScreenOverLineTextStyle);

// static final TextTheme _darkTextTheme = TextTheme(
//   headline1: _darkScreenHeading1TextStyle,
//   headline2: _darkScreenHeading2TextStyle,
//   headline3: _darkScreenHeading3TextStyle,
//   headline4: _darkScreenHeading4TextStyle,
//   headline5: _darkScreenHeading5TextStyle,
//   headline6: _darkScreenHeading6TextStyle,
//   subtitle1: _darkScreenSubTitle1TextStyle,
//   subtitle2: _darkScreenSubTitle2TextStyle,
//   bodyText1: _darkScreenBody1TextStyle,
//   bodyText2: _darkScreenBody2TextStyle,
//   button: _darkScreenButtonTextStyle,
//   caption: _darkScreenCaptionTextStyle,
//   overline: _darkScreenOverLineTextStyle,
// );

// static final TextStyle _lightScreenHeading1TextStyle = TextStyle(
//     fontSize: 96.0,
//     color: _lightOnPrimaryColor,
//     letterSpacing: -1.5,
//     fontWeight: FontWeight.w300);
// static final TextStyle _lightScreenHeading2TextStyle = TextStyle(
//     fontSize: 60.0,
//     color: _lightOnPrimaryColor,
//     letterSpacing: -0.5,
//     fontWeight: FontWeight.w300);
// static final TextStyle _lightScreenHeading3TextStyle = TextStyle(
//     fontSize: 48.0,
//     color: _lightOnPrimaryColor,
//     letterSpacing: 0.0,
//     fontWeight: FontWeight.w700);
// static final TextStyle _lightScreenHeading4TextStyle = TextStyle(
//     fontSize: 34.0,
//     color: _lightOnPrimaryColor,
//     letterSpacing: 0.25,
//     fontWeight: FontWeight.w400);
// static final TextStyle _lightScreenHeading5TextStyle = TextStyle(
//     fontSize: 24.0,
//     color: _lightOnPrimaryColor,
//     letterSpacing: 0.0,
//     fontWeight: FontWeight.w400);
// static final TextStyle _lightScreenHeading6TextStyle = TextStyle(
//     fontSize: 20.0,
//     color: _lightOnPrimaryColor,
//     letterSpacing: 0.15,
//     fontWeight: FontWeight.w500);
// static final TextStyle _lightScreenSubTitle1TextStyle = TextStyle(
//     fontSize: 16.0,
//     color: _lightOnPrimaryColor,
//     letterSpacing: 0.15,
//     fontWeight: FontWeight.w400);
// static final TextStyle _lightScreenSubTitle2TextStyle = TextStyle(
//     fontSize: 14.0,
//     color: _lightOnPrimaryColor,
//     letterSpacing: 0.1,
//     fontWeight: FontWeight.w500);
// static final TextStyle _lightScreenBody1TextStyle = TextStyle(
//     fontSize: 16.0,
//     color: _lightOnPrimaryColor,
//     letterSpacing: 0.5,
//     fontWeight: FontWeight.w400);
// static final TextStyle _lightScreenBody2TextStyle = TextStyle(
//     fontSize: 14.0,
//     color: _lightOnPrimaryColor,
//     letterSpacing: 0.25,
//     fontWeight: FontWeight.w400);
// static final TextStyle _lightScreenButtonTextStyle = TextStyle(
//     fontSize: 14.0,
//     color: Colors.white,
//     letterSpacing: 1.25,
//     fontWeight: FontWeight.w500);
// static final TextStyle _lightScreenCaptionTextStyle = TextStyle(
//     fontSize: 12.0,
//     color: _lightOnPrimaryColor,
//     letterSpacing: 0.4,
//     fontWeight: FontWeight.w400);
// static final TextStyle _lightScreenOverLineTextStyle = TextStyle(
//     fontSize: 10.0,
//     color: _lightOnPrimaryColor,
//     letterSpacing: 1.5,
//     fontWeight: FontWeight.w400);

//   static final TextStyle _darkScreenHeading1TextStyle =
//   _lightScreenHeading1TextStyle.copyWith(color: _darkOnPrimaryColor);
//   static final TextStyle _darkScreenHeading2TextStyle =
//   _lightScreenHeading2TextStyle.copyWith(color: _darkOnPrimaryColor);
//   static final TextStyle _darkScreenHeading3TextStyle =
//   _lightScreenHeading3TextStyle.copyWith(color: _darkOnPrimaryColor);
//   static final TextStyle _darkScreenHeading4TextStyle =
//   _lightScreenHeading4TextStyle.copyWith(color: _darkOnPrimaryColor);
//   static final TextStyle _darkScreenHeading5TextStyle =
//   _lightScreenHeading5TextStyle.copyWith(color: _darkOnPrimaryColor);
//   static final TextStyle _darkScreenHeading6TextStyle =
//   _lightScreenHeading6TextStyle.copyWith(color: _darkOnPrimaryColor);
//   static final TextStyle _darkScreenSubTitle1TextStyle =
//   _lightScreenSubTitle1TextStyle.copyWith(color: _darkOnPrimaryColor);
//   static final TextStyle _darkScreenSubTitle2TextStyle =
//   _lightScreenSubTitle2TextStyle.copyWith(color: _darkOnPrimaryColor);
//   static final TextStyle _darkScreenBody1TextStyle =
//   _lightScreenBody1TextStyle.copyWith(color: _darkOnPrimaryColor);
//   static final TextStyle _darkScreenBody2TextStyle =
//   _lightScreenBody2TextStyle.copyWith(color: _darkOnPrimaryColor);
//   static final TextStyle _darkScreenButtonTextStyle =
//   _lightScreenButtonTextStyle.copyWith(color: _darkOnPrimaryColor);
//   static final TextStyle _darkScreenCaptionTextStyle =
//   _lightScreenCaptionTextStyle.copyWith(color: _darkOnPrimaryColor);
//   static final TextStyle _darkScreenOverLineTextStyle =
//   _lightScreenOverLineTextStyle.copyWith(color: _darkOnPrimaryColor);
}
