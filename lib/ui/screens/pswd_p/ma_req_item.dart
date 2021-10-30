import 'package:davnor_medicare/constants/app_strings.dart';
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

class MARequestItemScreen extends StatelessWidget {
  final AttachedPhotosController controller = Get.find();
  final MARequestModel passedData = Get.arguments as MARequestModel;
  late final GeneralMARequestModel model;

  @override
  Widget build(BuildContext context) {
    model = GeneralMARequestModel(
        requesterID: passedData.requesterID,
        fullName: passedData.fullName,
        age: passedData.age,
        address: passedData.address,
        gender: passedData.gender,
        type: passedData.type,
        prescriptions: passedData.prescriptions,
        validID: passedData.validID,
        dateRqstd: passedData.date_rqstd);

    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                PSWDItemView(context, 'request', model),
                screenButtons(context),
                verticalSpace35,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget screenButtons(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      PSWDButton(
        onItemTap: () {
          showConfirmationDialog(
            dialogTitle: dialogpswdTitle,
            dialogCaption:
                'Please select yes if you want to accept the request',
            onYesTap: () {
              //pass this MA to onprgoress as transferred ACCEPTED
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
          showDialog(context: context, builder: (context) => declineDialogMA());
        },
        buttonText: 'Decline',
      ),
    ]);
  }
}

Widget declineDialogMA() {
  TextEditingController _textFieldController = TextEditingController();
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
                  controller: _textFieldController,
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
                        onItemTap: () {
                          print(_textFieldController.text);
                        },
                        buttonText: 'Submit')),
              ],
            ))
      ]);
}
