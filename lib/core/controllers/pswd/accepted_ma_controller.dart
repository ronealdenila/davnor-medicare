import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/models/med_assistance_model.dart';
import 'package:davnor_medicare/core/models/user_model.dart';
import 'package:davnor_medicare/core/services/logger_service.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AcceptedMAController extends GetxController {
  final log = getLogger('Accepted MA Controller');

  RxList<OnProgressMAModel> accMA = RxList<OnProgressMAModel>([]);
  RxInt index = (-1).obs;
  RxBool isLoading = true.obs;

  @override
  void onReady() {
    super.onReady();
    accMA.bindStream(getAcceptedMA());
  }

  Stream<List<OnProgressMAModel>> getAcceptedMA() {
    log.i('Accepted MA Controller | get Collection');
    return firestore
        .collection('on_progress_ma')
        .orderBy('dateRqstd')
        .where('isTransferred', isEqualTo: false)
        .snapshots()
        .map((query) {
      return query.docs.map((item) {
        isLoading.value = false;
        return OnProgressMAModel.fromJson(item.data());
      }).toList();
    });
  }

  String convertTimeStamp(Timestamp recordTime) {
    final dt = recordTime.toDate();
    return DateFormat.yMMMd().add_jm().format(dt);
  }

  Future<void> getPatientData(OnProgressMAModel model) async {
    model.requester.value = await firestore
        .collection('patients')
        .doc(model.requesterID)
        .get()
        .then((doc) => PatientModel.fromJson(doc.data()!));
  }

  String getProfilePhoto(OnProgressMAModel model) {
    return model.requester.value!.profileImage!;
  }

  String getFirstName(OnProgressMAModel model) {
    return model.requester.value!.firstName!;
  }

  String getLastName(OnProgressMAModel model) {
    return model.requester.value!.lastName!;
  }

  String getFullName(OnProgressMAModel model) {
    return '${getFirstName(model)} ${getLastName(model)}';
  }
}
