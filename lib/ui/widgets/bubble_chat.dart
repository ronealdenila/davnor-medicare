import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:davnor_medicare/core/models/chat_model.dart';
import 'package:davnor_medicare/constants/firebase.dart';

Widget bubbleChat(ChatModel chat) {
  if (chat.message!.startsWith('https://firebasestorage.googleapis.com/')) {
    final displayImages = chat.message!.split('>>>');
    if (displayImages.length == 1) {
      return displaySingleImage(chat);
    } else if (displayImages.length > 1) {
      displayImages.removeLast(); //remove excess >>> ""
      return displayMultipleImages(displayImages, chat);
    }
  }
  return displayMessage(chat);
}

Widget displaySingleImage(ChatModel chat) {
  return Row(
    mainAxisAlignment: chat.senderID == auth.currentUser!.uid
        ? MainAxisAlignment.end
        : MainAxisAlignment.start,
    children: [
      Flexible(
        child: Container(
            constraints: BoxConstraints(maxWidth: Get.width * .7),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: chat.senderID == auth.currentUser!.uid
                  ? neutralBubbleColor
                  : verySoftBlueColor[60],
              borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(10),
                  topRight: const Radius.circular(10),
                  bottomLeft: chat.senderID == auth.currentUser!.uid
                      ? const Radius.circular(10)
                      : Radius.zero,
                  bottomRight: chat.senderID == auth.currentUser!.uid
                      ? Radius.zero
                      : const Radius.circular(10)),
            ),
            child: Image.network(
              chat.message!,
              fit: BoxFit.cover,
            )),
      ),
    ],
  );
}

Widget displayMultipleImages(List<String> displayImages, ChatModel chat) {
  return Row(
    mainAxisAlignment: chat.senderID == auth.currentUser!.uid
        ? MainAxisAlignment.end
        : MainAxisAlignment.start,
    children: [
      Flexible(
        child: Container(
          constraints: BoxConstraints(maxWidth: Get.width * .7),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: chat.senderID == auth.currentUser!.uid
                ? neutralBubbleColor
                : verySoftBlueColor[60],
            borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(10),
                topRight: const Radius.circular(10),
                bottomLeft: chat.senderID == auth.currentUser!.uid
                    ? const Radius.circular(10)
                    : Radius.zero,
                bottomRight: chat.senderID == auth.currentUser!.uid
                    ? Radius.zero
                    : const Radius.circular(10)),
          ),
          child: GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            crossAxisCount: displayImages.length < 3 ? displayImages.length : 3,
            children: List.generate(displayImages.length, (index) {
              return Container(
                height: 68.5,
                color: Colors.white,
                child: Center(
                    child: Image.network(
                  displayImages[index],
                  fit: BoxFit.cover,
                )),
              );
            }),
          ),
        ),
      ),
    ],
  );
}

Widget displayMessage(ChatModel chat) {
  return Row(
    mainAxisAlignment: chat.senderID == auth.currentUser!.uid
        ? MainAxisAlignment.end
        : MainAxisAlignment.start,
    children: [
      Flexible(
        child: Container(
            constraints: BoxConstraints(maxWidth: Get.width * .7),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: chat.senderID == auth.currentUser!.uid
                  ? neutralBubbleColor
                  : verySoftBlueColor[60],
              borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(10),
                  topRight: const Radius.circular(10),
                  bottomLeft: chat.senderID == auth.currentUser!.uid
                      ? const Radius.circular(10)
                      : Radius.zero,
                  bottomRight: chat.senderID == auth.currentUser!.uid
                      ? Radius.zero
                      : const Radius.circular(10)),
            ),
            child: Text(
              chat.message!,
              style: body16Medium.copyWith(
                  color: chat.senderID == auth.currentUser!.uid
                      ? Colors.black
                      : Colors.white,
                  height: 1.4),
            )),
      ),
    ],
  );
}
