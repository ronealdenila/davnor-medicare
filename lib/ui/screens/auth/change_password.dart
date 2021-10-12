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

class ChangePasswordScreen extends StatelessWidget {
  final AuthController authController = Get.find();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CupertinoNavigationBarBackButton(
          onPressed: () {
            authController.currentPasswordController.clear();
            authController.newPasswordController.clear();
            Get.back();
          },
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
                'Change Password',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
              ),
              verticalSpace10,
              const Text(
                changePasswordDescription,
                style: TextStyle(fontSize: 18, color: neutralColor),
              ),
              verticalSpace50,
              Obx(
                () => FormInputFieldWithIcon(
                  controller: authController.currentPasswordController,
                  iconPrefix: Icons.vpn_key_rounded,
                  labelText: 'Current Password',
                  maxLines: 1,
                  obscureText: authController.isObscureCurrentPW!.value,
                  onChanged: (value) {
                    return;
                  },
                  onSaved: (value) =>
                      authController.currentPasswordController.text = value!,
                  suffixIcon: IconButton(
                    onPressed: authController.toggleCurrentPasswordVisibility,
                    icon: Icon(
                      authController.isObscureCurrentPW!.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  ),
                  validator: Validator().password,
                ),
              ),
              verticalSpace25,
              Obx(
                () => FormInputFieldWithIcon(
                  controller: authController.newPasswordController,
                  iconPrefix: Icons.vpn_key_rounded,
                  labelText: 'New Password',
                  onChanged: (value) {
                    return;
                  },
                  maxLines: 1,
                  obscureText: authController.isObscureNewPW!.value,
                  onSaved: (value) =>
                      authController.newPasswordController.text = value!,
                  suffixIcon: IconButton(
                    onPressed: authController.toggleNewPasswordVisibility,
                    icon: Icon(
                      authController.isObscureNewPW!.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  ),
                  textInputAction: TextInputAction.done,
                  validator: Validator().password,
                ),
              ),
              verticalSpace25,
              CustomButton(
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    await authController.changePassword(context);
                  }
                },
                text: 'Change Password',
                buttonColor: verySoftBlueColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
