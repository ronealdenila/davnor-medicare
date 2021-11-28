import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/patient/cons_queue_controller.dart';
import 'package:davnor_medicare/core/controllers/status_controller.dart';
import 'package:davnor_medicare/ui/screens/patient/queue_cons_table.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QueueConsScreen extends StatelessWidget {
  final ConsQueueController cQController = Get.put(ConsQueueController());
  static StatusController stats = Get.find();
  final RxString title = ''.obs;
  final RxString department = ''.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            verticalSpace25,
            Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                width: screenWidth(context),
                height: 260,
                decoration: BoxDecoration(
                  color: verySoftBlueColor[80],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    verticalSpace18,
                    returnTitleDept(),
                    verticalSpace10,
                    Container(
                      width: Get.width,
                      height: 137,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                      : cQController.queueConsList[0].queueNum!,
                                  style: title42BoldNeutral100,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    verticalSpace10,
                    InkWell(
                      onTap: () {
                        Get.to(() => QueueConsTableScreen());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'maqueue3'.tr,
                            style: subtitle18RegularWhite,
                          ),
                          horizontalSpace5,
                          Container(
                            height: 24,
                            width: 24,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.arrow_forward_outlined,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //Specialty
                  ],
                ),
              ),
            ),
            verticalSpace25,
            Center(
              child: Obx(
                () => Text(
                  cQController.isLoading.value
                      ? ''
                      : '${cQController.queueConsList.length} ${'maqueue4'.tr}',
                  style: subtitle20Medium,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget returnTitleDept() {
    return FutureBuilder(
        future: fetchCategoryData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(children: [
              Text(department.value.toUpperCase(),
                  style: subtitle20BoldWhite), //Department
              verticalSpace5,
              Text(title.value, style: subtitle18RegularWhite),
            ]);
          }
          return Column(children: [
            Text('Loading...', style: subtitle20BoldWhite), //Department
            verticalSpace5,
            Text('', style: subtitle18RegularWhite),
          ]);
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
