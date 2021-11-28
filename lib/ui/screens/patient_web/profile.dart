import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/constants/app_strings.dart';
import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/profile_controller.dart';
import 'package:davnor_medicare/core/controllers/patient/verification_req_controller.dart';
import 'package:davnor_medicare/helpers/validator.dart';
import 'package:davnor_medicare/ui/screens/patient/verification.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/widgets/auth/form_input_field_with_icon.dart';
import 'package:davnor_medicare/ui/widgets/custom_button.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:get/get.dart';

class PatientProfileWebScreen extends StatelessWidget {
  static AuthController authController = Get.find();
  final ProfileController profileController = Get.put(ProfileController());
  final VerificationController verificationController =
      Get.put(VerificationController());
  final fetchedData = authController.patientModel.value;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                verticalSpace10,
                displayProfile(),
                verticalSpace20,
                DmText.title24Bold(
                  '${fetchedData!.firstName} ${fetchedData!.lastName}',
                ),
                verticalSpace5,
                DmText.subtitle18Medium(
                  '${fetchedData!.email} ',
                ),
                verticalSpace15,
                SizedBox(
                  width: Get.width * .2,
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
                verticalSpace25,
                ElevatedButton.icon(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => changePassword(context));
                  },
                  icon: const Icon(
                    Icons.lock,
                    color: Colors.white,
                    size: 20,
                  ),
                  style: ElevatedButton.styleFrom(
                      elevation: 5,
                      primary: infoColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 35, vertical: 17),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      textStyle: const TextStyle(
                        fontSize: 18,
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
      ),
    );
  }

  Widget displayProfile() {
    return StreamBuilder<DocumentSnapshot>(
        stream: profileController.getProfilePatient(),
        builder: (context, snapshot) {
          if (snapshot.hasError || !snapshot.hasData) {
            return Stack(
              children: [
                CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage(blankProfile),
                ),
                Positioned(
                    bottom: 0,
                    right: 05,
                    child: ClipOval(
                      child: Material(
                        color: Colors.lightBlue,
                        child: InkWell(
                          onTap: () {
                            //upload and change profile photo
                            profileController.selectProfileImage();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Center(
                              child: Icon(
                                Icons.add_photo_alternate_rounded,
                                color: Colors.white,
                                size: 50,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )),
              ],
            );
          }
          final data = snapshot.data!.data() as Map<String, dynamic>;
          if (data['profileImage'] == '') {
            return Stack(
              children: [
                CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage(blankProfile),
                ),
                Positioned(
                    bottom: 0,
                    right: 05,
                    child: ClipOval(
                      child: Material(
                        color: Colors.lightBlue,
                        child: InkWell(
                          onTap: () {
                            //upload and change profile photo
                            profileController.selectProfileImage();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Center(
                              child: Icon(
                                Icons.add_photo_alternate_rounded,
                                color: Colors.white,
                                size: 50,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )),
              ],
            );
          }
          return Stack(children: [
            CircleAvatar(
              radius: 80,
              foregroundImage: NetworkImage(data['profileImage']),
              backgroundImage: AssetImage(blankProfile),
            ),
            Positioned(
                bottom: 0,
                right: 05,
                child: ClipOval(
                  child: Material(
                    color: Colors.lightBlue,
                    child: InkWell(
                      onTap: () {
                        profileController.selectProfileImage();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Center(
                          child: Icon(
                            Icons.add_photo_alternate_rounded,
                            color: Colors.white,
                            size: 50,
                          ),
                        ),
                      ),
                    ),
                  ),
                )),
          ]);
        });
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

Widget changePassword(BuildContext context) {
  final AuthController authController = Get.find();
  return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      contentPadding: EdgeInsets.symmetric(
        vertical: 30,
        horizontal: 50,
      ),
      children: [
        SizedBox(
          width: Get.width * .2,
          child: Column(
            children: [
              verticalSpace25,
              const Text(
                'Change Password',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
              ),
              verticalSpace10,
              const Text(
                changePasswordDescription,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: neutralColor),
              ),
              verticalSpace50,
              Obx(
                () => FormInputFieldWithIcon(
                  controller: authController.currentPasswordController,
                  iconPrefix: Icons.vpn_key_rounded,
                  labelText: 'Current Password',
                  maxLines: 1,
                  obscureText: authController.isObscureCurrentPW!.value,
                  onChanged: (value) {
                    return;
                  },
                  onSaved: (value) =>
                      authController.currentPasswordController.text = value!,
                  suffixIcon: IconButton(
                    onPressed: authController.toggleCurrentPasswordVisibility,
                    icon: Icon(
                      authController.isObscureCurrentPW!.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  ),
                  validator: Validator().password,
                ),
              ),
              verticalSpace25,
              Obx(
                () => FormInputFieldWithIcon(
                  controller: authController.newPasswordController,
                  iconPrefix: Icons.vpn_key_rounded,
                  labelText: 'New Password',
                  onChanged: (value) {
                    return;
                  },
                  maxLines: 1,
                  obscureText: authController.isObscureNewPW!.value,
                  onSaved: (value) =>
                      authController.newPasswordController.text = value!,
                  suffixIcon: IconButton(
                    onPressed: authController.toggleNewPasswordVisibility,
                    icon: Icon(
                      authController.isObscureNewPW!.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  ),
                  textInputAction: TextInputAction.done,
                  validator: Validator().password,
                ),
              ),
              verticalSpace25,
              CustomButton(
                onTap: () async {
                  await authController.changePassword(context);
                },
                text: 'Change Password',
                buttonColor: verySoftBlueColor,
              ),
            ],
          ),
        )
      ]);
}
