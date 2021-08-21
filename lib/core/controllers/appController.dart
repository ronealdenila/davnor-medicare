import 'package:get/get.dart';

class AppController extends GetxController {
  static AppController to = Get.find();

  //This is where to put the app logics e.g. toggle check box

  RxBool isObscureText = true.obs;
  RxBool isCheckboxChecked = false.obs;

  toggleTextVisibility() {
    isObscureText.value = !isObscureText.value;
  }

  toggleCheckBox(bool? newvalue) {
    isCheckboxChecked.value = newvalue!;
  }
}
