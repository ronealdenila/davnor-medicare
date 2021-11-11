import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/pswd/attached_photos_controller.dart';
import 'package:davnor_medicare/core/models/general_ma_req_model.dart';
import 'package:davnor_medicare/core/models/med_assistance_model.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/widgets/custom_button.dart';
import 'package:davnor_medicare/ui/widgets/pswd/ma_item_view.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AcceptedMARequestScreen extends StatelessWidget {
  final AttachedPhotosController controller = Get.find();
  final OnProgressMAModel passedData = Get.arguments as OnProgressMAModel;
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
        dateRqstd: passedData.dateRqstd,
        receivedBy: passedData.receivedBy);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              PSWDItemView(context, 'accepted', model),
              Align(
                alignment: Alignment.bottomRight,
                child: PSWDButton(
                  onItemTap: () async {
                    await firestore
                        .collection('on_progress_ma')
                        .doc(model.maID)
                        .update({
                      'isTransferred': true,
                    }).then((value) async {
                      await deleteMAFromQueue(model.maID!);
                      await updatePatientStatus(model.requesterID!);
                      //TO THINK: if i notify pa si patient if na accept ba iyang request
                      Get.back();
                    }).catchError((onError) {
                      showErrorDialog(
                    errorDescription: 'Something went wrong'
                  );
                    });
                  },
                  buttonText: 'Transfer for Head Approval',
                ),
              ),
              verticalSpace35,
            ],
          ),
        ),
      ),
    );
  }
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
