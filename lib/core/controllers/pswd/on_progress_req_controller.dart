import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/pswd/menu_controller.dart';
import 'package:davnor_medicare/core/models/ma_req_model.dart';
import 'package:davnor_medicare/core/services/logger_service.dart';
import 'package:davnor_medicare/ui/screens/pswd_p/on_progress_req_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OnProgressReqController extends GetxController {
  final log = getLogger('On Progress Req Controller');

  RxList<MedicalAssistanceModel> medicalAssistances =
      RxList<MedicalAssistanceModel>([]);

  final String _dateNow = DateFormat.yMMMMd().format(DateTime.now());

  // late DataSource _dataSource;

  // DataSource get dataSource => _dataSource;

  String get dateNow => _dateNow;

  @override
  void onReady() {
    super.onReady();
    medicalAssistances.bindStream(getMedicalAssistances());
  }

  Stream<List<MedicalAssistanceModel>> getMedicalAssistances() {
    log.i('getMedicalAssistance | Streaming Medical Assistance Request');
    return firestore
        .collection('ma_request')
        .orderBy('date_rqstd', descending: true)
        .snapshots()
        .map(
          (query) => query.docs
              .map((item) => MedicalAssistanceModel.fromJson(item.data()))
              .toList(),
        );
  }
}
