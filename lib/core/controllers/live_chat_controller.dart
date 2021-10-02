import 'dart:io';

import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/models/chat_model.dart';
import 'package:davnor_medicare/core/models/consultation_model.dart';
import 'package:davnor_medicare/core/services/image_picker_service.dart';
import 'package:davnor_medicare/core/services/logger_service.dart';
import 'package:get/get.dart';
import 'package:davnor_medicare/core/controllers/live_cons_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class LiveChatController extends GetxController {
  final log = getLogger('Doctor Home Consultations Controller');

  static LiveConsController liveConsController = Get.find();
  final ImagePickerService _imagePicker = ImagePickerService();
  final LiveConsultationModel consData = liveConsController.liveCons[0];
  RxList<ChatModel> liveChat = RxList<ChatModel>([]);

  //content if chat checker - to control what should be uploaded
  RxBool isPhotoCameraClicked = false.obs;
  RxBool isPhotoAttachClicked = false.obs;

  //chat message
  TextEditingController chatController = TextEditingController();

  //for sending images as chat message
  final uuid = const Uuid();
  final RxString fileName = ''.obs;

  //multiple imgs - attach photos
  RxList<XFile> images = RxList<XFile>();
  final RxString listPhotoURL = ''.obs;

  //single image from camera
  final RxString image = ''.obs;
  final RxString photoURL = ''.obs;

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

  Future<void> sendButton() async {
    if (isPhotoCameraClicked.value && image.value.isNotEmpty) {
      await uploadImage();
      await sendMessage(photoURL.value);
      await clearImage();
    } else if (isPhotoAttachClicked.value && images.isNotEmpty) {
      await uploadImages();
      await sendMessage(listPhotoURL.value);
      await clearImages();
    } else {
      if (chatController.text.isEmpty) {
        Get.snackbar('No message', 'Please write a message',
            snackPosition: SnackPosition.BOTTOM);
      } else {
        await sendMessage(chatController.text);
        await clearMessage();
      }
    }
  }

  Future<void> sendMessage(String message) async {
    await firestore
        .collection('chat')
        .doc(consData.consID)
        .collection('messages')
        .add({
      'senderID': auth.currentUser!.uid,
      'message': message,
      'dateCreated': Timestamp.fromDate(DateTime.now()),
    });
  }

  void pickImageFromCamera() {
    isPhotoCameraClicked.value = true;
    _imagePicker.pickFromCamera(image);
  }

  void pickMultiImage() {
    isPhotoAttachClicked.value = true;
    _imagePicker.pickMultiImage(images);
  }

  Future<void> uploadImage() async {
    final img = image.value;
    final v4 = uuid.v4();
    log.i('Using UID for making sure of the uniqueness -> $v4');
    fileName.value = img.split('/').last;
    final ref =
        storageRef.child('Consultation/${consData.consID}/Cam-Ph-$v4$fileName');
    final uploadTask = ref.putFile(File(img));
    await uploadTask.then((res) async {
      photoURL.value = await res.ref.getDownloadURL();
    });
  }

  Future<void> uploadImages() async {
    for (var i = 0; i < images.length; i++) {
      final v4 = uuid.v4();
      fileName.value = images[i].path.split('/').last;
      final ref = storageRef
          .child('Consultation/${consData.consID}/$i-Ph-$v4$fileName');
      await ref.putFile(File(images[i].path)).whenComplete(() async {
        await ref.getDownloadURL().then((value) {
          listPhotoURL.value += '$value>>>';
        });
      });
      log.i('$i -> fileName: $i-Photos$fileName');
    }
  }

  Future<void> clearMessage() async {
    log.i('_clearMessage');
    chatController.clear();
  }

  Future<void> clearImage() async {
    log.i('_clearImage');
    image.value = '';
    photoURL.value = '';
    isPhotoCameraClicked.value = false;
  }

  Future<void> clearImages() async {
    log.i('_clearImages');
    images.value = [];
    listPhotoURL.value = '';
    isPhotoAttachClicked.value = false;
  }
}