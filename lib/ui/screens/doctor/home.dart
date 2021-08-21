import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:davnor_medicare/ui/screens/doctor/profile.dart';
import 'package:davnor_medicare/core/controllers/authController.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';

class DoctorHomeScreen extends StatelessWidget {
  static AuthController to = Get.find();

  //data needed for consultation process
  final int slot = 10;
  final int count = 0;
  final bool isAvailable = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kcVerySoftBlueColor,
        body: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          onPressed: () {
                            Get.to(() => DoctorProfileScreen());
                            //Open Drawer pero Goto Profile lang sa For now for testing (E)
                          },
                          icon: Icon(
                            Icons.notes,
                            color: Colors.white,
                            size: 35.0,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            AuthController.to.signOut();
                          },
                          icon: Icon(
                            Icons.logout,
                            color: Colors.white,
                            size: 30.0,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Hello',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Dr. ${to.userModel.value.lastName}!',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Align(
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
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              isAvailable
                                  ? 'Available for Consultation'
                                  : 'Unavailable',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: kcVerySoftBlueColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                  ]),
            ),
            Expanded(
              child: Container(
                decoration: new BoxDecoration(
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
