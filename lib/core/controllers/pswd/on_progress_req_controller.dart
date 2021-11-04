import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/models/med_assistance_model.dart';
import 'package:davnor_medicare/core/services/logger_service.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OnProgressReqController extends GetxController {
  final log = getLogger('On Progress Req Controller');

  RxList<OnProgressMAModel> onProgressList = RxList<OnProgressMAModel>([]);
  final RxList<OnProgressMAModel> filteredList = RxList<OnProgressMAModel>();
  final RxString type = ''.obs;
  RxBool isLoading = true.obs;

  @override
  void onReady() {
    super.onReady();
    onProgressList.bindStream(getOnProgressList());
  }

  Stream<List<OnProgressMAModel>> getOnProgressList() {
    log.i('On Progress MA Controller | get Collection');
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
    filteredList.assignAll(onProgressList);
  }

  void filter({required String type}) {
    filteredList.clear();

    //filter for type only
    if (type != '' && type != 'All') {
      for (var i = 0; i < onProgressList.length; i++) {
        if (onProgressList[i].type == type) {
          filteredList.add(onProgressList[i]);
        }
      }
    } else {
      filteredList.assignAll(onProgressList);
    }
  }
}
