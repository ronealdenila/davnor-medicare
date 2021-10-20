import 'dart:convert';
import 'package:davnor_medicare/constants/app_strings.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/services/local_notification_service.dart';
import 'package:davnor_medicare/core/services/logger_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AppController {
  final log = getLogger('App Controller');

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
