import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:davnor_medicare/ui/screens/patient/home.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:davnor_medicare/ui/widgets/custom_button.dart';
import 'package:davnor_medicare/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:davnor_medicare/core/services/logger.dart';
import 'package:davnor_medicare/core/controllers/app_controller.dart';
import 'package:davnor_medicare/constants/firebase.dart';

class VerificationScreen extends StatelessWidget {
  final log = getLogger('Verification Screen');
  final AppController to = Get.find();
  final String userID = auth.currentUser!.uid;

  final RxString imgOfValidID = ''.obs;
  final RxString imgOfValidIDWithSelfie = ''.obs;
  final RxString imgURL = ''.obs;
  final RxString imgURLselfie = ''.obs;

  Future<void> uploadID(String filePathID) async {
    final ref = storageReference.child('validID/$userID.png');
    final uploadTask = ref.putFile(File(filePathID));
    await uploadTask.then((res) async {
      imgURL.value = await res.ref.getDownloadURL();
    });
  }

  Future<void> uploadIDS(String filePathIDS) async {
    final ref = storageReference.child('validIDSelfie/$userID.png');
    final uploadTask = ref.putFile(File(filePathIDS));
    await uploadTask.then((res) async {
      imgURLselfie.value = await res.ref.getDownloadURL();
    });
  }

  bool hasImagesSelected() {
    if (imgOfValidID.value != '' && imgOfValidIDWithSelfie.value != '') {
      return true;
    }
    return false;
  }

  Future<void> addVerificationRequest(String pathID, String pathIDS) async {
    await uploadID(pathID);
    await uploadIDS(pathIDS);
    await firestore.collection('to_verify').add({
      'patient_id': auth.currentUser!.uid,
      'valid_id': imgURL.value,
      'valid_selfie': imgURLselfie.value,
      'date_rqstd': Timestamp.fromDate(DateTime.now()),
    });
    //update user hasPendingStatus
    await showDialog();
  }

  Future<void> showDialog() async {
    showDefaultDialog(
      dialogTitle: dialog6Title,
      dialogCaption: dialog6Caption,
      onConfirmTap: () {
        Get.to(() => PatientHomeScreen());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CupertinoNavigationBarBackButton(
          color: Colors.black,
          onPressed: () {
            //back to...
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'To Verify Your Account',
                style: title24Bold,
              ),
              verticalSpace10,
              const Text(
                verificationDescription,
                style: body14Regular,
              ),
              verticalSpace35,
              const Text(
                'Upload Valid ID or Brgy. Certificate',
                style: body16Regular,
              ),
              verticalSpace10,
              DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(12),
                padding: const EdgeInsets.all(12),
                dashPattern: const [8, 8, 8, 8],
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  child: Container(
                    width: screenWidth(context),
                    height: 150,
                    color: neutralColor[10],
                    child: Obx(getValidID),
                  ),
                ),
              ),
              verticalSpace25,
              const Text(
                'Upload Valid ID or Brgy. Certificate with selfie',
                style: body16Regular,
              ),
              verticalSpace10,
              DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(12),
                padding: const EdgeInsets.all(12),
                dashPattern: const [8, 8, 8, 8],
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  child: Container(
                    width: screenWidth(context),
                    height: 150,
                    color: neutralColor[10],
                    child: Obx(getValidIDWithSelfie),
                  ),
                ),
              ),
              verticalSpace25,
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 211,
                  child: CustomButton(
                    onTap: () {
                      if (hasImagesSelected()) {
                        addVerificationRequest(
                            imgOfValidID.value, imgOfValidIDWithSelfie.value);
                      } else {
                        log.i('Verification Screen | Please provide images');
                      }
                    },
                    text: 'Submit',
                    buttonColor: verySoftBlueColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getValidID() {
    if (imgOfValidID.value == '') {
      return InkWell(
        onTap: () async {
          await to.pickSingleImage(imgOfValidID);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.file_upload_outlined,
              size: 51,
              color: neutralColor[60],
            ),
            verticalSpace10,
            Text(
              'Upload here',
              style: subtitle18RegularNeutral,
            )
          ],
        ),
      );
    }
    return InkWell(
      onTap: () {
        to.pickSingleImage(imgOfValidID);
      },
      child: Stack(
        children: [
          Image.file(
            File(imgOfValidID.value),
            width: Get.width,
            height: Get.height,
            fit: BoxFit.fill,
          ),
          Positioned(
            right: 5,
            top: 5,
            child: InkWell(
              onTap: () {
                imgOfValidID.value = '';
              },
              child: const Icon(
                Icons.remove_circle,
                size: 30,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getValidIDWithSelfie() {
    if (imgOfValidIDWithSelfie.value == '') {
      return InkWell(
        onTap: () async {
          await to.pickSingleImage(imgOfValidIDWithSelfie);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.file_upload_outlined,
              size: 51,
              color: neutralColor[60],
            ),
            verticalSpace10,
            Text(
              'Upload here',
              style: subtitle18RegularNeutral,
            )
          ],
        ),
      );
    }
    return InkWell(
      onTap: () {
        to.pickSingleImage(imgOfValidIDWithSelfie);
      },
      child: Stack(
        children: [
          Image.file(
            File(imgOfValidIDWithSelfie.value),
            width: Get.width,
            height: Get.height,
            fit: BoxFit.fill,
          ),
          Positioned(
            right: 5,
            top: 5,
            child: InkWell(
              onTap: () {
                imgOfValidIDWithSelfie.value = '';
              },
              child: const Icon(
                Icons.remove_circle,
                size: 30,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
