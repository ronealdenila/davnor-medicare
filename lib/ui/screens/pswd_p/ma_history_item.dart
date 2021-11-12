import 'package:davnor_medicare/core/controllers/ma_history_controller.dart';
import 'package:davnor_medicare/core/controllers/pswd/attached_photos_controller.dart';
import 'package:davnor_medicare/core/controllers/navigation_controller.dart';
import 'package:davnor_medicare/core/models/general_ma_req_model.dart';
import 'package:davnor_medicare/core/models/med_assistance_model.dart';
import 'package:davnor_medicare/ui/widgets/pswd/ma_item_view.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

NavigationController navigationController = Get.find();

class MAHistoryItemScreen extends StatelessWidget {
  MAHistoryItemScreen({Key? key, required this.passedData}) : super(key: key);
  final MAHistoryModel passedData;
  final AttachedPhotosController pcontroller = Get.find();

  final MAHistoryController hController = Get.find();
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
        receivedBy: passedData.receivedBy,
        dateRqstd: passedData.dateRqstd,
        pharmacy: passedData.pharmacy,
        medWorth: passedData.medWorth,
        dateClaimed: passedData.dateClaimed);

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
                  child: Text('Back to MA History Table')),
              PSWDItemView(context, 'completed', model),
              verticalSpace35,
            ],
          ),
        ),
      ),
    );
  }

  Future<void> goBack() {
    print('clicked');
    return navigationController.navigatorKey.currentState!
        .pushNamedAndRemoveUntil(
            '/MAHistoryListScreen', (Route<dynamic> route) => true);
  }
}
