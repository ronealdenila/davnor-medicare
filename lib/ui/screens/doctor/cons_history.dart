import 'package:davnor_medicare/ui/screens/doctor/cons_history_info.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:get/get.dart';
import 'package:davnor_medicare/core/controllers/cons_history_controller.dart';
import 'package:davnor_medicare/core/models/consultation_model.dart';
import 'package:davnor_medicare/ui/widgets/cons_history_card.dart';

class DocConsHistoryScreen extends StatelessWidget {
  final ConsHistoryController consHController =
      Get.put(ConsHistoryController());

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
                    const Text('Consultation History', style: title24BoldWhite),
                    verticalSpace20,
                    Row(children: [
                      SizedBox(
                        height: 50,
                        width: screenWidthPercentage(context, percentage: .5),
                        child: TextFormField(
                          controller: consHController.searchKeyword,
                          decoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Search here...'),
                          onChanged: (value) {
                            if (consHController.searchKeyword.text == '') {
                              consHController.consHistory.assignAll(
                                  consHController.filteredListforDoc);
                            }
                          },
                          onSaved: (value) =>
                              consHController.searchKeyword.text = value!,
                        ),
                      ),
                      horizontalSpace10,
                      InkWell(
                        onTap: () {
                          print(consHController.searchKeyword.text);
                          consHController.filterForDoctor(
                              name: consHController.searchKeyword.text);
                        },
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
      future: consHController.getPatientData(model),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ConsultationHistoryCard(
            consHistory: model,
            onItemTap: () {
              Get.to(() => HistoryInfoScreen(),
                  arguments: model, transition: Transition.rightToLeft);
              //TO DO SHOULD GO TO HISTORY ITEM
            },
          );
        }
        return loadingCardIndicator();
      },
    );
  }
}
