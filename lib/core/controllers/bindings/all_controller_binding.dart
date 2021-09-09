import 'package:davnor_medicare/core/controllers/app_controller.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/core/controllers/cons_controller.dart';
import 'package:davnor_medicare/core/controllers/doctor_home_controller.dart';
import 'package:davnor_medicare/core/controllers/admin_for_verif_controller.dart';
import 'package:davnor_medicare/core/controllers/ma_controller.dart';
import 'package:davnor_medicare/core/controllers/verification_controller.dart';
import 'package:davnor_medicare/core/services/article_service.dart';
import 'package:davnor_medicare/ui/screens/pswd_p/controller/pswd_controller.dart';
import 'package:get/get.dart';

class AllControllerBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController(), permanent: true);
    Get.lazyPut<ArticleService>(() => ArticleService());
    Get.lazyPut<DoctorHomeController>(() => DoctorHomeController());
    Get.lazyPut<ConsController>(() => ConsController());
    Get.lazyPut<AppController>(() => AppController());
    Get.lazyPut<MAController>(() => MAController());
    Get.lazyPut<VerificationController>(() => VerificationController());
    Get.lazyPut<PSWDController>(() => PSWDController());
    Get.lazyPut<VerificationRequestController>(
        () => VerificationRequestController());
  }
}

    //?Note: Lazyput para dili siya ma initialize during runtime
    //?then pag call sa Get.put() kung asa na screen 
    //?dihaa lang siya mag inititate (R)