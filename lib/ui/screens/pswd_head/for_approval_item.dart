import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/pswd/attached_photos_controller.dart';
import 'package:davnor_medicare/core/controllers/pswd/for_approval_controller.dart';
import 'package:davnor_medicare/core/models/general_ma_req_model.dart';
import 'package:davnor_medicare/core/models/med_assistance_model.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:davnor_medicare/ui/screens/pswd_head/helpers/local_navigator.dart';
import 'package:davnor_medicare/ui/widgets/custom_button.dart';
import 'package:davnor_medicare/ui/widgets/pswd/ma_item_view.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForApprovalItemScreen extends StatelessWidget {
  ForApprovalItemScreen({Key? key, required this.passedData}) : super(key: key);
  final OnProgressMAModel passedData;
  final ForApprovalController opController = Get.find();
  final AttachedPhotosController controller = Get.find();
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
        receivedBy: passedData.receivedBy,
        validID: passedData.validID,
        dateRqstd: passedData.dateRqstd);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace50,
              TextButton(
                  onPressed: () {
                    goBack();
                  },
                  child: Text('Back to For Approval Table')),
              PSWDItemView(context, 'transferred', model),
              screenButtons(),
              verticalSpace35,
            ],
          ),
        ),
      ),
    );
  }

  Future<void> goBack() {
    return navigationController.navigatorKey.currentState!
        .pushNamedAndRemoveUntil(
            '/ForApprovalListScreen', (Route<dynamic> route) => true);
  }

  Widget screenButtons() {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      PSWDButton(
        onItemTap: () {
          confirmationDialog(model.maID!);
        },
        buttonText: 'Approve',
      ),
      horizontalSpace25,
      PSWDButton(
        onItemTap: () async {
          //TO DO: maybe delete in on_progress_ma
          //delete folder in storage
          //and notify user, add reason
        },
        buttonText: 'Decline',
      ),
    ]);
  }

  void confirmationDialog(String maID) {
    return showConfirmationDialog(
      dialogTitle: 'Are you sure?',
      dialogCaption:
          'Select YES if you want to approve this MA Request. Otherwise, select NO',
      onYesTap: () async {
        await firestore
            .collection('on_progress_ma')
            .doc(maID)
            .update({'isApproved': true, 'isTransferred': false}).then((value) {
          opController.refresh();
        });
      },
      onNoTap: () {
        dismissDialog();
      },
    );
  }
}
