import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:davnor_medicare/ui/screens/doctor/profile.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';

class DoctorHomeScreen extends StatelessWidget {
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
              onPressed: () {
                authController.signOut();
              },
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
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      height: 5,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
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
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              fetchedData!.dStatus!
                                  ? 'Available for Consultation'
                                  : 'Unavailable',
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: verySoftBlueColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ]),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(55),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
