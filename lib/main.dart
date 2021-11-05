import 'package:davnor_medicare/constants/translation.dart';
import 'package:davnor_medicare/core/controllers/bindings/all_controller_binding.dart';
import 'package:davnor_medicare/routes/app_pages.dart';
// Import the firebase_app_check plugin
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///Receive message when app is in background solution for on message
Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  //await FirebaseAppCheck.instance
  //.activate(webRecaptchaSiteKey: 'recaptcha-v3-site-key');
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AllControllerBinding(),
      translations: LocalString(),
      locale: Locale('english', 'US'),
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Inter',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
