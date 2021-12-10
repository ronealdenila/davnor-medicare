import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/admin/disabled_doctors_controller.dart';
import 'package:davnor_medicare/core/controllers/navigation_controller.dart';
import 'package:davnor_medicare/core/models/user_model.dart';
import 'package:davnor_medicare/core/services/logger_service.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DoctorListController extends GetxController {
  final log = getLogger('Doctor List Controller');
  final DisabledDoctorsController dListController =
      Get.put(DisabledDoctorsController());

  final NavigationController navigationController = Get.find();
  final RxList<DoctorModel> doctorList = RxList<DoctorModel>();
  final RxList<DoctorModel> filteredDoctorList = RxList<DoctorModel>();
  final TextEditingController docFilter = TextEditingController();
  final RxBool isLoading = true.obs;
  final RxString title = ''.obs;
  final RxString department = ''.obs;

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

  Future<void> refetchList() async {
    doctorList.clear();
    filteredDoctorList.clear();
    await getDoctors().then((value) {
      doctorList.value = value;
      filteredDoctorList.assignAll(doctorList);
    });
  }

  Future<List<DoctorModel>> getDoctors() async {
    return firestore
        .collection('doctors')
        .where('disabled', isEqualTo: false)
        .orderBy('lastName')
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
        .update({'disabled': true}).then(
      (value) async {
        await firestore.collection('users').doc(uid).update({'disabled': true});
        await dListController.reloadAfter();
        Get.defaultDialog(title: 'Successfuly disabled Doctor');
      },
    );
  }

  Future<void> enableDoctor(String uid) async {
    await firestore
        .collection('doctors')
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
            errorDescription: 'Doctor is successfully enabled');
      },
    );
  }

  Future<void> updateDoctor(DoctorModel model) async {
    showLoading();
    await firestore.collection('doctors').doc(model.userID).update({
      'firstName':
          editFirstName.text == '' ? model.firstName : editFirstName.text,
      'lastName': editLastName.text == '' ? model.lastName : editLastName.text,
      'title': editTitle.value == '' ? model.title : editTitle.value,
      'department':
          editDepartment.value == '' ? model.department : editDepartment.value,
      'clinicHours': editClinicHours.value == ''
          ? model.clinicHours
          : editClinicHours.text,
    }).then((value) {
      dismissDialog();
      Get.defaultDialog(
          title: 'Doctor is successfully updated',
          middleText: "Please make sure to check the updated details",
          onConfirm: navigateToList);
    }).catchError(
      (error) {
        dismissDialog();
        showSimpleErrorDialog(
            errorDescription: 'Error Occured! Unable to update doctor');
      },
    );
  }

  Future<void> navigateToList() async {
    dismissDialog();
    await refetchList();
    return navigationController.navigatorKey.currentState!.pop();
  }

  String getProfilePhoto(DoctorModel model) {
    return model.profileImage!;
  }

  filter({required String name, required String title, required String dept}) {
    print(name + " " + title + " " + dept);
    final RxBool madeChanges = false.obs;
    doctorList.clear();

    //filter for name
    if (name != '') {
      for (var i = 0; i < filteredDoctorList.length; i++) {
        madeChanges.value = true;
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

    //filter for title
    if (title != '' && title != 'All') {
      if (doctorList.isEmpty) {
        for (var i = 0; i < filteredDoctorList.length; i++) {
          madeChanges.value = true;
          if (filteredDoctorList[i].title == title) {
            doctorList.add(filteredDoctorList[i]);
          }
        }
      } else {
        for (var i = 0; i < doctorList.length; i++) {
          if (doctorList[i].title != title) {
            doctorList.removeAt(i);
          }
        }
      }
    }

    //filter for dept
    if (dept != '' && dept != 'All') {
      if (doctorList.isEmpty) {
        for (var i = 0; i < filteredDoctorList.length; i++) {
          madeChanges.value = true;
          if (filteredDoctorList[i].department == dept) {
            doctorList.add(filteredDoctorList[i]);
          }
        }
      } else {
        for (var i = 0; i < doctorList.length; i++) {
          if (doctorList[i].department != dept) {
            doctorList.removeAt(i);
          }
        }
      }
    }

    //show all
    if (!madeChanges.value && doctorList.isEmpty) {
      doctorList.assignAll(filteredDoctorList);
    }
  }
}
