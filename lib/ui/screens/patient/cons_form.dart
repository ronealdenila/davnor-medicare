import 'package:davnor_medicare/constants/app_items.dart';
import 'package:davnor_medicare/core/controllers/patient/cons_req_controller.dart';
import 'package:davnor_medicare/helpers/validator.dart';
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
                    Text(
                      'consform'.tr,
                      style: title32Regular,
                    ),
                    verticalSpace18,
                    DiscomfortCategoryWidget(),
                    verticalSpace10,
                    Text(
                      'consform1'.tr,
                      style: subtitle20Medium,
                    ),
                    verticalSpace10,
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile<bool>(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              'consformii'.tr,
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
                            title: Text(
                              'consformi'.tr,
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
                    Text(
                      'consform2'.tr,
                      style: subtitle20Medium,
                    ),
                    verticalSpace10,
                    Visibility(
                      visible: !controller.isConsultForYou.value,
                      child: CustomTextFormField(
                        controller: controller.firstNameController,
                        labelText: 'consform8'.tr,
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
                        labelText: 'consform9'.tr,
                        validator: Validator().notEmpty,
                        onChanged: (value) {
                          return;
                        },
                        onSaved: (value) =>
                            controller.lastNameController.text = value!,
                      ),
                    ),
                    verticalSpace10,
                    SizedBox(
                      width: Get.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 4,
                            child: CustomTextFormField(
                              controller: controller.ageController,
                              labelText: 'consform3'.tr,
                              validator: Validator().number,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.done,
                              onChanged: (value) {
                                return;
                              },
                              onSaved: (value) =>
                                  controller.ageController.text = value!,
                            ),
                          ),
                          Spacer(),
                          Expanded(
                            flex: 5,
                            child: CustomButton(
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  await controller.nextButton();
                                }
                              },
                              text: 'consform4'.tr,
                              buttonColor: verySoftBlueColor,
                            ),
                          ),
                        ],
                      ),
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
