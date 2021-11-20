import 'package:davnor_medicare/constants/app_strings.dart';
import 'package:davnor_medicare/core/controllers/pswd/attached_photos_controller.dart';
import 'package:davnor_medicare/core/controllers/pswd/ma_req_list_controller.dart';
import 'package:davnor_medicare/core/controllers/status_controller.dart';
import 'package:davnor_medicare/core/models/general_ma_req_model.dart';
import 'package:davnor_medicare/core/models/med_assistance_model.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/widgets/custom_button.dart';
import 'package:davnor_medicare/ui/widgets/pswd/ma_item_view.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MARequestItemScreen extends StatelessWidget {
  MARequestItemScreen({Key? key, required this.passedData}) : super(key: key);
  final MARequestModel passedData;
  late final GeneralMARequestModel model;
  final MAReqListController maController = Get.find();
  final StatusController stats = Get.find();
  final AttachedPhotosController pcontroller = Get.find();

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace50,
              TextButton(
                  onPressed: () {
                    maController.goBack();
                  },
                  child: Text('Back to MA Requests Table')),
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
              if (stats.pswdPStatus.isEmpty && !stats.isPSLoading.value) {
                await maController.acceptMA(model);
              } else {
                showErrorDialog(
                    errorTitle: 'It looks like you already accepted a request',
                    errorDescription:
                        'Please finish the accepted request first before accepting another');
              }
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

  Widget declineDialogMA(GeneralMARequestModel model) {
    return SimpleDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
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
                    controller: maController.reason,
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
                            await maController.declineMARequest(
                                model.maID!, model.requesterID!);
                          },
                          buttonText: 'Submit')),
                ],
              ))
        ]);
  }
}
