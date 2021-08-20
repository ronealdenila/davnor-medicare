import 'package:davnor_medicare/constants/app_routes.dart';
import 'package:flutter/material.dart';

import 'package:davnor_medicare/core/controllers/appController.dart';
import 'package:davnor_medicare/core/controllers/authController.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put<AppController>(AppController());
  Get.put<AuthController>(AuthController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(backgroundColor: Colors.white,elevation: 0)
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      getPages: AppRoutes.routes,
      // navigatorKey: locator<NavigationService>().navigatorKey,
      // initialRoute: routes.LoginRoute,
      // onGenerateRoute: router.generateRoute,
    );
  }
}
