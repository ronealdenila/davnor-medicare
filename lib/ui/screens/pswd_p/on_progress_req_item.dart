import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/core/controllers/attached_photos_controller.dart';
import 'package:davnor_medicare/core/controllers/pswd/on_progress_req_controller.dart';
import 'package:davnor_medicare/core/models/general_ma_req_model.dart';
import 'package:davnor_medicare/core/models/med_assistance_model.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/widgets/pswd/ma_item_view.dart';
import 'package:davnor_medicare/ui/widgets/pswd/pswd_custom_button.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnProgressReqItemScreen extends StatelessWidget {
  OnProgressReqItemScreen({Key? key, required this.passedData})
      : super(key: key);
  final OnProgressMAModel passedData;
  final AuthController authController = Get.find();
  final AttachedPhotosController pcontroller = Get.find();
  late final GeneralMARequestModel model;
  final OnProgressReqController opController = Get.find();

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
              IconButton(
                  onPressed: () {
                    opController.goBack();
                  },
                  icon: Icon(
                    Icons.arrow_back_outlined,
                    size: 30,
                  )),
              PSWDItemView(context, 'approved', model),
              authController.userRole == 'pswd-h'
                  ? SizedBox(
                      width: 0,
                      height: 0,
                    )
                  : Align(
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
    return SimpleDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
                      controller: opController.pharmacyController,
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
                      controller: opController.worthController,
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
                  authController.userRole == 'pswd-h'
                      ? SizedBox(
                          width: 0,
                          height: 0,
                        )
                      : Align(
                          alignment: Alignment.bottomCenter,
                          child: PSWDButton(
                              onItemTap: () async {
                                await opController.toBeReleased(
                                    model.maID!, model.requesterID!);
                              },
                              buttonText: 'Submit')),
                ],
              ))
        ]);
  }
}
