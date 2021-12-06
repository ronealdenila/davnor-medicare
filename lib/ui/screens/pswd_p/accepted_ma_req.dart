import 'package:davnor_medicare/core/controllers/pswd/accepted_ma_controller.dart';
import 'package:davnor_medicare/core/controllers/attached_photos_controller.dart';
import 'package:davnor_medicare/core/models/general_ma_req_model.dart';
import 'package:davnor_medicare/core/models/med_assistance_model.dart';
import 'package:davnor_medicare/ui/widgets/custom_button.dart';
import 'package:davnor_medicare/ui/widgets/pswd/ma_item_view.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AcceptedMARequestScreen extends StatelessWidget {
  AcceptedMARequestScreen({Key? key, required this.passedData})
      : super(key: key);
  final AttachedPhotosController controller = Get.find();
  final OnProgressMAModel passedData;
  late final GeneralMARequestModel model;
  final AcceptedMAController acceptedMA = Get.find();

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
        receiverID: passedData.receiverID,
        receivedBy: passedData.receivedBy);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              verticalSpace50,
              PSWDItemView(context, 'accepted', model),
              Align(
                alignment: Alignment.bottomRight,
                child: PSWDButton(
                  onItemTap: () async {
                    await acceptedMA.transferToHead(model);
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
