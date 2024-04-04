import 'dart:ui';

import 'package:lets_collect/src/constants/assets.dart';

enum Language {
  english(
    Locale('en', 'US'),
    Assets.english,
    'english',
  ),
  arabic(
    Locale('ar', 'ar_AE'),
    Assets.arabic,
    'arabic',
  );

  const Language(this.value, this.image, this.text);

  final Locale value;
  final AssetGenImage image;
  final String text;
}