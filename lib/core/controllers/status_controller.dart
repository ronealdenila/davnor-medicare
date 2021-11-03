import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/core/models/patient_doc_status_model.dart';
import 'package:davnor_medicare/core/services/logger_service.dart';
import 'package:get/get.dart';

class StatusController extends GetxController {
  final log = getLogger('Status Controller');

  static AuthController authController = Get.find();
  RxList<PatientStatusModel> patientStatus = RxList<PatientStatusModel>([]);
  RxList<DoctorStatusModel> doctorStatus = RxList<DoctorStatusModel>([]);
  RxList<PSWDStatusModel> pswdPStatus = RxList<PSWDStatusModel>([]);
  // RxList<PatientStatusModel> pswdHStatus = RxList<PatientStatusModel>([]);
  // RxList<PatientStatusModel> maStatus = RxList<PatientStatusModel>([]);
  RxBool isLoading = true.obs;
  RxBool isPSLoading = true.obs;

  @override
  void onReady() {
    super.onReady();
    if (authController.userRole == 'patient') {
      patientStatus.bindStream(getPStatus());
      pswdPStatus.bindStream(getPSWDPStatus());
    } else if (authController.userRole == 'doctor') {
      doctorStatus.bindStream(getDStatus());
    } else if (authController.userRole == 'pswd-p' ||
        authController.userRole == 'pswd-h') {
      pswdPStatus.bindStream(getPSWDPStatus());
    }
  }

  Stream<List<PatientStatusModel>> getPStatus() {
    return firestore
        .collection('patients')
        .doc(auth.currentUser!.uid)
        .collection('status')
        .snapshots()
        .map((query) {
      return query.docs.map((item) {
        isLoading.value = false;
        return PatientStatusModel.fromJson(item.data());
      }).toList();
    });
  }

  Stream<List<DoctorStatusModel>> getDStatus() {
    log.i('GETTING DOC STATS');
    return firestore
        .collection('doctors')
        .doc('OY4Xkw6mmjUo7TwYX4X1Xlw4nUp2')
        .collection('status')
        .snapshots()
        .map((query) {
      return query.docs.map((item) {
        isLoading.value = false;
        return DoctorStatusModel.fromJson(item.data());
      }).toList();
    });
  }

  Stream<List<PSWDStatusModel>> getPSWDPStatus() {
    log.i('MA Queue Controller | Get PSWD Status');
    return firestore.collection('pswd_status').snapshots().map((query) {
      return query.docs.map((item) {
        isPSLoading.value = false;
        return PSWDStatusModel.fromJson(item.data());
      }).toList();
    });
  }
}
