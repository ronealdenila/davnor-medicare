import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:davnor_medicare/core/controllers/pswd/attached_photos_controller.dart';
import 'package:davnor_medicare/ui/shared/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:davnor_medicare/core/models/chat_model.dart';
import 'package:davnor_medicare/constants/firebase.dart';

final AttachedPhotosController controller = Get.find();
final double bubbleChatSize = kIsWeb ? .3 : .7;

Widget bubbleChat(ChatModel chat, BuildContext context) {
  if (chat.message!.startsWith('https://firebasestorage.googleapis.com/')) {
    final displayImages = chat.message!.split('>>>');
    if (displayImages.length == 1) {
      return displaySingleImage(chat, context);
    } else if (displayImages.length > 1) {
      displayImages.removeLast(); //remove excess >>> ""
      return displayMultipleImages(displayImages, chat, context);
    }
  }
  return displayMessage(chat);
}

Widget displaySingleImage(ChatModel chat, BuildContext context) {
  return Row(
    mainAxisAlignment: chat.senderID == auth.currentUser!.uid
        ? MainAxisAlignment.end
        : MainAxisAlignment.start,
    children: [
      Flexible(
        child: Container(
            constraints: BoxConstraints(maxWidth: Get.width * bubbleChatSize),
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
            child: InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) => attachedPhotoDialog(chat.message!));
              },
              child: Image.network(
                chat.message!,
                fit: BoxFit.cover,
              ),
            )),
      ),
    ],
  );
}

Widget displayMultipleImages(
    List<String> displayImages, ChatModel chat, BuildContext context) {
  return Row(
    mainAxisAlignment: chat.senderID == auth.currentUser!.uid
        ? MainAxisAlignment.end
        : MainAxisAlignment.start,
    children: [
      Flexible(
        child: Container(
          constraints: BoxConstraints(maxWidth: Get.width * bubbleChatSize),
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
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            crossAxisCount: displayImages.length < 3 ? displayImages.length : 3,
            children: List.generate(displayImages.length, (index) {
              return Container(
                height: 68.5,
                color: Colors.white,
                child: Center(
                    child: InkWell(
                  onTap: () {
                    controller.fetchedImages.assignAll(displayImages);
                    controller.selectedIndex.value = index;
                    print(controller.selectedIndex.value);
                    showDialog(
                        context: context,
                        builder: (context) => attachedPhotosDialog());
                  },
                  child: Image.network(
                    displayImages[index],
                    fit: BoxFit.cover,
                  ),
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
            constraints: BoxConstraints(maxWidth: Get.width * bubbleChatSize),
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

Widget attachedPhotosDialog() {
  return SimpleDialog(
    contentPadding: EdgeInsets.zero,
    titlePadding: EdgeInsets.zero,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: IconButton(
              onPressed: controller.prevPhoto,
              icon: const Icon(
                Icons.arrow_back_ios_rounded,
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              height: kIsWeb ? Get.height * .7 : Get.height * .8,
              width: kIsWeb ? Get.height * .7 : Get.width * .9,
              color: Colors.transparent,
              child: Obx(
                () => CarouselSlider.builder(
                  carouselController: controller.crslController,
                  itemCount: controller.fetchedImages.length,
                  itemBuilder: (context, index, realIndex) {
                    return buildImage(index);
                  },
                  options: CarouselOptions(
                      initialPage: controller.selectedIndex.value,
                      viewportFraction: 1,
                      height: double.infinity,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: false,
                      onPageChanged: (index, reason) =>
                          controller.selectedIndex.value = index),
                ),
              ),
            ),
          ),
          Expanded(
            child: IconButton(
              onPressed: controller.nextPhoto,
              icon: const Icon(
                Icons.arrow_forward_ios_rounded,
              ),
            ),
          ),
        ],
      ),
      SizedBox(
        height: kIsWeb ? 110 : 60,
        width: Get.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.fetchedImages.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Center(
                        child: Obx(
                          () => Container(
                            padding: const EdgeInsets.all(6),
                            color: index == controller.selectedIndex.value
                                ? verySoftBlueColor
                                : Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                controller.selectedIndex.value = index;
                                controller.animateToSlide(index);
                              },
                              child: Image.network(
                                controller.fetchedImages[index],
                                height: kIsWeb ? 100 : 50,
                                width: kIsWeb ? 100 : 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget buildImage(int index) {
  return Container(
    color: Colors.grey,
    child: Image.network(
      controller.fetchedImages[index],
      fit: BoxFit.fitWidth,
    ),
  );
}

Widget attachedPhotoDialog(String imgURL) {
  return SimpleDialog(
    contentPadding: EdgeInsets.zero,
    titlePadding: EdgeInsets.zero,
    children: [
      Container(
        decoration: const BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(
              Radius.circular(40),
            )),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        width: Get.width * .9,
        child: Container(
          color: Colors.white,
          child: Image.network(
            imgURL,
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
    ],
  );
}
