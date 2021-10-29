import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/models/med_assistance_model.dart';
import 'package:davnor_medicare/core/models/user_model.dart';
import 'package:davnor_medicare/core/services/logger_service.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MAHistoryController extends GetxController {
  final log = getLogger('MA History Controller');

  RxList<MAHistoryModel> maList = RxList<MAHistoryModel>([]);

  //FOR PSWD SIDE
  final RxList<MAHistoryModel> mafilteredList = RxList<MAHistoryModel>();
  final TextEditingController maFilter = TextEditingController();

  Future<void> getMAHistoryForPatient() async {
    log.i('Get MA History for Patient - ${auth.currentUser!.uid}');
    await firestore
        .collection('ma_history')
        .where('requesterID', isEqualTo: auth.currentUser!.uid)
        .get()
        .then((value) {
      for (final result in value.docs) {
        maList.add(MAHistoryModel.fromJson(result.data()));
      }
    });
  }

  Future<void> getMAHistoryForPSWD() async {
    log.i('Get MA History for PSWD Personnel - ${auth.currentUser!.uid}');
    await firestore
        .collection('ma_history')
        .orderBy('dateRqstd')
        .get()
        .then((value) {
      for (final result in value.docs) {
        maList.add(MAHistoryModel.fromJson(result.data()));
      }
    });
  }

  String convertTimeStamp(Timestamp recordTime) {
    final dt = recordTime.toDate();
    return DateFormat.yMMMd().add_jm().format(dt);
  }

  Future<void> getRequesterData(MAHistoryModel model) async {
    model.patient.value = await firestore
        .collection('patients')
        .doc(model.requesterID)
        .get()
        .then((doc) => PatientModel.fromJson(doc.data()!));
  }

  String getPatientProfile(MAHistoryModel model) {
    return model.patient.value!.profileImage!;
  }

  String getPatientFirstName(MAHistoryModel model) {
    return model.patient.value!.firstName!;
  }

  String getPatientLastName(MAHistoryModel model) {
    return model.patient.value!.lastName!;
  }

  String getPatientName(MAHistoryModel model) {
    return '${getPatientFirstName(model)} ${getPatientLastName(model)}';
  }
}
