import 'package:davnor_medicare/ui/shared/app_colors.dart';
// import 'package:davnor_medicare/ui/shared/styles.dart';
// import 'package:davnor_medicare/ui/shared/ui_helpers.dart';

import 'package:davnor_medicare/core/controllers/patient/ma_queue_controller.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QueueMATableScreen extends StatelessWidget {
  final MAQueueController maQueueController = Get.put(MAQueueController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: SizedBox(
                width: Get.width,
                child: StreamBuilder(
                    stream: maQueueController.getMAQueueCollection(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          child: getDataTable(context),
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.none) {
                        return noData();
                      }
                      return loadingIndicator();
                    })),
          )),
    );
  }

  Widget getDataTable(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        cardTheme: CardTheme(
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          clipBehavior: Clip.antiAlias,
        ),
        dataTableTheme: DataTableThemeData(
          headingRowColor: MaterialStateProperty.all(Colors.blue.shade200),
        ),
        iconTheme: const IconThemeData(color: Colors.blue),
      ),
      child: SizedBox(
        width: Get.width,
        child: PaginatedDataTable(
          source: QueueDataSource(queueMAList: maQueueController.queueMAList),
          columns: const [
            DataColumn(label: Text('No.', style: subtitle18BoldWhite)),
            DataColumn(label: Text('Queue No.', style: subtitle18BoldWhite)),
          ],
        ),
      ),
    );
  }

  Widget loadingIndicator() {
    return const Center(
      child: SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget noData() {
    return const Text('There are no queue');
  }
}
