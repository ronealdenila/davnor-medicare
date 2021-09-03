import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/core/services/logger.dart';
import 'package:image_picker/image_picker.dart';
import 'package:davnor_medicare/ui/screens/patient/ma_form2.dart';
import 'package:davnor_medicare/ui/screens/patient/home.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:davnor_medicare/constants/app_strings.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:get/get.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';

class MAController extends GetxController {
  final log = getLogger('MA Controller');
  static AuthController authController = Get.find();
  final fetchedData = authController.patientModel.value;
  RxBool isMedicalAssistForYou = true.obs;

  //Input Data from MA Form
  final RxString imgOfValidID = ''.obs;
  final RxString gender = ''.obs;
  final RxString type = ''.obs;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  final RxList<XFile> images = RxList<XFile>();

  //Saving Data
  final RxString documentID = ''.obs;
  final RxString generatedCode = 'MA24'.obs; //MA24 -> mock code

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

  Future<void> checkEmptyFields() async {
    if (gender.value == '' ||
        type.value == '' ||
        firstNameController.text == '' ||
        lastNameController.text == '' ||
        ageController.text == '' ||
        addressController.text == '') {
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
      //check slot
      await uploadImages();
      await saveRequestforMA();
    } else {
      log.i('ERROR: please provide prescriptions');
    }
  }

  Future<void> uploadImages() async {
    //upload images to firebase storage
    //get urls and save
  }

  Future<void> saveRequestforMA() async {
    final docRef = await firestore.collection('ma_request').add({
      'requester_id': auth.currentUser!.uid,
      'firstName': firstNameController.text,
      'lastName': lastNameController.text,
      'age': ageController.text,
      'address': addressController.text,
      'gender': gender.value,
      'type': type.value,
      'prescription': '',
      'valid_id': '',
      'date_rqstd': Timestamp.fromDate(DateTime.now()),
      'isTurn': false, //should be true if mao ang first request
    });

    documentID.value = docRef.id; //save id bcs it will be save w/ the queueNum

    //Generate MA Queue
    await showAllData(); //FOR TESTING ONLY
    await clearControllers();
    await showDialog();
  }

  Future<void> showDialog() async {
    final caption = 'Your priority number is $generatedCode.\n$dialog4Caption';
    showDefaultDialog(
      dialogTitle: dialog5Title,
      dialogCaption: caption,
      onConfirmTap: () {
        Get.to(() => PatientHomeScreen());
      },
    );
  }

  Future<void> showAllData() async {
    //FOR TESTING ONLY
    log.i('Full Name: ${firstNameController.text} ${lastNameController.text}');
    log.i('Age: ${ageController.text}, Address: ${addressController.text}');
    log.i('Gender: ${gender.value}, Patient Type: ${type.value}');
  }

  Future<void> clearControllers() async {
    log.i('_clearControllers | User Input on MA form is cleared');
    firstNameController.clear();
    lastNameController.clear();
    ageController.clear();
    addressController.clear();
    images.value = [];
    imgOfValidID.value = '';
    gender.value = '';
    type.value = '';
  }
}
