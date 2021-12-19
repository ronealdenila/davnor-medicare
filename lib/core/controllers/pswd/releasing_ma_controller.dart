import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/ma_history_controller.dart';
import 'package:davnor_medicare/core/controllers/navigation_controller.dart';
import 'package:davnor_medicare/core/controllers/pswd/menu_controller.dart';
import 'package:davnor_medicare/core/models/general_ma_req_model.dart';
import 'package:davnor_medicare/core/models/med_assistance_model.dart';
import 'package:davnor_medicare/core/services/logger_service.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:davnor_medicare/routes/app_pages.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ReleasingMAController extends GetxController {
  final log = getLogger('Releasing MA Controller');
  final NavigationController navigationController = Get.find();
  final RxList<OnProgressMAModel> toRelease = RxList<OnProgressMAModel>([]);
  final RxList<OnProgressMAModel> filteredList = RxList<OnProgressMAModel>();
  final TextEditingController rlsFilter = TextEditingController();
  final RxBool isLoading = true.obs;
  final MAHistoryController maHController = Get.find();
  final MenuController menuController = Get.find();

  @override
  void onReady() {
    super.onReady();
    toRelease.bindStream(getToReleaseList());
  }

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 5), () {
      isLoading.value = false;
    });
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
      'dateClaimed': FieldValue.serverTimestamp(),
    }).then((value) async {
      await deleteMA(model.maID!);
      dismissDialog(); //dismissLoading
      dismissDialog(); //then dismiss dialog for are your sure? yes/no
      maHController.refreshPSWD();
      menuController.changeActiveItemTo('Medical Assistance History');
      navigationController.navigateTo(Routes.MA_HISTORY_LIST);
    }).catchError((onError) {
      dismissDialog(); //dismissLoading
      dismissDialog(); //then dismiss dialog for are your sure? yes/no
      showErrorDialog(
          errorTitle: 'Something went wrong',
          errorDescription: 'Unable to update request. Please try again later');
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
      'requesterID': model.requesterID,
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
      'dateClaimed': FieldValue.serverTimestamp(),
    }).then((value) async {
      await deleteMA(model.maID!);
      dismissDialog(); //dismissLoading
      dismissDialog(); //then dismiss dialog for are your sure? yes/no
      maHController.refreshPSWD();
      menuController.changeActiveItemTo('Medical Assistance History');
      navigationController.navigateTo(Routes.MA_HISTORY_LIST);
    }).catchError((onError) {
      dismissDialog(); //dismissLoading
      dismissDialog(); //then dismiss dialog for are your sure? yes/no
      showErrorDialog(
          errorTitle: 'Something went wrong',
          errorDescription: 'Unable to update request. Please try again later');
    });
  }
}
