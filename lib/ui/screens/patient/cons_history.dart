import 'package:davnor_medicare/ui/screens/patient/cons_history_item.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:davnor_medicare/ui/widgets/cons_history_card.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/widgets/custom_dropdown2.dart';
import 'package:davnor_medicare/constants/app_items.dart';
import 'package:get/get.dart';
import 'package:davnor_medicare/core/controllers/cons_history_controller.dart';
import 'package:davnor_medicare/core/models/consultation_model.dart';

class ConsHistoryScreen extends StatelessWidget {
  final ConsHistoryController consHController =
      Get.put(ConsHistoryController());
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
                    const Text('Consultation History', style: title24BoldWhite),
                    verticalSpace15,
                    InkWell(
                      onTap: () {
                        if (consHController.isLoading.value) {
                          print('Dialog for: please wait, fetching record...');
                        } else if (consHController.consHistory.isEmpty) {
                          print('Dialog for: you have no consultation history');
                        } else {
                          consHController.showDialog(context);
                        }
                      },
                      child: Card(
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Container(
                          width: 170,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: verySoftBlueColor[100],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Search by date',
                                style:
                                    body14Medium.copyWith(color: Colors.white),
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
                    ),
                  ]),
            ),
            verticalSpace25,
            Expanded(
              child: Container(
                width: screenWidth(context),
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
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: const SizedBox(
              height: 24, width: 24, child: CircularProgressIndicator()),
        ),
      );
    }
    if (consHController.consHistory.isEmpty &&
        !consHController.isLoading.value) {
      return const Text(
        'No Consultation History',
        textAlign: TextAlign.center,
        style: body14Medium,
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
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
