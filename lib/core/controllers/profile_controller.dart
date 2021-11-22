import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/core/services/image_picker_service.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';

import 'package:davnor_medicare/core/services/logger_service.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ProfileController extends GetxController {
  final log = getLogger('Profile Controller');
  final ImagePickerService imagePicker = ImagePickerService();

  static AuthController authController = Get.find();
  final fetchedData = authController.patientModel.value;
  XFile? imageSelected;
  RxString imagePath = ''.obs;
  RxString url = ''.obs;

  @override
  void onReady() {
    super.onReady();
    log.i('ONREADY');
  }

  bool hasValidIDandValidSelfie() {
    if (fetchedData!.validID == '' && fetchedData!.validSelfie == '') {
      return false;
    }
    return true;
  }

  Stream<DocumentSnapshot> getProfilePatient() {
    return firestore
        .collection('patients')
        .doc(auth.currentUser!.uid)
        .snapshots();
  }

  Stream<DocumentSnapshot> getProfileDoctor() {
    return firestore
        .collection('doctors')
        .doc(auth.currentUser!.uid)
        .snapshots();
  }

  Stream<DocumentSnapshot> getProfilePSWD() {
    return firestore
        .collection('pswd_personnel')
        .doc(auth.currentUser!.uid)
        .snapshots();
  }

  Stream<DocumentSnapshot> getProfileAdmin() {
    return firestore
        .collection('admins')
        .doc(auth.currentUser!.uid)
        .snapshots();
  }

  void selectProfileImage() async {
    imageSelected = await imagePicker.pickImageOnWeb(imagePath);
    if (imageSelected != null || imagePath.value != '') {
      //upload photo automatically ???
      await uploadImageWeb();
    }
  }

  Future<void> uploadImageWeb() async {
    final fileBytes = imageSelected!.readAsBytes();
    final metadata = firebase_storage.SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': imagePath.value});
    final ref = storageRef.child('user/${auth.currentUser!.uid}/profile-photo');
    final uploadTask = ref.putData(await fileBytes, metadata);
    await uploadTask.then((res) async {
      url.value = await res.ref.getDownloadURL();
      //send to collection -> change to different ROLES TOO
      updateStatus('patients');
    });
  }

  Future<void> updateStatus(String role) async {
    await firestore.collection(role).doc(auth.currentUser!.uid).update({
      'profileImage': url.value,
    });
  }
}
