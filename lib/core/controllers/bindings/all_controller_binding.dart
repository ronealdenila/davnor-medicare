import 'package:davnor_medicare/core/controllers/admin/doctor_registration_controller.dart';
import 'package:davnor_medicare/core/controllers/admin/for_verification_controller.dart';
import 'package:davnor_medicare/core/controllers/admin/menu_controller.dart';
import 'package:davnor_medicare/core/controllers/admin/pswd_registration_controller.dart';
import 'package:davnor_medicare/core/controllers/app_controller.dart';
import 'package:davnor_medicare/core/controllers/article_controller.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/core/controllers/doctor/consultations_controller.dart';
import 'package:davnor_medicare/core/controllers/doctor/menu_controller.dart';
import 'package:davnor_medicare/core/controllers/live_chat_controller.dart';
import 'package:davnor_medicare/core/controllers/live_cons_controller.dart';
import 'package:davnor_medicare/core/controllers/ma_history_controller.dart';
import 'package:davnor_medicare/core/controllers/patient/cons_req_controller.dart';
import 'package:davnor_medicare/core/controllers/patient/ma_queue_controller.dart';
import 'package:davnor_medicare/core/controllers/patient/ma_req_controller.dart';
import 'package:davnor_medicare/core/controllers/patient/profile_controller.dart';
import 'package:davnor_medicare/core/controllers/patient/verification_req_controller.dart';
import 'package:davnor_medicare/core/controllers/pswd/attached_photos_controller.dart';
import 'package:davnor_medicare/core/controllers/pswd/for_approval_controller.dart';
import 'package:davnor_medicare/core/controllers/pswd/menu_controller.dart';
import 'package:davnor_medicare/core/controllers/navigation_controller.dart';
import 'package:davnor_medicare/core/controllers/pswd/on_progress_req_controller.dart';
import 'package:davnor_medicare/core/controllers/pswd/releasing_ma_controller.dart';
import 'package:davnor_medicare/core/controllers/status_controller.dart';
import 'package:get/get.dart';

class AllControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController(), permanent: true);
    Get.put<ArticleController>(ArticleController(), permanent: true);
    Get.lazyPut<AppController>(() => AppController());
    Get.lazyPut<StatusController>(() => StatusController());
    Get.lazyPut<AttachedPhotosController>(() => AttachedPhotosController());

    //patient
    Get.lazyPut<ConsRequestController>(() => ConsRequestController());
    Get.lazyPut<MARequestController>(() => MARequestController());
    Get.lazyPut<MAQueueController>(() => MAQueueController());
    Get.lazyPut<VerificationController>(() => VerificationController());
    Get.lazyPut<MAHistoryController>(() => MAHistoryController());
    Get.lazyPut<ProfileController>(() => ProfileController());

    //doctor
    Get.lazyPut<ConsultationsController>(() => ConsultationsController());
    Get.lazyPut<LiveChatController>(() => LiveChatController());
    Get.lazyPut<LiveConsController>(() => LiveConsController());
    Get.lazyPut<DoctorMenuController>(() => DoctorMenuController());

    //admin
    Get.lazyPut<ForVerificationController>(() => ForVerificationController());
    Get.lazyPut<AdminMenuController>(() => AdminMenuController());
    Get.lazyPut<DoctorRegistrationController>(
        () => DoctorRegistrationController());
    Get.lazyPut<PSWDRegistrationController>(() => PSWDRegistrationController());

    //pswd
    Get.lazyPut<OnProgressReqController>(() => OnProgressReqController());
    Get.lazyPut<MenuController>(() => MenuController());
    Get.lazyPut<NavigationController>(() => NavigationController());
    Get.lazyPut<MARequestController>(() => MARequestController());
    Get.lazyPut<ForApprovalController>(() => ForApprovalController());
    Get.lazyPut<OnProgressReqController>(() => OnProgressReqController());
    Get.lazyPut<ReleasingMAController>(() => ReleasingMAController());
    Get.lazyPut<MAHistoryController>(() => MAHistoryController());
  }
}
