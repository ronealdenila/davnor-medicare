import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/models/med_assistance_model.dart';
import 'package:davnor_medicare/core/models/user_model.dart';
import 'package:davnor_medicare/core/services/logger_service.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class MAReqListController extends GetxController {
  final log = getLogger('MA Requests List Controller');

  RxList<MARequestModel> maRequests = RxList<MARequestModel>([]);
  final RxList<MARequestModel> filteredList = RxList<MARequestModel>();
  final TextEditingController maFilter = TextEditingController();
  final RxString type = ''.obs;

  @override
  void onReady() {
    super.onReady();
    maRequests.bindStream(assignListStream());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getCollection() {
    log.i('MA Requests List Controller | get Collection');
    return firestore.collection('ma_request').snapshots();
  }

  Stream<List<MARequestModel>> assignListStream() {
    log.i('MA Requests List Controller | assign');
    return getCollection().map(
      (query) => query.docs
          .map((item) => MARequestModel.fromJson(item.data()))
          .toList(),
    );
  }

  Future<void> getPatientData(MARequestModel model) async {
    model.requester.value = await firestore
        .collection('patients')
        .doc(model.requesterID)
        .get()
        .then((doc) => PatientModel.fromJson(doc.data()!));
  }

  String getProfilePhoto(MARequestModel model) {
    return model.requester.value!.profileImage!;
  }

  String getFirstName(MARequestModel model) {
    return model.requester.value!.firstName!;
  }

  String getLastName(MARequestModel model) {
    return model.requester.value!.lastName!;
  }

  String getFullName(MARequestModel model) {
    return '${getFirstName(model)} ${getLastName(model)}';
  }
}
