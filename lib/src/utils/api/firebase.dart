import 'dart:io';
import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:overlay_support/overlay_support.dart';

import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../model/notification/push_notification_model.dart';
import '../data/object_factory.dart';

class NotificationServices {
  //initialising firebase message plugin
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  PushNotification? _notificationInfo;

  //initialising firebase message plugin
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  //function to initialise flutter local notification plugin to show notifications for android when app is active
  void initLocalNotifications(
      BuildContext context, RemoteMessage message) async {
    var androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/ic_stat_logo');
    var iosInitializationSettings = const DarwinInitializationSettings();

    var initializationSetting = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);

    await _flutterLocalNotificationsPlugin.initialize(initializationSetting,
        onDidReceiveNotificationResponse: (payload) {
      // handle interaction when app is active for android
      handleMessage(context, message);
    });
  }

  void firebaseInit(BuildContext context) async {
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (kDebugMode) {
        print("notifications title:${notification!.title}");
        print("notifications body:${notification.body}");
        print('count:${android!.count}');
        print('data:${message.data.toString()}');
      }
      // Parse the message received
      PushNotification pushNotification = PushNotification(
        title: message.notification?.title,
        body: message.notification?.body,
        dataTitle: message.data['title'],
        dataBody: message.data['body'],
      );

      if (Platform.isIOS) {
        initLocalNotifications(context, message);
        showNotification(message);
        ///Overlay for notification
        // _notificationInfo = pushNotification;
        // if (_notificationInfo != null) {
        //   /// For displaying the notification as an overlay
        //   showOverlayNotification(
        //         (context) {
        //       return Card(
        //         margin: const EdgeInsets.symmetric(horizontal: 4),
        //         child: SafeArea(
        //           child: ListTile(
        //             leading: SizedBox.fromSize(
        //               size: const Size(40, 40),
        //               child: ClipOval(
        //                 child: Container(
        //                   // color: AppColors.primaryGrayColor,
        //                   decoration: const BoxDecoration(
        //                       image: DecorationImage(image: AssetImage(Assets.NOTI),fit: BoxFit.contain)
        //                   ),
        //                 ),
        //               ),
        //             ),
        //             title: Text(_notificationInfo!.title!),
        //             subtitle: Text(_notificationInfo!.body!),
        //             trailing: InkWell(
        //               child: const Text(
        //                 "Dismiss",
        //                 style: TextStyle(color: AppColors.secondaryColor),
        //               ),
        //               onTap: () {
        //                 OverlaySupportEntry.of(context)!.dismiss();
        //               },
        //             ),
        //           ),
        //         ),
        //       );
        //     },
        //     duration: const Duration(milliseconds: 4000),
        //   );
        // }
      }

      if (Platform.isAndroid) {
        initLocalNotifications(context, message);
        showNotification(message);
      }
      ///Overlay for notification
      // _notificationInfo = pushNotification;
      // if (_notificationInfo != null) {
      //   /// For displaying the notification as an overlay
      //   showOverlayNotification(
      //         (context) {
      //       return Card(
      //         margin: const EdgeInsets.symmetric(horizontal: 4),
      //         child: SafeArea(
      //           child: ListTile(
      //             leading: SizedBox.fromSize(
      //               size: const Size(40, 40),
      //               child: ClipOval(
      //                 child: Container(
      //                   // color: AppColors.primaryGrayColor,
      //                   decoration: const BoxDecoration(
      //                       image: DecorationImage(image: AssetImage(Assets.NOTI),fit: BoxFit.contain)
      //                   ),
      //                 ),
      //               ),
      //             ),
      //             title: Text(_notificationInfo!.title!),
      //             subtitle: Text(_notificationInfo!.body!),
      //             trailing: InkWell(
      //               child: const Text(
      //                 "Dismiss",
      //                 style: TextStyle(color: AppColors.secondaryColor),
      //               ),
      //               onTap: () {
      //                 OverlaySupportEntry.of(context)!.dismiss();
      //               },
      //             ),
      //           ),
      //         ),
      //       );
      //     },
      //     duration: const Duration(milliseconds: 4000),
      //   );
      // }
    });
  }

  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        print('user granted permission');
      }
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      if (kDebugMode) {
        print('user granted provisional permission');
      }
    } else {
      //appsetting.AppSettings.openNotificationSettings();
      if (kDebugMode) {
        print('user denied permission');
      }
    }
  }

  // function to show visible notification when app is active
  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      message.notification!.android!.channelId.toString(),
      message.notification!.android!.channelId.toString(),
      importance: Importance.max,
      showBadge: true,
      playSound: true,
      // sound: const RawResourceAndroidNotificationSound('jetsons_doorbell')
    );

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            channel.id.toString(), channel.name.toString(),
            channelDescription: 'your channel description',
            importance: Importance.high,
            priority: Priority.high,
            playSound: true,
            ticker: 'ticker',
            sound: channel.sound
            //     sound: RawResourceAndroidNotificationSound('jetsons_doorbell')
            //  icon: largeIconPath
            );

    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
            presentAlert: true, presentBadge: true, presentSound: true);

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);

    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
        0,
        message.notification!.title.toString(),
        message.notification!.body.toString(),
        notificationDetails,
      );
    });
  }

  //function to get device token on which we will send the notifications
  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token!;
  }

  // void isTokenRefresh()async{
  //   messaging.onTokenRefresh.listen((event) {
  //     event.toString();
  //     if (kDebugMode) {
  //       print('refresh');
  //     }
  //   });
  // }

  //handle tap on notification when app is in background or terminated
  Future<void> setupInteractMessage(BuildContext context) async {
    // when app is terminated
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      handleMessage(context, initialMessage);
    }

    //when app ins background
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleMessage(context, event);
    });
  }

  void handleMessage(BuildContext context, RemoteMessage message) {
    if (message.data == null) {
      return;
    } else if (ObjectFactory().prefs.isLoggedIn()!) {
      context.go('/home');
      context.push('/notification');
    }
  }

  Future forgroundMessage() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
}
