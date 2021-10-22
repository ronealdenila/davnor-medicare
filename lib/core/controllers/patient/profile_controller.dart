import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/core/models/verification_req_model.dart';
import 'package:davnor_medicare/core/services/logger_service.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final log = getLogger('Profile Controller');

  @override
  void onReady() {
    super.onReady();
    log.i('ONREADY');
  }

  static AuthController authController = Get.find();
  final fetchedData = authController.patientModel.value;

  bool hasValidIDandValidSelfie() {
    if (fetchedData!.validID == '' && fetchedData!.validSelfie == '') {
      return false;
    }
    return true;
  }
}
