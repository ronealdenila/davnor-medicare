import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/ui/screens/patient/profile.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PatientHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            actions: [
              IconButton(
                onPressed: () {
                  //authController.signOut();
                },
                icon: const Icon(
                  Icons.notifications_outlined,
                ),
              ),
              IconButton(
                onPressed: () {
                  //authController.signOut();
                },
                icon: const Icon(Icons.logout),
              ),
            ],
          ),
          drawer: Drawer(
            child: TextButton(
              onPressed: () {
                //Get.to(() => ---);
              },
              child: const Text('Profile'),
            ),
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Hello',
                    style: title32Regular,
                  ),
                  verticalSpace5,
                  const Text(
                    'David!',
                    style: subtitle20Medium,
                  ),
                  verticalSpace25,
                  SizedBox(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(13),
                        child:
                            Image.asset(patientHomeHeader, fit: BoxFit.fill)),
                  ),
                  verticalSpace25,
                  const Text(
                    'How can we help you?',
                    style: body16SemiBold,
                  ),
                  verticalSpace10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          height: 107,
                          width: 107,
                          decoration: BoxDecoration(
                            color: verySoftMagenta[60],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 10),
                                child: Text('Request Consultation',
                                    style: body14SemiBoldWhite),
                              ),
                              Align(
                                child: Container(
                                  alignment: Alignment.bottomCenter,
                                  height: 25,
                                  width: 99,
                                  decoration: const BoxDecoration(
                                      color: verySoftMagentaCustomColor,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(100),
                                        topRight: Radius.circular(100),
                                        bottomLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15),
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          height: 107,
                          width: 107,
                          decoration: BoxDecoration(
                            color: verySoftOrange,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 10),
                                child: Text('Request Medical Assistance',
                                    style: body14SemiBoldWhite),
                              ),
                              Align(
                                child: Container(
                                  alignment: Alignment.bottomCenter,
                                  height: 25,
                                  width: 99,
                                  decoration: const BoxDecoration(
                                      color: verySoftOrangeCustomColor,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(100),
                                        topRight: Radius.circular(100),
                                        bottomLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15),
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          height: 107,
                          width: 107,
                          decoration: BoxDecoration(
                            color: verySoftRed[60],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 10),
                                child: Text('View\nQueue',
                                    style: body14SemiBoldWhite),
                              ),
                              Align(
                                child: Container(
                                  alignment: Alignment.bottomCenter,
                                  height: 25,
                                  width: 99,
                                  decoration: const BoxDecoration(
                                      color: verySoftRedCustomColor,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(100),
                                        topRight: Radius.circular(100),
                                        bottomLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15),
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  verticalSpace25,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Health Articles',
                        style: body16SemiBold,
                      ),
                      Text(
                        'See all',
                        style: body14RegularNeutral,
                      ),
                    ],
                  ),
                  verticalSpace18,
                  Column(
                    children: [
                      Card(
                        elevation: 9,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          height: 115,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 17.5, horizontal: 17.5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 80,
                                  height: 80,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(13),
                                      child: Image.asset(patientHomeHeader,
                                          fit: BoxFit.cover)),
                                ),
                                horizontalSpace18,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'Title',
                                      style: caption12SemiBold,
                                    ),
                                    Text(
                                      'description',
                                      style: caption10Regular,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
