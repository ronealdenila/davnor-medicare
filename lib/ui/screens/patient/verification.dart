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

class VerificationScreen extends StatelessWidget {
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Icon(
                            Icons.file_upload_outlined,
                            size: 51,
                            color: neutralColor[60],
                          ),
                        ),
                        verticalSpace10,
                        Text(
                          'Upload here',
                          style: subtitle18RegularNeutral,
                        )
                      ],
                    ),
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Icon(
                            Icons.file_upload_outlined,
                            size: 51,
                            color: neutralColor[60],
                          ),
                        ),
                        verticalSpace10,
                        Text(
                          'Upload here',
                          style: subtitle18RegularNeutral,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              verticalSpace25,
              Align(
                alignment: FractionalOffset.bottomCenter,
                child: SizedBox(
                  width: 211,
                  child: CustomButton(
                    onTap: () {
                      showDefaultDialog(
                        dialogTitle: dialog6Title,
                        dialogCaption: dialog6Caption,
                        onConfirmTap: () {
                          Get.to(() => PatientHomeScreen());
                        },
                      );
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
}
