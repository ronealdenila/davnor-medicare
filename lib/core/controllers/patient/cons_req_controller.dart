import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/constants/app_items.dart';
import 'package:davnor_medicare/constants/app_strings.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/core/models/cons_stats_model.dart';
import 'package:davnor_medicare/core/models/consultation_model.dart';
import 'package:davnor_medicare/core/services/image_picker_service.dart';
import 'package:davnor_medicare/core/services/logger_service.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:davnor_medicare/ui/screens/patient/cons_form2.dart';
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
  //final RxString fileName = ''.obs;
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
  RxString categoryID = ''.obs;

  //Cons Form 2
  RxBool isFollowUp = true.obs;
  String? selectedDiscomfort;

  //Cons Form 3
  RxList<XFile> images = RxList<XFile>();
  String imageUrls = '';
  final RxString generatedCode = 'C025'.obs; //MA24 -> mock code
  late String documentId;

  RxList<ConsStatusModel> statusList = RxList<ConsStatusModel>();
  RxInt statusIndex = 0.obs;
  RxString categoryHolder = ''.obs;
  RxString specialistD = 'Otolaryngologist (ENT)'.obs;

  @override
  void onReady() {
    super.onReady();
    log.i('ONREADY');
    statusList.bindStream(getStatus());
  }

  Stream<List<ConsStatusModel>> getStatus() {
    log.i('Cons Queue Controller | Get PSWD Status');
    return firestore.collection('cons_status').snapshots().map(
          (query) => query.docs
              .map((item) => ConsStatusModel.fromJson(item.data()))
              .toList(),
        );
  }

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

  Future<void> uploadLabResults() async {
    for (var i = 0; i < images.length; i++) {
      final v4 = uuid.v4();
      //fileName.value = images[i].path.split('/').last;
      final ref = storageRef.child('Cons_Request/$userID/Pr-$v4$v4');
      await ref.putFile(File(images[i].path)).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          imageUrls += '$value>>>';
        });
      });
    }
    log.i('uploadPrescription| $imageUrls image/s save to storage');
  }

  bool hasAvailableSlot() {
    //TO DO: if zero mean no doctor is online
    final slot = statusList[statusIndex.value].consSlot!;
    final rqstd = statusList[statusIndex.value].consRqstd!;
    if (slot > rqstd) {
      return true;
    }
    return false;
  }

  Future<void> submitConsultRequest() async {
    if (hasAvailableSlot()) {
      showLoading();
      await uploadLabResults();
      assignValues();
      final consultation = ConsultationModel(
        consID: '',
        patientId: auth.currentUser!.uid,
        fullName: fullName,
        age: ageController.text,
        category: categoryID.value,
        dateRqstd: Timestamp.fromDate(DateTime.now()),
        description: descriptionController.text,
        isFollowUp: isFollowUp.value ? false : true,
        imgs: imageUrls,
      );

      final docRef = await consultRef.add(consultation);
      documentId = docRef.id; //save id bcs it will be save w/ the queueNum
      await updateId();

      await initializeConsultationModel(docRef.id);

      //Generate Cons Queue
      final lastNum = statusList[statusIndex.value].qLastNum! + 1;
      if (lastNum < 10) {
        generatedCode.value = 'C0$lastNum';
      } else {
        generatedCode.value = 'C$lastNum';
      }

      await addToConsQueueCollection();
      await updateStatus(); //update patient status and cons status

      dismissDialog();
      await clearControllers();
      await showDialog();
      log.i('submitConsultRequest | Consultation Submit Succesfully');
    } else {
      showErrorDialog(
          errorTitle: 'Sorry, there are no slot available for now',
          errorDescription: 'Please try again next time');
      log.i('submitConsultRequest | Consultation Submit Failed');
    }
  }

  Future<void> addToConsQueueCollection() async {
    await firestore.collection('cons_queue').doc(documentId).set({
      'categoryID': categoryID.value,
      'requesterID': auth.currentUser!.uid,
      'consID': documentId,
      'queueNum': generatedCode.value,
      'dateCreated': Timestamp.fromDate(DateTime.now()),
    });
  }

  Future<void> showDialog() async {
    final caption = 'Your priority number is $generatedCode.\n$dialog4Caption';
    showDefaultDialog(
        dialogTitle: dialog4Title,
        dialogCaption: caption,
        onConfirmTap: () {
          Get.to(() => PatientHomeScreen());
        });
  }

  Future<void> updateId() async => firestore
      .collection('cons_request')
      .doc(documentId)
      .update({
        'consID': documentId,
      })
      .then((value) => log.i('Consultation ID initialized'))
      .catchError((error) => log.w('Failed to update cons Id'));

  Future<void> updateStatus() async {
    await firestore
        .collection('cons_status')
        .doc(categoryID.value)
        .update({
          'qLastNum': statusList[statusIndex.value].qLastNum! + 1,
          'consRqstd': statusList[statusIndex.value].consRqstd! + 1
        })
        .then((value) => log.i('Status Updated'))
        .catchError((error) => log.i('Failed to update status: $error'));

    log.i('updateActiveQueue | Setting active queue to true');
    await firestore
        .collection('patients')
        .doc(userID)
        .collection('status')
        .doc('value')
        .update(
      {
        'hasActiveQueueCons': true,
        'queueCons': generatedCode.value,
        'categoryID': categoryID.value
      },
    );
  }

  Future<void> initializeConsultationModel(String docRef) async {
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

  Future<void> toggleSingleCardSelection(int index) async {
    for (var indexBtn = 0; indexBtn < discomfortData.length; indexBtn++) {
      if (indexBtn == index) {
        selectedIndex.value = index;
        categoryHolder.value = discomfortData[indexBtn].categoryID!;
        specialistD.value = discomfortData[indexBtn].specialist!;
        log.i('Temporary: ${categoryHolder.value} is selected');
      } else {}
    }
  }

  Future<void> nextButton() async {
    if (categoryHolder == '') {
      await getconsultationCategory(specialistD.value);
    } else {
      categoryID.value = categoryHolder.value;
    }
    log.wtf('Final: ${categoryID.value} is selected');
    await Get.to(() => ConsForm2Screen());
  }

  Future<void> getconsultationCategory(String specialistD) async {
    final ageInput = ageController.text == '' ? '0' : ageController.text;
    final parseAge = int.parse(ageInput);
    assert(parseAge is int);
    final dept = parseAge >= 18 ? 'Family Department' : 'Pediatrics Department';
    for (var i = 0; i < statusList.length; i++) {
      if (statusList[i].deptName == dept &&
          statusList[i].title == specialistD) {
        statusIndex.value = i;
        categoryID.value = statusList[i].categoryID!;
        return;
      }
    }
    if (categoryID.value == '') {
      print('CATEGORY NOT FOUND');
    }
  }

  Future<void> clearControllers() async {
    log.i('_clearControllers | User Input on cons form is cleared');
    firstNameController.clear();
    lastNameController.clear();
    descriptionController.clear();
    ageController.clear();
  }

  void pickForFollowUpImagess() {
    _imagePickerService.pickMultiImage(images);
  }
}
