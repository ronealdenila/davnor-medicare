import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/models/med_assistance_model.dart';
import 'package:davnor_medicare/core/services/logger_service.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OnProgressReqController extends GetxController {
  final log = getLogger('On Progress Req Controller');

  RxList<OnProgressMAModel> medicalAssistances = RxList<OnProgressMAModel>([]);

  final String _dateNow = DateFormat.yMMMMd().format(DateTime.now());

  String get dateNow => _dateNow;

  @override
  void onReady() {
    super.onReady();
    medicalAssistances.bindStream(getMedicalAssistances());
  }

  Stream<List<OnProgressMAModel>> getMedicalAssistances() {
    //log.i('getMedicalAssistance | Streaming Medical Assistance Request');
    return firestore
        .collection('ma_request')
        .orderBy('dateRqstd')
        .where('isApproved', isEqualTo: true)
        .snapshots()
        .map(
          (query) => query.docs
              .map((item) => OnProgressMAModel.fromJson(item.data()))
              .toList(),
        );
  }

  String convertTimeStamp(Timestamp recordTime) {
    final dt = recordTime.toDate();
    return DateFormat.yMMMd().add_jm().format(dt);
  }
}
