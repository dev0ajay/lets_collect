import 'dart:ui';

import 'package:lets_collect/src/constants/assets.dart';

enum Language {
  english(
    Locale('en', 'US'),
    Assets.english,
    'en',
  ),
  arabic(
    Locale('ar', 'ar_AE'),
    Assets.arabic,
    'ar',
  );

  const Language(this.value, this.image, this.text);

  final Locale value;
  final AssetGenImage image;
  final String text;
}