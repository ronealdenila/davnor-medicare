import 'package:davnor_medicare/constants/app_strings.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/core/controllers/attached_photos_controller.dart';
import 'package:davnor_medicare/core/controllers/pswd/releasing_ma_controller.dart';
import 'package:davnor_medicare/core/models/general_ma_req_model.dart';
import 'package:davnor_medicare/core/models/med_assistance_model.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:davnor_medicare/ui/widgets/pswd/ma_item_view.dart';
import 'package:davnor_medicare/ui/widgets/pswd/pswd_custom_button.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReleasingAreaItemScreen extends StatelessWidget {
  ReleasingAreaItemScreen({Key? key, required this.passedData})
      : super(key: key);
  final OnProgressMAModel passedData;
  final ReleasingMAController rlsController = Get.find();
  final AuthController authController = Get.find();
  final AttachedPhotosController pcontroller = Get.find();
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
      dateRqstd: passedData.dateRqstd,
      receivedBy: passedData.receivedBy,
      pharmacy: passedData.pharmacy,
      medWorth: passedData.medWorth,
    );

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpace50,
          IconButton(
              onPressed: () {
                rlsController.goBack();
              },
              icon: Icon(
                Icons.arrow_back_outlined,
                size: 30,
              )),
          PSWDItemView(context, 'medReady', model),
          authController.userRole == 'pswd-h'
              ? SizedBox(
                  width: 0,
                  height: 0,
                )
              : Align(
                  alignment: Alignment.bottomRight,
                  child: PSWDButton(
                    onItemTap: () {
                      showConfirmationDialog(
                        dialogTitle: dialogpswdTitle,
                        dialogCaption: dialogpswdCaption,
                        onYesTap: () async {
                          await rlsController.transfferToHistory(model);
                        },
                        onNoTap: () {
                          dismissDialog();
                        },
                      );
                    },
                    buttonText: 'Claimed',
                  ),
                ),
          verticalSpace35,
        ],
      ),
    );
  }
}
