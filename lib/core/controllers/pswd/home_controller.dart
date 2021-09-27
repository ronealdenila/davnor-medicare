import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/models/med_assistance_model.dart';
import 'package:davnor_medicare/core/services/logger_service.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  final log = getLogger('Home Controller');

  RxList<MARequestModel> medicalAssistances = RxList<MARequestModel>([]);

  final String _dateNow = DateFormat.yMMMMd().format(DateTime.now());

  String get dateNow => _dateNow;

  @override
  void onReady() {
    super.onReady();
    medicalAssistances.bindStream(getMedicalAssistances());
  }

  Stream<List<MARequestModel>> getMedicalAssistances() {
    log.i('getMedicalAssistance | Streaming Medical Assistance Request');
    return firestore
        .collection('ma_request')
        .orderBy('date_rqstd', descending: true)
        .snapshots()
        .map(
          (query) => query.docs
              .map((item) => MARequestModel.fromJson(item.data()))
              .toList(),
        );
  }
}
