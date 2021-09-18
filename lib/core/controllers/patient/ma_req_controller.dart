import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/core/services/image_picker_service.dart';
import 'package:davnor_medicare/core/services/logger_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:davnor_medicare/ui/screens/patient/ma_form2.dart';
import 'package:davnor_medicare/ui/screens/patient/home.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:davnor_medicare/constants/app_strings.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:get/get.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:uuid/uuid.dart';

class MARequestController extends GetxController {
  final log = getLogger('MA Controller');

  static AuthController authController = Get.find();
  final ImagePickerService _imagePickerService = ImagePickerService();

  final uuid = const Uuid();

  final fetchedData = authController.patientModel.value;
  RxBool isMAForYou = true.obs;
  final String userID = auth.currentUser!.uid;

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
  final RxString fileName = ''.obs;
  final RxString listPhotoURL = ''.obs;
  final RxString photoURL = ''.obs;
  final RxString generatedCode = 'MA24'.obs; //MA24 -> mock code

  bool hasIDSelected() {
    if (imgOfValidID.value != '') {
      return true;
    }
    return false;
  }

  Future<void> assignValues() async {
    if (isMAForYou.value) {
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
    //should have loading progress
    if (hasPrescriptionSelected()) {
      //check slot

      await uploadAndSaveImgs();
      await saveRequestforMA();
    } else {
      log.i('ERROR: please provide prescriptions');
    }
  }

  Future<void> uploadAndSaveImgs() async {
    if (isMAForYou.value == false) {
      await uploadImage();
    }
    await uploadImages();
  }

  Future<void> uploadImage() async {
    final img = imgOfValidID.value;
    final v4 = uuid.v4();
    log.i('UNQ? -> $v4');
    fileName.value = img.split('/').last;
    final ref = storageRef.child('MA/ID-$v4$fileName');
    final uploadTask = ref.putFile(File(img));
    await uploadTask.then((res) async {
      photoURL.value = await res.ref.getDownloadURL();
    });
  }

  Future<void> uploadImages() async {
    for (var i = 0; i < images.length; i++) {
      final v4 = uuid.v4();
      fileName.value = images[i].path.split('/').last;
      final ref = storageRef.child('MA/$i-Pr-$v4$fileName');
      await ref.putFile(File(images[i].path)).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          listPhotoURL.value += '$value>>>';
        });
      });
      log.i('$i -> fileName: $i-Presc$fileName');
    }
  }

  Future<void> saveRequestforMA() async {
    final docRef = await firestore.collection('ma_request').add({
      'requesterID': auth.currentUser!.uid,
      'fullName': '${firstNameController.text} ${lastNameController.text}',
      'age': ageController.text,
      'address': addressController.text,
      'gender': gender.value,
      'type': type.value,
      'prescriptions': listPhotoURL.value,
      'validID': isMAForYou.value ? imgOfValidID.value : photoURL.value,
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
    listPhotoURL.value = '';
    photoURL.value = '';
  }

  void pickSingleImage() {
    _imagePickerService.pickImage(imgOfValidID);
  }

  void pickMultiImage() {
    _imagePickerService.pickMultiImage(images);
  }
}
