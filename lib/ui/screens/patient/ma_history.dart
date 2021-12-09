import 'package:davnor_medicare/core/controllers/ma_history_controller.dart';
import 'package:davnor_medicare/core/models/med_assistance_model.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:davnor_medicare/ui/screens/patient/ma_history_info.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/widgets/patient/ma_card.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MAHistoryScreen extends StatelessWidget {
  final MAHistoryController maHController = Get.put(MAHistoryController());
  final RxBool firedOnce = false.obs;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: verySoftBlueColor,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        backgroundColor: verySoftBlueColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    verticalSpace20,
                    Text('mahistory'.tr, style: title24BoldWhite),
                    verticalSpace15,
                    InkWell(
                      onTap: () {
                        if (maHController.isLoading.value) {
                          showSimpleErrorDialog(errorDescription: 'mahrec1'.tr);
                        } else if (maHController.maHistoryList.isEmpty) {
                          showSimpleErrorDialog(errorDescription: 'mahrec2'.tr);
                        } else {
                          maHController.showDialog(context);
                        }
                      },
                      child: Wrap(
                        runSpacing: 8,
                        children: [
                          Card(
                            elevation: 6,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Container(
                              width: 250,
                              padding: EdgeInsets.only(right: 10),
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: verySoftBlueColor[100],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'conslog2'.tr,
                                    style: body14Medium.copyWith(
                                        color: Colors.white),
                                  ),
                                  horizontalSpace5,
                                  const Icon(
                                    Icons.calendar_today,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            elevation: 6,
                            child: SizedBox(
                                height: 50,
                                child: ElevatedButton(
                                  child: Icon(
                                    Icons.refresh,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: verySoftBlueColor[100],
                                  ),
                                  onPressed: () {
                                    if (maHController.isLoading.value) {
                                      showSimpleErrorDialog(
                                          errorDescription: 'mahrec1'.tr);
                                    } else if (maHController
                                            .maHistoryList.isEmpty &&
                                        maHController
                                            .filteredListforP.isEmpty) {
                                      showSimpleErrorDialog(
                                          errorDescription: 'mahrec2'.tr);
                                    } else {
                                      maHController.refresh();
                                    }
                                  },
                                )),
                          ),
                        ],
                      ),
                    ),
                  ]),
            ),
            verticalSpace25,
            Expanded(
              child: Container(
                width: Get.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(55),
                  ),
                ),
                child: Padding(
                    padding: const EdgeInsets.only(
                      top: 25,
                    ),
                    child: Obx(() => listBuilder()) //historyList
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget listBuilder() {
    if (maHController.isLoading.value) {
      return Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: const SizedBox(
              height: 24, width: 24, child: CircularProgressIndicator()),
        ),
      );
    }
    if (maHController.maHistoryList.isEmpty &&
        !maHController.isLoading.value &&
        maHController.filteredListforP.isEmpty) {
      return Text(
        'mahrec'.tr,
        textAlign: TextAlign.center,
        style: body14Medium,
      );
    }
    if (maHController.maHistoryList.isEmpty &&
        !maHController.isLoading.value &&
        maHController.filteredListforP.isNotEmpty) {
      return Text(
        'errordialog15'.tr,
        textAlign: TextAlign.center,
        style: body14Medium,
      );
    }
    firedOnce.value
        ? null
        : maHController.filteredListforP.assignAll(maHController.maHistoryList);
    firedOnce.value = true;
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      shrinkWrap: true,
      itemCount: maHController.filteredListforP.length,
      itemBuilder: (context, index) {
        return MACard(
            maHistory: maHController.filteredListforP[index],
            onTap: () {
              Get.to(() => MAHistoryInfoScreen(),
                  arguments: maHController.filteredListforP[index]);
            });
      },
    );
  }
}
