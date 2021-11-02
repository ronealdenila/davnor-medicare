import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/constants/app_strings.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/pswd/attached_photos_controller.dart';
import 'package:davnor_medicare/core/models/general_ma_req_model.dart';
import 'package:davnor_medicare/core/models/med_assistance_model.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/widgets/custom_button.dart';
import 'package:davnor_medicare/ui/widgets/pswd/ma_item_view.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final RxBool hasAccepted = false.obs;
final TextEditingController reason = TextEditingController();

class MARequestItemScreen extends StatelessWidget {
  final AttachedPhotosController controller = Get.find();
  final MARequestModel passedData = Get.arguments as MARequestModel;
  late final GeneralMARequestModel model;

  @override
  Widget build(BuildContext context) {
    model = GeneralMARequestModel(
        maID: passedData.maID,
        requesterID: passedData.requesterID,
        fullName: passedData.fullName,
        age: passedData.age,
        address: passedData.address,
        gender: passedData.gender,
        type: passedData.type,
        prescriptions: passedData.prescriptions,
        validID: passedData.validID,
        dateRqstd: passedData.date_rqstd);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              PSWDItemView(context, 'request', model),
              screenButtons(context, model),
              verticalSpace35,
            ],
          ),
        ),
      ),
    );
  }

  Widget screenButtons(BuildContext context, GeneralMARequestModel model) {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      PSWDButton(
        onItemTap: () {
          showConfirmationDialog(
            dialogTitle: dialogpswdTitle,
            dialogCaption:
                'Please select yes if you want to accept the request',
            onYesTap: () async {
              hasAccepted.value = true;
              await acceptMA(model);
            },
            onNoTap: () {
              dismissDialog();
            },
          );
        },
        buttonText: 'Accept',
      ),
      PSWDButton(
        onItemTap: () {
          showDialog(
              context: context, builder: (context) => declineDialogMA(model));
        },
        buttonText: 'Decline',
      ),
    ]);
  }
}

Future<void> addNotification(String uid) async {
  final action = ' has denied your ';
  final title = 'The pswd personnel${action}Medical Assistance(MA) Request';
  final message = '"${reason.text}"';

  await firestore
      .collection('patients')
      .doc(uid)
      .collection('notifications')
      .add({
    'photo': '',
    'from': 'The pswd personnel',
    'action': action,
    'subject': 'MA Request',
    'message': message,
    'createdAt': Timestamp.fromDate(DateTime.now()),
  });

  await appController.sendNotificationViaFCM(title, message, uid);

  await firestore
      .collection('patients')
      .doc(uid)
      .collection('status')
      .doc('value')
      .get()
      .then((doc) async {
    final count = int.parse(doc['notifBadge'] as String) + 1;
    await firestore
        .collection('patients')
        .doc(uid)
        .collection('status')
        .doc('value')
        .update({
      'notifBadge': '$count',
    });
  });
}

Future<void> acceptMA(GeneralMARequestModel model) async {
  showLoading();
  await firestore
      .collection('on_progress_ma')
      .doc(model.maID)
      .set(<String, dynamic>{
    'maID': model.maID,
    'requesterID': model.requesterID,
    'fullName': model.fullName,
    'age': model.age,
    'address': model.address,
    'gender': model.gender,
    'type': model.type,
    'prescriptions': model.prescriptions,
    'dateRqstd': model.dateRqstd,
    'validID': model.validID,
    'isTransferred': false,
    'receivedBy': auth.currentUser!.uid,
    'isApproved': false,
    'isMedReady': false,
    'medWorth': '',
    'pharmacy': '',
  }).then((value) async {
    //NOTIF TO PREPARE FOR AN INTERVIEW (undecided yet)
    await deleteMA(model.maID!);
    dismissDialog(); //dismissLoading
    dismissDialog(); //then dismiss dialog for are your sure? yes/no
    Get.back();
  });
}

Future<void> deleteMA(String maID) async {
  await firestore
      .collection('ma_request')
      .doc(maID)
      .delete()
      .then((value) => print("MA Request Deleted"))
      .catchError((error) => print("Failed to delete MA Request"));
}

Widget declineDialogMA(GeneralMARequestModel model) {
  return SimpleDialog(
      contentPadding: const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
      children: [
        SizedBox(
            width: 950,
            child: Column(
              children: [
                const Text(
                  'To inform the patient',
                  style: title32Regular,
                ),
                verticalSpace10,
                const Text(
                  'Please specify the reason',
                  style: title20Regular,
                ),
                verticalSpace50,
                TextFormField(
                  controller: reason,
                  decoration: const InputDecoration(
                    labelText: 'Enter the reason here',
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                  ),
                  maxLines: 10,
                  keyboardType: TextInputType.multiline,
                ),
                verticalSpace25,
                Align(
                    alignment: Alignment.bottomCenter,
                    child: PSWDButton(
                        onItemTap: () async {
                          hasAccepted.value = true;
                          showLoading();
                          await updatePatientStatus(model.requesterID!);
                          await addNotification(model.requesterID!);
                          await deleteMAFromQueue(model.maID!);
                          await deleteMA(model.maID!);
                          dismissDialog(); //dismiss Loading
                          dismissDialog(); //dismiss Popup Dialog
                          Get.back();
                        },
                        buttonText: 'Submit')),
              ],
            ))
      ]);
}

Future<void> deleteMAFromQueue(String maID) async {
  await firestore
      .collection('ma_queue')
      .doc(maID)
      .delete()
      .then((value) => print("MA Req Deleted in Queue"))
      .catchError((error) => print("Failed to delete ma req in queue"));
}

Future<void> updatePatientStatus(String patientID) async {
  await firestore
      .collection('patients')
      .doc(patientID)
      .collection('status')
      .doc('value')
      .update({'hasActiveQueueMA': false, 'queueMA': ''});
}
