<<<<<<< Updated upstream
import 'package:davnor_medicare/core/services/navigation_service.dart';
import 'package:davnor_medicare/locator.dart';
=======
import 'package:davnor_medicare/core/controllers/appController.dart';
>>>>>>> Stashed changes
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'routes.dart' as router;
import 'constants/route_paths.dart' as routes;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
<<<<<<< Updated upstream
  // Register all the models and services before the app starts
  setupLocator();
=======
  Get.put<AppController>(AppController());
  Get.put<AuthController>(AuthController());
>>>>>>> Stashed changes
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(backgroundColor: Colors.white,elevation: 0)
      ),
      debugShowCheckedModeBanner: false,
      navigatorKey: locator<NavigationService>().navigatorKey,
      initialRoute: routes.MADescriptionRoute,
      //initialRoute: routes.LoginRoute,
      onGenerateRoute: router.generateRoute,
    );
  }
}
