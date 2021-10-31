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

  //Edit
  final TextEditingController editFirstName = TextEditingController();
  final TextEditingController editLastName = TextEditingController();
  final TextEditingController editClinicHours = TextEditingController();
  final RxString editTitle = ''.obs;
  final RxString editDepartment = ''.obs;
  final RxBool enableEditing = false.obs;

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

  Future<void> updateDoctor(DoctorModel model) async {
    await firestore
        .collection('doctors')
        .doc(model.userID)
        .update({
          'firstName':
              editFirstName.text == '' ? model.firstName : editFirstName.text,
          'lastName':
              editLastName.text == '' ? model.lastName : editLastName.text,
          'title': editTitle.value == '' ? model.title : editTitle.value,
          'department': editDepartment.value == ''
              ? model.department
              : editDepartment.value,
          'clinicHours': editClinicHours.value == ''
              ? model.clinicHours
              : editClinicHours.value,
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

  String getProfilePhoto(DoctorModel model) {
    return model.profileImage!;
  }

  filter({required String name, required String title}) {
    print(name + " " + title);
    doctorList.clear();

    //filter for name only
    if (name != '' && title == '') {
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

    //filter for title only
    else if (name == '' && title != '') {
      for (var i = 0; i < filteredDoctorList.length; i++) {
        if (filteredDoctorList[i]
            .title!
            .toLowerCase()
            .contains(title.toLowerCase())) {
          doctorList.add(filteredDoctorList[i]);
        }
      }
    }

    //filter for both
    else if (name != '' && title != '') {
      for (var i = 0; i < filteredDoctorList.length; i++) {
        if ((filteredDoctorList[i]
                    .lastName!
                    .toLowerCase()
                    .contains(name.toLowerCase()) ||
                filteredDoctorList[i]
                    .firstName!
                    .toLowerCase()
                    .contains(name.toLowerCase())) &&
            filteredDoctorList[i]
                .title!
                .toLowerCase()
                .contains(title.toLowerCase())) {
          doctorList.add(filteredDoctorList[i]);
        }
      }
    }

    //show all
    else if (name == '' && title == 'All') {
      doctorList.assignAll(filteredDoctorList);
    }
  }
}
