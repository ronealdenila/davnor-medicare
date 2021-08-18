import 'package:davnor_medicare/core/services/authentication_service.dart';
import 'package:davnor_medicare/core/services/navigation_service.dart';
import 'package:davnor_medicare/locator.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:davnor_medicare/constants/route_paths.dart' as routes;

class LoginScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  final NavigationService _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .3,
                  child: Image.asset(
                    'asset/images/auth_header.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Text(
                'Welcome Back!',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: kIsWeb ? 40 : 25),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      hintText: 'Enter valid email id as abc@gmail.com'),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Enter secure password'),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: TextButton(
                  onPressed: () {
                    _navigationService.navigateTo(routes.ForgotPasswordRoute);
                  },
                  child: Text(
                    'Forgot Password',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: kcInfoColor,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: kcVerySoftBlueColor[20],
                    borderRadius: BorderRadius.circular(10)),
                child: TextButton(
                  onPressed: () {
                    //For testing. Use this accounts
                    //PSWD Staff:  pswd@gmail.com //Admin: admin@gmail.com
                    //Patient: patient@gmail.com //Doctor: doctor@gmail.com
                    _authenticationService.loginWithEmail(
                        email: emailController.text, password: '123456');
                  },
                  child: Text(
                    'Sign in',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Text(
                    'Dont have an account?',
                  ),
                  TextButton(
                    onPressed: () {
                      _navigationService.navigateTo(routes.SignupRoute);
                    },
                    child: Text(
                      'Signup here',
                      style: TextStyle(color: kcInfoColor, fontSize: 15),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
