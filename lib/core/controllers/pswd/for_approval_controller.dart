import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/models/med_assistance_model.dart';
// import 'package:davnor_medicare/core/models/user_model.dart';
import 'package:davnor_medicare/core/services/logger_service.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ForApprovalController extends GetxController {
  final log = getLogger('For Approval MA Controller');

  RxList<OnProgressMAModel> forApprovalList = RxList<OnProgressMAModel>([]);
  final RxList<OnProgressMAModel> filteredList = RxList<OnProgressMAModel>();
  final RxString reason = ''.obs;
  final RxString type = ''.obs;
  RxBool isLoading = true.obs;

  @override
  void onReady() {
    super.onReady();
    forApprovalList.bindStream(getForApproval());
  }

  Stream<List<OnProgressMAModel>> getForApproval() {
    log.i('Accepted MA Controller | get Collection');
    return firestore
        .collection('on_progress_ma')
        .orderBy('dateRqstd')
        .where('isTransferred', isEqualTo: true)
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
}
