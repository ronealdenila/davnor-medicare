import 'dart:io';
import 'package:davnor_medicare/core/controllers/patient/verification_req_controller.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:davnor_medicare/ui/widgets/custom_button.dart';
import 'package:davnor_medicare/constants/app_strings.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class VerificationScreen extends GetView<VerificationController> {
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
                    onTap: controller.submitVerification,
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
    if (controller.imgOfValidID.value == '') {
      return InkWell(
        onTap: controller.pickValidID,
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
      onTap: controller.pickValidID,
      child: Stack(
        children: [
          Image.file(
            File(controller.imgOfValidID.value),
            width: Get.width,
            height: Get.height,
            fit: BoxFit.fill,
          ),
          Positioned(
            right: 5,
            top: 5,
            child: InkWell(
              onTap: () {
                controller.imgOfValidID.value = '';
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
    if (controller.imgOfValidIDWithSelfie.value == '') {
      return InkWell(
        onTap: controller.pickValidIDWithSelfie,
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
      onTap: controller.pickValidIDWithSelfie,
      child: Stack(
        children: [
          Image.file(
            File(controller.imgOfValidIDWithSelfie.value),
            width: Get.width,
            height: Get.height,
            fit: BoxFit.fill,
          ),
          Positioned(
            right: 5,
            top: 5,
            child: InkWell(
              onTap: () {
                controller.imgOfValidIDWithSelfie.value = '';
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
