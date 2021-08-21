import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/core/controllers/appController.dart';
import 'package:davnor_medicare/core/controllers/authController.dart';
import 'package:davnor_medicare/helpers/validator.dart';
import 'package:davnor_medicare/ui/screens/global/forgot_password.dart';
import 'package:davnor_medicare/ui/screens/global/signup.dart';
import 'package:davnor_medicare/ui/screens/global/widgets/bottom_text.dart';
import 'package:davnor_medicare/ui/screens/global/widgets/form_input_field_with_icon.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:davnor_medicare/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  //TODO: Register them into one file. kay if daghan nag controller sa widget
  //mutaas na ang variable declaration dria
  final AuthController authController = AuthController.to;
  final AppController appController = AppController.to;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: screenWidth(context),
                height: screenHeightPercentage(context, percentage: .3),
                child: Image.asset(authHeader, fit: BoxFit.fill),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                margin: EdgeInsets.all(20),
                elevation: 3,
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            verticalSpace18,
                            Text(
                              'Welcome Back!',
                              style: TextStyle(
                                  fontSize: 32, fontWeight: FontWeight.bold),
                            ),
                            verticalSpace10,
                            FormInputFieldWithIcon(
                              controller: authController.emailController,
                              iconPrefix: Icons.email,
                              labelText: 'Email',
                              validator: Validator().email,
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (value) => null,
                              onSaved: (value) =>
                                  authController.emailController.text = value!,
                            ),
                            verticalSpace25,
                            FormInputFieldWithIcon(
                              controller: authController.passwordController,
                              iconPrefix: Icons.lock,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  appController.toggleTextVisibility();
                                },
                                icon: Icon(
                                  appController.isObscureText.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                              labelText: 'Password',
                              validator: Validator().password,
                              obscureText: appController.isObscureText.value,
                              onChanged: (value) => null,
                              onSaved: (value) => authController
                                  .passwordController.text = value!,
                              maxLines: 1,
                              textInputAction: TextInputAction.done,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  Get.to(() => ForgotPasswordScreen());
                                },
                                child: Text('Forgot Password'),
                                style:
                                    TextButton.styleFrom(primary: kcInfoColor),
                              ),
                            ),
                            verticalSpace25,
                            CustomButton(
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  authController
                                      .signInWithEmailAndPassword(context);
                                }
                              },
                              text: 'Sign In',
                              color: kcVerySoftBlueColor,
                              fontSize: 20,
                            ),
                            verticalSpace25,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              BottomTextWidget(
                onTap: () {
                  Get.to(() => SignupScreen());
                },
                text1: "Don't have an account?",
                text2: 'Signup here',
              )
            ],
          ),
        ),
      ),
    );
  }
}
