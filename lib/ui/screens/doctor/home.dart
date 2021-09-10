import 'package:davnor_medicare/core/controllers/patient/cons_req_controller.dart';
import 'package:davnor_medicare/core/controllers/doctor/doctor_home_controller.dart';
import 'package:davnor_medicare/core/models/consultation_model.dart';
import 'package:davnor_medicare/ui/screens/doctor/cons_request_item.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:davnor_medicare/ui/widgets/consultation_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:davnor_medicare/ui/screens/doctor/profile.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';

import 'package:davnor_medicare/ui/widgets/action_card.dart';

class DoctorHomeScreen extends StatelessWidget {
  final DoctorHomeController doctorController = Get.put(DoctorHomeController());
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
          backgroundColor: verySoftBlueColor,
          actions: [
            IconButton(
              onPressed: authController.signOut,
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        drawer: Drawer(
          child: TextButton(
            onPressed: () {
              Get.to(() => DoctorProfileScreen());
            },
            child: const Text('Profile'),
          ),
        ),
        backgroundColor: verySoftBlueColor,
        body: Column(
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
                width: screenWidth(context),
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
                        width: screenWidth(context),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: ActionCard(
                                  text: 'Change Status',
                                  color: verySoftMagenta[60],
                                  secondaryColor: verySoftMagentaCustomColor,
                                  onTap: () {}),
                            ),
                            Expanded(
                              child: ActionCard(
                                  text: 'Add More Patients to Examine',
                                  color: verySoftOrange[60],
                                  secondaryColor: verySoftOrangeCustomColor,
                                  onTap: () {}),
                            ),
                            Expanded(
                              child: ActionCard(
                                  text: 'Read \nHealth Articles',
                                  color: verySoftRed[60],
                                  secondaryColor: verySoftRedCustomColor,
                                  onTap: () {}),
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
                    Expanded(
                      child: Obx(
                        () => ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          shrinkWrap: true,
                          itemCount: doctorController.consultations.length,
                          itemBuilder: (context, index) {
                            return ConsultationCard(
                              consultation:
                                  doctorController.consultations[index],
                              onItemTap: () {
                                Get.to(
                                  () => ConsRequestItemScreen(),
                                  arguments: index,
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
