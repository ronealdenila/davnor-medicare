import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/constants/app_strings.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/core/models/category_model.dart';
import 'package:davnor_medicare/core/models/consultation_model.dart';
import 'package:davnor_medicare/core/services/logger.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:davnor_medicare/ui/screens/patient/cons_form.dart';
import 'package:davnor_medicare/ui/screens/patient/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class ConsController extends GetxController {
  final log = getLogger('Cons Controller');
  final uuid = const Uuid();
  final RxString fileName = ''.obs;

  static AuthController authController = Get.find();
  final fetchedData = authController.patientModel.value;
  final String userID = auth.currentUser!.uid;
  Rxn<PrescriptionModel> prescription = Rxn<PrescriptionModel>();

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
  RxList<XFile> images = RxList<XFile>();
  String imageUrls = '';

  final String generatedCode = 'C025';

  //* (R) how I implemented it: ctrl + left click sa .withConverted naay sample
  //* giprovide mao akong gi basehan
  final prescriptionRef = firestore
      .collection('consultation_request')
      .withConverter<PrescriptionModel>(
        fromFirestore: (snapshot, _) =>
            PrescriptionModel.fromJson(snapshot.data()!),
        toFirestore: (movie, _) => movie.toJson(),
      );

  bool hasImagesSelected() {
    if (images.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<void> pickMultiImage() async {
    final pickedImages = await ImagePicker().pickMultiImage();
    if (pickedImages != null) {
      images.value = pickedImages;
    } else {
      log.e('error occured');
    }
  }

  Future<void> uploadPrescription() async {
    for (var i = 0; i < images.length; i++) {
      final v4 = uuid.v4();
      fileName.value = images[i].path.split('/').last;
      final ref = storageRef.child('PrescriptionImages/$i-Pr-$v4$fileName');
      await ref.putFile(File(images[i].path)).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          imageUrls += '$value>>>';
        });
      });
    }
    log.i('uploadPrescription| $imageUrls image/s save to storage');
  }

  Future<void> submitConsultRequest() async {
    showLoading();
    await uploadPrescription();
    assignValues();
    final prescription = PrescriptionModel(
      patientId: auth.currentUser!.uid,
      fullName: fullName,
      age: ageController.text,
      category: selectedDiscomfort,
      dateRqstd: Timestamp.now(),
      description: descriptionController.text,
      isFollowUp: isFollowUp.value,
      imgs: imageUrls,
    );
    final docRef = await prescriptionRef.add(prescription);
    await initializePrescriptionModel(docRef.id);
    showDefaultDialog(
        dialogTitle: dialog4Title,
        dialogCaption: dialog4Caption,
        onConfirmTap: () {
          Get.to(() => PatientHomeScreen());
        });
    clearControllers();
    fetchedData!.hasActiveQueue = true;
    await updateActiveQueue();

    log.i('submitConsultRequest | Consultation Submit Succesfully');
    log.i('Setting active queue to true');
  }

  Future<void> updateActiveQueue() async {
    await firestore.collection('patients').doc(userID).update(
      {'hasActiveQueue': fetchedData!.hasActiveQueue},
    );
  }

  Future<void> initializePrescriptionModel(String docRef) async {
    prescription.value = await prescriptionRef
        .doc(docRef)
        .get()
        .then((snapshot) => snapshot.data()!);
  }

  void assignValues() {
    if (isConsultForYou.value) {
      log.w('Self consult. Assigning values from fetched data');
      firstNameController.text = fetchedData!.firstName!;
      lastNameController.text = fetchedData!.lastName!;
    } else {
      log.w('Consult for others. fullname from database fetched');
    }
    log.v('patient name: $fullName');
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

  void checkRequestConsultation() {
    if (fetchedData!.hasActiveQueue!) {
      showErrorDialog(
          errorTitle: 'You have existing consultation mofo',
          errorDescription: 'Please proceed to your existing consultation');
    } else {
      showConfirmationDialog(
        dialogTitle: dialog1Title,
        dialogCaption: dialog1Caption,
        onYesTap: () {
          isConsultForYou.value = true;
          Get.to(() => ConsFormScreen());
        },
        onNoTap: () {
          isConsultForYou.value = false;
          Get.to(() => ConsFormScreen());
        },
      );
    }
  }
}
