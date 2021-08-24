import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:get/get.dart';

class DoctorProfileScreen extends StatelessWidget {
  static AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .4,
                decoration: new BoxDecoration(
                  color: kcInfoColor,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                  ),
                ),
                child: Column(children: <Widget>[
                  SizedBox(
                    height: 5,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.keyboard_arrow_left,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CircleAvatar(
                    backgroundImage: AssetImage(authHeader),
                    radius: 50,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Dr. ${authController.userModel.value!.firstName} ${authController.userModel.value!.lastName}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    '${authController.userModel.value!.email}',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                        color: Colors.white),
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 7,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: 50,
                          width: 50,
                          decoration: const BoxDecoration(
                            color: kcInfoColor,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(50),
                              topLeft: Radius.circular(50),
                              bottomRight: Radius.circular(50),
                              bottomLeft: Radius.circular(50),
                            ),
                          ),
                          child: const Icon(
                            Icons.perm_contact_calendar,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(18, 0, 0, 0),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const <Widget>[
                                Text(
                                  'SPECIALTY',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  //'${to.userModel.value.email}'
                                  'Cardiologist  - x',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 7,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: 50,
                          width: 50,
                          decoration: const BoxDecoration(
                            color: kcInfoColor,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(50),
                              topLeft: Radius.circular(50),
                              bottomRight: Radius.circular(50),
                              bottomLeft: Radius.circular(50),
                            ),
                          ),
                          child: const Icon(
                            Icons.perm_contact_calendar,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(18, 0, 0, 0),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  //'${to.userModel.value.department}'
                                  'DEPARTMENT',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  'Internal Medicine  - x',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 7,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: 50,
                          width: 50,
                          decoration: const BoxDecoration(
                            color: kcInfoColor,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(50),
                              topLeft: Radius.circular(50),
                              bottomRight: Radius.circular(50),
                              bottomLeft: Radius.circular(50),
                            ),
                          ),
                          child: const Icon(
                            Icons.perm_contact_calendar,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(18.0, 0, 0, 0),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Text(
                                  'CLINIC HOURS',
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                const Text(
                                  '1pm - 6pm (Weekends) - x',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.lock,
                  color: Colors.white,
                  size: 20,
                ),
                style: ElevatedButton.styleFrom(
                    elevation: 5,
                    primary: kcInfoColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 35, vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    )),
                label: const Text('Change Password'),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
