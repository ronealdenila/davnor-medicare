import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/constants/app_strings.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/core/models/pswd_stats_model.dart';
import 'package:davnor_medicare/core/services/image_picker_service.dart';
import 'package:davnor_medicare/core/services/logger_service.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:davnor_medicare/ui/screens/patient/home.dart';
import 'package:davnor_medicare/ui/screens/patient/ma_form2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class MARequestController extends GetxController {
  final log = getLogger('MA Controller');
  static AuthController authController = Get.find();
  final ImagePickerService _imagePickerService = ImagePickerService();

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

  //Saving Data
  final RxString documentID = ''.obs;
  //final RxString fileName = ''.obs;
  final RxString listPhotoURL = ''.obs;
  final RxString photoURL = ''.obs;
  final RxString generatedCode = 'MA24'.obs; //MA24 -> mock code

  RxList<PSWDStatusModel> statusList = RxList<PSWDStatusModel>();

  @override
  void onReady() {
    super.onReady();
    log.i('ONREADY');
    statusList.bindStream(getStatus());
  }

  Stream<List<PSWDStatusModel>> getStatus() {
    log.i('MA Queue Controller | Get PSWD Status');
    return firestore.collection('pswd_status').snapshots().map(
          (query) => query.docs
              .map((item) => PSWDStatusModel.fromJson(item.data()))
              .toList(),
        );
  }

  bool hasAvailableSlot() {
    final slot = statusList[0].maSlot!;
    final rqstd = statusList[0].maRequested!;
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
    showLoading();
    if (hasPrescriptionSelected()) {
      if (hasAvailableSlot()) {
        //check slot again
        await uploadAndSaveImgs();
        await saveRequestforMA();
      } else {
        //sorry naunhan naka, naay mas paspas mu fill up
      }
      dismissDialog();
    } else {
      dismissDialog();
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
    //log.i('Using UID for making sure of the uniqueness -> $v4');
    //fileName.value = img.split('/').last;
    final ref = storageRef.child('MA_Request/$userID/ID-$v4$v4');
    final uploadTask = ref.putFile(File(img));
    await uploadTask.then((res) async {
      photoURL.value = await res.ref.getDownloadURL();
    });
  }

  Future<void> uploadImages() async {
    for (var i = 0; i < images.length; i++) {
      final v4 = uuid.v4();
      //fileName.value = images[i].path.split('/').last;
      final ref = storageRef.child('MA_Request/$userID/Pr-$v4$v4');
      await ref.putFile(File(images[i].path)).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          listPhotoURL.value += '$value>>>';
        });
      });
      //log.i('$i -> fileName: $i-Presc$fileName');
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
    final lastNum = statusList[0].qLastNum! + 1;
    if (lastNum < 10) {
      generatedCode.value = 'MA0$lastNum';
    } else {
      generatedCode.value = 'MA$lastNum';
    }

    await addToMAQueueCollection();
    await updateStatus();

    await showAllData(); //FOR TESTING ONLY
    await clearControllers();
    await showDialog();
  }

  Future<void> addToMAQueueCollection() async {
    await firestore.collection('ma_queue').doc(documentID.value).set({
      'requesterID': auth.currentUser!.uid,
      'maID': documentID.value,
      'queueNum': generatedCode.value,
      'dateCreated': Timestamp.fromDate(DateTime.now()),
    });
  }

  Future<void> updateStatus() async {
    await firestore
        .collection('pswd_status')
        .doc('status')
        .update({
          'qLastNum': statusList[0].qLastNum! + 1,
          'maRequested': statusList[0].maRequested! + 1
        })
        .then((value) => log.i('Status Updated'))
        .catchError((error) => log.i('Failed to update status: $error'));

    await firestore
        .collection('patients')
        .doc(userID)
        .collection('status')
        .doc('value')
        .update({'hasActiveQueueMA': true, 'queueMA': generatedCode});
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
    log.i('Document ID: ${documentID.value}');
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
  }

  void pickSingleImage() {
    _imagePickerService.pickImage(imgOfValidID);
  }

  void pickMultiImage() {
    _imagePickerService.pickMultiImage(images);
  }
}
