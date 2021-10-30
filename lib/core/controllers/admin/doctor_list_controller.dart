import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/models/user_model.dart';
import 'package:davnor_medicare/core/services/logger_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DoctorListController extends GetxController {
  final log = getLogger('Doctor List Controller');

  final RxList<DoctorModel> doctorList = RxList<DoctorModel>();
  final RxList<DoctorModel> filteredDoctorList = RxList<DoctorModel>();
  final TextEditingController docFilter = TextEditingController();
  final RxBool isLoading = true.obs;
  final RxString title = ''.obs;

  @override
  void onReady() {
    super.onReady();
    log.i('onReady | DoctorListController');
    getDoctors().then((value) {
      doctorList.value = value;
      filteredDoctorList.assignAll(doctorList);
      isLoading.value = false;
    });
  }

  Future<List<DoctorModel>> getDoctors() async {
    return firestore
        .collection('doctors')
        .where('disabled', isEqualTo: false)
        .get()
        .then(
          (query) => query.docs
              .map((item) => DoctorModel.fromJson(item.data()))
              .toList(),
        );
  }

  Future<void> disableDoctor(String uid) async {
    await firestore
        .collection('doctors')
        .doc(uid)
        .update({'disabled': true})
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

  filter({required String name, required String title}) {
    print(name + " " + title);
    doctorList.clear();
    if (name.isEmpty) {
      print("Empty name");
    } else {
      for (var i = 0; i < filteredDoctorList.length; i++) {
        if (filteredDoctorList[i]
                .lastName!
                .toLowerCase()
                .contains(name.toLowerCase()) ||
            filteredDoctorList[i]
                .firstName!
                .toLowerCase()
                .contains(name.toLowerCase())) {
          doctorList.add(filteredDoctorList[i]);
        }
      }
    }
    if (title.isEmpty) {
      print("Empty title");
    } else {
      for (var i = 0; i < filteredDoctorList.length; i++) {
        if (filteredDoctorList[i]
            .title!
            .toLowerCase()
            .contains(title.toLowerCase())) {
          doctorList.add(filteredDoctorList[i]);
        }
      }
    }

    for (var i = 0; i < doctorList.length; i++) {
      print(doctorList[i].firstName);
    }

    final stores = doctorList.map((e) => e.userID).toSet();
    doctorList.retainWhere((x) => stores.remove(x.userID));
  }
}
