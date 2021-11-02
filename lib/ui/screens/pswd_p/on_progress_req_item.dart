import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/pswd/attached_photos_controller.dart';
import 'package:davnor_medicare/core/models/general_ma_req_model.dart';
import 'package:davnor_medicare/core/models/med_assistance_model.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/widgets/pswd/ma_item_view.dart';
import 'package:davnor_medicare/ui/widgets/pswd/pswd_custom_button.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnProgressReqItemScreen extends StatelessWidget {
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
        receivedBy: passedData.receivedBy,
        validID: passedData.validID,
        dateRqstd: passedData.dateRqstd);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              PSWDItemView(context, 'approved', model),
              Align(
                alignment: Alignment.bottomRight,
                child: PSWDButton(
                  onItemTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => detailsDialogMA());
                  },
                  buttonText: 'Medicine is Ready',
                ),
              ),
              verticalSpace35,
            ],
          ),
        ),
      ),
    );
  }

  Widget detailsDialogMA() {
    final _pharmacyController = TextEditingController();
    final _worthController = TextEditingController();
    return SimpleDialog(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
        children: [
          SizedBox(
              width: 590,
              child: Column(
                children: [
                  const Text(
                    'To Complete the Details for the Medical Assistance',
                    textAlign: TextAlign.center,
                    style: title32Regular,
                  ),
                  verticalSpace50,
                  SizedBox(
                    width: 360,
                    height: 60,
                    child: TextFormField(
                      controller: _pharmacyController,
                      decoration: const InputDecoration(
                        labelText: 'Name of Pharmacy',
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
                  ),
                  verticalSpace25,
                  SizedBox(
                    width: 360,
                    height: 60,
                    child: TextFormField(
                      controller: _worthController,
                      decoration: const InputDecoration(
                        labelText: 'Worth of Medicine',
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
                  ),
                  verticalSpace25,
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: PSWDButton(
                          onItemTap: () async {
                            await firestore
                                .collection('on_progress_ma')
                                .doc(model.maID)
                                .update({
                              'isMedReady': true,
                              'medWorth': _worthController.text,
                              'pharmacy': _pharmacyController.text
                            }).then((value) {
                              //TO DO: notify patient na pwede na ma claime
                            });
                          },
                          buttonText: 'Submit')),
                ],
              ))
        ]);
  }
}
