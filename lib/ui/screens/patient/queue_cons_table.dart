import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/patient/cons_queue_controller.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QueueConsTableScreen extends StatelessWidget {
  final ConsQueueController cQController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Slots: ',
                  style: body14RegularNeutral,
                ),
                StreamBuilder<DocumentSnapshot>(
                    stream: firestore
                        .collection('cons_status')
                        .doc(cQController.stats.patientStatus[0].categoryID)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Text('Something went wrong');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text('Loading');
                      }
                      final data =
                          snapshot.data!.data() as Map<String, dynamic>;
                      return Text('${data['consSlot']}');
                    }),
              ],
            ),
            SizedBox(width: Get.width, child: Obx(() => returnTable(context))),
          ],
        )),
      ),
    );
  }

  Widget returnTable(context) {
    if (cQController.isLoading.value) {
      return loadingIndicator();
    }
    if (cQController.queueConsList.isEmpty && cQController.isLoading.value) {
      return noData();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: getDataTable(context),
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
          rowsPerPage: 8,
          source: QueueDataSource(queueConsList: cQController.queueConsList),
          columns: [
            DataColumn(label: Text('queue6'.tr, style: subtitle18BoldWhite)),
            DataColumn(label: Text('queue7'.tr, style: subtitle18BoldWhite)),
          ],
        ),
      ),
    );
  }

  Widget loadingIndicator() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.only(top: 20),
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget noData() {
    return Text('queue5'.tr);
  }
}
