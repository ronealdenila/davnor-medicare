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
  final RxBool enableEditing = false.obs;

  //Edit
  final TextEditingController editFirstName = TextEditingController();
  final TextEditingController editLastName = TextEditingController();
  final RxString editPosition = ''.obs;

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

  Future<void> updatePSWD(PswdModel model) async {
    await firestore
        .collection('pswd_personnel')
        .doc(model.userID)
        .update({
          'firstName':
              editFirstName.text == '' ? model.firstName : editFirstName.text,
          'lastName':
              editLastName.text == '' ? model.lastName : editLastName.text,
          'position':
              editPosition.value == '' ? model.position : editPosition.value,
        })
        .then(
          (value) => {
            //Dialog success
          },
        )
        .catchError(
          (error) => {
            //Dialog error
          },
        );
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
        if (filteredPswdList[i]
            .position!
            .toLowerCase()
            .contains(title.toLowerCase())) {
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
            filteredPswdList[i]
                .position!
                .toLowerCase()
                .contains(title.toLowerCase())) {
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
