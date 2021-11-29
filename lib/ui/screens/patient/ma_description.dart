import 'package:davnor_medicare/constants/app_strings.dart';

import 'package:davnor_medicare/core/controllers/status_controller.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:davnor_medicare/ui/screens/patient/home.dart';
import 'package:davnor_medicare/ui/screens/patient/ma_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/widgets/custom_button.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:davnor_medicare/core/controllers/patient/ma_req_controller.dart';
import 'package:get/get.dart';

class MADescriptionScreen extends StatelessWidget {
  final MARequestController controller = Get.put(MARequestController());
  final StatusController stats = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: CupertinoNavigationBarBackButton(
            color: Colors.black,
            onPressed: () => Get.offAll(() => PatientHomeScreen()),
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Text(
                      'Medical Assistance (MA)',
                      style: title24Medium,
                    ),
                    Text(madescriptionParagraph1, style: body16Regular),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text('medicalasssistance'.tr,
                      textAlign: TextAlign.justify, style: body14Regular),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: screenWidthPercentage(context, percentage: .4),
                      child: Text(
                        'ma1'.tr,
                        style: body14SemiBold,
                      ),
                    ),
                    SizedBox(
                      width: screenWidthPercentage(context, percentage: .4),
                      child: Text(
                        'ma4'.tr,
                        style: body14SemiBold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: screenWidthPercentage(context, percentage: .4),
                      child: Text('ma2'.tr,
                          textAlign: TextAlign.justify,
                          style: caption12Regular),
                    ),
                    SizedBox(
                      width: screenWidthPercentage(context, percentage: .4),
                      child: Text('ma5'.tr,
                          textAlign: TextAlign.justify,
                          style: caption12Regular),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: screenWidthPercentage(context, percentage: .4),
                      child: Text('ma3'.tr,
                          textAlign: TextAlign.justify,
                          style: caption12Regular),
                    ),
                    SizedBox(
                      width: screenWidthPercentage(context, percentage: .4),
                      child: Text('ma6'.tr,
                          textAlign: TextAlign.justify,
                          style: caption12Regular),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text('ma7'.tr,
                      textAlign: TextAlign.justify, style: body14SemiBold),
                ),
                Row(
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('ma8'.tr,
                              textAlign: TextAlign.left,
                              style: caption12SemiBold),
                          SizedBox(
                            height: 5,
                          ),
                          Text('ma9'.tr,
                              textAlign: TextAlign.left,
                              style: caption12SemiBold),
                        ]),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const <Widget>[
                            Text('Cut-off: 9:30 am & Releasing: 12:30 pm',
                                textAlign: TextAlign.left,
                                style: caption12Regular),
                            SizedBox(
                              height: 5,
                            ),
                            Text('Cut-off: 1:30 pm & Releasing: 4:30 pm',
                                textAlign: TextAlign.left,
                                style: caption12Regular),
                          ]),
                    ),
                  ],
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                Align(child: availMAButton()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget availMAButton() {
    return CustomButton(
      onTap: () {
        if (stats.patientStatus[0].pStatus!) {
          if (!stats.patientStatus[0].hasActiveQueueMA!) {
            if (stats.pswdPStatus[0].hasFunds!) {
              if (!stats.pswdPStatus[0].isCutOff!) {
                return showConfirmationDialog(
                  dialogTitle: 'dialog2'.tr,
                  dialogCaption: 'dialogsub2'.tr,
                  onYesTap: () {
                    controller.isMAForYou.value = true;
                    dismissDialog();
                    Get.to(() => MAFormScreen());
                  },
                  onNoTap: () {
                    controller.isMAForYou.value = false;
                    dismissDialog();
                    Get.to(() => MAFormScreen());
                  },
                );
              } else {
                showErrorDialog(
                    errorTitle: 'Sorry were cut off already.',
                    errorDescription: 'Please try again next time.');
              }
            } else {
              showErrorDialog(
                  errorTitle: 'Sorry MA has no fund for now.',
                  errorDescription: 'Please try again next time');
            }
          } else {
            showErrorDialog(
                errorTitle: 'maerror3'.tr, errorDescription: 'action6'.tr);
          }
        } else {
          showErrorDialog(
              errorTitle: 'action7'.tr, errorDescription: 'action8'.tr);
        }
      },
      text: 'ma10'.tr,
      buttonColor: verySoftBlueColor,
      fontSize: 20,
    );
  }
}
