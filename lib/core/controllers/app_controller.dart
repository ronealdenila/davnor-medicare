import 'package:davnor_medicare/core/services/logger_service.dart.dart';
import 'package:get/get.dart';

class AppController {
  final log = getLogger('App Controller');

  bool toggleTextVisibility(RxBool isObscureText) {
    log.i('toggleTextVisibility | Toggle Text Visibility');
    return isObscureText.value = !isObscureText.value;
  }
}
