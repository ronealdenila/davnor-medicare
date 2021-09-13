import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/constants/app_items.dart';
import 'package:davnor_medicare/constants/app_strings.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/core/models/consultation_model.dart';
import 'package:davnor_medicare/core/services/image_picker_service.dart';
import 'package:davnor_medicare/core/services/logger_service.dart.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:davnor_medicare/ui/screens/patient/cons_form.dart';
import 'package:davnor_medicare/ui/screens/patient/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class ConsRequestController extends GetxController {
  final log = getLogger('Cons Controller');

  static AuthController authController = Get.find();
  final ImagePickerService _imagePickerService = ImagePickerService();
  final fetchedData = authController.patientModel.value;

  final uuid = const Uuid();
  final RxString fileName = ''.obs;

  final String userID = auth.currentUser!.uid;
  Rxn<ConsultationModel> consultation = Rxn<ConsultationModel>();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  late String fullName =
      '${firstNameController.text} ${lastNameController.text}';

  RxBool isConsultForYou = true.obs;
  RxInt selectedIndex = 0.obs;

  //Cons Form 2
  RxBool isFollowUp = true.obs;
  String? selectedDiscomfort;

  //Cons Form 3
  RxList<XFile> images = RxList<XFile>();
  String imageUrls = '';

  final String generatedCode = 'C025';

  final consultRef =
      firestore.collection('cons_request').withConverter<ConsultationModel>(
            fromFirestore: (snapshot, _) =>
                ConsultationModel.fromJson(snapshot.data()!),
            toFirestore: (snapshot, _) => snapshot.toJson(),
          );

  bool hasImagesSelected() {
    if (images.isNotEmpty) {
      return true;
    }
    return false;
  }

  late String documentId;

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
    final consultation = ConsultationModel(
      consId: 'null',
      patientId: auth.currentUser!.uid,
      fullName: fullName,
      age: ageController.text,
      category: selectedDiscomfort,
      dateRqstd: Timestamp.now().microsecondsSinceEpoch.toString(),
      description: descriptionController.text,
      isFollowUp: isFollowUp.value,
      imgs: imageUrls,
    );
    final docRef = await consultRef.add(consultation);
    documentId = docRef.id;
    await updateId();
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
  }

  Future<void> updateId() async => firestore
      .collection('cons_request')
      .doc(documentId)
      .update({
        'consId': documentId,
      })
      .then((value) => log.i('Consultation ID initialized'))
      .catchError((error) => log.w('Failed to update cons Id'));

  Future<void> updateActiveQueue() async {
    log.i('updateActiveQueue | Setting active queue to true');
    await firestore.collection('patients').doc(userID).update(
      {'hasActiveQueue': fetchedData!.hasActiveQueue},
    );
  }

  Future<void> initializePrescriptionModel(String docRef) async {
    consultation.value =
        await consultRef.doc(docRef).get().then((snapshot) => snapshot.data()!);
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

  void toggleSingleCardSelection(int index) {
    for (var indexBtn = 0; indexBtn < discomfortData.length; indexBtn++) {
      if (indexBtn == index) {
        selectedIndex.value = index;
        selectedDiscomfort = discomfortData[indexBtn].title;
        log.wtf('$selectedDiscomfort is selected');
      } else {}
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

  void pickForFollowUpImages() {
    _imagePickerService.pickMultiImage(images);
  }
}
