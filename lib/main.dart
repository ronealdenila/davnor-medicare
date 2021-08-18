import 'package:davnor_medicare/core/services/navigation_service.dart';
import 'package:davnor_medicare/locator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'routes.dart' as router;
import 'constants/route_paths.dart' as routes;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Register all the models and services before the app starts
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      navigatorKey: locator<NavigationService>().navigatorKey,
      initialRoute: routes.LoginRoute,
      onGenerateRoute: router.generateRoute,
    );
  }
}
