import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/core/models/med_assistance_model.dart';
import 'package:davnor_medicare/core/models/user_model.dart';
import 'package:davnor_medicare/core/services/logger_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class MAHistoryController extends GetxController {
  final log = getLogger('MA History Controller');

  static AuthController authController = Get.find();
  RxList<MAHistoryModel> maHistoryList = RxList<MAHistoryModel>([]);
  final RxBool isLoading = true.obs;

  //searching MA history in PSWD side...
  RxList<MAHistoryModel> filteredListforPSWD = RxList<MAHistoryModel>([]);
  final TextEditingController searchKeyword = TextEditingController();
  RxString last30DaysDropDown = ''.obs;

  //searching MA history in patient side...
  RxList<MAHistoryModel> filteredListforP = RxList<MAHistoryModel>([]);

  @override
  void onReady() {
    super.onReady();
    log.i('onReady | MA History Controller');
    if (authController.userRole == 'pswd-h' ||
        authController.userRole == 'pswd-p') {
      maHistoryList.bindStream(getMAHistoryForPSWD());
    } else if (authController.userRole == 'patient') {
      maHistoryList.bindStream(getMAHistoryForPatient());
    }
  }

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 5), () {
      isLoading.value = false;
    });
  }

  void refresh() {
    filteredListforP.clear();
    filteredListforP.assignAll(maHistoryList);
  }

  void refreshPSWD() {
    filteredListforPSWD.clear();
    filteredListforPSWD.assignAll(maHistoryList);
  }

  Stream<List<MAHistoryModel>> getMAHistoryForPatient() {
    log.i('Get MA History for Patient - ${auth.currentUser!.uid}');
    return firestore
        .collection('ma_history')
        .where('requesterID', isEqualTo: auth.currentUser!.uid)
        .orderBy('dateClaimed', descending: true)
        .snapshots()
        .map((query) {
      return query.docs.map((item) {
        isLoading.value = false;
        return MAHistoryModel.fromJson(item.data());
      }).toList();
    });
  }

  Stream<List<MAHistoryModel>> getMAHistoryForPSWD() {
    log.i('Get MA History for PSWD Personnel - ${auth.currentUser!.uid}');
    return firestore
        .collection('ma_history')
        .orderBy('dateClaimed', descending: true)
        .snapshots()
        .map((query) {
      return query.docs.map((item) {
        isLoading.value = false;
        return MAHistoryModel.fromJson(item.data());
      }).toList();
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
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp! * 1000);
    var diff = now.difference(date);
    print("diff in days : ${diff.inDays}");
    return diff.inDays;
  }

  filter({required String name, required bool last30days}) {
    filteredListforPSWD.clear();

    //filter for name only
    if (name != '' && !last30days) {
      for (var i = 0; i < maHistoryList.length; i++) {
        if (maHistoryList[i]
            .fullName!
            .toLowerCase()
            .contains(name.toLowerCase())) {
          filteredListforPSWD.add(maHistoryList[i]);
        }
      }
    }

    //filter for last 30 days only
    else if (name == '' && last30days) {
      filterLast30Days();
    }

    //filter for both
    else if (name != '' && last30days) {
      for (var i = 0; i < maHistoryList.length; i++) {
        if ((maHistoryList[i]
                .fullName!
                .toLowerCase()
                .contains(name.toLowerCase())) &&
            readTimestamp(maHistoryList[i].dateClaimed!.seconds) <= 30) {
          filteredListforPSWD.add(maHistoryList[i]);
        }
      }
    }

    //show all
    else if (name == '' && !last30days) {
      filteredListforPSWD.assignAll(maHistoryList);
    }
  }

  filterLast30Days() {
    for (var i = 0; i < maHistoryList.length; i++) {
      if (readTimestamp(maHistoryList[i].dateClaimed!.seconds) <= 30) {
        filteredListforPSWD.add(maHistoryList[i]);
      }
    }
  }

  showDialogPSWD(context) {
    Get.dialog(AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Container(
        color: Colors.white,
        height: kIsWeb ? Get.height * 0.32 : Get.height * .45,
        width: kIsWeb ? Get.width * 0.20 : Get.width * .9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SfDateRangePicker(
              onSelectionChanged: onSelectionChangedPSWD,
              selectionMode: DateRangePickerSelectionMode.single,
            ),
          ],
        ),
      ),
    ));
  }

  showDialog(context) {
    Get.dialog(AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Container(
        color: Colors.white,
        height: kIsWeb ? Get.height * 0.32 : Get.height * .45,
        width: kIsWeb ? Get.width * 0.20 : Get.width * .9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SfDateRangePicker(
              onSelectionChanged: onSelectionChanged,
              selectionMode: DateRangePickerSelectionMode.single,
            ),
          ],
        ),
      ),
    ));
  }

  String getMonth(Timestamp time) {
    return time.toDate().month.toString();
  }

  String getDate(Timestamp time) {
    return time.toDate().day.toString();
  }

  String getYear(Timestamp time) {
    return time.toDate().year.toString();
  }

  void onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    filteredListforP.clear(); //p
    Timestamp myTimeStamp = Timestamp.fromDate(args.value);
    print(maHistoryList.length);
    for (var i = 0; i < maHistoryList.length; i++) {
      String dateConstant =
          maHistoryList[i].dateClaimed!.toDate().month.toString() +
              " - " +
              maHistoryList[i].dateClaimed!.toDate().day.toString() +
              " - " +
              maHistoryList[i].dateClaimed!.toDate().year.toString();

      String dateSelected = myTimeStamp.toDate().month.toString() +
          " - " +
          myTimeStamp.toDate().day.toString() +
          " - " +
          myTimeStamp.toDate().year.toString();
      print(i.toString() +
          "  " +
          dateConstant +
          " dateSelected  " +
          dateSelected);
      if (dateConstant == dateSelected) {
        filteredListforP.add(maHistoryList[i]);
      }
    }
    Get.back();
  }

  void onSelectionChangedPSWD(DateRangePickerSelectionChangedArgs args) {
    filteredListforPSWD.clear();
    Timestamp myTimeStamp = Timestamp.fromDate(args.value);
    print(maHistoryList.length);
    for (var a = 0; a < maHistoryList.length; a++) {
      String dateConstant =
          maHistoryList[a].dateClaimed!.toDate().month.toString() +
              " - " +
              maHistoryList[a].dateClaimed!.toDate().day.toString() +
              " - " +
              maHistoryList[a].dateClaimed!.toDate().year.toString();

      String dateSelected = myTimeStamp.toDate().month.toString() +
          " - " +
          myTimeStamp.toDate().day.toString() +
          " - " +
          myTimeStamp.toDate().year.toString();
      print(a.toString() +
          "  " +
          dateConstant +
          " dateSelected  " +
          dateSelected);
      if (dateConstant == dateSelected) {
        filteredListforPSWD.add(maHistoryList[a]);
      }
    }
    Get.back();
  }
}
