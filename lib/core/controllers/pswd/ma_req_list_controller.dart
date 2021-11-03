import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/models/med_assistance_model.dart';
// import 'package:davnor_medicare/core/models/user_model.dart';
import 'package:davnor_medicare/core/services/logger_service.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MAReqListController extends GetxController {
  final log = getLogger('MA Requests List Controller');

  RxList<MARequestModel> maRequests = RxList<MARequestModel>([]);
  final RxList<MARequestModel> filteredList = RxList<MARequestModel>();
  final TextEditingController maFilter = TextEditingController();
  final RxString type = ''.obs;
  RxBool isLoading = true.obs;

  @override
  void onReady() {
    super.onReady();
    maRequests.bindStream(getMARequests());
  }

  Stream<List<MARequestModel>> getMARequests() {
    log.i('MA Requests List Controller | get Collection');
    return firestore
        .collection('ma_request')
        .orderBy('date_rqstd')
        .snapshots()
        .map((query) {
      return query.docs.map((item) {
        isLoading.value = false;
        return MARequestModel.fromJson(item.data());
      }).toList();
    });
  }

  // Stream<QuerySnapshot<Map<String, dynamic>>> getCollection() {
  //   log.i('MA Requests List Controller | get Collection');
  //   return firestore.collection('ma_request').orderBy('date_rqstd').snapshots();
  // }

  // Stream<List<MARequestModel>> assignListStream() {
  //   log.i('MA Requests List Controller | assign');
  //   return getCollection().map(
  //     (query) => query.docs
  //         .map((item) => MARequestModel.fromJson(item.data()))
  //         .toList(),
  //   );
  // }

  String convertTimeStamp(Timestamp recordTime) {
    final dt = recordTime.toDate();
    return DateFormat.yMMMd().add_jm().format(dt);
  }
}
