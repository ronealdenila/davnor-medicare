import 'package:get/get.dart';

class AppController extends GetxController {
  static AppController to = Get.find();

  //This is where to put the app logics e.g. toggle check box

  // Example snippet
  RxBool isLoginWidgetDisplayed = true.obs;
  RxBool isObscureText = true.obs;
  RxBool isCheckboxChecked = false.obs;

  toggleTextVisibility() {
    isObscureText.value = !isObscureText.value;
  }
  

  changeDisplayedAuthWidget() {
    isLoginWidgetDisplayed.value = !isLoginWidgetDisplayed.value;
  }
}
