import 'package:davnor_medicare/core/controllers/app_controller.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/core/controllers/cons_controller.dart';
import 'package:davnor_medicare/core/controllers/ma_controller.dart';
import 'package:davnor_medicare/core/services/article_service.dart';
import 'package:get/get.dart';

class AllControllerBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<AuthController>(AuthController(), permanent: true);
    Get.put<ArticleService>(ArticleService());
    Get.lazyPut<AppController>(() => AppController());
    Get.lazyPut<ConsController>(() => ConsController());
    Get.lazyPut<MAController>(() => MAController());
  }
}
