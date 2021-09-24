import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/models/chat_model.dart';
import 'package:davnor_medicare/core/models/consultation_model.dart';
import 'package:davnor_medicare/core/services/logger_service.dart';
import 'package:get/get.dart';
import 'package:davnor_medicare/core/controllers/live_cons_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LiveChatController extends GetxController {
  final log = getLogger('Doctor Home Consultations Controller');

  static LiveConsController liveConsController = Get.find();
  final LiveConsultationModel consData = liveConsController.liveCons[0];
  RxList<ChatModel> liveChat = RxList<ChatModel>([]);

  TextEditingController chatController = TextEditingController();

  @override
  void onReady() {
    super.onReady();
    liveChat.bindStream(assignLiveChat(consData));
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getLiveChatMessages(
      LiveConsultationModel model) {
    log.i('get Live Chat Messages');
    return firestore
        .collection('chat')
        .doc(model.consID)
        .collection('messages')
        .orderBy('dateCreated', descending: true)
        .snapshots();
  }

  Stream<List<ChatModel>> assignLiveChat(LiveConsultationModel model) {
    log.i('assign Live Chat Messages');
    return getLiveChatMessages(model).map(
      (query) =>
          query.docs.map((item) => ChatModel.fromJson(item.data())).toList(),
    );
  }

  Future<void> sendMessage() async {
    await firestore
        .collection('chat')
        .doc(consData.consID)
        .collection('messages')
        .add({
      'senderID': auth.currentUser!.uid,
      'message': chatController.text,
      'dateCreated':
          Timestamp.fromDate(DateTime.now()), //to be changed -> epoch
    });
    await clearControllers();
  }

  Future<void> clearControllers() async {
    log.i('_clearControllers');
    chatController.clear();
  }
}
