import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/core/models/status_model.dart';
import 'package:davnor_medicare/core/services/logger_service.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:get/get.dart';

class CallingPatientController extends GetxController {
  final log = getLogger('Status Controller');
  final AuthController authController = Get.find();
  RxList<IncomingCallModel> incCall = RxList<IncomingCallModel>([]);
  RxBool isAlertboxOpened = false.obs;
  RxBool isLoading = true.obs;
  RxString patientId = ''.obs;
  RxString channelId = ''.obs;
  RxBool atCallSession = false.obs;

  void showRejectedCallDialog() {
    showDefaultDialog(
      dialogTitle: 'The patient rejected your call',
      dialogCaption: 'Please try again.',
      onConfirmTap: () {
        dismissDialog();
      },
    );
  }

  void bindToList(String patientId) {
    incCall.bindStream(getCallStatus(patientId));
  }

  Stream<List<IncomingCallModel>> getCallStatus(String patientId) {
    log.i('GETTING PATIENT InCOMING cALL STATS');
    return firestore
        .collection('patients')
        .doc(patientId)
        .collection('incomingCall')
        .snapshots()
        .map((query) {
      return query.docs.map((item) {
        isLoading.value = false;
        return IncomingCallModel.fromJson(item.data());
      }).toList();
    });
  }
}
