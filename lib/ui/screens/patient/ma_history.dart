import 'package:davnor_medicare/ui/screens/patient/ma_history_info.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:davnor_medicare/ui/widgets/patient/ma_card.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:davnor_medicare/core/controllers/ma_history_controller.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/widgets/custom_dropdown2.dart';
import 'package:davnor_medicare/constants/app_items.dart';

class MAHistoryScreen extends StatelessWidget {
  final MAHistoryController maHController = Get.put(MAHistoryController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
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
                    const Text('Medical Assistance History',
                        style: title24BoldWhite),
                    verticalSpace20,
                    Row(children: [
                      SizedBox(
                        width: 100,
                        height: 50,
                        child: CustomDropdown2(
                          hintText: 'Jan',
                          dropdownItems: month,
                        ),
                      ),
                      horizontalSpace15,
                      SizedBox(
                        width: 100,
                        height: 50,
                        child: CustomDropdown2(
                          hintText: '01',
                          dropdownItems: day,
                        ),
                      ),
                      horizontalSpace10,
                      InkWell(
                        onTap: () {},
                        child: Card(
                          elevation: 6,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: verySoftBlueColor[100],
                            ),
                            child: const Icon(
                              Icons.search_rounded,
                              color: Colors.white,
                              size: 35,
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ]),
            ),
            verticalSpace35,
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
                  child: FutureBuilder(
                      future: maHController.getMAHistoryForPatient(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Text(
                            'You have no Medical Assistance (MA) record',
                            textAlign: TextAlign.center,
                          );
                        }
                        if (snapshot.connectionState == ConnectionState.done) {
                          return ListView.builder(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 30),
                              shrinkWrap: true,
                              itemCount: maHController.maList.length,
                              itemBuilder: (context, index) {
                                return MACard(
                                    maHistory: maHController.maList[index],
                                    onTap: () {
                                      Get.to(() => MAHistoryInfoScreen(),
                                          arguments:
                                              maHController.maList[index]);
                                    });
                              });
                        }
                        return const Center(
                          child: SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator()),
                        );
                      }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
