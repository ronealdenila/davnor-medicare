import 'dart:io';
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
import 'package:davnor_medicare/core/controllers/app_controller.dart';

// ignore: must_be_immutable
class VerificationScreen extends StatelessWidget {
  static AppController to = Get.find();
  // ignore: type_annotate_public_apis
  var imgOfValidID = ''.obs;
  // ignore: type_annotate_public_apis
  var imgOfValidIDWithSelfie = ''.obs;

  bool hasImagesSelected() {
    if (imgOfValidID.value != '' && imgOfValidIDWithSelfie.value != '') {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CupertinoNavigationBarBackButton(
          color: Colors.black,
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
                        //Upload photos to storage and get url,
                        //then save data to firestore for verification
                        showDefaultDialog(
                          dialogTitle: dialog6Title,
                          dialogCaption: dialog6Caption,
                          onConfirmTap: () {
                            Get.to(() => PatientHomeScreen());
                          },
                        );
                      } else {
                        //Error: "Please provide images"
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
      child: Image.file(
        File(imgOfValidID.value),
        fit: BoxFit.fill,
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
      child: Image.file(
        File(imgOfValidIDWithSelfie.value),
        fit: BoxFit.fill,
      ),
    );
  }
}
