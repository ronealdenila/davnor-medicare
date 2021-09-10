import 'package:davnor_medicare/ui/shared/app_colors.dart';
// import 'package:davnor_medicare/ui/shared/styles.dart';
// import 'package:davnor_medicare/ui/shared/ui_helpers.dart';

import 'package:davnor_medicare/core/controllers/patient/ma_queue_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class QueueMATableScreen extends StatelessWidget {
  final MAQueueController maQueueController = Get.put(MAQueueController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SizedBox(
            width: Get.width,
            child: StreamBuilder(
                stream: maQueueController.getMAQueueCollection(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    return getDataTable();
                  } else if (snapshot.connectionState == ConnectionState.none) {
                    return dataTableNoData();
                  }
                  return loadingDataTable();
                })));
  }

  Widget getDataTable() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: DataTable(
            headingTextStyle: const TextStyle(color: Colors.white),
            showBottomBorder: true,
            headingRowColor: MaterialStateColor.resolveWith(
                (states) => Colors.blue.shade200),
            columns: const [
              DataColumn(label: Text('No.')),
              DataColumn(label: Text('Queue No.')),
            ],
            rows: List<DataRow>.generate(
                20,
                (index) => DataRow(cells: [
                      DataCell(Text('${index + 1}')),
                      DataCell(
                          Text(maQueueController.queueMAList[index].queueNum!)),
                    ]))),
      ),
    );
  }

  Widget loadingDataTable() {
    return Shimmer.fromColors(
      baseColor: neutralColor[10]!,
      highlightColor: Colors.white,
      child: DataTable(
          columns: const [
            DataColumn(label: Text('No.')),
            DataColumn(label: Text('Queue No.')),
          ],
          rows: List<DataRow>.generate(
              20,
              (index) => const DataRow(cells: [
                    DataCell(Text('')),
                    DataCell(Text('')),
                  ]))),
    );
  }

  Widget dataTableNoData() {
    return Column(
      children: [
        DataTable(
            columns: const [
              DataColumn(label: Text('No.')),
              DataColumn(label: Text('Queue No.')),
            ],
            rows: List<DataRow>.generate(
                1,
                (index) => const DataRow(cells: [
                      DataCell(Text('')),
                      DataCell(Text('')),
                    ]))),
        const Text('There are no queue')
      ],
    );
  }
}
