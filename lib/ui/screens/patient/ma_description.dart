import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/constants/app_strings.dart';
import 'package:davnor_medicare/constants/firebase.dart';
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
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text(madescriptionParagraph2,
                      textAlign: TextAlign.justify, style: body14Regular),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: screenWidthPercentage(context, percentage: .4),
                      child: const Text(
                        'REQUIREMENTS',
                        style: body14SemiBold,
                      ),
                    ),
                    SizedBox(
                      width: screenWidthPercentage(context, percentage: .4),
                      child: const Text(
                        'WHERE TO SECURE',
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
                      child: const Text(madescriptionParagraph3,
                          textAlign: TextAlign.justify,
                          style: caption12Regular),
                    ),
                    SizedBox(
                      width: screenWidthPercentage(context, percentage: .4),
                      child: const Text(madescriptionParagraph4,
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
                      child: const Text(madescriptionParagraph5,
                          textAlign: TextAlign.justify,
                          style: caption12Regular),
                    ),
                    SizedBox(
                      width: screenWidthPercentage(context, percentage: .4),
                      child: const Text(madescriptionParagraph6,
                          textAlign: TextAlign.justify,
                          style: caption12Regular),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text('SCHEDULE',
                      textAlign: TextAlign.justify, style: body14SemiBold),
                ),
                Row(
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const <Widget>[
                          Text('Morning',
                              textAlign: TextAlign.left,
                              style: caption12SemiBold),
                          SizedBox(
                            height: 5,
                          ),
                          Text('Afternoon',
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
    return StreamBuilder<DocumentSnapshot>(
        stream: stats.getPatientStatus(auth.currentUser!.uid),
        builder: (context, snapshot) {
          final data = snapshot.data!.data() as Map<String, dynamic>;
          return CustomButton(
            onTap: () {
              if (data['pStatus'] as bool) {
                if (!data['hasActiveQueueMA']) {
                  if (controller.hasAvailableSlot()) {
                    //check activeQueue/slot/fund
                    return showConfirmationDialog(
                      dialogTitle: dialog2Title,
                      dialogCaption: dialog2Caption,
                      onYesTap: () {
                        controller.isMAForYou.value = true;
                        Get.to(() => MAFormScreen());
                      },
                      onNoTap: () {
                        controller.isMAForYou.value = false;
                        Get.to(() => MAFormScreen());
                      },
                    );
                  } else {
                    showErrorDialog(
                      errorTitle: 'No Slot Available',
                      errorDescription:
                          'Sorry, there are no available slots at the moment. Please try again next time',
                    );
                  }
                } else {
                  showErrorDialog(
                      errorTitle:
                          'Sorry, you still have an on progress MA request transaction',
                      errorDescription:
                          'Please proceed to your existing consultation');
                }
              } else {
                showErrorDialog(
                    errorTitle:
                        'Sorry, only verified users can use this feature',
                    errorDescription:
                        'Please verify your account first in your profile');
              }
            },
            text: 'Avail Medical Assistance',
            buttonColor: verySoftBlueColor,
            fontSize: 20,
          );
        });
  }

  void showDialog() {
    return showConfirmationDialog(
      dialogTitle: dialog2Title,
      dialogCaption: dialog2Caption,
      onYesTap: () {
        controller.isMAForYou.value = true;
        Get.to(() => MAFormScreen());
      },
      onNoTap: () {
        controller.isMAForYou.value = false;
        Get.to(() => MAFormScreen());
      },
    );
  }
}
