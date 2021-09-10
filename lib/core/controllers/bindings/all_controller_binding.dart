import 'package:davnor_medicare/core/controllers/app_controller.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/core/controllers/patient/cons_req_controller.dart';
import 'package:davnor_medicare/core/controllers/doctor/doctor_home_controller.dart';
import 'package:davnor_medicare/core/controllers/admin/for_verification_controller.dart';
import 'package:davnor_medicare/core/controllers/patient/ma_req_controller.dart';
import 'package:davnor_medicare/core/controllers/patient/verification_req_controller.dart';
import 'package:davnor_medicare/core/controllers/article_controller.dart';
import 'package:davnor_medicare/core/controllers/pswd/attached_photos_controller.dart';
import 'package:davnor_medicare/core/controllers/patient/ma_queue_controller.dart';
import 'package:get/get.dart';

class AllControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController(), permanent: true);
    Get.lazyPut<ArticleController>(() => ArticleController());
    Get.lazyPut<DoctorHomeController>(() => DoctorHomeController());
    Get.lazyPut<ConsController>(() => ConsController());
    Get.lazyPut<AppController>(() => AppController());
    Get.lazyPut<MAController>(() => MAController());
    Get.lazyPut<MAQueueController>(() => MAQueueController());
    Get.lazyPut<VerificationController>(() => VerificationController());
    Get.lazyPut<PSWDController>(() => PSWDController());
    Get.lazyPut<MenuController>(() => MenuController());
    Get.lazyPut<NavigationController>(() => NavigationController());
    Get.lazyPut<VerificationRequestController>(
        () => VerificationRequestController());
  }
}

    //?Note: Lazyput para dili siya ma initialize during runtime
    //?then pag call sa Get.put() kung asa na screen 
    //?dihaa lang siya mag inititate (R)