import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/models/med_assistance_model.dart';
import 'package:davnor_medicare/core/services/logger_service.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ReleasingMAController extends GetxController {
  final log = getLogger('Releasing MA Controller');

  RxList<OnProgressMAModel> toRelease = RxList<OnProgressMAModel>([]);
  final RxList<OnProgressMAModel> filteredList = RxList<OnProgressMAModel>();
  final TextEditingController rlsFilter = TextEditingController();
  RxBool isLoading = true.obs;

  @override
  void onReady() {
    super.onReady();
    toRelease.bindStream(getToReleaseList());
  }

  Stream<List<OnProgressMAModel>> getToReleaseList() {
    log.i('To Release MA Controller | get Collection');
    return firestore
        .collection('on_progress_ma')
        .orderBy('dateRqstd')
        .where('isMedReady', isEqualTo: true)
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

  void refresh() {
    filteredList.clear();
    filteredList.assignAll(toRelease);
  }

  void filter({required String name}) {
    filteredList.clear();

    //filter for name only
    if (name != '') {
      print('NAME');
      for (var i = 0; i < toRelease.length; i++) {
        if (toRelease[i].fullName!.toLowerCase().contains(name.toLowerCase())) {
          filteredList.add(toRelease[i]);
        }
      }
    } else {
      filteredList.assignAll(toRelease);
    }
  }
}
