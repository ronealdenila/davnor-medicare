import 'package:davnor_medicare/core/controllers/pswd/attached_photos_controller.dart';
import 'package:davnor_medicare/ui/widgets/pswd/ma_item_view.dart';
import 'package:flutter/material.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:get/get.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:davnor_medicare/ui/widgets/custom_button.dart';

class ForApprovalItemScreen extends StatelessWidget {
  final AttachedPhotosController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              PSWDItemView(context, 'transferred'),
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
      text: 'Approve',
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
