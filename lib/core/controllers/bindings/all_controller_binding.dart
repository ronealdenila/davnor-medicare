import 'package:davnor_medicare/core/controllers/admin/menu_controller.dart';
import 'package:davnor_medicare/core/controllers/app_controller.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/core/controllers/patient/cons_req_controller.dart';
import 'package:davnor_medicare/core/controllers/doctor/consultations_controller.dart';
import 'package:davnor_medicare/core/controllers/admin/for_verification_controller.dart';
import 'package:davnor_medicare/core/controllers/patient/ma_req_controller.dart';
import 'package:davnor_medicare/core/controllers/patient/verification_req_controller.dart';
import 'package:davnor_medicare/core/controllers/article_controller.dart';
import 'package:davnor_medicare/core/controllers/patient/ma_queue_controller.dart';
import 'package:davnor_medicare/core/controllers/pswd/on_progress_req_controller.dart';
import 'package:davnor_medicare/core/controllers/pswd/menu_controller.dart';
import 'package:davnor_medicare/core/controllers/pswd/navigation_controller.dart';
import 'package:get/get.dart';

class AllControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController(), permanent: true);
    Get.lazyPut<ArticleController>(() => ArticleController());
    Get.lazyPut<AppController>(() => AppController());

    //patient
    Get.lazyPut<ConsRequestController>(() => ConsRequestController());
    Get.lazyPut<MARequestController>(() => MARequestController());
    Get.lazyPut<MAQueueController>(() => MAQueueController());
    Get.lazyPut<VerificationController>(() => VerificationController());

    //doctor
    Get.lazyPut<ConsultationsController>(() => ConsultationsController());

    //admin
    Get.lazyPut<ForVerificationController>(() => ForVerificationController());
    Get.lazyPut<AdminMenuController>(() => AdminMenuController());

    //pswd
    Get.lazyPut<OnProgressReqController>(() => OnProgressReqController());
    Get.lazyPut<MenuController>(() => MenuController());
    Get.lazyPut<NavigationController>(() => NavigationController());
  }
}

    //?Note: Lazyput para dili siya ma initialize during runtime
    //?then pag call sa Get.put() kung asa na screen 
    //?dihaa lang siya mag inititate (R)