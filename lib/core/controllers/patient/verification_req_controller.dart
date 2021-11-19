import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/constants/app_strings.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/services/image_picker_service.dart';
import 'package:davnor_medicare/core/services/logger_service.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:get/get.dart';

class VerificationController extends GetxController {
  final log = getLogger('Verification Screen');

  static AuthController authController = Get.find();
  final ImagePickerService _imagePickerService = ImagePickerService();
  final uuid = const Uuid();
  final String userID = auth.currentUser!.uid;

  final fetchedData = authController.patientModel.value;

  final RxString imgOfValidID = ''.obs;
  final RxString imgOfValidIDWithSelfie = ''.obs;
  XFile? imgOfValidIDWeb;
  XFile? imgOfValidIDWithSelfiWeb;
  final RxString imgURL = ''.obs;
  final RxString imgURLselfie = ''.obs;
  final RxString file = ''.obs;

  Stream<DocumentSnapshot> getStatus() {
    final Stream<DocumentSnapshot> doc = firestore
        .collection('patients')
        .doc(userID)
        .collection('status')
        .doc('value')
        .snapshots();
    return doc;
  }

  Future<void> uploadID(String filePathID) async {
    final v4 = uuid.v4();
    final ref = storageRef.child('user/$userID/Valid-ID-$v4$v4');
    final uploadTask = ref.putFile(File(filePathID));
    await uploadTask.then((res) async {
      imgURL.value = await res.ref.getDownloadURL();
    });
  }

  Future<void> uploadIDS(String filePathIDS) async {
    final v4 = uuid.v4();
    final ref = storageRef.child('user/$userID/Valid-ID-Selfie-$v4$v4');
    final uploadTask = ref.putFile(File(filePathIDS));
    await uploadTask.then((res) async {
      imgURLselfie.value = await res.ref.getDownloadURL();
    });
  }

  Future<void> uploadIDWeb(XFile image) async {
    final v4 = uuid.v4();
    final fileBytes = image.readAsBytes();
    final metadata = firebase_storage.SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': image.path});
    final ref = storageRef.child('user/$userID/ID-$v4$v4');
    final uploadTask = ref.putData(await fileBytes, metadata);
    await uploadTask.then((res) async {
      imgURL.value = await res.ref.getDownloadURL();
    });
  }

  Future<void> uploadIDSDWeb(XFile image) async {
    final v4 = uuid.v4();
    final fileBytes = image.readAsBytes();
    final metadata = firebase_storage.SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': image.path});
    final ref = storageRef.child('user/$userID/Valid-ID-Selfie-$v4$v4');
    final uploadTask = ref.putData(await fileBytes, metadata);
    await uploadTask.then((res) async {
      imgURLselfie.value = await res.ref.getDownloadURL();
    });
  }

  bool hasImagesSelected() {
    if (imgOfValidID.value != '' && imgOfValidIDWithSelfie.value != '') {
      return true;
    }
    return false;
  }

  Future<void> addVerificationRequest() async {
    showLoading();
    if (kIsWeb) {
      await uploadIDWeb(imgOfValidIDWeb!);
      await uploadIDSDWeb(imgOfValidIDWeb!);
    } else {
      await uploadID(imgOfValidID.value);
      await uploadIDS(imgOfValidIDWithSelfie.value);
    }
    await firestore.collection('to_verify').doc(userID).set({
      'patientID': userID,
      'firstName': fetchedData!.firstName,
      'lastName': fetchedData!.lastName,
      'validID': imgURL.value,
      'validSelfie': imgURLselfie.value,
      'dateRqstd': Timestamp.fromDate(DateTime.now()),
    });
    await setPendingVerification();
    await clearData();
    await showDialog();
  }

  Future<void> setPendingVerification() async {
    await firestore
        .collection('patients')
        .doc(userID)
        .collection('status')
        .doc('value')
        .update({'pendingVerification': true});
  }

  void submitVerification() {
    if (hasImagesSelected()) {
      addVerificationRequest();
    } else {
      Get.snackbar(
        'Submit Failed',
        'Please select your valid ID and w/ Selfie',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void pickValidID() async {
    imgOfValidIDWeb = await _imagePickerService.pickImageOnWeb(imgOfValidID);
  }

  void pickValidIDWithSelfie() async {
    imgOfValidIDWithSelfiWeb =
        await _imagePickerService.pickImageOnWeb(imgOfValidIDWithSelfie);
  }

  Future<void> showDialog() async {
    showDefaultDialog(
      dialogTitle: dialog6Title,
      dialogCaption: dialog6Caption,
      onConfirmTap: () {
        dismissDialog();
        Get.back();
      },
    );
  }

  Future<void> clearData() async {
    dismissDialog();
    imgOfValidID.value = '';
    imgOfValidIDWithSelfie.value = '';
    imgURL.value = '';
    imgURLselfie.value = '';
    file.value = '';
  }
}
