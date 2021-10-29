import 'package:davnor_medicare/core/controllers/patient/notif_controller.dart';
import 'package:davnor_medicare/ui/widgets/patient/notification_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationFeedScreen extends StatelessWidget {
  static NotifController notifController = Get.put(NotifController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              elevation: 1,
              title: const Text(
                'Notifications',
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.white,
            ),
            backgroundColor: Colors.white,
            body: Obx(displayNotification)));
  }

  Widget displayNotification() {
    return notifController.notif.isEmpty
        ? const Center(
            child: Text(
              'You have no notifications',
              textAlign: TextAlign.center,
            ),
          )
        : ListView.builder(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            shrinkWrap: true,
            itemCount: notifController.notif.length,
            itemBuilder: (context, index) {
              return NotificationCard(notif: notifController.notif[index]);
            });
  }
}
