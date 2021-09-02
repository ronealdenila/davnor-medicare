import 'package:davnor_medicare/constants/app_strings.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/core/models/category_model.dart';
import 'package:davnor_medicare/core/services/logger.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:davnor_medicare/ui/screens/patient/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ConsController extends GetxController {
  final log = getLogger('Cons Controller');
  static AuthController authController = Get.find();
  final fetchedData = authController.patientModel.value;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  late String fullName =
      '${firstNameController.text} ${lastNameController.text}';

  RxBool isConsultForYou = true.obs;
  RxBool isFollowUp = true.obs;

  String? selectedDiscomfort;

  //Cons Form 3
  final RxList<XFile> images = RxList<XFile>();
  final String generatedCode = 'C025';

  bool hasImagesSelected() {
    if (images.isNotEmpty) {
      return true;
    }
    return false;
  }

  void assignValues() {
    if (isConsultForYou.value) {
      log.w('Self consult. Assigning values from fetched data');
      firstNameController.text = fetchedData!.firstName!;
      lastNameController.text = fetchedData!.lastName!;
    } else {
      log.w('Consult for others. fullname input fetch');
    }
    log.v('patient name: $fullName');
  }

  //For new consult
  Future<void> submitNewConsult() async {
    log.i('submitNewConsult | New Consultation Granted');
    log.v('Choosen discomfort: $selectedDiscomfort');
    log.v('Age: ${ageController.text}');
    log.v('description: ${descriptionController.text}');
    assignValues();
    showDefaultDialog(
        dialogTitle: dialog4Title,
        dialogCaption: dialog4Caption,
        onConfirmTap: () {
          Get.to(() => PatientHomeScreen());
        });
    clearControllers();
  }

  void toggleSingleCardSelection(int index, List<Category> items) {
    for (var indexBtn = 0; indexBtn < items.length; indexBtn++) {
      if (indexBtn == index) {
        items[indexBtn].isSelected = true;
        selectedDiscomfort = items[indexBtn].title;
      } else {
        items[indexBtn].isSelected = false;
      }
    }
  }

  void clearControllers() {
    log.i('_clearControllers | User Input on cons form is cleared');
    firstNameController.clear();
    lastNameController.clear();
    descriptionController.clear();
    ageController.clear();
  }
}
