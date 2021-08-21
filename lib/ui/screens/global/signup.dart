import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/core/controllers/appController.dart';
import 'package:davnor_medicare/core/controllers/authController.dart';
import 'package:davnor_medicare/helpers/validator.dart';
import 'package:davnor_medicare/ui/screens/global/doctor_application_instruction.dart';
import 'package:davnor_medicare/ui/screens/global/terms_and_policy.dart';
import 'package:davnor_medicare/ui/screens/global/widgets/bottom_text.dart';
import 'package:davnor_medicare/ui/screens/global/widgets/checkbox_form_field.dart';
import 'package:davnor_medicare/ui/screens/global/widgets/form_input_field_with_icon.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:davnor_medicare/ui/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupScreen extends StatelessWidget {
  final AuthController authController = AuthController.to;
  final AppController appController = AppController.to;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _confirmPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => CustomScrollView(
          slivers: [
            CustomSliverAppBar(),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Column(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        margin: EdgeInsets.all(20),
                        child: Form(
                          key: _formKey,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Center(
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    verticalSpace18,
                                    Text(
                                      'Sign Up',
                                      style: TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    verticalSpace10,
                                    FormInputFieldWithIcon(
                                      controller:
                                          authController.firstNameController,
                                      iconPrefix: Icons.person,
                                      labelText: 'First Name',
                                      validator: Validator().notEmpty,
                                      keyboardType: TextInputType.name,
                                      onChanged: (value) => null,
                                      onSaved: (value) => authController
                                          .firstNameController.text = value!,
                                    ),
                                    verticalSpace10,
                                    FormInputFieldWithIcon(
                                      controller:
                                          authController.lastNameController,
                                      iconPrefix: Icons.person,
                                      labelText: 'Last Name',
                                      validator: Validator().notEmpty,
                                      keyboardType: TextInputType.name,
                                      onChanged: (value) => null,
                                      onSaved: (value) => authController
                                          .lastNameController.text = value!,
                                    ),
                                    verticalSpace10,
                                    FormInputFieldWithIcon(
                                      controller:
                                          authController.emailController,
                                      iconPrefix: Icons.email,
                                      labelText: 'Email',
                                      validator: Validator().email,
                                      keyboardType: TextInputType.emailAddress,
                                      onChanged: (value) => null,
                                      onSaved: (value) => authController
                                          .emailController.text = value!,
                                    ),
                                    verticalSpace10,
                                    FormInputFieldWithIcon(
                                      controller:
                                          authController.passwordController,
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
                                      obscureText:
                                          appController.isObscureText.value,
                                      onChanged: (value) => null,
                                      onSaved: (value) => authController
                                          .passwordController.text = value!,
                                      maxLines: 1,
                                    ),
                                    verticalSpace10,
                                    FormInputFieldWithIcon(
                                      controller: _confirmPassController,
                                      iconPrefix: Icons.lock,
                                      labelText: 'Confirm Password',
                                      //It must be put on validator folder pero di
                                      //ko familiar sa regex. Copy paste problem Xd
                                      //So I resolved it in a diry yet effective way (R)
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'This is a required field';
                                        }
                                        if (value !=
                                            authController
                                                .passwordController.text)
                                          return 'Password does not match';
                                        else
                                          return null;
                                      },
                                      obscureText:
                                          appController.isObscureText.value,
                                      onChanged: (value) => null,
                                      onSaved: (value) =>
                                          _confirmPassController.text = value!,
                                      maxLines: 1,
                                      textInputAction: TextInputAction.done,
                                    ),
                                    CheckboxFormField(
                                      title: BottomTextWidget(
                                          onTap: () {
                                            Get.to(
                                                () => TermsAndPolicyScreen());
                                          },
                                          text1: 'I agree to',
                                          text2: 'Terms & Condition'),
                                      validator: (value) {
                                        if (value == false)
                                        //Wala ko kabalo unsay error message dapat ani (R)
                                          return 'Please check';
                                      },
                                    ),
                                    verticalSpace10,
                                    CustomButton(
                                      onTap: () async {
                                        if (_formKey.currentState!.validate()) {
                                          authController
                                              .registerWithEmailAndPassword(
                                                  context);
                                        }
                                      },
                                      text: 'Sign Up Now',
                                      color: kcVerySoftBlueColor,
                                      fontSize: 20,
                                    ),
                                    verticalSpace18,
                                    Align(
                                      alignment: Alignment.center,
                                      child: BottomTextWidget(
                                        onTap: () {
                                          Get.to(
                                              DoctorApplicationInstructionScreen());
                                        },
                                        text1: 'Are you a doctor?',
                                        text2: 'Join us now!',
                                      ),
                                    ),
                                    verticalSpace25,
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      verticalSpace50
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: CupertinoNavigationBarBackButton(
        color: Colors.black,
        onPressed: () {
          Get.back();
        },
      ),
      expandedHeight: screenHeightPercentage(context, percentage: .2),
      pinned: true,
      snap: false,
      floating: false,
      flexibleSpace: FlexibleSpaceBar(
        background: Image.asset(
          authHeader,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
