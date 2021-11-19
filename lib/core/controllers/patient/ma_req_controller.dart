import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/constants/app_strings.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/core/controllers/status_controller.dart';
import 'package:davnor_medicare/core/services/image_picker_service.dart';
import 'package:davnor_medicare/core/services/logger_service.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:davnor_medicare/ui/screens/patient/home.dart';
import 'package:davnor_medicare/ui/screens/patient/ma_form2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class MARequestController extends GetxController {
  final log = getLogger('MA Controller');
  static AuthController authController = Get.find();
  final ImagePickerService _imagePickerService = ImagePickerService();
  static StatusController stats = Get.find();

  final uuid = const Uuid();
  final fetchedData = authController.patientModel.value;
  RxBool isMAForYou = true.obs;
  final String userID = auth.currentUser!.uid;
  bool isAvailable = true;

  //Input Data from MA Form
  final RxString imgOfValidID = ''.obs;
  final RxString gender = ''.obs;
  final RxString type = ''.obs;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  final RxList<XFile> images = RxList<XFile>();
  XFile? imgOfValidIDFile;

  //final RxString fileName = ''.obs;
  final RxString listPhotoURL = ''.obs;
  final RxString photoURL = ''.obs;
  final RxString generatedCode = 'MA24'.obs; //MA24 -> mock code

  //Generate unique MA ID
  final RxString generatedMAID = ''.obs;

  bool hasAvailableSlot() {
    final slot = stats.pswdPStatus[0].maSlot!;
    final rqstd = stats.pswdPStatus[0].maRequested!;
    if (slot > rqstd) {
      return true;
    }
    return false;
  }

  bool hasIDSelected() {
    if (imgOfValidID.value != '') {
      return true;
    }
    return false;
  }

  Future<void> assignValues() async {
    if (isMAForYou.value) {
      if (fetchedData!.validID! == '') {
        await fetchnewlyAddedValidID();
      } else {
        imgOfValidID.value = fetchedData!.validID!;
      }
      firstNameController.text = fetchedData!.firstName!;
      lastNameController.text = fetchedData!.lastName!;
    }
  }

  Future<void> fetchnewlyAddedValidID() async {
    await firestore
        .collection('patients')
        .doc(auth.currentUser!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        imgOfValidID.value = data['validID'];
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  Future<void> nextButton() async {
    await assignValues();
    if (hasIDSelected()) {
      await checkEmptyFields();
    } else {
      log.i('ERROR DIALOG: please provide valid ID');
    }
  }

  Future<void> checkEmptyFields() async {
    if (gender.value == '' ||
        type.value == '' ||
        firstNameController.text == '' ||
        lastNameController.text == '' ||
        ageController.text == '' ||
        addressController.text == '') {
      showErrorDialog(
        errorTitle: 'ERROR!',
        errorDescription: 'Please dont leave any empty fields');
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

  Future<void> webMARequest() async {
    await assignValues();
    if (hasIDSelected()) {
      if (gender.value == '' ||
          type.value == '' ||
          firstNameController.text == '' ||
          lastNameController.text == '' ||
          ageController.text == '' ||
          addressController.text == '') {
        //showErrorDialog(errorDescription: 'Please dont leave any empty fields');
        //DAPAT ING-ANI, NAAY TITLE:
        showErrorDialog(
            errorTitle: 'Some fields were missing',
            errorDescription: 'Please dont leave any empty fields');
      } else {
        await requestMAButton();
      }
    } else {
      log.i('ERROR DIALOG: please provide valid ID');
    }
  }

  Future<void> requestMAButton() async {
    showLoading();
    if (hasPrescriptionSelected()) {
      if (hasAvailableSlot()) {
        generatedMAID.value = uuid.v4();
        await uploadAndSaveImgs();
        await saveRequestforMA();
      } else {
        showErrorDialog(
          errorTitle: 'ERROR!',
          errorDescription: 'Sorry, someone already got the last slot.');
      }
      dismissDialog();
    } else {
      dismissDialog();
      showErrorDialog(
        errorTitle: 'ERROR! ',
        errorDescription: 'Please provide prescriptions.');
    }
  }

  Future<void> uploadAndSaveImgs() async {
    if (isMAForYou.value == false) {
      if (kIsWeb) {
        await uploadImageWeb();
      } else {
        await uploadImage();
      }
    }
    if (kIsWeb) {
      await uploadImagesWeb();
    } else {
      await uploadImages();
    }
  }

  Future<void> uploadImage() async {
    final img = imgOfValidID.value;
    final v4 = uuid.v4();
    //log.i('Using UID for making sure of the uniqueness -> $v4');
    //fileName.value = img.split('/').last;
    final ref = storageRef
        .child('MA_Request/$userID/ma_req/${generatedMAID.value}/ID-$v4$v4');
    final uploadTask = ref.putFile(File(img));
    await uploadTask.then((res) async {
      photoURL.value = await res.ref.getDownloadURL();
    });
  }

  Future<void> uploadImageWeb() async {
    final v4 = uuid.v4();
    final fileBytes = imgOfValidIDFile!.readAsBytes();
    final metadata = firebase_storage.SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': imgOfValidID.value});
    final ref = storageRef
        .child('MA_Request/$userID/ma_req/${generatedMAID.value}/ID-$v4$v4');
    final uploadTask = ref.putData(await fileBytes, metadata);
    await uploadTask.then((res) async {
      photoURL.value = await res.ref.getDownloadURL();
    });
  }

  Future<void> uploadImages() async {
    for (var i = 0; i < images.length; i++) {
      final v4 = uuid.v4();
      //fileName.value = images[i].path.split('/').last;
      final ref = storageRef
          .child('MA_Request/$userID/ma_req/${generatedMAID.value}/Pr-$v4$v4');
      await ref.putFile(File(images[i].path)).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          listPhotoURL.value += '$value>>>';
        });
      });
      //log.i('$i -> fileName: $i-Presc$fileName');
    }
  }

  Future<void> uploadImagesWeb() async {
    for (var i = 0; i < images.length; i++) {
      final v4 = uuid.v4();
      final fileBytes = images[i].readAsBytes();
      final ref = storageRef
          .child('MA_Request/$userID/ma_req/${generatedMAID.value}/Pr-$v4$v4');
      final metadata = firebase_storage.SettableMetadata(
          contentType: 'image/jpeg',
          customMetadata: {'picked-file-path': images[i].path});

      await ref.putData(await fileBytes, metadata).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          listPhotoURL.value += '$value>>>';
        });
      });
      //log.i('$i -> fileName: $i-Presc$fileName');
    }
  }

  Future<void> saveRequestforMA() async {
    await firestore.collection('ma_request').doc(generatedMAID.value).set({
      'maID': generatedMAID.value,
      'requesterID': auth.currentUser!.uid,
      'fullName': '${firstNameController.text} ${lastNameController.text}',
      'age': ageController.text,
      'address': addressController.text,
      'gender': gender.value,
      'type': type.value,
      'prescriptions': listPhotoURL.value,
      'validID': isMAForYou.value ? imgOfValidID.value : photoURL.value,
      'date_rqstd': Timestamp.fromDate(DateTime.now()),
    });

    //Generate MA Queue
    final lastNum = stats.pswdPStatus[0].qLastNum! + 1;
    if (lastNum < 10) {
      generatedCode.value = 'MA0$lastNum';
    } else {
      generatedCode.value = 'MA$lastNum';
    }

    await addToMAQueueCollection();
    await updateStatus();

    await showAllData(); //FOR TESTING ONLY
    await clearControllers();
    if (kIsWeb) {
      await showDialogWeb();
    } else {
      await showDialog();
    }
  }

  Future<void> addToMAQueueCollection() async {
    await firestore.collection('ma_queue').doc(generatedMAID.value).set({
      'requesterID': auth.currentUser!.uid,
      'maID': generatedMAID.value,
      'queueNum': generatedCode.value,
      'dateCreated': Timestamp.fromDate(DateTime.now()),
    });
  }

  Future<void> updateStatus() async {
    await firestore
        .collection('pswd_status')
        .doc('status')
        .update({
          'qLastNum': FieldValue.increment(1),
          'maRequested': FieldValue.increment(1)
        })
        .then((value) => log.i('Status Updated'))
        .catchError((error) => log.i('Failed to update status: $error'));

    await firestore
        .collection('patients')
        .doc(userID)
        .collection('status')
        .doc('value')
        .update({'hasActiveQueueMA': true, 'queueMA': generatedCode.value});
  }

  Future<void> showDialog() async {
    final caption =
        'Your priority number is ${generatedCode.value}.\n$dialog4Caption';
    showDefaultDialog(
      dialogTitle: dialog5Title,
      dialogCaption: caption,
      onConfirmTap: () {
        Get.to(() => PatientHomeScreen());
      },
    );
  }

  Future<void> showDialogWeb() async {
    final caption =
        'Your priority number is ${generatedCode.value}.\n$dialog4Caption';
    showDefaultDialog(
      dialogTitle: dialog5Title,
      dialogCaption: caption,
      onConfirmTap: () {
        dismissDialog();
        Get.back();
      },
    );
  }

  Future<void> showAllData() async {
    //FOR TESTING ONLY
    log.i('Full Name: ${firstNameController.text} ${lastNameController.text}');
    log.i('Age: ${ageController.text}, Address: ${addressController.text}');
    log.i('Gender: ${gender.value}, Patient Type: ${type.value}');
    log.i('Document ID: ${generatedMAID.value}');
    log.i('Generated Queue Number: ${generatedCode.value}');
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
    generatedMAID.value = '';
  }

  void pickSingleImage() async {
    imgOfValidIDFile = await _imagePickerService.pickImageOnWeb(imgOfValidID);
  }

  void pickMultiImageS() {
    _imagePickerService.pickMultiImage(images);
  }
}
