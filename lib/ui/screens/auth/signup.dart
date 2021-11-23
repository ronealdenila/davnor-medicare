import 'package:davnor_medicare/constants/app_strings.dart';
import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/helpers/validator.dart';
import 'package:davnor_medicare/ui/screens/auth/doctor_application_guide.dart';
import 'package:davnor_medicare/ui/screens/auth/terms_and_policy.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/responsive.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/widgets/auth/bottom_text.dart';
import 'package:davnor_medicare/ui/widgets/auth/checkbox_form_field.dart';
import 'package:davnor_medicare/ui/widgets/auth/form_input_field_with_icon.dart';
import 'package:davnor_medicare/ui/widgets/custom_button.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupScreen extends GetView<AuthController> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          //color: Colors.white,
          body: SingleChildScrollView(
              child: Row(children: <Widget>[
        if (isDesktop(context) || isTab(context))
          Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * .2,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(davnormedicare, fit: BoxFit.fill),
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
                  Image.asset(davnormedicare, fit: BoxFit.fill),
                  Positioned(
                    left: 5,
                    top: 20,
                    child: IconButton(
                      icon: Icon(
                        Icons.chevron_left,
                        size: 65,
                      ),
                      onPressed: Get.back,
                      color: Colors.blueGrey
                    ),
                  ),
                ]),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
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
                                    if (kIsWeb) {
                                      showDialog(
                                          context: context,
                                          builder: (context) =>
                                              termsAndCondition(context));
                                    } else {
                                      Get.to(() => TermsAndPolicyScreen());
                                    }
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
                                onTap: () {
                                  if (kIsWeb) {
                                    showDialog(
                                        context: context,
                                        builder: (context) =>
                                            joinUsNow(context));
                                  } else {
                                    Get.to(
                                        () => DoctorApplicationGuideScreen());
                                  }
                                },
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
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: Visibility(
                      visible: kIsWeb,
                      child: TextButton(
                          onPressed: () => Get.back(),
                          child: Text(
                            'Login',
                          ))),
                ),
              ),
            ],
          ),
        ),
      ])),
    );
  }
}

Widget termsAndCondition(BuildContext context) {
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
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'Terms & Conditions',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 35),
                child: Text(
                  termsAndPolicyParagraph1,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 7, horizontal: 35),
                child: Text(
                  'Privacy Policy',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 35),
                child: Text(
                  termsAndPolicyParagraph2,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 35),
                child: Text(
                  'Information Collection and Use',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 35),
                child: Text(
                  termsAndPolicyParagraph3,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 7, horizontal: 35),
                child: Text(
                  'Termination',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 35),
                child: Text(
                  termsAndPolicyParagraph4,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
              ),
            ],
          ),
        )
      ]);
}

Widget joinUsNow(BuildContext context) {
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
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'Join Our Team',
                  textAlign: TextAlign.center,
                  style: title24Bold,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Text(
                  doctorapplicationinstructionParagraph1,
                  style: body14Regular,
                  textAlign: TextAlign.center,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 40, horizontal: 35),
                child: Text(
                  doctorapplicationinstructionParagraph2,
                  textAlign: TextAlign.justify,
                  style: body16Regular,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 35),
                child: Text(
                  doctorapplicationinstructionParagraph3,
                  textAlign: TextAlign.justify,
                  style: body16Regular,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 35),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 35),
                child: Text(
                  'For Interested Doctors:',
                  textAlign: TextAlign.left,
                  style: body16SemiBold,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 35),
                child: GestureDetector(
                  onTap: authController.launchDoctorApplicationForm,
                  child: Text(
                    'Join us here',
                    textAlign: TextAlign.left,
                    style: body14RegularUnderline.copyWith(color: infoColor),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 35),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 35),
                child: Text(
                  'For any inquiries, please email us at:',
                  textAlign: TextAlign.left,
                  style: body16SemiBold,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 35),
                child: GestureDetector(
                  onTap: authController.launchDoctorApplicationEmail,
                  child: Text(
                    'davnor.medicare@gmail.com',
                    textAlign: TextAlign.left,
                    style: body14Regular.copyWith(color: infoColor),
                  ),
                ),
              ),
            ],
          ),
        )
      ]);
}
