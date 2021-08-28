import 'package:davnor_medicare/core/services/logger.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

enum CategoryType { followUp, newConsult }

class AppController extends GetxController {
  static AppController to = Get.find();
  final log = getLogger('App Controller');

  //This is where to put the app logics e.g. toggle check box

  RxBool isObscureText = true.obs;
  RxBool isCheckboxChecked = false.obs;

  RxBool isConsultForYou = true.obs;

  CategoryType? categoryType = CategoryType.followUp;

  bool toggleTextVisibility() {
    log.i('toggleTextVisibility | Toggle Text Visibility');
    return isObscureText.value = !isObscureText.value;
  }

  Future<void> launchURL(String url) async {
    log.i('launchURL | Launched at URL: $url');
    await canLaunch(url)
        ? await launch(url)
        : Get.defaultDialog(title: 'Could not launch $url');
  }
}
