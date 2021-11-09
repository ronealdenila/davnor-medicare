import 'package:davnor_medicare/core/controllers/pswd/navigation_controller.dart';
import 'package:davnor_medicare/core/models/user_model.dart';
import 'package:davnor_medicare/core/models/verification_req_model.dart';
import 'package:davnor_medicare/routes/app_pages.dart';
import 'package:davnor_medicare/ui/screens/admin/admin_profile.dart';
import 'package:davnor_medicare/ui/screens/admin/disabled_doctors.dart';
import 'package:davnor_medicare/ui/screens/admin/disabled_pswd.dart';
import 'package:davnor_medicare/ui/screens/admin/doctor_list.dart';
import 'package:davnor_medicare/ui/screens/admin/doctor_registration.dart';
import 'package:davnor_medicare/ui/screens/admin/edit_doctor.dart';
import 'package:davnor_medicare/ui/screens/admin/edit_pswd_staff.dart';
import 'package:davnor_medicare/ui/screens/admin/home.dart';
import 'package:davnor_medicare/ui/screens/admin/pswd_staff_list.dart';
import 'package:davnor_medicare/ui/screens/admin/pswd_staff_registration.dart';
import 'package:davnor_medicare/ui/screens/admin/verification_req_item.dart';
import 'package:davnor_medicare/ui/screens/admin/verification_req_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

NavigationController navigationController = Get.find();

Navigator localNavigator() => Navigator(
      key: navigationController.navigatorKey,
      onGenerateRoute: generateRoute,
      initialRoute: '/dashboard',
    );

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.DASHBOARD:
      return _getPageRoute(AdminDashboardScreen());
    case Routes.DOCTOR_LIST:
      return _getPageRoute(DoctorListScreen());
    case Routes.PSWD_STAFF_LIST:
      return _getPageRoute(PSWDStaffListScreen());
    case Routes.ADMIN_PROFILE:
      return _getPageRoute(AdminProfileScreen());
    case Routes.VERIFICATION_REQ_LIST:
      return _getPageRoute(VerificationReqListScreen());
    case Routes.DOCTOR_REGISTRATION:
      return _getPageRoute(DoctorRegistrationScreen());
    case Routes.PSWD_STAFF_REGISTRATION:
      return _getPageRoute(PSWDStaffRegistrationScreen());
    case Routes.EDIT_DOCTOR:
      final DoctorModel passedData = settings.arguments as DoctorModel;
      return _getPageRoute(EditDoctorScrenn(passedData: passedData));
    case Routes.EDIT_PSWD_STAFF:
      final PswdModel passedData = settings.arguments as PswdModel;
      return _getPageRoute(EditPSWDStaffScrenn(passedData: passedData));
    case Routes.VERIFICATION_REQ_ITEM:
      final VerificationReqModel passedData =
          settings.arguments as VerificationReqModel;
      return _getPageRoute(VerificationReqItemScreen(passedData: passedData));
    case Routes.DISABLED_DOCTORS:
      return _getPageRoute(DisabledDoctorListScreen());
    case Routes.DISABLED_PSWD_STAFF:
      return _getPageRoute(DisabledPSWDStaffScreen());
    default:
      return _getPageRoute(const SizedBox());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}
