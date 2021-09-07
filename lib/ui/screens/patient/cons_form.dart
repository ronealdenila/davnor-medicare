import 'package:davnor_medicare/app_data.dart';
import 'package:davnor_medicare/core/controllers/cons_controller.dart';
import 'package:davnor_medicare/helpers/validator.dart';
import 'package:davnor_medicare/ui/screens/patient/cons_form2.dart';
import 'package:davnor_medicare/ui/screens/patient/home.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:davnor_medicare/ui/widgets/custom_button.dart';
import 'package:davnor_medicare/ui/widgets/patient/category_card.dart';
import 'package:davnor_medicare/ui/widgets/patient/custom_text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConsFormScreen extends GetView<ConsController> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: CupertinoNavigationBarBackButton(
            color: Colors.black,
            onPressed: () {
              Get.to(
                () => PatientHomeScreen(),
                transition: Transition.cupertino,
              );
            },
          ),
        ),
        body: Obx(
          () => Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Where are you experiencing discomfort?',
                      style: title32Regular,
                    ),
                    verticalSpace18,
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Wrap(
                          spacing: 10,
                          children: AppData.categories.map(
                            (e) {
                              final index = AppData.categories.indexOf(e);
                              return CategoryCard(
                                title: e.title!,
                                iconPath: e.iconPath!,
                                isSelected: e.isSelected!,
                                onTap: () {
                                  //TODO(R): isSelected must be observable
                                  controller.toggleSingleCardSelection(
                                    index,
                                    AppData.categories,
                                  );
                                },
                              );
                            },
                          ).toList(),
                        ),
                      ),
                    ),
                    verticalSpace10,
                    const Text(
                      'What type of consultation?',
                      style: subtitle20Medium,
                    ),
                    verticalSpace10,
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile<bool>(
                            contentPadding: EdgeInsets.zero,
                            title: const Text(
                              'Follow-Up',
                              style: body16Regular,
                            ),
                            value: true,
                            groupValue: controller.isFollowUp.value,
                            onChanged: (bool? value) =>
                                controller.isFollowUp.value = value!,
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<bool>(
                            contentPadding: EdgeInsets.zero,
                            title: const Text(
                              'New Consultation',
                              style: body16Regular,
                            ),
                            value: false,
                            groupValue: controller.isFollowUp.value,
                            onChanged: (bool? value) =>
                                controller.isFollowUp.value = value!,
                          ),
                        ),
                      ],
                    ),
                    verticalSpace18,
                    const Text(
                      "Patient's Infomation",
                      style: subtitle20Medium,
                    ),
                    verticalSpace10,
                    Visibility(
                      visible: !controller.isConsultForYou.value,
                      child: CustomTextFormField(
                        controller: controller.firstNameController,
                        labelText: 'First Name',
                        validator: Validator().notEmpty,
                        onChanged: (value) {
                          return;
                        },
                        onSaved: (value) =>
                            controller.firstNameController.text = value!,
                      ),
                    ),
                    verticalSpace10,
                    Visibility(
                      visible: !controller.isConsultForYou.value,
                      child: CustomTextFormField(
                        controller: controller.lastNameController,
                        labelText: 'Last Name',
                        validator: Validator().notEmpty,
                        onChanged: (value) {
                          return;
                        },
                        onSaved: (value) =>
                            controller.lastNameController.text = value!,
                      ),
                    ),
                    verticalSpace10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 160,
                          child: CustomTextFormField(
                            controller: controller.ageController,
                            labelText: 'Age',
                            validator: Validator().notEmpty,
                            keyboardType: TextInputType.number,
                            //* for improvement: pwede ta pag click sa done
                            //* magsubmit na ang form
                            textInputAction: TextInputAction.done,
                            onChanged: (value) {
                              return;
                            },
                            onSaved: (value) =>
                                controller.ageController.text = value!,
                          ),
                        ),
                        SizedBox(
                          width: 160,
                          child: CustomButton(
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                await Get.to(() => ConsForm2Screen());
                              }
                            },
                            text: 'Next',
                            buttonColor: verySoftBlueColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
