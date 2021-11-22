import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/core/models/chat_model.dart';
import 'package:davnor_medicare/core/models/consultation_model.dart';
import 'package:davnor_medicare/core/models/user_model.dart';
import 'package:davnor_medicare/core/services/logger_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ConsHistoryController extends GetxController {
  final log = getLogger('Consultation History Controller');
  static AuthController authController = Get.find();
  final RxBool isLoading = true.obs;
  final RxBool isLoadingAdditionalData = true.obs;
  final RxBool chatDone = false.obs;

  RxList<ConsultationHistoryModel> consHistory =
      RxList<ConsultationHistoryModel>([]);
  RxList<ChatModel> chatHistory = RxList<ChatModel>([]);

  //searching consultation history in doctor side...
  RxList<ConsultationHistoryModel> filteredListforDoc =
      RxList<ConsultationHistoryModel>([]);
  final TextEditingController searchKeyword = TextEditingController();

  //searching consultation history in patient side...
  RxList<ConsultationHistoryModel> filteredListforP =
      RxList<ConsultationHistoryModel>([]);

  @override
  void onReady() {
    super.onReady();
    log.i('onReady | Cons History');
    if (authController.userRole == 'doctor') {
      getConsHistoryForDoctor().then((value) {
        consHistory.value = value;
        filteredListforDoc.assignAll(consHistory);
        isLoading.value = false;
      });
    } else if (authController.userRole == 'patient') {
      getConsHistoryForPatient().then((value) {
        consHistory.value = value;
        filteredListforP.assignAll(consHistory);
        isLoading.value = false;
      });
    }
  }

  Future<List<ConsultationHistoryModel>> getConsHistoryForPatient() async {
    log.i('Get Cons History for Patient - ${auth.currentUser!.uid}');
    return firestore
        .collection('cons_history')
        .where('patientId', isEqualTo: auth.currentUser!.uid)
        .orderBy('dateConsEnd')
        .get()
        .then(
          (query) => query.docs
              .map((item) => ConsultationHistoryModel.fromJson(item.data()))
              .toList(),
        )
        .catchError((onError) {
      print(onError);
      isLoading.value = false;
    });
  }

  Future<List<ConsultationHistoryModel>> getConsHistoryForDoctor() async {
    log.i('Get Cons History for Doctor - ${auth.currentUser!.uid}');
    return firestore
        .collection('cons_history')
        .where('docID', isEqualTo: auth.currentUser!.uid)
        .orderBy('dateConsEnd')
        .get()
        .then(
          (query) => query.docs
              .map((item) => ConsultationHistoryModel.fromJson(item.data()))
              .toList(),
        )
        .catchError((onError) {
      print(onError);
      isLoading.value = false;
    });
  }

  Future<void> getAdditionalData(ConsultationHistoryModel model) async {
    await getPatientData(model);
    await getDoctorData(model);
    //isLoadingAdditionalData.value = false;
  }

  Future<void> getPatientData(ConsultationHistoryModel model) async {
    model.patient.value = await firestore
        .collection('patients')
        .doc(model.patientId)
        .get()
        .then((doc) => PatientModel.fromJson(doc.data()!));
    isLoadingAdditionalData.value = false;
  }

  Future<void> getDoctorData(ConsultationHistoryModel model) async {
    model.doc.value = await firestore
        .collection('doctors')
        .doc(model.docID)
        .get()
        .then((doc) => DoctorModel.fromJson(doc.data()!));
    isLoadingAdditionalData.value = false;
  }

  String getPatientProfile(ConsultationHistoryModel model) {
    return model.patient.value!.profileImage!;
  }

  String getPatientFirstName(ConsultationHistoryModel model) {
    return model.patient.value!.firstName!;
  }

  String getPatientLastName(ConsultationHistoryModel model) {
    return model.patient.value!.lastName!;
  }

  String getPatientName(ConsultationHistoryModel model) {
    return '${getPatientFirstName(model)} ${getPatientLastName(model)}';
  }

  String getDoctorProfile(ConsultationHistoryModel model) {
    return model.doc.value!.profileImage!;
  }

  String getDoctorFirstName(ConsultationHistoryModel model) {
    return model.doc.value!.firstName!;
  }

  String getDoctorLastName(ConsultationHistoryModel model) {
    return model.doc.value!.lastName!;
  }

  String getDoctorFullName(ConsultationHistoryModel model) {
    return '${getDoctorFirstName(model)} ${getDoctorLastName(model)}';
  }

  String convertDate(Timestamp recordTime) {
    final dt = recordTime.toDate();
    return DateFormat.yMMMd().add_jm().format(dt);
  }

  Future<void> getChatHistory(ConsultationHistoryModel model) async {
    log.i(model.consID);
    await firestore
        .collection('chat')
        .doc(model.consID)
        .collection('messages')
        .orderBy('dateCreated', descending: true)
        .get()
        .then((value) {
      for (final result in value.docs) {
        chatHistory.add(ChatModel.fromJson(result.data()));
      }
    });
  }

  filterForDoctor({required String name}) {
    filteredListforDoc.assignAll(consHistory);
    consHistory.clear();

    //filter for name of patient only
    if (name != '') {
      for (var i = 0; i < filteredListforDoc.length; i++) {
        if (filteredListforDoc[i]
            .fullName!
            .toLowerCase()
            .contains(name.toLowerCase())) {
          consHistory.add(filteredListforDoc[i]);
        }
      }
    }
  }

  showDialog(context) {
    Get.dialog(AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Container(
        color: Colors.white,
        height: kIsWeb ? Get.height * 0.30 : Get.height * .45,
        width: kIsWeb ? Get.width * 0.20 : Get.width * .9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SfDateRangePicker(
              onSelectionChanged: onSelectionChanged,
              selectionMode: DateRangePickerSelectionMode.single,
            ),
          ],
        ),
      ),
    ));
  }

  String getMonth(Timestamp time) {
    return time.toDate().month.toString();
  }

  String getDate(Timestamp time) {
    return time.toDate().day.toString();
  }

  String getYear(Timestamp time) {
    return time.toDate().year.toString();
  }

  void onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    consHistory.clear();
    Timestamp myTimeStamp = Timestamp.fromDate(args.value);
    for (var i = 0; i < filteredListforP.length; i++) {
      String dateConstant = getMonth(filteredListforP[i].dateConsEnd!) +
          " - " +
          getDate(filteredListforP[i].dateConsEnd!) +
          " - " +
          getYear(filteredListforP[i].dateConsEnd!);
      ;
      String dateSelected = myTimeStamp.toDate().month.toString() +
          " - " +
          myTimeStamp.toDate().day.toString() +
          " - " +
          myTimeStamp.toDate().year.toString();
      print(i.toString() +
          "  " +
          dateConstant +
          " dateSelected  " +
          dateSelected);
      if (dateConstant == dateSelected) {
        consHistory.add(filteredListforP[i]);
      }
    }
    Get.back();
  }
}
