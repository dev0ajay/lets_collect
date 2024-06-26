import 'package:flutter/material.dart';

class Assets {
  Assets._();

  // splash screen assets
  static const String SPLASH_LOGO = 'assets/png_icons/splash_logo.png';

  // Localization icon assets

  static const AssetGenImage english = AssetGenImage('assets/png_icons/usa_flag.png');
  static const AssetGenImage arabic = AssetGenImage('assets/png_icons/bahrain_flag.png');

  // login screen assets

  static const String APP_LOGO = 'assets/png_icons/logo.png';
  static const String CALENDER = 'assets/png_icons/calender.png';
  static const String DOWN_ARROWN = 'assets/png_icons/down arrow.png';
  static const String FACEBOOK = 'assets/png_icons/facebook.png';
  static const String GOOGLE = 'assets/png_icons/google.png';
  static const String LOCK = 'assets/png_icons/lock.png';
  static const String MAIL = 'assets/png_icons/mail.png';
  static const String TICK = 'assets/png_icons/tick icon.png';
  static const String DISABLED_TICK = 'assets/png_icons/disabled_tick.png';
  static const String SIDE_ARROW = 'assets/png_icons/side_arrow.png';
  static const String DOWN_ARROW = 'assets/png_icons/down arrow.png';
  static const String NO_IMAGE = 'assets/png_icons/noImage.jpg';
  static const String NO_IMG = 'assets/png_icons/no_image.png';
  static const String APPLE_LOGO = 'assets/png_icons/apple.png';



  ///Lottie
  static const String SELECT_CITY_LOTTIE = 'assets/lottie/selectCity.json';
  static const String JUMBINGDOT = 'assets/lottie/jumbingdot.json';
  static const String OTP = 'assets/lottie/otp.json';
  static const String RESET = 'assets/lottie/reset_password.json';
  static const String NO_INTERNET = 'assets/lottie/nonetwork.json';
  static const String NO_DATA = 'assets/lottie/no_data.json';
  static const String OOPS = 'assets/lottie/oops.json';
  static const String TRY_AGAIN = 'assets/lottie/error.json';
  static const String SCANING = 'assets/lottie/scan.json';
  static const String CHOOSE = 'assets/lottie/choose.json';
  static const String SOON = 'assets/lottie/soon.json';


  ///SVG
  static const String HELP_SVG = 'assets/svg/help_svg.svg';
  static const String CONTAINER_SVG = 'assets/svg/container.svg';
  static const String SORT_SVG = 'assets/svg/sort.svg';
  static const String FILTER_SVG = 'assets/svg/filter.svg';
  static const String NOTIFICATION_SVG = 'assets/svg/notification.svg';
  static const String MAIL_SVG = 'assets/svg/msg.svg';
  static const String CONTACT_US_SVG = 'assets/svg/message_icon.svg';
  static const String SHADE_SVG = 'assets/svg/shade.svg';
  static const String HOME_SVG = 'assets/svg/home.svg';
  static const String REWARD_SVG = 'assets/svg/reward.svg';
  static const String SEARCH_SVG = 'assets/svg/search.svg';
  static const String PROFILE_SVG = 'assets/svg/profile.svg';
  static const String SCAN_SVG = 'assets/svg/scan.svg';
  static const String CAM_SVG = 'assets/svg/cam.svg';
  static const String UPLOAD_SVG = 'assets/svg/upload.svg';


  ///General
  static const String UPLOAD = 'assets/png_icons/upload.png';
  static const String SCANNER = 'assets/png_icons/scanner.png';
  static const String NOTI = 'assets/png_icons/app_icon_android.png';



  ///home screen
  static const String WALLET = 'assets/png_icons/wallet.png';
  static const String SCAN = 'assets/png_icons/scan_img.png';
  static const String HOME = 'assets/png_icons/home.png';
  static const String REWARD = 'assets/png_icons/gift.png';
  static const String PROFILE = 'assets/png_icons/user.png';
  static const String SEARCH = 'assets/png_icons/search.png';
  static const String SCAN_ICON = 'assets/png_icons/cam_scan.png';
  static const String GIFT_ICON = 'assets/png_icons/gift_icon.png';

///Profile Screen
  static const String HELP = 'assets/png_icons/help.png';
  static const String CANCEL = 'assets/png_icons/cancel.png';




}
class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider() => AssetImage(_assetName);

  String get path => _assetName;

  String get keyName => _assetName;
}