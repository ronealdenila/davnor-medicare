import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/constants/app_strings.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/services/image_picker_service.dart';
import 'package:davnor_medicare/core/services/logger_service.dart.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:davnor_medicare/ui/screens/patient/home.dart';
import 'package:get/get.dart';

class VerificationController extends GetxController {
  final log = getLogger('Verification Screen');
  final ImagePickerService _imagePickerService = ImagePickerService();

  final String userID = auth.currentUser!.uid;

  final RxString imgOfValidID = ''.obs;
  final RxString imgOfValidIDWithSelfie = ''.obs;
  final RxString imgURL = ''.obs;
  final RxString imgURLselfie = ''.obs;
  final RxString file = ''.obs;

  Future<void> uploadID(String filePathID) async {
    file.value = filePathID.split('/').last;
    final ref = storageRef.child('verification/$userID/Valid-ID-$file');
    final uploadTask = ref.putFile(File(filePathID));
    await uploadTask.then((res) async {
      imgURL.value = await res.ref.getDownloadURL();
    });
  }

  Future<void> uploadIDS(String filePathIDS) async {
    file.value = filePathIDS.split('/').last;
    final ref = storageRef.child('verification/$userID/Valid-ID-Selfie-$file');
    final uploadTask = ref.putFile(File(filePathIDS));
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
    await uploadID(imgOfValidID.value);
    await uploadIDS(imgOfValidIDWithSelfie.value);
    await firestore.collection('to_verify').add({
      'patientID': auth.currentUser!.uid,
      'validID': imgURL.value,
      'validSelfie': imgURLselfie.value,
      'dateRqstd': Timestamp.fromDate(DateTime.now()),
    });
    //update user hasPendingStatus
    await showDialog();
  }

  void submitVerification() {
    if (hasImagesSelected()) {
      addVerificationRequest();
    } else {
      //TODO: Add error Dialog
    }
  }

  void pickValidID() {
    _imagePickerService.pickImage(imgOfValidID);
  }

  void pickValidIDWithSelfie() {
    _imagePickerService.pickImage(imgOfValidIDWithSelfie);
  }

  Future<void> showDialog() async {
    showDefaultDialog(
      dialogTitle: dialog6Title,
      dialogCaption: dialog6Caption,
      onConfirmTap: () => Get.to(() => PatientHomeScreen()),
    );
  }
}
