import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/core/models/status_model.dart';
import 'package:davnor_medicare/core/services/logger_service.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:davnor_medicare/ui/screens/call_session.dart';
import 'package:davnor_medicare/ui/screens/patient/incoming_call.dart';
import 'package:get/get.dart';

class CallingPatientController extends GetxController {
  final log = getLogger('Status Controller');

  RxList<IncomingCallModel> incCall = RxList<IncomingCallModel>([]);
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    ever(incCall, (value) {
      if (incCall[0].didReject!) {
        showDialog();
      } else if (incCall[0].patientJoined!) {
        Get.to(() => CallSessionScreen());
      }
    });
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

  Future<void> showDialog() async {
    showDefaultDialog(
      dialogTitle: 'The patient rejected your call',
      dialogCaption: 'Please try again.',
      onConfirmTap: () {
        dismissDialog();
        Get.back();
      },
    );
  }
}
