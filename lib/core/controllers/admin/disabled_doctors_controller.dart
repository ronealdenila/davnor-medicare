import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/models/user_model.dart';
import 'package:davnor_medicare/core/services/logger_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DisabledDoctorsController extends GetxController {
  final log = getLogger('Disabled Doctors Controller');

  final RxList<DoctorModel> disabledList = RxList<DoctorModel>();
  final RxList<DoctorModel> filteredDisabledList = RxList<DoctorModel>();
  final TextEditingController filterKey = TextEditingController();
  final RxBool isLoading = true.obs;

  @override
  void onReady() {
    super.onReady();
    log.i('onReady | Disabled Doctors Controller');
    getDoctors().then((value) {
      disabledList.value = value;
      filteredDisabledList.assignAll(disabledList);
      isLoading.value = false;
    });
  }

  Future<List<DoctorModel>> getDoctors() async {
    return firestore
        .collection('doctors')
        .where('disabled', isEqualTo: true)
        .get()
        .then(
          (query) => query.docs
              .map((item) => DoctorModel.fromJson(item.data()))
              .toList(),
        );
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
