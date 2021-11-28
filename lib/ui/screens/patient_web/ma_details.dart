import 'package:davnor_medicare/constants/app_strings.dart';
import 'package:davnor_medicare/core/controllers/navigation_controller.dart';
import 'package:davnor_medicare/core/controllers/patient/ma_req_controller.dart';
import 'package:davnor_medicare/core/controllers/status_controller.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:davnor_medicare/routes/app_pages.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/widgets/custom_button.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MADescriptionWebScreen extends StatelessWidget {
  final MARequestController ma = Get.find();
  final StatusController stats = Get.find();
  final NavigationController navigationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                        style: title40Medium,
                      ),
                      Text(madescriptionParagraph1, style: body20Regular),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text('medicalasssistance'.tr,
                        textAlign: TextAlign.justify, style: body18Regular),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'ma1'.tr,
                              style: body20SemiBold,
                            ),
                            verticalSpace5,
                            Text('(1) ${'ma2'.tr}',
                                textAlign: TextAlign.justify,
                                style: caption18Regular),
                            Text('(2) ${'ma3'.tr}',
                                textAlign: TextAlign.justify,
                                style: caption18Regular),
                          ],
                        ),
                      ),
                      horizontalSpace20,
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'ma4'.tr,
                              style: body20SemiBold,
                            ),
                            verticalSpace5,
                            Text('(1) ${'ma5'.tr}',
                                textAlign: TextAlign.justify,
                                style: caption18Regular),
                            Text('(2) ${'ma6'.tr}',
                                textAlign: TextAlign.justify,
                                style: caption18Regular),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text('ma7'.tr,
                        textAlign: TextAlign.justify, style: body20SemiBold),
                  ),
                  Row(
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('ma8'.tr,
                                textAlign: TextAlign.left,
                                style: caption18SemiBold),
                            verticalSpace10,
                            Text('ma9'.tr,
                                textAlign: TextAlign.left,
                                style: caption18SemiBold),
                          ]),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 2, 0, 0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const <Widget>[
                              verticalSpace5,
                              Text('Cut-off: 9:30 am & Releasing: 12:30 pm',
                                  textAlign: TextAlign.left,
                                  style: caption18Regular),
                              SizedBox(
                                height: 18,
                              ),
                              Text('Cut-off: 1:30 pm & Releasing: 4:30 pm',
                                  textAlign: TextAlign.left,
                                  style: caption18Regular),
                            ]),
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                  Align(
                      alignment: FractionalOffset.bottomRight,
                      child: availMAButton()),
                ]),
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
                    ma.isMAForYou.value = true;
                    dismissDialog();
                    navigationController
                        .navigateToWithBack(Routes.PATIENT_WEB_MA_FORM);
                  },
                  onNoTap: () {
                    ma.isMAForYou.value = false;
                    dismissDialog();
                    navigationController
                        .navigateToWithBack(Routes.PATIENT_WEB_MA_FORM);
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
      fontSize: 28,
    );
  }
}
