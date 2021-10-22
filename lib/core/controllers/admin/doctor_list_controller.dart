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
      isLoading.value = false;
    });
  }

  Future<List<DoctorModel>> getDoctors() async {
    return firestore.collection('doctors').get().then(
          (query) => query.docs
              .map((item) => DoctorModel.fromJson(item.data()))
              .toList(),
        );
  }
}
