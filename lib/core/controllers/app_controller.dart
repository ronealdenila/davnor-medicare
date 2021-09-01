import 'package:davnor_medicare/core/services/logger.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart';

class AppController extends GetxController {
  static AppController to = Get.find();
  final log = getLogger('App Controller');

  RxBool isObscureText = true.obs;
  RxBool isCheckboxChecked = false.obs;

  RxBool isMedicalAssistForYou = true.obs;

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

  Future<void> pickSingleImage(RxString image) async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      image.value = pickedImage.path;
    }
  }

  Future<void> pickImages(RxList<XFile> images) async {
    final pickedFileList = await ImagePicker().pickMultiImage();

    if (pickedFileList != null) {
      images.value = pickedFileList;
    }
  }
}
