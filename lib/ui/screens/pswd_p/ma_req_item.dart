import 'package:davnor_medicare/core/controllers/pswd/attached_photos_controller.dart';
import 'package:davnor_medicare/core/models/general_ma_req_model.dart';
import 'package:davnor_medicare/core/models/med_assistance_model.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
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

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              PSWDItemView(context, 'request', model),
              screenButtons(),
              verticalSpace35,
            ],
          ),
        ),
      ),
    );
  }
}

Widget screenButtons() {
  return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
    CustomButton(
      onTap: () async {},
      text: 'Accept',
      buttonColor: verySoftOrange[60],
      fontSize: 15,
    ),
    horizontalSpace25,
    CustomButton(
      onTap: () async {},
      text: 'Decline',
      buttonColor: verySoftOrange[60],
      fontSize: 15,
    ),
  ]);
}
