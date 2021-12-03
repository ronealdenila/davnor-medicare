import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/constants/app_strings.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/pswd/attached_photos_controller.dart';
import 'package:davnor_medicare/core/models/general_ma_req_model.dart';
import 'package:davnor_medicare/core/models/user_model.dart';
import 'package:davnor_medicare/core/services/local_notification_service.dart';
import 'package:davnor_medicare/core/services/logger_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class AppController {
  final log = getLogger('App Controller');
  final AttachedPhotosController controller =
      Get.put(AttachedPhotosController());

  final String _dateNow = DateFormat.yMMMMd().format(DateTime.now());

  String get dateNow => _dateNow;

  bool toggleTextVisibility(RxBool isObscureText) {
    log.i('toggleTextVisibility | Toggle Text Visibility');
    log.i(isObscureText);
    return isObscureText.value = !isObscureText.value;
  }

  void initLocalNotif(BuildContext context) {
    LocalNotificationService.initialize(context);
    messaging.getInitialMessage();

    ///Foreground
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        log.i(message.notification!.body);
        log.i(message.notification!.title);
      }

      LocalNotificationService.display(message);
    });
  }

  Future<void> sendNotificationViaFCM(
      String title, String message, String sendTo) async {
    await firestore
        .collection('patients')
        .doc(sendTo)
        .collection('status')
        .doc('value')
        .get()
        .then((DocumentSnapshot documentSnapshot) async {
      if (documentSnapshot.exists) {
        Map data = documentSnapshot.data() as Map;
        print('Token: ${data['deviceToken']}');
        if (data['deviceToken'] != '') {
          const postUrl = 'https://fcm.googleapis.com/fcm/send';
          final data = {
            'notification': {'title': title, 'body': message},
            'to': sendTo
          };

          final headers = {
            'content-type': 'application/json',
            'Authorization': serverkey
          };

          final response = await http.post(Uri.parse(postUrl),
              body: json.encode(data),
              encoding: Encoding.getByName('utf-8'),
              headers: headers);

          if (response.statusCode == 200) {
            log.i('Send via POST success!');
          } else {
            log.i('Send via POST failed');
          }
        }
      }
    });
  }

  //Global Function FOR DYNAMIC PSWD ITEM VIEW - PSWD Side
  Future<void> getPatientData(GeneralMARequestModel model) async {
    final allImages = '${model.validID}>>>${model.prescriptions}';
    await controller.splitFetchedImage(allImages);
    model.requester.value = await firestore
        .collection('patients')
        .doc(model.requesterID)
        .get()
        .then((doc) => PatientModel.fromJson(doc.data()!));
  }

  String getProfilePhoto(GeneralMARequestModel model) {
    return model.requester.value!.profileImage!;
  }

  String getFirstName(GeneralMARequestModel model) {
    return model.requester.value!.firstName!;
  }

  String getLastName(GeneralMARequestModel model) {
    return model.requester.value!.lastName!;
  }

  String getFullName(GeneralMARequestModel model) {
    return '${getFirstName(model)} ${getLastName(model)}';
  }

  String convertTimeStamp(Timestamp recordTime) {
    final dt = recordTime.toDate();
    return DateFormat.yMMMd().add_jm().format(dt);
  }
}
