import 'package:davnor_medicare/constants/app_strings.dart';
import 'package:davnor_medicare/core/controllers/authController.dart';
import 'package:davnor_medicare/helpers/validator.dart';
import 'package:davnor_medicare/ui/screens/global/widgets/form_input_field_with_icon.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:davnor_medicare/ui/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final AuthController authController = AuthController.to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CupertinoNavigationBarBackButton(
          color: Colors.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: ListView(
          children: [
            verticalSpace25,
            Text(
              'Recover Password',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            ),
            verticalSpace10,
            Text(
              ForgotPasswordDescription,
              style: TextStyle(fontSize: 18, color: kcNeutralColor),
            ),
            verticalSpace50,
            FormInputFieldWithIcon(
                controller: authController.emailController,
                iconPrefix: Icons.email,
                labelText: 'Email',
                validator: Validator().email,
                onChanged: (value) => null,
                onSaved: (value) =>
                    authController.emailController.text = value!),
            verticalSpace25,
            CustomButton(
              onTap: () {
                //TODO: Method for password reset
              },
              text: 'Request Password Reset',
              color: kcVerySoftBlueColor,
            ),
          ],
        ),
      ),
    );
  }
}
