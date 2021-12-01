import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:davnor_medicare/ui/screens/patient/cons_history_item.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:davnor_medicare/ui/widgets/cons_history_card.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:get/get.dart';
import 'package:davnor_medicare/core/controllers/cons_history_controller.dart';
import 'package:davnor_medicare/core/models/consultation_model.dart';

class ConsHistoryScreen extends StatelessWidget {
  final ConsHistoryController consHController = Get.find();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          backgroundColor: verySoftBlueColor,
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
                    Text('conshistory'.tr, style: title24BoldWhite),
                    verticalSpace15,
                    InkWell(
                      onTap: () {
                        if (consHController.isLoading.value) {
                          showErrorDialog(
                              errorTitle: 'ERROR',
                              errorDescription: 'conslog'.tr);
                        } else if (consHController.consHistory.isEmpty) {
                          showErrorDialog(
                              errorTitle: 'ERROR',
                              errorDescription: 'conslog1'.tr);
                        } else {
                          consHController.showDialog(context);
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
                              width: 220,
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
                          horizontalSpace10,
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
                                    if (consHController.isLoading.value) {
                                      showErrorDialog(
                                          errorTitle: 'ERROR',
                                          errorDescription: 'conslog'.tr);
                                    } else if (consHController
                                        .consHistory.isEmpty) {
                                      showErrorDialog(
                                          errorTitle: 'ERROR',
                                          errorDescription: 'conslog1'.tr);
                                    } else {
                                      consHController.refresh();
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
    if (consHController.isLoading.value) {
      return Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: const SizedBox(
              height: 24, width: 24, child: CircularProgressIndicator()),
        ),
      );
    }
    if (consHController.consHistory.isEmpty &&
        !consHController.isLoading.value) {
      return Text(
        'conslog3'.tr,
        textAlign: TextAlign.center,
        style: body14Medium,
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      shrinkWrap: true,
      itemCount: consHController.consHistory.length,
      itemBuilder: (context, index) {
        return displayConsHistory(consHController.consHistory[index]);
      },
    );
  }

  Widget displayConsHistory(ConsultationHistoryModel model) {
    return FutureBuilder(
      future: consHController.getDoctorData(model),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ConsultationHistoryCard(
            consHistory: model,
            onItemTap: () {
              Get.to(() => ConsHistoryItemScreen(),
                  arguments: model, transition: Transition.rightToLeft);
            },
          );
        }
        return loadingCardIndicator();
      },
    );
  }
}
