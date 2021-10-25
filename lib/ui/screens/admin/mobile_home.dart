import 'package:auto_size_text/auto_size_text.dart';
import 'package:davnor_medicare/constants/app_items.dart';
import 'package:davnor_medicare/constants/app_strings.dart';
import 'package:davnor_medicare/core/controllers/admin/doctor_registration_controller.dart';
import 'package:davnor_medicare/core/controllers/admin/menu_controller.dart';
import 'package:davnor_medicare/core/controllers/admin/pswd_registration_controller.dart';
import 'package:davnor_medicare/core/controllers/pswd/navigation_controller.dart';
import 'package:davnor_medicare/core/controllers/pswd/on_progress_req_controller.dart';
import 'package:davnor_medicare/helpers/validator.dart';
import 'package:davnor_medicare/routes/app_pages.dart';
import 'package:davnor_medicare/ui/screens/admin/helpers/local_navigator.dart';
import 'package:davnor_medicare/ui/screens/admin/mobile_doctor_list.dart';
import 'package:davnor_medicare/ui/screens/admin/mobile_pswd_list.dart';
import 'package:davnor_medicare/ui/screens/admin/verification_req_list.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/widgets/action_card.dart';
import 'package:davnor_medicare/ui/widgets/admin/side_menu.dart';
import 'package:davnor_medicare/ui/widgets/patient/custom_dropdown.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:flutter/cupertino.dart';

class MobileAdminHomeScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  static AuthController authController = Get.find();
  final OnProgressReqController homeController = Get.find();
  final DoctorRegistrationController doctorRegistrationController = Get.find();
  final PSWDRegistrationController pswdRegistrationController = Get.find();
  final fetchedData = authController.adminModel.value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: true,
      body: adminHomeScreen(),
    );
  }

  Widget adminHomeScreen() {
    return Scaffold(
        body: SafeArea(
      child: Column(children: [
        Container(
          padding: const EdgeInsets.all(25),
          width: Get.width,
          decoration: const BoxDecoration(
            color: kcVerySoftBlueColor,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
            ),
          ),
          child: Row(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'Hello, ${fetchedData!.firstName}',
                  style: subtitle20BoldWhite,
                ),
              ),
            ],
          ),
        ),
        ElevatedButton(
          child: const Text('Go to Doctor List'),
          onPressed: () => Get.to(() => MobileDoctorListScreen()),
        ),
        ElevatedButton(
          child: const Text('Go to PSWD List'),
          onPressed: () => Get.to(() => MobilePSWDStaffListScreen()),
        )
      ]),
    ));
  }
}
