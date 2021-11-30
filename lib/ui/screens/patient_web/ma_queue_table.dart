import 'package:davnor_medicare/core/controllers/patient/ma_queue_controller.dart';
import 'package:davnor_medicare/core/controllers/status_controller.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QueueMATableWebScreen extends StatelessWidget {
  final MAQueueController maQueueController = Get.put(MAQueueController());
  final StatusController stats = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
            width: Get.width,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(onPressed: () {}, 
                          icon: Icon(Icons.arrow_back_outlined,
                          size: 30,)),
                          Text(
                            'maqueue1'.tr,
                            style: subtitle18Medium,
                          ),
                          verticalSpace15,
                          Center(
                            child: Text(
                              stats.patientStatus[0].queueMA!,
                              style: title90BoldBlue,
                            ),
                          ),
                        ]),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        verticalSpace35,
                        Text(
                          'maqueue2'.tr,
                          style: subtitle18MediumNeutral,
                        ),
                        verticalSpace10,
                        Center(
                          child: Obx(
                            () => Text(
                              maQueueController.isLoading.value
                                  ? ''
                                  : maQueueController.queueMAList[0].queueNum!,
                              style: title42BoldNeutral100,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Obx(() => returnTable(context)),
            ])),
      ),
    ));
  }

  Widget returnTable(context) {
    if (maQueueController.isLoading.value) {
      return loadingIndicator();
    }
    if (maQueueController.queueMAList.isEmpty &&
        maQueueController.isLoading.value) {
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
          rowsPerPage: 10,
          source: QueueDataSource(queueMAList: maQueueController.queueMAList),
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
      child: SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget noData() {
    return Text('queue5'.tr);
  }
}
