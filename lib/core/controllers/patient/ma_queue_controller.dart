import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/services/logger_service.dart.dart';
import 'package:get/get.dart';
import 'package:davnor_medicare/core/models/ma_queue_model.dart';

class MAQueueController extends GetxController {
  final log = getLogger('MA Queue Controller');

  RxList<MAQueueModel> queueMAList = RxList<MAQueueModel>();

  @override
  void onReady() {
    super.onReady();
    queueMAList.bindStream(getMAQueueList());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMAQueueCollection() {
    log.i('MA Queue Controller | get MA Queue List');
    return firestore
        .collection('ma_queue')
        .orderBy('dateCreated', descending: false)
        .snapshots();
  }

  Stream<List<MAQueueModel>> getMAQueueList() {
    log.i('MA Queue Controller | get MA Queue List');
    return getMAQueueCollection().map(
      (query) =>
          query.docs.map((item) => MAQueueModel.fromJson(item.data())).toList(),
    );
  }
}
