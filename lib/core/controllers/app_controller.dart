import 'package:davnor_medicare/core/services/logger.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:image_picker/image_picker.dart';

enum CategoryType { followUp, newConsult }

class AppController extends GetxController {
  static AppController to = Get.find();
  final log = getLogger('App Controller');

  RxBool isObscureText = true.obs;
  RxBool isCheckboxChecked = false.obs;

  RxBool isConsultForYou = true.obs;

  RxBool isMedicalAssistForYou = true.obs;

  RxBool isFollowUp = true.obs;

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

  Future<void> pickMultipleImages(
      RxList<Asset> images, List<Asset> resultList) async {
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: images,
        materialOptions: const MaterialOptions(
          actionBarTitle: 'Select Images',
        ),
      );
    } on Exception catch (e) {
      log.i('pickImages | $e');
    }
    images.value = resultList;
  }

  // ignore: type_annotate_public_apis
  Future<void> pickSingleImage(var image) async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      image.value = pickedImage.path;
    }
  }
}
