import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/models/consultation_model.dart';
import 'package:davnor_medicare/core/services/logger_service.dart.dart';
import 'package:get/get.dart';

//To be rename
class ForConsultationsController extends GetxController {
  final log = getLogger('Doctor Home Controller');

  RxList<ConsultationModel> consultations = RxList<ConsultationModel>([]);

  @override
  void onReady() {
    super.onReady();
    consultations.bindStream(getConsultations());
  }

  Stream<List<ConsultationModel>> getConsultations() {
    log.i('getConsultations | Streaming Consultation Request');
    return firestore
        .collection('cons_request')
        .orderBy('dateRqstd', descending: false)
        //category is hard coded for now. must be initialized based on title of
        //logged in doctor
        .where('category', isEqualTo: 'Heart')
        .snapshots()
        .map(
          (query) => query.docs
              .map((item) => ConsultationModel.fromJson(item.data()))
              .toList(),
        );
  }
}
