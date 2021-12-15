import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/models/notification_model.dart';
import 'package:davnor_medicare/core/services/logger_service.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/helpers/time_ago.dart';
import 'package:intl/intl.dart';

class NotifController extends GetxController {
  final log = getLogger('NotifController Controller');

  static AuthController authController = Get.find();
  RxList<NotificationModel> notif = RxList<NotificationModel>([]);

  @override
  void onReady() {
    super.onReady();
    notif.bindStream(assignListStream());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getNotifications() {
    log.i('Get Notifications | ${auth.currentUser!.uid}');
    return firestore
        .collection('patients')
        .doc(auth.currentUser!.uid)
        .collection('notifications')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Stream<List<NotificationModel>> assignListStream() {
    return getNotifications().map(
      (query) => query.docs
          .map((item) => NotificationModel.fromJson(item.data()))
          .toList(),
    );
  }

  String convert(Timestamp recordTime) {
    final dt = recordTime.toDate();
    final dateString = DateFormat('dd-MM-yyyy h:mma').format(dt);
    return TimeAgo.timeAgoSinceDate(dateString, dt);
  }
}
