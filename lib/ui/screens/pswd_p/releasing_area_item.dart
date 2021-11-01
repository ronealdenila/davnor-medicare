import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/constants/app_strings.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/pswd/attached_photos_controller.dart';
import 'package:davnor_medicare/core/models/general_ma_req_model.dart';
import 'package:davnor_medicare/core/models/med_assistance_model.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/widgets/pswd/ma_item_view.dart';
import 'package:davnor_medicare/ui/widgets/pswd/pswd_custom_button.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReleasingAreaItemScreen extends StatelessWidget {
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
      receivedBy: passedData.receivedBy,
      pharmacy: passedData.pharmacy,
      medWorth: passedData.medWorth,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              PSWDItemView(context, 'medReady', model),
              Align(
                alignment: Alignment.bottomRight,
                child: PSWDButton(
                  onItemTap: () {
                    showConfirmationDialog(
                      dialogTitle: dialogpswdTitle,
                      dialogCaption: dialogpswdCaption,
                      onYesTap: () {
                        showLoading();
                        transfferToHistpry(model);
                        dismissDialog();
                      },
                      onNoTap: () {
                        dismissDialog();
                      },
                    );
                  },
                  buttonText: 'Claimed',
                ),
              ),
              verticalSpace35,
            ],
          ),
        ),
      ),
    );
  }

  Future<void> transfferToHistpry(GeneralMARequestModel model) async {
    showLoading();
    await firestore
        .collection('ma_history')
        .doc(model.maID)
        .set(<String, dynamic>{
      'maID': model.maID,
      'patientId': model.requesterID,
      'fullName': model.fullName,
      'age': model.age,
      'address': model.address,
      'gender': model.gender,
      'type': model.type,
      'prescriptions': model.prescriptions,
      'dateRqstd': model.dateRqstd,
      'validID': model.validID,
      'receivedBy': model.receivedBy,
      'medWorth': model.medWorth,
      'pharmacy': model.pharmacy,
      'dateClaimed': Timestamp.fromDate(DateTime.now()),
    }).then((value) async {
      //NOTIF USER: CLAIMED
      await deleteMA(model.maID!);
      dismissDialog(); //dismissLoading
      dismissDialog(); //then dismiss dialog for are your sure? yes/no
      Get.back();
    });
  }

  Future<void> deleteMA(String maID) async {
    await firestore
        .collection('on_progress_ma')
        .doc(maID)
        .delete()
        .then((value) => print("MA Request Deleted"))
        .catchError((error) => print("Failed to delete MA Request"));
  }
}
