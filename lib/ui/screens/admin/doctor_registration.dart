import 'package:davnor_medicare/constants/app_items.dart';
import 'package:davnor_medicare/core/controllers/admin/doctor_registration_controller.dart';
import 'package:davnor_medicare/helpers/validator.dart';
import 'package:davnor_medicare/ui/screens/admin/helpers/local_navigator.dart';
import 'package:davnor_medicare/ui/widgets/patient/custom_dropdown.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoctorRegistrationScreen extends GetView<DoctorRegistrationController> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DmText.title42Bold(
                'Doctor Registration Form',
              ),
              verticalSpace15,
              DmText.title32Bold(
                'Please fill  in the information of the  Doctor.',
              ),
            ],
          ),
        ),
        verticalSpace15,
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DmText.title24Medium(
                        'Lastname',
                        color: const Color(
                          0xFF6A6565,
                        ),
                      ),
                      verticalSpace15,
                      //TO DO: Change into regular text field???

                      DmInputField(
                        controller: controller.lastNameController,
                        validator: Validator().notEmpty,
                        isRequired: true,
                      ),
                      verticalSpace20,
                      DmText.title24Medium(
                        'First Name',
                        color: const Color(
                          0xFF6A6565,
                        ),
                      ),
                      verticalSpace15,
                      DmInputField(
                        controller: controller.firstNameController,
                        validator: Validator().notEmpty,
                        isRequired: true,
                      ),
                      verticalSpace20,
                      DmText.title24Medium(
                        'Email Address',
                        color: const Color(
                          0xFF6A6565,
                        ),
                      ),
                      verticalSpace15,
                      DmInputField(
                        controller: controller.emailController,
                        validator: Validator().notEmpty,
                        isRequired: true,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DmText.title24Medium(
                              'Title',
                              color: const Color(
                                0xFF6A6565,
                              ),
                            ),
                            verticalSpace15,
                            CustomDropdown(
                              hintText: 'Choose',
                              dropdownItems: title,
                              onChanged: (Item? item) =>
                                  controller.title.value = item!.name,
                              onSaved: (Item? item) =>
                                  controller.title.value = item!.name,
                            ),
                            verticalSpace20,
                            DmText.title24Medium(
                              'Department',
                              color: const Color(
                                0xFF6A6565,
                              ),
                            ),
                            verticalSpace15,
                            CustomDropdown(
                              hintText: 'Which department(s) do you belong to?',
                              dropdownItems: department,
                              onChanged: (Item? item) =>
                                  controller.department.value = item!.name,
                              onSaved: (Item? item) =>
                                  controller.department.value = item!.name,
                            ),
                            verticalSpace20,
                            DmText.title24Medium(
                              'Clinic Hours',
                              color: const Color(
                                0xFF6A6565,
                              ),
                            ),
                            verticalSpace15,
                            DmInputField(
                              controller: controller.clinicHours,
                              validator: Validator().notEmpty,
                              isRequired: true,
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Wrap(
                          children: [
                            SizedBox(
                              height: 67,
                              width: 260,
                              child: DmButton(
                                title: 'REGISTER',
                                onTap: controller.registerDoctor,
                              ),
                            ),
                            SizedBox(
                              height: 67,
                              width: 260,
                              child: DmButton.outline(
                                title: 'Cancel',
                                onTap: goBack,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> goBack() {
    return navigationController.navigatorKey.currentState!
        .popAndPushNamed('/dashboard');
  }
}
