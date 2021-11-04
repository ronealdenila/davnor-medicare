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
      getMAHistoryForPSWD().then((value) {
        maHistoryList.value = value;
        filteredListforPSWD.assignAll(maHistoryList);
        isLoading.value = false;
      });
    } else if (authController.userRole == 'patient') {
      getMAHistoryForPatient().then((value) {
        maHistoryList.value = value;
        filteredListforP.assignAll(maHistoryList);
        isLoading.value = false;
      });
    }
  }

  Future<List<MAHistoryModel>> getMAHistoryForPatient() async {
    log.i('Get MA History for Patient - ${auth.currentUser!.uid}');
    return firestore
        .collection('ma_history')
        .where('requesterID', isEqualTo: auth.currentUser!.uid)
        .get()
        .then(
          (query) => query.docs
              .map((item) => MAHistoryModel.fromJson(item.data()))
              .toList(),
        );
  }

  Future<List<MAHistoryModel>> getMAHistoryForPSWD() async {
    log.i('Get MA History for PSWD Personnel - ${auth.currentUser!.uid}');
    return firestore.collection('ma_history').orderBy('dateRqstd').get().then(
          (query) => query.docs
              .map((item) => MAHistoryModel.fromJson(item.data()))
              .toList(),
        );
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
    maHistoryList.clear();

    //filter for name only
    if (name != '' && !last30days) {
      for (var i = 0; i < filteredListforPSWD.length; i++) {
        if (filteredListforPSWD[i]
            .fullName!
            .toLowerCase()
            .contains(name.toLowerCase())) {
          maHistoryList.add(filteredListforPSWD[i]);
        }
      }
    }

    //filter for last 30 days only
    else if (name == '' && last30days) {
      filterLast30Days();
    }

    //filter for both
    else if (name != '' && last30days) {
      print('BOTH');
      for (var i = 0; i < filteredListforPSWD.length; i++) {
        if ((filteredListforPSWD[i]
                .fullName!
                .toLowerCase()
                .contains(name.toLowerCase())) &&
            readTimestamp(filteredListforPSWD[i].dateClaimed!.seconds) <= 30) {
          maHistoryList.add(filteredListforPSWD[i]);
        }
      }
    }

    //show all
    else if (name == '' && !last30days) {
      maHistoryList.assignAll(filteredListforPSWD);
    }
  }

  filterLast30Days() {
    for (var i = 0; i < filteredListforPSWD.length; i++) {
      if (readTimestamp(filteredListforPSWD[i].dateClaimed!.seconds) <= 30) {
        maHistoryList.add(filteredListforPSWD[i]);
      }
    }
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
    maHistoryList.clear();
    Timestamp myTimeStamp = Timestamp.fromDate(args.value);
    for (var i = 0; i < filteredListforP.length; i++) {
      String dateConstant = getMonth(filteredListforP[i].dateClaimed!) +
          " - " +
          getDate(filteredListforP[i].dateClaimed!) +
          " - " +
          getYear(filteredListforP[i].dateClaimed!);
      ;
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
        maHistoryList.add(filteredListforP[i]);
      }
    }
    Get.back();
  }
}
