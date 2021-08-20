import 'package:get/get.dart';

class AppController extends GetxController {
  static AppController instance = Get.find();

  //This is where to put the app logics e.g. toggle check box

  // Example snippet
  RxBool isLoginWidgetDisplayed = true.obs;

  changeDisplayedAuthWidget() {
    isLoginWidgetDisplayed.value = !isLoginWidgetDisplayed.value;
  }
}
