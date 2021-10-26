import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/models/med_assistance_model.dart';
import 'package:davnor_medicare/core/models/user_model.dart';
import 'package:davnor_medicare/core/services/logger_service.dart';
import 'package:get/get.dart';

class ForApprovalController extends GetxController {
  final log = getLogger('For Approval MA Controller');

  RxList<OnProgressMAModel> forApproval = RxList<OnProgressMAModel>([]);

  @override
  void onReady() {
    super.onReady();
    forApproval.bindStream(assignListStream());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getCollection() {
    log.i('For Approval MA Controller | get Collection');
    return firestore
        .collection('on_progress_ma')
        .orderBy('dateRqstd')
        .where('isTransferred', isEqualTo: true)
        .snapshots();
  }

  Stream<List<OnProgressMAModel>> assignListStream() {
    log.i('For Approval MA Controller | assign');
    return getCollection().map(
      (query) => query.docs
          .map((item) => OnProgressMAModel.fromJson(item.data()))
          .toList(),
    );
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
