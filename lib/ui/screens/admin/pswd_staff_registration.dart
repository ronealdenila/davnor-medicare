import 'package:davnor_medicare/constants/app_items.dart';
import 'package:davnor_medicare/core/controllers/admin/pswd_registration_controller.dart';
import 'package:davnor_medicare/core/controllers/app_controller.dart';
import 'package:davnor_medicare/helpers/validator.dart';
import 'package:davnor_medicare/ui/screens/admin/helpers/local_navigator.dart';
import 'package:davnor_medicare/ui/widgets/patient/custom_dropdown.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PSWDStaffRegistrationScreen extends GetView<PSWDRegistrationController> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AppController appController = Get.find();
  final GlobalKey<FormFieldState> psrdpKey1 = GlobalKey<FormFieldState>();

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
              IconButton(
                  onPressed: () {
                    navigationController.goBack();
                  },
                  icon: Icon(
                    Icons.arrow_back_outlined,
                    size: 30,
                  )),
              DmText.title42Bold(
                'PSWD Staff Registration Form',
              ),
              verticalSpace15,
              DmText.title32Bold(
                'Please fill  in the information of the PSWD Personnel.',
              ),
            ],
          ),
        ),
        verticalSpace15,
        Expanded(
          child: Form(
            key: formKey,
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
                                'Position',
                                color: const Color(
                                  0xFF6A6565,
                                ),
                              ),
                              verticalSpace15,
                              CustomDropdown(
                                givenKey: psrdpKey1,
                                hintText: 'Choose',
                                dropdownItems: position,
                                onChanged: (Item? item) =>
                                    controller.position.value = item!.name,
                                onSaved: (Item? item) =>
                                    controller.position.value = item!.name,
                              ),
                              verticalSpace20,
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
                                    title: 'ADD',
                                    onTap: () async {
                                      if (formKey.currentState!.validate()) {
                                        await controller.registerPSWD();
                                        formKey.currentState!.reset();
                                        appController.resetDropDown(psrdpKey1);
                                      }
                                    }),
                              ),
                              SizedBox(
                                height: 67,
                                width: 260,
                                child: DmButton.outline(
                                  title: 'Cancel',
                                  onTap: () {
                                    formKey.currentState!.reset();
                                    navigationController.goBack();
                                  },
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
        ),
      ],
    );
  }
}
