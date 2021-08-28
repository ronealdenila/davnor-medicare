import 'package:davnor_medicare/app_data.dart';
import 'package:davnor_medicare/core/controllers/app_controller.dart';
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

class ConsFormScreen extends StatelessWidget {
  static AppController appController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: CupertinoNavigationBarBackButton(
            color: Colors.black,
            onPressed: () => Get.to(() => PatientHomeScreen(),
                transition: Transition.cupertino),
          ),
        ),
        body: Padding(
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
                      children: AppData.categories.map((e) {
                        return CategoryCard(
                          title: e.title!,
                          iconPath: e.iconPath!,
                          onTap: () {},
                        );
                      }).toList(),
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
                    Checkbox(
                      shape: const CircleBorder(),
                      value: true,
                      onChanged: (bool? newValue) {},
                      activeColor: verySoftBlueColor,
                    ),
                    const Text(
                      'Follow-up',
                      style: body16Regular,
                    ),
                    Checkbox(
                      shape: const CircleBorder(),
                      value: false,
                      onChanged: (bool? newValue) {},
                    ),
                    const Text(
                      'New Consultation',
                      style: body16Regular,
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
                  visible: !appController.isConsultForYou.value,
                  child: const CustomTextFormField('First Name'),
                ),
                verticalSpace10,
                Visibility(
                  visible: !appController.isConsultForYou.value,
                  child: const CustomTextFormField('Last Name'),
                ),
                verticalSpace10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 160,
                      child: CustomTextFormField('Age'),
                    ),
                    SizedBox(
                      width: 160,
                      child: CustomButton(
                        onTap: () => Get.to(() => const ConsForm2Screen()),
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
    );
  }
}
