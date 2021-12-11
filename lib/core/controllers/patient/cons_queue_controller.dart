import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/status_controller.dart';
import 'package:davnor_medicare/core/models/cons_queue_model.dart';
import 'package:davnor_medicare/core/services/logger_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';

class ConsQueueController extends GetxController {
  final log = getLogger('Cons Queue Controller');
  final StatusController stats = Get.find();
  RxList<ConsQueueModel> queueConsList = RxList<ConsQueueModel>();
  RxBool isLoading = true.obs;

  @override
  void onReady() {
    super.onReady();
    queueConsList.bindStream(getConsQueue());
  }

  Stream<List<ConsQueueModel>> getConsQueue() {
    log.i('get Cons Queue | Streaming Consultation Queue');
    return firestore
        .collection('cons_queue')
        .where('categoryID', isEqualTo: stats.patientStatus[0].categoryID)
        .orderBy('dateCreated')
        .snapshots(includeMetadataChanges: true)
        .map((query) {
      return query.docs.map((item) {
        isLoading.value = false;
        return ConsQueueModel.fromJson(item.data());
      }).toList();
    });
  }
}

class QueueDataSource extends DataTableSource {
  QueueDataSource({required this.queueConsList});

  final List<ConsQueueModel> queueConsList;
  int selectedRow = 0;

  @override
  DataRow getRow(int index) {
    return DataRow.byIndex(index: index, cells: <DataCell>[
      DataCell(Text('${index + 1}', style: subtitle20Medium)),
      DataCell(Text(queueConsList[index].queueNum!, style: subtitle20Medium)),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => queueConsList.length;

  @override
  int get selectedRowCount => selectedRow;
}
