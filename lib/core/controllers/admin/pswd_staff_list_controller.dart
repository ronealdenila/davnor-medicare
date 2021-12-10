import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/admin/disabled_staff_controller.dart';
import 'package:davnor_medicare/core/controllers/navigation_controller.dart';
import 'package:davnor_medicare/core/models/user_model.dart';
import 'package:davnor_medicare/core/services/logger_service.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PSWDStaffListController extends GetxController {
  final log = getLogger('PSWD Staff List Controller');
  final DisabledStaffsController dListController =
      Get.put(DisabledStaffsController());
  final NavigationController navigationController = Get.find();

  final RxList<PswdModel> pswdList = RxList<PswdModel>();
  final RxList<PswdModel> filteredPswdList = RxList<PswdModel>();
  final TextEditingController pswdFilter = TextEditingController();
  final RxBool isLoading = true.obs;
  final RxString position = ''.obs;
  final RxBool enableEditing = false.obs;

  //Edit
  final TextEditingController editFirstName = TextEditingController();
  final TextEditingController editLastName = TextEditingController();
  final RxString editPosition = ''.obs;

  @override
  void onReady() {
    super.onReady();
    log.i('onReady | PSWDStaffListController');
    getPSWDStaffs().then((value) {
      pswdList.value = value;
      filteredPswdList.assignAll(pswdList);
      isLoading.value = false;
    });
  }

  Future<void> refetchList() async {
    pswdList.clear();
    filteredPswdList.clear();
    await getPSWDStaffs().then((value) {
      pswdList.value = value;
      filteredPswdList.assignAll(pswdList);
    });
  }

  Future<List<PswdModel>> getPSWDStaffs() async {
    return firestore
        .collection('pswd_personnel')
        .where('disabled', isEqualTo: false)
        .orderBy('lastName')
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
        .update({'disabled': true}).then((value) async {
      await firestore.collection('users').doc(uid).update({'disabled': true});
      await refetchList();
      await dListController.reloadAfter();
      showSimpleErrorDialog(
          errorDescription: 'PSWD Staff is successfully disabled');
    });
  }

  Future<void> enablePSWDStaff(String uid) async {
    await firestore
        .collection('pswd_personnel')
        .doc(uid)
        .update({'disabled': false}).then(
      (value) async {
        await firestore
            .collection('users')
            .doc(uid)
            .update({'disabled': false});
        await dListController.reloadAfter();
        await refetchList();
        showSimpleErrorDialog(
            errorDescription: 'PSWD Staff is successfully enabled');
      },
    );
  }

  Future<void> updatePSWD(PswdModel model) async {
    showLoading();
    await firestore.collection('pswd_personnel').doc(model.userID).update({
      'firstName':
          editFirstName.text == '' ? model.firstName : editFirstName.text,
      'lastName': editLastName.text == '' ? model.lastName : editLastName.text,
      'position':
          editPosition.value == '' ? model.position : editPosition.value,
    }).then(
      (value) {
        dismissDialog();
        Get.defaultDialog(
            title: 'PSWD Staff is successfully updated',
            middleText: "Please make sure to check the updated details",
            onConfirm: navigateToList);
      },
    ).catchError(
      (error) {
        dismissDialog();
        showSimpleErrorDialog(
            errorDescription: 'Error Occured! Unable to update PSWD');
      },
    );
  }

  Future<void> navigateToList() async {
    dismissDialog();
    await refetchList();
    return navigationController.navigatorKey.currentState!.pop();
  }

  String getProfilePhoto(PswdModel model) {
    return model.profileImage!;
  }

  filter({required String name, required String title}) {
    pswdList.clear();

    //filter for name only
    if (name != '' && title == '') {
      for (var i = 0; i < filteredPswdList.length; i++) {
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
    }

    //filter for position only
    else if (name == '' && title != '') {
      for (var i = 0; i < filteredPswdList.length; i++) {
        if (filteredPswdList[i].position == title) {
          pswdList.add(filteredPswdList[i]);
        }
      }
    }

    //filter for both
    else if (name != '' && title != '') {
      for (var i = 0; i < filteredPswdList.length; i++) {
        if ((filteredPswdList[i]
                    .lastName!
                    .toLowerCase()
                    .contains(name.toLowerCase()) ||
                filteredPswdList[i]
                    .firstName!
                    .toLowerCase()
                    .contains(name.toLowerCase())) &&
            filteredPswdList[i].position == title.toLowerCase()) {
          pswdList.add(filteredPswdList[i]);
        }
      }
    }

    //show all
    else if (name == '' && title == 'All') {
      pswdList.assignAll(filteredPswdList);
    }
  }
}
