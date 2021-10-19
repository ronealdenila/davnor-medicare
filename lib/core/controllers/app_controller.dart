import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/services/local_notification_service.dart';
import 'package:davnor_medicare/core/services/logger_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

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
}
