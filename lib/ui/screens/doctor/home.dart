import 'package:davnor_medicare/core/controllers/doctor/consultations_controller.dart';
import 'package:davnor_medicare/core/models/consultation_model.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:davnor_medicare/ui/screens/doctor/cons_history.dart';
import 'package:davnor_medicare/ui/screens/doctor/cons_req_item.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/widgets/consultation_card.dart';
import 'package:davnor_medicare/ui/widgets/custom_drawer.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:davnor_medicare/ui/screens/doctor/live_cons.dart';
import 'package:get/get.dart';
import 'package:davnor_medicare/ui/screens/doctor/profile.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/core/controllers/live_cons_controller.dart';
import 'package:davnor_medicare/ui/widgets/action_card.dart';
import 'package:davnor_medicare/ui/screens/doctor/article_list.dart';

class DoctorHomeScreen extends StatelessWidget {
  final ConsultationsController consRequests =
      Get.put(ConsultationsController());
  final LiveConsController liveCont = Get.put(LiveConsController());
  static AuthController authController = Get.find();
  final fetchedData = authController.doctorModel.value;

  //data needed for consultation process
  final int slot = 10;
  final int count = 0;
  final bool isAvailable = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: verySoftBlueColor,
            ),
            drawer: CustomDrawer(
              forDoctorDrawer: true,
              accountName: '${fetchedData!.firstName} ${fetchedData!.lastName}',
              accountEmail: fetchedData!.email,
              userProfile: fetchedData!.profileImage == ''
                  ? const Icon(
                      Icons.person,
                      size: 56,
                    )
                  : Image.network(fetchedData!.profileImage!),
              onProfileTap: () => Get.to(() => DoctorProfileScreen()),
              onCurrentConsultTap: () {
                if (liveCont.liveCons.isNotEmpty) {
                  Get.to(() => LiveConsultationScreen(),
                      arguments: liveCont.liveCons[0]);
                } else {
                  showErrorDialog(
                      errorTitle: 'No current consultation',
                      errorDescription: 'Please accept consultation request');
                }
              },
              onConsultHisoryTap: () => Get.to(() => DocConsHistoryScreen()),
              onLogoutTap: authController.signOut,
            ),
            backgroundColor: verySoftBlueColor,
            body: SizedBox(
              width: Get.width,
              height: Get.height,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          verticalSpace20,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Hello',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 32,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Dr. ${fetchedData!.lastName}!',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'DOCTOR STATUS',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                '$count out of $slot patients',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                elevation: 5,
                                child: const Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    'Available for Consultation',
                                    //fetchedData!.dStatus!? : 'Unavailable',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: verySoftBlueColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          verticalSpace10,
                        ]),
                  ),
                  Expanded(
                    child: Container(
                      width: Get.width,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(55),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          verticalSpace50,
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: SizedBox(
                              width: Get.width,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: ActionCard(
                                        text: 'Change Status',
                                        color: verySoftMagenta[60],
                                        secondaryColor:
                                            verySoftMagentaCustomColor,
                                        onTap: () {}),
                                  ),
                                  Expanded(
                                    child: ActionCard(
                                        text: 'Add More Patients to Examine',
                                        color: verySoftOrange[60],
                                        secondaryColor:
                                            verySoftOrangeCustomColor,
                                        onTap: () {}),
                                  ),
                                  Expanded(
                                    child: ActionCard(
                                        text: 'Read \nHealth Articles',
                                        color: verySoftRed[60],
                                        secondaryColor: verySoftRedCustomColor,
                                        onTap: () =>
                                            Get.to(() => ArticleListScreen())),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          verticalSpace35,
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            child: Text(
                              'Consultation Requests',
                              style: body16SemiBold,
                            ),
                          ),
                          verticalSpace18,
                          Expanded(child: requestList()),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            floatingActionButton: Obx(getFloatingButton)));
  }

  Widget getFloatingButton() {
    if (liveCont.liveCons.isNotEmpty) {
      return FloatingActionButton(
        backgroundColor: verySoftBlueColor[30],
        elevation: 2,
        onPressed: () {
          Get.to(() => LiveConsultationScreen(),
              arguments: liveCont.liveCons[0]);
        },
        child: const Icon(
          Icons.chat_rounded,
        ),
      );
    }
    return const Text('');
  }

  Widget requestList() {
    return StreamBuilder(
        stream: consRequests.getCollection(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (consRequests.consultations.isNotEmpty) {
              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                shrinkWrap: true,
                itemCount: consRequests.consultations.length,
                itemBuilder: (context, index) {
                  return displayConsultations(
                      consRequests.consultations[index]);
                },
              );
            } else {
              return const Center(
                  child: Text('No consultation request at the moment'));
            }
          }
          return const Center(
              child: SizedBox(
                  width: 24, height: 24, child: CircularProgressIndicator()));
        });
  }

  Widget displayConsultations(ConsultationModel model) {
    return FutureBuilder(
      future: consRequests.getPatientData(model),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ConsultationCard(
              consReq: model,
              onItemTap: () {
                Get.to(() => ConsRequestItemScreen(), arguments: model);
              });
        }
        return loadingCardIndicator();
      },
    );
  }
}
