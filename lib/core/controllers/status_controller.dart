import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/core/models/cons_stats_model.dart';
import 'package:davnor_medicare/core/models/status_model.dart';
import 'package:davnor_medicare/core/services/logger_service.dart';
import 'package:davnor_medicare/ui/screens/incoming_call.dart';
import 'package:davnor_medicare/ui/screens/patient/home.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class StatusController extends GetxController {
  final log = getLogger('Status Controller');
  final AuthController authController = Get.find();
  final RxList<PatientStatusModel> patientStatus =
      RxList<PatientStatusModel>([]);
  final RxList<DoctorStatusModel> doctorStatus = RxList<DoctorStatusModel>([]);
  final RxList<PSWDStatusModel> pswdPStatus = RxList<PSWDStatusModel>([]);
  final RxList<IncomingCallModel> incCall = RxList<IncomingCallModel>([]);
  final RxList<ConsStatusModel> statusList = RxList<ConsStatusModel>(); //doc
  final RxBool isLoadingP = true.obs;
  final RxBool isLoadingD = true.obs;
  final RxBool isCallStatsLoading = true.obs;
  final RxBool isPSLoading = true.obs;
  final RxBool atCallSession = false.obs;

  @override
  void onReady() {
    super.onReady();
    log.i('On Ready Status Controller');
    if (authController.userRole == 'patient') {
      if (!kIsWeb) {
        setDeviceToken();
      }
      patientStatus.bindStream(getPStatus());
      pswdPStatus.bindStream(getMAStatus());
      incCall.bindStream(getCallStatus());
    } else if (authController.userRole == 'doctor') {
      doctorStatus.bindStream(getDStatus());
      statusList.bindStream(getStatus());
    } else if (authController.userRole == 'pswd-p' ||
        authController.userRole == 'pswd-h') {
      pswdPStatus.bindStream(getMAStatus());
    }
  }

  @override
  void onInit() {
    super.onInit();
    ever(incCall, (value) {
      if (authController.userRole == 'patient') {
        if (!isCallStatsLoading.value) {
          if (incCall[0].isCalling! && !incCall[0].patientJoined!) {
            atCallSession.value = true;
            Get.to(() => CallSession());
          } else if (!incCall[0].isCalling! && atCallSession.value) {
            atCallSession.value = false;
            if (!kIsWeb) {
              Get.offAll(() => PatientHomeScreen());
            } else {
              Get.back();
            }
          }
        }
      }
    });
  }

  Future<void> setDeviceToken() async {
    await firestore
        .collection('patients')
        .doc(auth.currentUser!.uid)
        .collection('status')
        .doc('value')
        .update({'deviceToken': await getDeviceToken()});
  }

  Future<String> getDeviceToken() async {
    return (await messaging.getToken())!;
  }

  Stream<List<PatientStatusModel>> getPStatus() {
    log.i('GETTING PATIENT STATS');
    return firestore
        .collection('patients')
        .doc(auth.currentUser!.uid)
        .collection('status')
        .snapshots()
        .map((query) {
      return query.docs.map((item) {
        isLoadingP.value = false;
        return PatientStatusModel.fromJson(item.data());
      }).toList();
    });
  }

  Stream<List<IncomingCallModel>> getCallStatus() {
    log.i('GETTING PATIENT InCOMING cALL STATS');
    return firestore
        .collection('patients')
        .doc(auth.currentUser!.uid)
        .collection('incomingCall')
        .snapshots()
        .map((query) {
      return query.docs.map((item) {
        isCallStatsLoading.value = false;
        return IncomingCallModel.fromJson(item.data());
      }).toList();
    });
  }

  Stream<List<DoctorStatusModel>> getDStatus() {
    log.i('GETTING DOC STATS');
    return firestore
        .collection('doctors')
        .doc(auth.currentUser!.uid)
        .collection('status')
        .snapshots()
        .map((query) {
      return query.docs.map((item) {
        isLoadingD.value = false;
        print('done loading');
        return DoctorStatusModel.fromJson(item.data());
      }).toList();
    });
  }

  Stream<List<ConsStatusModel>> getStatus() {
    log.i('GETTING CONS SLOT STATS FOR DOCTOR');
    return firestore
        .collection('cons_status')
        .where('categoryID',
            isEqualTo: authController.doctorModel.value!.categoryID)
        .snapshots()
        .map(
          (query) => query.docs
              .map((item) => ConsStatusModel.fromJson(item.data()))
              .toList(),
        );
  }

  Stream<List<PSWDStatusModel>> getMAStatus() {
    log.i('GETTING PSWD MA STATS');
    return firestore.collection('pswd_status').snapshots().map((query) {
      return query.docs.map((item) {
        isPSLoading.value = false;
        print('nagfalse');
        return PSWDStatusModel.fromJson(item.data());
      }).toList();
    });
  }
}
