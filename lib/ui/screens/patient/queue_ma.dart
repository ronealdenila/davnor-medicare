import 'package:davnor_medicare/core/controllers/patient/ma_queue_controller.dart';
import 'package:davnor_medicare/core/controllers/status_controller.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:davnor_medicare/ui/screens/patient/queue_ma_table.dart';
import 'package:get/get.dart';

class QueueMAScreen extends StatelessWidget {
  final MAQueueController maQueueController = Get.put(MAQueueController());
  static StatusController stats = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 50,
          horizontal: 30,
        ),
        child: SingleChildScrollView(
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
                  stats.patientStatus[0].queueMA!,
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
                  decoration: BoxDecoration(
                    color: verySoftBlueColor[80],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      verticalSpace18,
                      const Text('PSWD OFFICE', style: subtitle20BoldWhite),
                      verticalSpace5,
                      const Text('Medical Assistance (MA)',
                          style: subtitle18RegularWhite),
                      verticalSpace10,
                      Container(
                        width: screenWidth(context),
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
                                    maQueueController.isLoading.value
                                        ? ''
                                        : 'temp',
                                    //TO DO: uncomment puhon -  maQueueController.queueMAList[0].queueNum!,
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
                          Get.to(() => QueueMATableScreen());
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Text(
                                  'maqueue3'.tr,
                                  style: subtitle18RegularWhite,
                                ),
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
                    maQueueController.isLoading.value
                        ? ''
                        : '${maQueueController.queueMAList.length} ${'maqueue4'.tr}',
                    style: subtitle20Medium,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
