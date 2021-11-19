import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/helpers/validator.dart';
import 'package:davnor_medicare/ui/screens/auth/doctor_application_guide.dart';
import 'package:davnor_medicare/ui/screens/auth/terms_and_policy.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/responsive.dart';
import 'package:davnor_medicare/ui/widgets/auth/bottom_text.dart';
import 'package:davnor_medicare/ui/widgets/auth/checkbox_form_field.dart';
import 'package:davnor_medicare/ui/widgets/auth/form_input_field_with_icon.dart';
import 'package:davnor_medicare/ui/widgets/custom_button.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupScreen extends GetView<AuthController> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          //color: Colors.white,
          body: SingleChildScrollView(
              child: Row(children: <Widget>[
        if (isDesktop(context) || isTab(context))
          Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * .2,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(authHeader, fit: BoxFit.fill),
            ),
          ),
        Expanded(
          child: Column(
            crossAxisAlignment: !isMobile(context)
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.start,
            children: <Widget>[
              if (isMobile(context))
                Stack(children: [
                  Image.asset(authHeader, fit: BoxFit.fill),
                  Positioned(
                    left: 5,
                    top: 5,
                    child: IconButton(
                      icon: Icon(
                        Icons.chevron_left,
                        size: 35,
                      ),
                      onPressed: Get.back,
                      color: Colors.black,
                    ),
                  ),
                ]),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: const EdgeInsets.all(20),
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
                            verticalSpace15,
                            const Text(
                              'Sign Up',
                              style: TextStyle(
                                  fontSize: 32, fontWeight: FontWeight.bold),
                            ),
                            verticalSpace10,
                            FormInputFieldWithIcon(
                              controller: controller.firstNameController,
                              iconPrefix: Icons.person,
                              labelText: 'First Name',
                              validator: Validator().notEmpty,
                              keyboardType: TextInputType.name,
                              onChanged: (value) {
                                return;
                              },
                              onSaved: (value) =>
                                  controller.firstNameController.text = value!,
                            ),
                            verticalSpace10,
                            FormInputFieldWithIcon(
                              controller: controller.lastNameController,
                              iconPrefix: Icons.person,
                              labelText: 'Last Name',
                              validator: Validator().notEmpty,
                              keyboardType: TextInputType.name,
                              onChanged: (value) {
                                return;
                              },
                              onSaved: (value) =>
                                  controller.lastNameController.text = value!,
                            ),
                            verticalSpace10,
                            FormInputFieldWithIcon(
                              controller: controller.emailController,
                              iconPrefix: Icons.email,
                              labelText: 'Email',
                              validator: Validator().email,
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (value) {
                                return;
                              },
                              onSaved: (value) =>
                                  controller.emailController.text = value!,
                            ),
                            verticalSpace10,
                            Obx(
                              () => FormInputFieldWithIcon(
                                controller: controller.passwordController,
                                iconPrefix: Icons.lock,
                                suffixIcon: IconButton(
                                  onPressed:
                                      controller.togglePasswordVisibility,
                                  icon: Icon(
                                    controller.isObscureText!.value
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                ),
                                labelText: 'Password',
                                validator: Validator().password,
                                obscureText: controller.isObscureText!.value,
                                onChanged: (value) {
                                  return;
                                },
                                onSaved: (value) =>
                                    controller.passwordController.text = value!,
                                maxLines: 1,
                              ),
                            ),
                            verticalSpace10,
                            FormInputFieldWithIcon(
                              controller: controller.confirmPassController,
                              iconPrefix: Icons.lock,
                              labelText: 'Confirm Password',
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'This is a required field';
                                }
                                if (value !=
                                    controller.passwordController.text) {
                                  return 'Password does not match';
                                } else {
                                  return null;
                                }
                              },
                              obscureText: controller.isObscureText!.value,
                              onChanged: (value) {
                                return;
                              },
                              onSaved: (value) => controller
                                  .confirmPassController.text = value!,
                              maxLines: 1,
                              textInputAction: TextInputAction.done,
                            ),
                            CheckboxFormField(
                              title: BottomTextWidget(
                                  onTap: () {
                                    Get.to(() => TermsAndPolicyScreen());
                                  },
                                  text1: 'I agree to',
                                  text2: 'Terms & Condition'),
                              validator: (value) {
                                if (value == false) {
                                  return 'Please check';
                                }
                              },
                            ),
                            CustomButton(
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  await controller.registerPatient(context);
                                }
                              },
                              text: 'Sign Up Now',
                              buttonColor: verySoftBlueColor,
                              fontSize: 20,
                            ),
                            verticalSpace15,
                            Align(
                              child: BottomTextWidget(
                                onTap: () => Get.to(
                                  () => DoctorApplicationGuideScreen(),
                                ),
                                text1: 'Are you a doctor?',
                                text2: 'Join us now!',
                              ),
                            ),
                            verticalSpace20,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]))),
    );
  }
}
