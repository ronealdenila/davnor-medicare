import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/ui/screens/auth/change_password.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:get/get.dart';

class DoctorProfileScreen extends StatelessWidget {
  static AuthController authController = Get.find();

  final fetchedData = authController.doctorModel.value;

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
                decoration: const BoxDecoration(
                  color: infoColor,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    verticalSpace5,
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        onPressed: Get.back,
                        icon: const Icon(
                          Icons.keyboard_arrow_left,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                    ),
                    verticalSpace10,
                    displayProfile(),
                    verticalSpace20,
                    DmText.title24Bold(
                      'Dr. ${fetchedData!.firstName} ${fetchedData!.lastName}',
                      color: Colors.white,
                    ),
                    verticalSpace5,
                    DmText.subtitle18Regular(
                      fetchedData!.email,
                      color: Colors.white,
                    ),
                  ],
                ),
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
                          decoration: BoxDecoration(
                            color: infoColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Icon(
                            Icons.perm_contact_calendar,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(18, 0, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'SPECIALTY',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              verticalSpace5,
                              DmText.subtitle18Medium(fetchedData!.title),
                            ],
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
                          decoration: BoxDecoration(
                            color: infoColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Icon(
                            Icons.perm_contact_calendar,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(18, 0, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                //'${to.userModel.value.department}'
                                'DEPARTMENT',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              DmText.subtitle18Medium(fetchedData!.department),
                            ],
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
                          decoration: BoxDecoration(
                            color: infoColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Icon(
                            Icons.perm_contact_calendar,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(18, 0, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'CLINIC HOURS',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              DmText.subtitle18Medium(fetchedData!.clinicHours),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () => Get.to(() => ChangePasswordScreen()),
                icon: const Icon(
                  Icons.lock,
                  color: Colors.white,
                  size: 20,
                ),
                style: ElevatedButton.styleFrom(
                    elevation: 5,
                    primary: infoColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 35, vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
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

  Widget displayProfile() {
    if (fetchedData!.profileImage == '') {
      return CircleAvatar(
        radius: 50,
        backgroundImage: AssetImage(blankProfile),
      );
    }
    return CircleAvatar(
      radius: 50,
      backgroundImage: NetworkImage(fetchedData!.profileImage!),
    );
  }
}
