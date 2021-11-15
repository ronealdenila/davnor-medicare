import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/patient/profile_controller.dart';
import 'package:davnor_medicare/core/controllers/patient/verification_req_controller.dart';
import 'package:davnor_medicare/ui/screens/auth/change_password.dart';
import 'package:davnor_medicare/ui/screens/patient/verification.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:get/get.dart';

class PatientProfileScreen extends StatelessWidget {
  static AuthController authController = Get.find();
  static ProfileController profileController = Get.put(ProfileController());
  static VerificationController verificationController =
      Get.put(VerificationController());
  final fetchedData = authController.patientModel.value;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                      '${fetchedData!.firstName} ${fetchedData!.lastName}',
                      color: Colors.white,
                    ),
                    verticalSpace5,
                    DmText.subtitle18Medium(
                      '${fetchedData!.email} ',
                      color: Colors.white,
                    ),
                  ],
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
                              Text('profile'.tr, style: body14Regular),
                              displayStatus()
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
                label: Text('profile2'.tr),
              ),
              const SizedBox(height: 20),
              Visibility(
                  visible: profileController.hasValidIDandValidSelfie(),
                  child: displayAttachedPhotos())
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
      backgroundImage: AssetImage(blankProfile),
    );
  }

  Widget displayStatus() {
    return StreamBuilder<DocumentSnapshot>(
      stream: verificationController.getStatus(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading');
        }
        final data = snapshot.data!.data() as Map<String, dynamic>;
        if (data['pStatus'] as bool) {
          return Text(
            'Verified',
            style: body16Regular.copyWith(
                color: verySoftBlueColor[80], fontWeight: FontWeight.bold),
          );
        } else if (data['pendingVerification'] as bool) {
          return Text(
            'Pending',
            style: body14Regular.copyWith(
                color: verySoftBlueColor[80], fontStyle: FontStyle.italic),
          );
        }
        return TextButton(
            onPressed: () {
              Get.to(() => VerificationScreen());
            },
            child: Text(
              'profile1'.tr,
              style: body16RegularUnderlineBlue,
            ));
      },
    );
  }

  Widget displayAttachedPhotos() {
    return StreamBuilder<DocumentSnapshot>(
      stream: firestore
          .collection('patients')
          .doc(auth.currentUser!.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError || !snapshot.hasData) {
          return SizedBox(
            height: 0,
            width: 0,
          );
        }
        final data = snapshot.data!.data() as Map<String, dynamic>;
        return Visibility(
          visible: data['validID'] != '' && data['validSelfie'] != '',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text('profile3'.tr, style: body14Regular),
              ),
              SizedBox(
                width: Get.width,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 120,
                          height: 120,
                          child: InkWell(
                            onTap: () => showDialog(
                                context: context,
                                builder: (context) =>
                                    attachedPhotoDialog(data['validID'])),
                            child: Image.network(
                              data['validID'],
                              height: 106,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(grayBlank,
                                    fit: BoxFit.cover);
                              },
                            ),
                          ),
                        ),
                        horizontalSpace10,
                        SizedBox(
                          width: 120,
                          height: 120,
                          child: InkWell(
                            onTap: () => showDialog(
                                context: context,
                                builder: (context) =>
                                    attachedPhotoDialog(data['validSelfie'])),
                            child: Image.network(
                              data['validSelfie'],
                              height: 106,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(grayBlank,
                                    fit: BoxFit.cover);
                              },
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        );
      },
    );
  }
}

Widget attachedPhotoDialog(String imgURL) {
  return SimpleDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    contentPadding: EdgeInsets.zero,
    titlePadding: EdgeInsets.zero,
    children: [
      Container(
        decoration: const BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(
              Radius.circular(40),
            )),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        width: Get.width * .9,
        child: Container(
          color: Colors.white,
          child: Image.network(
            imgURL,
            fit: BoxFit.fitHeight,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(grayBlank, fit: BoxFit.cover);
            },
          ),
        ),
      ),
    ],
  );
}
