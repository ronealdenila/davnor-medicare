import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/navigation_controller.dart';
import 'package:davnor_medicare/core/controllers/patient/cons_queue_controller.dart';
import 'package:davnor_medicare/core/controllers/status_controller.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QueueConsTableWebScreen extends StatelessWidget {
  final ConsQueueController cQController = Get.put(ConsQueueController());
  final StatusController stats = Get.find();
  final RxString title = ''.obs;
  final RxString department = ''.obs;
  final NavigationController navigationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            child: SizedBox(
                width: Get.width,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      navigationController.goBack();
                                    },
                                    icon: Icon(
                                      Icons.arrow_back_outlined,
                                      size: 30,
                                    )),
                                Text(
                                  'maqueue1'.tr,
                                  style: subtitle18Medium,
                                ),
                                verticalSpace15,
                                Center(
                                  child: Text(
                                    stats.patientStatus[0].queueCons!,
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
                                      cQController.isLoading.value
                                          ? ''
                                          : cQController
                                              .queueConsList[0].queueNum!,
                                      style: title42BoldNeutral100,
                                    ),
                                  ),
                                ),
                                returnTitleDept(),
                              ]),
                        ],
                      ),
                    ),
                    Obx(() => returnTable(context)),
                  ],
                ))),
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
          rowsPerPage: 10,
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

  Widget returnTitleDept() {
    return FutureBuilder(
        future: fetchCategoryData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(department.value.toUpperCase(),
                      style: subtitle18Regular), //Department
                  verticalSpace5,
                  Text(title.value,
                      style: body16Medium.copyWith(color: neutralColor)),
                ]);
          }
          return Text('Loading...',
              style: body16Medium.copyWith(color: neutralColor));
        });
  }

  Future<void> fetchCategoryData() async {
    await firestore
        .collection('cons_status')
        .doc(stats.patientStatus[0].categoryID)
        .get()
        .then((DocumentSnapshot snap) {
      if (snap.exists) {
        title.value = snap['title'];
        department.value = snap['deptName'];
      }
    });
  }
}
