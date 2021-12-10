import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/models/user_model.dart';
import 'package:davnor_medicare/core/services/logger_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DisabledStaffsController extends GetxController {
  final log = getLogger('Disabled PSWD Staff Controller');

  final RxList<PswdModel> disabledList = RxList<PswdModel>();
  final RxList<PswdModel> filteredDisabledList = RxList<PswdModel>();
  final TextEditingController filterKey = TextEditingController();
  final RxBool isLoading = true.obs;

  @override
  void onReady() {
    super.onReady();
    log.i('onReady | Disabled PSWD Staff Controller');
    getPSWDStaff().then((value) {
      disabledList.value = value;
      filteredDisabledList.assignAll(disabledList);
      isLoading.value = false;
    });
  }

  Future<List<PswdModel>> getPSWDStaff() async {
    return firestore
        .collection('pswd_personnel')
        .where('disabled', isEqualTo: true)
        .get()
        .then(
          (query) => query.docs
              .map((item) => PswdModel.fromJson(item.data()))
              .toList(),
        );
  }

  Future<void> reloadAfter() async {
    await getPSWDStaff().then((value) {
      disabledList.value = value;
      filteredDisabledList.assignAll(disabledList);
    });
  }

  filter({required String name}) {
    disabledList.clear();

    //filter for name
    if (name != '') {
      for (var i = 0; i < filteredDisabledList.length; i++) {
        if (filteredDisabledList[i]
                .lastName!
                .toLowerCase()
                .contains(name.toLowerCase()) ||
            filteredDisabledList[i]
                .firstName!
                .toLowerCase()
                .contains(name.toLowerCase())) {
          disabledList.add(filteredDisabledList[i]);
        }
      }
    } else {
      disabledList.assignAll(filteredDisabledList);
    }
  }
}
