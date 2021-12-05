import 'package:davnor_medicare/core/controllers/doctor/consultations_controller.dart';
import 'package:davnor_medicare/core/models/consultation_model.dart';
import 'package:davnor_medicare/ui/screens/doctor/cons_req_item.dart';
import 'package:davnor_medicare/ui/widgets/consultation_card.dart';
import 'package:flutter/material.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:get/get.dart';

class ConsultationListScreen extends StatelessWidget {
  final ConsultationsController consRequests = Get.find();
  final RxBool firedOnce = false.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Consultation Requests',
            style: subtitle18Medium.copyWith(color: Colors.black),
          ),
          toolbarHeight: 50,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(
                    () => Checkbox(
                      value: consRequests.checked.value,
                      onChanged: (value) {
                        consRequests.checked.value = value!;
                        if (value == true) {
                          consRequests.filter();
                        } else {
                          consRequests.refresh();
                        }
                      },
                    ),
                  ),
                  Text(
                    'Senior Only',
                    style: body16Regular,
                  )
                ],
              ),
            ),
            Obx(() => requestList(context)),
          ],
        ));
  }

  Widget requestList(BuildContext context) {
    if (consRequests.isLoading.value) {
      return Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: const SizedBox(
              height: 24, width: 24, child: CircularProgressIndicator()),
        ),
      );
    }
    if (consRequests.consultations.isEmpty && !consRequests.isLoading.value) {
      return const Center(child: Text('No consultation request at the moment'));
    }
    firedOnce.value
        ? null
        : consRequests.filteredList.assignAll(consRequests.consultations);
    firedOnce.value = true;
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        shrinkWrap: true,
        itemCount: consRequests.filteredList.length,
        itemBuilder: (context, index) {
          return displayConsultations(consRequests.filteredList[index], index);
        },
      ),
    );
  }

  Widget displayConsultations(ConsultationModel model, int index) {
    return FutureBuilder(
      future: consRequests.getPatientData(model),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ConsultationCard(
              consReq: model,
              onItemTap: () {
                Get.to(() => ConsRequestItemScreen(), arguments: model);
                consRequests.mobileIndex.value = index;
              });
        }
        return loadingCardIndicator();
      },
    );
  }
}
