import 'package:davnor_medicare/constants/app_items.dart';
import 'package:davnor_medicare/core/controllers/ma_history_controller.dart';
import 'package:davnor_medicare/core/models/med_assistance_model.dart';

import 'package:davnor_medicare/ui/screens/patient/ma_history_info.dart';
import 'package:davnor_medicare/ui/screens/pswd_p/ma_history_list.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:davnor_medicare/ui/widgets/cons_history_card.dart';
import 'package:davnor_medicare/ui/widgets/custom_dropdown2.dart';
import 'package:davnor_medicare/ui/widgets/patient/ma_card.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MAHistoryScreen extends StatelessWidget {
  final MAHistoryController maHController = Get.put(MAHistoryController());

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
                    const Text('Medical Assistance History',
                        style: title24BoldWhite),
                    verticalSpace15,
                    InkWell(
                      onTap: () {
                        if (maHController.isLoading.value) {
                          print('Dialog for: please wait, fetching record...');
                        } else if (maHController.maHistoryList.isEmpty) {
                          print('Dialog for: you have no MA history');
                        } else {
                          maHController.showDialog(context);
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
    if (maHController.isLoading.value) {
      return const SizedBox(
          height: 24, width: 24, child: CircularProgressIndicator());
    }
    if (maHController.maHistoryList.isEmpty && !maHController.isLoading.value) {
      return const Text(
        'You have no Medical Assistance (MA) record',
        textAlign: TextAlign.center,
        style: body14Medium,
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      shrinkWrap: true,
      itemCount: maHController.maHistoryList.length,
      itemBuilder: (context, index) {
        return displayMAHistory(maHController.maHistoryList[index]);
      },
    );
  }

  Widget displayMAHistory(MAHistoryModel model) {
    return FutureBuilder(
        future: maHController.getMAHistoryForPatient(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                shrinkWrap: true,
                itemCount: maHController.maHistoryList.length,
                itemBuilder: (context, index) {
                  return MACard(
                      maHistory: maHController.maHistoryList[index],
                      onTap: () {
                        Get.to(() => MAHistoryInfoScreen(),
                            arguments: maHController.maHistoryList[index]);
                      });
                });
          }
          return loadingCardIndicator();
        });
  }
}
