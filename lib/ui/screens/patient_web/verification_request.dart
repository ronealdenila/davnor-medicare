import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/core/controllers/patient/verification_req_controller.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/widgets/custom_button.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:get/get.dart';

class VerificationWebScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 80),
        child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: ResponsiveView(context)),
        ),
      ),
    );
  }
}

class ResponsiveView extends GetResponsiveView {
  ResponsiveView(this.context) : super(alwaysUseBuilder: false);
  final BuildContext context;
  static AuthController authController = Get.find();
  final VerificationController verificationController = Get.find();
  final fetchedData = authController.patientModel.value;

  @override
  Widget tablet() => Column(
        children: [
          Text(
            'verification'.tr,
            style: title24Bold,
          ),
          verticalSpace10,
          Text(
            'verifi1'.tr,
            style: body14Regular,
          ),
          verticalSpace35,
          Wrap(
            alignment: WrapAlignment.center,
            runSpacing: 25,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  horizontalSpace35,
                  Column(
                    children: [
                      Text(
                        'verifi2'.tr,
                        style: body16Regular,
                      ),
                      verticalSpace10,
                      DottedBorder(
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(12),
                        padding: const EdgeInsets.all(12),
                        dashPattern: const [8, 8, 8, 8],
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                          child: Container(
                            width: 400,
                            height: 150,
                            color: neutralColor[10],
                            child: Obx(getValidID),
                          ),
                        ),
                      ),
                    ],
                  ),
                  horizontalSpace35,
                ],
              ),
              Column(
                children: [
                  Text(
                    'verifi3'.tr,
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
                        width: 400,
                        height: 150,
                        color: neutralColor[10],
                        child: Obx(getValidIDWithSelfie),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          verticalSpace25,
          button()
        ],
      );

  @override
  Widget desktop() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'verification'.tr,
            style: title24Bold,
          ),
          verticalSpace10,
          Text(
            'verifi1'.tr,
            style: body14Regular,
          ),
          verticalSpace35,
          SizedBox(
            width: Get.width,
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'verifi2'.tr,
                      style: body16Regular,
                    ),
                    verticalSpace10,
                    DottedBorder(
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(12),
                      padding: const EdgeInsets.all(12),
                      dashPattern: const [8, 8, 8, 8],
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                        child: Container(
                          width: 400,
                          height: 150,
                          color: neutralColor[10],
                          child: Obx(getValidID),
                        ),
                      ),
                    ),
                  ],
                ),
                horizontalSpace35,
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'verifi3'.tr,
                      style: body16Regular,
                    ),
                    verticalSpace10,
                    DottedBorder(
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(12),
                      padding: const EdgeInsets.all(12),
                      dashPattern: const [8, 8, 8, 8],
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                        child: Container(
                          width: 400,
                          height: 150,
                          color: neutralColor[10],
                          child: Obx(getValidIDWithSelfie),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          verticalSpace25,
          button(),
        ],
      );

  Widget getValidID() {
    if (verificationController.imgOfValidID.value == '') {
      return InkWell(
        onTap: verificationController.pickValidID,
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
              'verifi4'.tr,
              style: subtitle18RegularNeutral,
            )
          ],
        ),
      );
    }
    return InkWell(
      onTap: verificationController.pickValidID,
      child: Stack(
        children: [
          Image.network(
            verificationController.imgOfValidID.value,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(grayBlank, fit: BoxFit.cover);
            },
          ),
          Positioned(
            right: 5,
            top: 5,
            child: InkWell(
              onTap: () {
                verificationController.imgOfValidID.value = '';
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

  Widget button() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: 211,
        child: CustomButton(
          onTap: verificationController.submitVerification,
          text: 'verifi5'.tr,
          buttonColor: verySoftBlueColor,
        ),
      ),
    );
  }

  Widget getValidIDWithSelfie() {
    if (verificationController.imgOfValidIDWithSelfie.value == '') {
      return InkWell(
        onTap: verificationController.pickValidIDWithSelfie,
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
              'verifi4'.tr,
              style: subtitle18RegularNeutral,
            )
          ],
        ),
      );
    }
    return InkWell(
      onTap: verificationController.pickValidIDWithSelfie,
      child: Stack(
        children: [
          Image.network(
            verificationController.imgOfValidIDWithSelfie.value,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(grayBlank, fit: BoxFit.cover);
            },
          ),
          Positioned(
            right: 5,
            top: 5,
            child: InkWell(
              onTap: () {
                verificationController.imgOfValidIDWithSelfie.value = '';
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
