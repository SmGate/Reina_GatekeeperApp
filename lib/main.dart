import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_notification_channel/flutter_notification_channel.dart';
import 'package:flutter_notification_channel/notification_importance.dart';
import 'package:flutter_notification_channel/notification_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gatekeeper/Routes/routes_managment.dart';
import 'package:gatekeeper/Routes/set_routes.dart';
import 'package:gatekeeper/utils/Constants/app_translations.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  print("Handling a background message: ${message.notification!.title}");
  print("Handling a background message: ${message.notification!.body}");
}

String? countryCode;
String? languageCode;

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isIOS) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCDmrShxv0r-kUBDpA1bC_vjcmRwv_6jGE",
            appId: "1:1085340446333:ios:6ac309e5ea8c1c52180b14",
            messagingSenderId: "1085340446333",
            projectId: "smart-ga"));
  } else {
    await Firebase.initializeApp();
  }

  var result = await FlutterNotificationChannel.registerNotificationChannel(
    description: 'Your channel description',
    id: 'high_importance_channel',
    importance: NotificationImportance.IMPORTANCE_HIGH,
    name: 'Your channel name',
    visibility: NotificationVisibility.VISIBILITY_PUBLIC,
    allowBubbles: true,
    enableVibration: true,
    enableSound: true,
    showBadge: true,
  );
  print(result);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  getValuesFromPref();
  runApp(MyApp());
}

void getValuesFromPref() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  countryCode = preferences.getString("countryCode");
  languageCode = preferences.getString("languageCode");
  print("********************${countryCode}");
  print("********************${languageCode}");
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ScreenUtilInit(
        useInheritedMediaQuery: true,
        designSize: Size(375, 812),
        builder: (context, child) {
          return GetMaterialApp(
            translations: AppTranslations(),
            locale: Locale(languageCode ?? 'en', countryCode ?? 'US'),
            debugShowCheckedModeBanner: false,
            initialRoute: splashscreen,
            getPages: RouteManagement.getPages(),
          );
        });
  }
}
