import 'package:davnor_medicare/core/services/logger_service.dart';
import 'package:get/get.dart';

class AppController {
  final log = getLogger('App Controller');

  bool toggleTextVisibility(RxBool isObscureText) {
    log.i('toggleTextVisibility | Toggle Text Visibility');
    log.i(isObscureText);
    return isObscureText.value = !isObscureText.value;
  }
}
