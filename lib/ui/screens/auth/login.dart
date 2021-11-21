import 'package:davnor_medicare/constants/app_strings.dart';
import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:davnor_medicare/helpers/validator.dart';
import 'package:davnor_medicare/ui/screens/auth/forgot_password.dart';
import 'package:davnor_medicare/ui/screens/auth/signup.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/responsive.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/widgets/auth/bottom_text.dart';
import 'package:davnor_medicare/ui/widgets/auth/form_input_field_with_icon.dart';
import 'package:davnor_medicare/ui/widgets/custom_button.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ResponsiveView(context));
  }
}

class ResponsiveView extends GetResponsiveView {
  ResponsiveView(this.context) : super(alwaysUseBuilder: false);
  final BuildContext context;
  final AuthController authController = Get.find();

  @override
  Widget phone() => phoneVersion(context);

  @override
  Widget tablet() => desktopVersion(context);

  @override
  Widget desktop() => desktopVersion(context);

  Widget desktopVersion(BuildContext context) {
    if (isMobile(context)) {
      return phoneVersion(context);
    } else {}
    return SingleChildScrollView(
        child: Row(children: <Widget>[
      Expanded(
        flex: 1,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * .2,
          height: MediaQuery.of(context).size.height,
          child: Image.asset(davnormedicare, fit: BoxFit.fill),
        ),
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              margin: const EdgeInsets.all(20),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        verticalSpace15,
                        const Text('Welcome Back!', style: title32Bold),
                        verticalSpace25,
                        FormInputFieldWithIcon(
                          controller: authController.emailController,
                          iconPrefix: Icons.email,
                          labelText: 'Email',
                          validator: Validator().email,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            return;
                          },
                          onSaved: (value) =>
                              authController.emailController.text = value!,
                        ),
                        verticalSpace20,
                        Obx(
                          () => FormInputFieldWithIcon(
                            controller: authController.passwordController,
                            iconPrefix: Icons.lock,
                            suffixIcon: IconButton(
                              onPressed: () {
                                authController.togglePasswordVisibility();
                              },
                              icon: Icon(
                                authController.isObscureText!.value
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                            labelText: 'Password',
                            validator: Validator().password,
                            obscureText: authController.isObscureText!.value,
                            onChanged: (value) {
                              return;
                            },
                            onSaved: (value) =>
                                authController.passwordController.text = value!,
                            maxLines: 1,
                            textInputAction: TextInputAction.done,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              if (kIsWeb) {
                                showDialog(
                                    context: context,
                                    builder: (context) =>
                                        forgotPassword(context));
                              } else {
                                Get.to(() => ForgotPasswordScreen());
                              }
                            },
                            style: TextButton.styleFrom(primary: infoColor),
                            child: const Text(
                              'Forgot Password?',
                              style: body14SemiBold,
                            ),
                          ),
                        ),
                        //  verticalSpace10,
                        CustomButton(
                          onTap: () async {
                            await authController
                                .signInWithEmailAndPassword(context);
                          },
                          text: 'Sign In',
                          buttonColor: verySoftBlueColor,
                          fontSize: 20,
                        ),
                        verticalSpace15,
                      ],
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
            verticalSpace15,
          ],
        ),
      ),
    ]));
  }

  Widget phoneVersion(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
            width: Get.width,
            height: Get.height * .45,
            child: Image.asset(davnormedicare,
                fit: BoxFit.cover, gaplessPlayback: true)),
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          margin: const EdgeInsets.all(20),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    verticalSpace15,
                    const Text('Welcome Back!', style: title32Bold),
                    verticalSpace25,
                    FormInputFieldWithIcon(
                      controller: authController.emailController,
                      iconPrefix: Icons.email,
                      labelText: 'Email',
                      validator: Validator().email,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        return;
                      },
                      onSaved: (value) =>
                          authController.emailController.text = value!,
                    ),
                    verticalSpace20,
                    Obx(
                      () => FormInputFieldWithIcon(
                        controller: authController.passwordController,
                        iconPrefix: Icons.lock,
                        suffixIcon: IconButton(
                          onPressed: () {
                            authController.togglePasswordVisibility();
                          },
                          icon: Icon(
                            authController.isObscureText!.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                        labelText: 'Password',
                        validator: Validator().password,
                        obscureText: authController.isObscureText!.value,
                        onChanged: (value) {
                          return;
                        },
                        onSaved: (value) =>
                            authController.passwordController.text = value!,
                        maxLines: 1,
                        textInputAction: TextInputAction.done,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          if (kIsWeb) {
                            showDialog(
                                context: context,
                                builder: (context) => forgotPassword(context));
                          } else {
                            Get.to(() => ForgotPasswordScreen());
                          }
                        },
                        style: TextButton.styleFrom(primary: infoColor),
                        child: const Text(
                          'Forgot Password?',
                          style: body14SemiBold,
                        ),
                      ),
                    ),
                    //  verticalSpace10,
                    CustomButton(
                      onTap: () async {
                        await authController
                            .signInWithEmailAndPassword(context);
                      },
                      text: 'Sign In',
                      buttonColor: verySoftBlueColor,
                      fontSize: 20,
                    ),
                    verticalSpace15,
                  ],
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
        verticalSpace15,
      ],
    ));
  }
}

Widget forgotPassword(BuildContext context) {
  final AuthController authController = Get.find();
  return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      contentPadding: EdgeInsets.symmetric(
        vertical: 30,
        horizontal: 50,
      ),
      children: [
        SizedBox(
          width: Get.width * .2,
          child: Column(
            children: [
              verticalSpace25,
              const Text(
                'Recover Password',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
              ),
              verticalSpace10,
              const Text(
                forgotPasswordDescription,
                style: TextStyle(fontSize: 18, color: neutralColor),
              ),
              verticalSpace50,
              FormInputFieldWithIcon(
                  controller: authController.emailController,
                  iconPrefix: Icons.email,
                  labelText: 'Email',
                  validator: Validator().email,
                  onChanged: (value) {
                    return;
                  },
                  onSaved: (value) =>
                      authController.emailController.text = value!),
              verticalSpace25,
              CustomButton(
                onTap: () async {
                  await authController.sendPasswordResetEmail(context);
                  dismissDialog();
                },
                text: 'Request Password Reset',
                buttonColor: verySoftBlueColor,
              ),
            ],
          ),
        )
      ]);
}
