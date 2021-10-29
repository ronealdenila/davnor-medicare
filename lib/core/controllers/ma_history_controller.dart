import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/models/med_assistance_model.dart';
import 'package:davnor_medicare/core/models/user_model.dart';
import 'package:davnor_medicare/core/services/logger_service.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MAHistoryController extends GetxController {
  final log = getLogger('MA History Controller');

  RxList<MAHistoryModel> maList = RxList<MAHistoryModel>([]);
  RxList<MAHistoryModel> maListmaster = RxList<MAHistoryModel>([]);
  //FOR PSWD SIDE
  final RxList<MAHistoryModel> mafilteredList = RxList<MAHistoryModel>();
  final TextEditingController maFilter = TextEditingController();

  RxBool enabledPastDays = false.obs;

  @override
  void onReady() {
    super.onReady();
    log.i('onReady | DoctorListController');
    getMAHistoryForPSWD();
  }

  Future<void> getMAHistoryForPatient() async {
    log.i('Get MA History for Patient - ${auth.currentUser!.uid}');
    await firestore
        .collection('ma_history')
        .where('requesterID', isEqualTo: auth.currentUser!.uid)
        .get()
        .then((value) {
      for (final result in value.docs) {
        maList.add(MAHistoryModel.fromJson(result.data()));
        maListmaster.add(MAHistoryModel.fromJson(result.data()));
      }
    });
  }

  Future<void> getMAHistoryForPSWD() async {
    log.i('Get MA History for PSWD Personnel - ${auth.currentUser!.uid}');
    await firestore
        .collection('ma_history')
        .orderBy('dateRqstd')
        .get()
        .then((value) {
      for (final result in value.docs) {
        maList.add(MAHistoryModel.fromJson(result.data()));
        maListmaster.add(MAHistoryModel.fromJson(result.data()));
      }
    });
  }

  String convertTimeStamp(Timestamp recordTime) {
    final dt = recordTime.toDate();
    return DateFormat.yMMMd().add_jm().format(dt);
  }

  Future<void> getRequesterData(MAHistoryModel model) async {
    model.patient.value = await firestore
        .collection('patients')
        .doc(model.requesterID)
        .get()
        .then((doc) => PatientModel.fromJson(doc.data()!));
  }

  String getPatientProfile(MAHistoryModel model) {
    return model.patient.value!.profileImage!;
  }

  String getPatientFirstName(MAHistoryModel model) {
    return model.patient.value!.firstName!;
  }

  String getPatientLastName(MAHistoryModel model) {
    return model.patient.value!.lastName!;
  }

  String getPatientName(MAHistoryModel model) {
    return '${getPatientFirstName(model)} ${getPatientLastName(model)}';
  }

  int readTimestamp(int? timestamp) {
    var now = DateTime.now();
    var format = DateFormat('HH:mm a');
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp! * 1000);
    var diff = now.difference(date);
    var time = '';

    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + ' DAY AGO';
      } else {
        time = diff.inDays.toString() + ' DAYS AGO';
      }
    } else {
      if (diff.inDays == 7) {
        time = (diff.inDays / 7).floor().toString() + ' WEEK AGO';
      } else {
        time = (diff.inDays / 7).floor().toString() + ' WEEKS AGO';
      }
    }
    print("diff in days : ${diff.inDays}");
    print(time);
    return diff.inDays;
  }

  filter({
    required String name,
  }) {
    maList.clear();
    for (var i = 0; i < maListmaster.length; i++) {
      if (maListmaster[i]
          .fullName!
          .toLowerCase()
          .contains(name.toLowerCase())) {
        maList.add(maListmaster[i]);
      }
    }
    if (enabledPastDays.value == true) {
      for (var i = 0; i < maListmaster.length; i++) {
        if (readTimestamp(maListmaster[i].dateClaimed!.seconds) > 30) {
        } else {
          maList.add(maListmaster[i]);
        }
      }
    }

    for (var i = 0; i < maList.length; i++) {
      print(maList[i].fullName);
    }

    final stores = maList.map((e) => e.fullName).toSet();
    maList.retainWhere((x) => stores.remove(x.fullName));
  }

  filterPastDays() {
    maList.clear();

    if (enabledPastDays.value == true) {
      for (var i = 0; i < maListmaster.length; i++) {
        if (readTimestamp(maListmaster[i].dateClaimed!.seconds) > 30) {
        } else {
          maList.add(maListmaster[i]);
        }
      }
    } else {
      maList.assignAll(maListmaster);
    }

    for (var i = 0; i < maList.length; i++) {
      print(maList[i].fullName);
    }

    // final stores = maList.map((e) => e.fullName).toSet();
    // maList.retainWhere((x) => stores.remove(x.fullName));
  }
}
