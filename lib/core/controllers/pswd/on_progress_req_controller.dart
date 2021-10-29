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

  final String _dateNow = DateFormat.yMMMMd().format(DateTime.now());

  String get dateNow => _dateNow;

  @override
  void onReady() {
    super.onReady();
    onProgressList.bindStream(assignListStream());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getCollection() {
    log.i('Releasing MA Controller | get Collection');
    return firestore
        .collection('on_progress_ma')
        .orderBy('dateRqstd')
        .where('isMedReady', isEqualTo: true)
        .snapshots();
  }

  Stream<List<OnProgressMAModel>> assignListStream() {
    log.i('Releasing MA Controller | assign');
    return getCollection().map(
      (query) => query.docs
          .map((item) => OnProgressMAModel.fromJson(item.data()))
          .toList(),
    );
  }

  String convertTimeStamp(Timestamp recordTime) {
    final dt = recordTime.toDate();
    return DateFormat.yMMMd().add_jm().format(dt);
  }
}
