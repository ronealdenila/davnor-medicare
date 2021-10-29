import 'package:davnor_medicare/core/controllers/pswd/attached_photos_controller.dart';
import 'package:davnor_medicare/core/models/general_ma_req_model.dart';
import 'package:davnor_medicare/core/models/med_assistance_model.dart';
import 'package:davnor_medicare/ui/widgets/pswd/ma_item_view.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MAHistoryItemScreen extends StatelessWidget {
  final AttachedPhotosController controller = Get.find();
  final MAHistoryModel passedData = Get.arguments as MAHistoryModel;
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
        receivedBy: passedData.receivedBy,
        dateRqstd: passedData.dateRqstd,
        pharmacy: passedData.pharmacy,
        medWorth: passedData.medWorth,
        dateClaimed: passedData.dateClaimed);

    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                PSWDItemView(context, 'completed', model),
                verticalSpace35,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
