import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/models/ma_req_model.dart';
import 'package:davnor_medicare/core/services/logger_service.dart.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final log = getLogger('Home Controller');

  RxList<MedicalAssistanceModel> medicalAssistances =
      RxList<MedicalAssistanceModel>([]);

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
