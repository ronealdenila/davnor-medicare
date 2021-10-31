import 'package:davnor_medicare/constants/app_items.dart';
import 'package:davnor_medicare/core/controllers/patient/cons_req_controller.dart';
import 'package:davnor_medicare/helpers/validator.dart';
import 'package:davnor_medicare/ui/screens/patient/cons_form2.dart';
import 'package:davnor_medicare/ui/screens/patient/home.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/widgets/custom_button.dart';
import 'package:davnor_medicare/ui/widgets/patient/custom_text_form_field.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConsFormScreen extends GetView<ConsRequestController> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Get.put(ConsRequestController());
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
                      'What kind of discomfort are you experiencing?',
                      style: title32Regular,
                    ),
                    verticalSpace18,
                    DiscomfortCategoryWidget(),
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
                              'New Consultation',
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
                              'Follow-Up',
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
                                await controller.nextButton();
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

class DiscomfortCategoryWidget extends GetView<ConsRequestController> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: discomfortData.length,
        itemBuilder: (ctx, index) {
          return Obx(
            () => Card(
              color: controller.selectedIndex.value == index
                  ? verySoftBlueColor[10]
                  : Colors.white,
              child: InkWell(
                onTap: () => controller.toggleSingleCardSelection(index),
                child: SizedBox(
                  height: 120,
                  width: 120,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 55,
                        width: 55,
                        child: Image.asset(
                          discomfortData[index].iconPath!,
                        ),
                      ),
                      verticalSpace5,
                      Text(
                        discomfortData[index].title!,
                        style: body16Regular,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
