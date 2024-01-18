import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lets_collect/app.dart';
import 'package:lets_collect/src/utils/data/object_factory.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp();
  // FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  // ConnectionStatusSingleton connectionStatus =
  // ConnectionStatusSingleton.getInstance();
  // connectionStatus.initialize();

  final SharedPreferences sharedPreferences =
  await SharedPreferences.getInstance();
  ObjectFactory().setPrefs(sharedPreferences);
//
//  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
//  if (Platform.isAndroid) {
//    androidInfo = await deviceInfo.androidInfo;
//    if (androidInfo != null) {
//      ObjectFactory().prefs.setPhoneModel(phoneModel: androidInfo.model);
//    }
//
//    print('Running on ${androidInfo.model}'); // e.g. "Moto G (4)"
//  } else {
//    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
//    print('Running on ${iosInfo.utsname.machine}');
//  }

  ///setting pref

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light));

  ///setting device orientation as portrait, then calling the runApp method
  SystemChrome.setPreferredOrientations(

      <DeviceOrientation>[DeviceOrientation.portraitUp]).then((_) {
    runApp(
     const App(),
    );
  });
}




