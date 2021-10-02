import 'package:davnor_medicare/core/services/logger_service.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  final log = getLogger('Image Picker Service');

  Future<void> pickImage(RxString image) async {
    log.i('pickImage called');
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      image.value = pickedImage.path;
    }
  }

  Future<void> pickMultiImage(RxList<XFile> images) async {
    log.i('pickMultiImage called');
    final pickedFileList = await ImagePicker().pickMultiImage();
    if (pickedFileList != null) {
      images.value = pickedFileList;
    }
  }

  Future<void> pickFromCamera(RxString image) async {
    log.i('pickImageCamera called');
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      image.value = pickedImage.path;
    }
  }
}
