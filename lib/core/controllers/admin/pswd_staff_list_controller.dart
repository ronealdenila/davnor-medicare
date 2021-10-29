import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/models/user_model.dart';
import 'package:davnor_medicare/core/services/logger_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PSWDStaffListController extends GetxController {
  final log = getLogger('PSWD Staff List Controller');

  final RxList<PswdModel> pswdList = RxList<PswdModel>();
  final RxList<PswdModel> filteredPswdList = RxList<PswdModel>();
  final TextEditingController pswdFilter = TextEditingController();
  final RxBool isLoading = true.obs;
  final RxString position = ''.obs;

  @override
  void onReady() {
    super.onReady();
    log.i('onReady | DoctorListController');
    getPSWDStaffs().then((value) {
      pswdList.value = value;
      filteredPswdList.assignAll(pswdList);
      isLoading.value = false;
    });
  }

  Future<List<PswdModel>> getPSWDStaffs() async {
    return firestore
        .collection('pswd_personnel')
        .where('disabled', isEqualTo: false)
        .get()
        .then(
          (query) => query.docs
              .map((item) => PswdModel.fromJson(item.data()))
              .toList(),
        );
  }

  Future<void> disablePSWDStaff(String uid) async {
    await firestore
        .collection('pswd_personnel')
        .doc(uid)
        .update({'disabled': true})
        .then((value) => {
              //Dialog success
            })
        .catchError((error) => {
              //Dialog error
            });
  }

  filter({required String name, required String title}) {
    pswdList.clear();
    for (var i = 0; i < pswdList.length; i++) {
      if (filteredPswdList[i]
              .lastName!
              .toLowerCase()
              .contains(name.toLowerCase()) ||
          filteredPswdList[i]
              .firstName!
              .toLowerCase()
              .contains(name.toLowerCase())) {
        pswdList.add(filteredPswdList[i]);
      }
    }
    for (var i = 0; i < filteredPswdList.length; i++) {
      if (filteredPswdList[i]
          .position!
          .toLowerCase()
          .contains(title.toLowerCase())) {
        pswdList.add(filteredPswdList[i]);
      }
    }

    for (var i = 0; i < pswdList.length; i++) {
      print(pswdList[i].firstName);
    }

    final stores = pswdList.map((e) => e.email).toSet();
    pswdList.retainWhere((x) => stores.remove(x.email));
  }
}
