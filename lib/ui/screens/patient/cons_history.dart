import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:davnor_medicare/ui/widgets/cons_history_card.dart';
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
                      future: consHController.getConsHistoryForPatient(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return ListView.builder(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 30),
                            shrinkWrap: true,
                            itemCount: consHController.consHistory.length,
                            itemBuilder: (context, index) {
                              return displayConsHistory(
                                  consHController.consHistory[index]);
                            },
                          );
                        }
                        return loadingCardIndicator();
                      }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget displayConsHistory(ConsultationHistoryModel model) {
    return FutureBuilder(
      future: consHController.getAdditionalData(model),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ConsultationHistoryCard(
            consHistory: model,
            onItemTap: () {}, //TO DO: Cons History Item Screen
          );
        }
        return loadingCardIndicator();
      },
    );
  }
}
