import 'package:davnor_medicare/core/controllers/pswd/attached_photos_controller.dart';
import 'package:davnor_medicare/core/models/general_ma_req_model.dart';
import 'package:davnor_medicare/core/models/med_assistance_model.dart';
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

    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
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
                      //open dialog
                    },
                    buttonText: 'Medicine is Ready',
                  ),
                ),
                verticalSpace35,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
