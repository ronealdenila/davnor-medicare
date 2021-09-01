import 'package:davnor_medicare/core/services/logger.dart';
import 'package:image_picker/image_picker.dart';
import 'package:davnor_medicare/ui/screens/patient/ma_form2.dart';
import 'package:davnor_medicare/ui/screens/patient/home.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:davnor_medicare/constants/app_strings.dart';
import 'package:get/get.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';

class MAController extends GetxController {
  final log = getLogger('MA Controller');
  static AuthController authController = Get.find();
  final fetchedData = authController.patientModel.value;
  RxBool isMedicalAssistForYou = true.obs;

  //MA Form
  final RxString imgOfValidID = ''.obs;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  //MA Form 2
  final RxList<XFile> images = RxList<XFile>();
  final String generatedCode = 'MA24';

  bool hasIDSelected() {
    if (imgOfValidID.value != '') {
      return true;
    }
    return false;
  }

  Future<void> assignValues() async {
    if (isMedicalAssistForYou.value) {
      firstNameController.text = fetchedData!.firstName!;
      lastNameController.text = fetchedData!.lastName!;
      imgOfValidID.value = 'kay null sa firestore'; //fetchedData!.validId!;
    }
  }

  Future<void> nextButton() async {
    await assignValues();
    if (hasIDSelected()) {
      await checkEmptyFields();
    } else {
      log.i('ERROR: please provide valid ID');
    }
  }

  bool isEmpty = false; //TEMPORARY
  Future<void> checkEmptyFields() async {
    if (isEmpty) {
      //condition for checking fields
      log.i('ERROR: please dont leave any empty fields');
    } else {
      await Get.to(() => MAForm2Screen());
    }
  }

  bool hasPrescriptionSelected() {
    if (images.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<void> requestMAButton() async {
    if (hasPrescriptionSelected()) {
      //precriptions
      //check slot
      await uploadImages();
      await sendDataAsMAReq();
      //Generate MA Queue and show to dialog
    } else {
      log.i('ERROR: please provide prescriptions');
    }
  }

  Future<void> uploadImages() async {
    //upload images to firebase storage
    //get urls and save
  }

  Future<void> sendDataAsMAReq() async {
    final caption = 'Your priority number is $generatedCode.\n$dialog4Caption';
    //save data to ma_request collection
    await showAllData();
    await clearControllers();
    showDefaultDialog(
      dialogTitle: dialog5Title,
      dialogCaption: caption,
      onConfirmTap: () {
        Get.to(() => PatientHomeScreen());
      },
    );
  }

  Future<void> showAllData() async {
    log.i('Full Name: ${firstNameController.text} ${lastNameController.text}');
    log.i('Age: ${ageController.text}, Address: ${addressController.text}');
  }

  Future<void> clearControllers() async {
    log.i('_clearControllers | User Input on MA form is cleared');
    firstNameController.clear();
    lastNameController.clear();
    ageController.clear();
    addressController.clear();
    images.value = [];
    imgOfValidID.value = '';
  }
}
