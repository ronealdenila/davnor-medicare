import 'package:davnor_medicare/constants/app_strings.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/helpers/validator.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/widgets/auth/form_input_field_with_icon.dart';
import 'package:davnor_medicare/ui/widgets/custom_button.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final AuthController authController = Get.find();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CupertinoNavigationBarBackButton(
          color: Colors.black,
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: ListView(
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
                  if (_formKey.currentState!.validate()) {
                    await authController.sendPasswordResetEmail(context);
                  }
                },
                text: 'Request Password Reset',
                buttonColor: verySoftBlueColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
