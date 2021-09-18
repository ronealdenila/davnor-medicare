import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/services/logger_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:davnor_medicare/core/models/ma_queue_model.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';

class MAQueueController extends GetxController {
  final log = getLogger('MA Queue Controller');

  RxList<MAQueueModel> queueMAList = RxList<MAQueueModel>();

  @override
  void onReady() {
    super.onReady();
    queueMAList.bindStream(assignMAQueueList());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMAQueueCollection() {
    log.i('MA Queue Controller | get MA Queue Collection');
    return firestore
        .collection('ma_queue')
        .orderBy('dateCreated', descending: false)
        .snapshots();
  }

  Stream<List<MAQueueModel>> assignMAQueueList() {
    log.i('MA Queue Controller | assign MA Queue List');
    return getMAQueueCollection().map(
      (query) =>
          query.docs.map((item) => MAQueueModel.fromJson(item.data())).toList(),
    );
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
