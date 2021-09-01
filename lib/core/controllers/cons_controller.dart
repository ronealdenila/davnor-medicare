import 'package:davnor_medicare/core/models/category_model.dart';
import 'package:davnor_medicare/core/services/logger.dart';
import 'package:davnor_medicare/ui/screens/patient/cons_form.dart';
import 'package:davnor_medicare/ui/screens/patient/cons_form2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum CategoryType { followUp, newConsult }

class ConsController extends GetxController {
  final log = getLogger('Cons Controller');

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  RxBool isConsultForYou = true.obs;
  RxBool isFollowUp = true.obs;

  CategoryType? categoryType = CategoryType.followUp;

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

  Future<void> submit() async {
    log.wtf(
        '${firstNameController.text} ${lastNameController.text} can proceed');
    await Get.to(() => ConsForm2Screen());
  }

  Future<void> clearControllers() async {
    log.i('_clearControllers | User Input on cons form is cleared');
    firstNameController.clear();
    lastNameController.clear();
    ageController.clear();
  }
}
