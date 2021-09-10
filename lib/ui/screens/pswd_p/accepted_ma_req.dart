import 'package:davnor_medicare/ui/screens/pswd_p/controller/attached_photos_controller.dart';
import 'package:davnor_medicare/ui/widgets/pswd/ma_item_view.dart';
import 'package:flutter/material.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:get/get.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:davnor_medicare/ui/widgets/custom_button.dart';

class AcceptedMARequestScreen extends StatelessWidget {
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
              PSWDItemView(context, 'accepted'),
              Align(
                alignment: Alignment.bottomRight,
                child: CustomButton(
                  onTap: () async {},
                  text: 'Transfer for Head Approval',
                  buttonColor: verySoftOrange[60],
                  fontSize: 15,
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
