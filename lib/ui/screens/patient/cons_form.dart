import 'package:davnor_medicare/app_data.dart';
import 'package:davnor_medicare/core/controllers/app_controller.dart';
import 'package:davnor_medicare/core/models/category_model.dart';
import 'package:davnor_medicare/core/services/logger.dart';
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

class ConsFormScreen extends StatefulWidget {
  @override
  _ConsFormScreenState createState() => _ConsFormScreenState();
}

class _ConsFormScreenState extends State<ConsFormScreen> {
  final log = getLogger('Cons Form Screen');
  final AppController appController = AppController.to;

  void toggleSingleCardSelection(int index, List<Category> items) {
    for (var indexBtn = 0; indexBtn < items.length; indexBtn++) {
      if (indexBtn == index) {
        items[indexBtn].isSelected = true;
        log.i('${items[indexBtn].title} is selected');
      } else {
        items[indexBtn].isSelected = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: CupertinoNavigationBarBackButton(
            // color: Colors.black,
            onPressed: () => Get.to(
              () => PatientHomeScreen(),
              transition: Transition.cupertino,
            ),
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
                      children: AppData.categories.map(
                        (e) {
                          final index = AppData.categories.indexOf(e);
                          return CategoryCard(
                            title: e.title!,
                            iconPath: e.iconPath!,
                            isSelected: e.isSelected!,
                            onTap: () {
                              setState(
                                () {
                                  toggleSingleCardSelection(
                                    index,
                                    AppData.categories,
                                  );
                                },
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
                      child: RadioListTile<CategoryType>(
                        contentPadding: EdgeInsets.zero,
                        title: const Text(
                          'Follow-Up',
                          style: body16Regular,
                        ),
                        value: CategoryType.followUp,
                        groupValue: appController.categoryType,
                        onChanged: (CategoryType? value) {
                          setState(() {
                            appController.categoryType = value;
                            appController.isFollowUp.value = true;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<CategoryType>(
                        contentPadding: EdgeInsets.zero,
                        title: const Text(
                          'New Consultation',
                          style: body16Regular,
                        ),
                        value: CategoryType.newConsult,
                        groupValue: appController.categoryType,
                        onChanged: (CategoryType? value) {
                          setState(() {
                            appController.categoryType = value;
                            appController.isFollowUp.value = false;
                          });
                        },
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
                        onTap: () => Get.to(() => ConsForm2Screen()),
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
