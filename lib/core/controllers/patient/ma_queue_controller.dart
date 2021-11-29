import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/status_controller.dart';
import 'package:davnor_medicare/core/services/logger_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:davnor_medicare/core/models/ma_queue_model.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';

class MAQueueController extends GetxController {
  final log = getLogger('MA Queue Controller');

  RxList<MAQueueModel> queueMAList = RxList<MAQueueModel>();
  final StatusController stats = Get.find();
  RxBool isLoading = true.obs;

  @override
  void onReady() {
    super.onReady();
    queueMAList.bindStream(getMAQueue());
  }

  Stream<List<MAQueueModel>> getMAQueue() {
    log.i('MA Queue Controller | assign MA Queue List');
    return firestore
        .collection('ma_queue')
        .orderBy('dateCreated')
        .snapshots()
        .map((query) {
      return query.docs.map((item) {
        isLoading.value = false;
        return MAQueueModel.fromJson(item.data());
      }).toList();
    });
  }
}

class QueueDataSource extends DataTableSource {
  QueueDataSource({required this.queueMAList});

  final List<MAQueueModel> queueMAList;
  int selectedRow = 0;

  @override
  DataRow getRow(int index) {
    return DataRow.byIndex(index: index, cells: <DataCell>[
      DataCell(Text('${index + 1}', style: subtitle20Medium)),
      DataCell(Text(queueMAList[index].queueNum!, style: subtitle20Medium)),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => queueMAList.length;

  @override
  int get selectedRowCount => selectedRow;
}
