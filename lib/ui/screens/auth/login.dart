import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/helpers/validator.dart';
import 'package:davnor_medicare/ui/screens/auth/forgot_password.dart';
import 'package:davnor_medicare/ui/screens/auth/signup.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/responsive.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:davnor_medicare/ui/widgets/auth/bottom_text.dart';
import 'package:davnor_medicare/ui/widgets/auth/form_input_field_with_icon.dart';
import 'package:davnor_medicare/ui/widgets/custom_button.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  final AuthController authController = Get.find();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: !isMobile(context) ? 40:0),
              child: Column(
                mainAxisAlignment: !isMobile(context) ? MainAxisAlignment.start:MainAxisAlignment.center,
                crossAxisAlignment: !isMobile(context) ? CrossAxisAlignment.start:CrossAxisAlignment.center,
                children: <Widget>[
                  if (isMobile(context))
                    Image.asset(
                      authHeader,
                      height: size.height * 0.3,
                    ),
                    Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    margin: const EdgeInsets.all(20),
                    elevation: 3,
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Center(
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                verticalSpace18,
                                const Text('Welcome Back!', style: title32Bold),
                                verticalSpace50,
                                FormInputFieldWithIcon(
                                  controller: authController.emailController,
                                  iconPrefix: Icons.email,
                                  labelText: 'Email',
                                  validator: Validator().email,
                                  keyboardType: TextInputType.emailAddress,
                                  onChanged: (value) {
                                    return;
                                  },
                                  onSaved: (value) => authController
                                      .emailController.text = value!,
                                ),
                                verticalSpace25,
                                FormInputFieldWithIcon(
                                  controller: authController.passwordController,
                                  iconPrefix: Icons.lock,
                                  suffixIcon: IconButton(
                                    onPressed:
                                        authController.togglePasswordVisibility,
                                    icon: Icon(
                                      authController.isObscureText!.value
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                  ),
                                  labelText: 'Password',
                                  validator: Validator().password,
                                  obscureText:
                                      authController.isObscureText!.value,
                                  onChanged: (value) {
                                    return;
                                  },
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
                                    style: TextButton.styleFrom(
                                        primary: infoColor),
                                    child: const Text(
                                      'Forgot Password',
                                      style: body14SemiBold,
                                    ),
                                  ),
                                ),
                                verticalSpace25,
                                CustomButton(
                                  onTap: () async {
                                    if (_formKey.currentState!.validate()) {
                                      await authController
                                          .signInWithEmailAndPassword(context);
                                    }
                                  },
                                  text: 'Sign In',
                                  buttonColor: verySoftBlueColor,
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
                  ),

                  if (isDesktop(context) || isTab(context))
                  Expanded(
                    child: Image.asset(
                      authHeader,
                      height: size.height * 0.7,
                    )
                   )
                ],
              ),
            )
          )]
      )
    );
  }
}