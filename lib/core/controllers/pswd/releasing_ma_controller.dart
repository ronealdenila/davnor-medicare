import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/navigation_controller.dart';
import 'package:davnor_medicare/core/models/general_ma_req_model.dart';
import 'package:davnor_medicare/core/models/med_assistance_model.dart';
import 'package:davnor_medicare/core/services/logger_service.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ReleasingMAController extends GetxController {
  final log = getLogger('Releasing MA Controller');
  final NavigationController navigationController = Get.find();
  RxList<OnProgressMAModel> toRelease = RxList<OnProgressMAModel>([]);
  final RxList<OnProgressMAModel> filteredList = RxList<OnProgressMAModel>();
  final TextEditingController rlsFilter = TextEditingController();
  RxBool isLoading = true.obs;

  @override
  void onReady() {
    super.onReady();
    toRelease.bindStream(getToReleaseList());
  }

  Stream<List<OnProgressMAModel>> getToReleaseList() {
    log.i('To Release MA Controller | get Collection');
    return firestore
        .collection('on_progress_ma')
        .orderBy('dateRqstd')
        .where('isMedReady', isEqualTo: true)
        .snapshots()
        .map((query) {
      return query.docs.map((item) {
        isLoading.value = false;
        return OnProgressMAModel.fromJson(item.data());
      }).toList();
    });
  }

  String convertTimeStamp(Timestamp recordTime) {
    final dt = recordTime.toDate();
    return DateFormat.yMMMd().add_jm().format(dt);
  }

  void refresh() {
    filteredList.clear();
    filteredList.assignAll(toRelease);
  }

  void filter({required String name}) {
    filteredList.clear();

    //filter for name only
    if (name != '') {
      print('NAME');
      for (var i = 0; i < toRelease.length; i++) {
        if (toRelease[i].fullName!.toLowerCase().contains(name.toLowerCase())) {
          filteredList.add(toRelease[i]);
        }
      }
    } else {
      filteredList.assignAll(toRelease);
    }
  }

  Future<void> transfferToHistory(GeneralMARequestModel model) async {
    showLoading();
    await firestore
        .collection('ma_history')
        .doc(model.maID)
        .set(<String, dynamic>{
      'maID': model.maID,
      'requesterID': model.requesterID,
      'receiverID': model.receiverID,
      'fullName': model.fullName,
      'age': model.age,
      'address': model.address,
      'gender': model.gender,
      'type': model.type,
      'prescriptions': model.prescriptions,
      'dateRqstd': model.dateRqstd,
      'validID': model.validID,
      'receivedBy': model.receivedBy,
      'medWorth': model.medWorth,
      'pharmacy': model.pharmacy,
      'dateClaimed': FieldValue.serverTimestamp(), //Timestamp.fromDate(DateTime.now()),
    }).then((value) async {
      //TO DO / THINK - mag NOTIF paba kay USER pag claimed na niya
      await deleteMA(model.maID!);
      dismissDialog(); //dismissLoading
      dismissDialog(); //then dismiss dialog for are your sure? yes/no
      goBack();
    }).catchError((onError) {
      dismissDialog(); //dismissLoading
      dismissDialog(); //then dismiss dialog for are your sure? yes/no
      //TO DO: Error Dialog ----> something went wrong
    });
  }

  Future<void> deleteMA(String maID) async {
    await firestore
        .collection('on_progress_ma')
        .doc(maID)
        .delete()
        .then((value) => print("MA Request Deleted"))
        .catchError((error) => print("Failed to delete MA Request"));
  }

  void goBack() {
    return navigationController.navigatorKey.currentState!.pop();
  }

  Future<void> transfferToHistoryFromList(OnProgressMAModel model) async {
    showLoading();
    await firestore
        .collection('ma_history')
        .doc(model.maID)
        .set(<String, dynamic>{
      'maID': model.maID,
      'patientId': model.requesterID,
      'fullName': model.fullName,
      'age': model.age,
      'address': model.address,
      'gender': model.gender,
      'type': model.type,
      'prescriptions': model.prescriptions,
      'dateRqstd': model.dateRqstd,
      'validID': model.validID,
      'receivedBy': model.receivedBy,
      'receiverID': model.receiverID,
      'medWorth': model.medWorth,
      'pharmacy': model.pharmacy,
      'dateClaimed': FieldValue.serverTimestamp(), //Timestamp.fromDate(DateTime.now()),
    }).then((value) async {
      //TO DO / THINK - mag NOTIF paba kay USER pag claimed na niya
      await deleteMA(model.maID!);
      dismissDialog(); //dismissLoading
      dismissDialog(); //then dismiss dialog for are your sure? yes/no
      goBack();
    }).catchError((onError) {
      dismissDialog(); //dismissLoading
      dismissDialog(); //then dismiss dialog for are your sure? yes/no
      //TO DO: Error Dialog ----> something went wrong
    });
  }
}
