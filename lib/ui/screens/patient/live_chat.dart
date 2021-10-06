import 'dart:io';
import 'dart:ui';
import 'package:davnor_medicare/core/controllers/live_chat_controller.dart';
import 'package:davnor_medicare/core/controllers/live_cons_controller.dart';
import 'package:davnor_medicare/core/models/consultation_model.dart';
import 'package:davnor_medicare/ui/screens/patient/live_chat_info.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:davnor_medicare/core/models/chat_model.dart';
import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/constants/firebase.dart';

class LiveChatScreen extends StatelessWidget {
  static LiveConsController liveCont = Get.find();
  final LiveConsultationModel consData = Get.arguments as LiveConsultationModel;
  final LiveChatController liveChatCont = Get.put(LiveChatController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
          future: liveCont.getDoctorData(consData),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return liveConsScreen();
            }
            return const Scaffold(
                body: Center(child: CircularProgressIndicator()));
          }),
    );
  }

  Widget liveConsScreen() {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 1,
        title: Row(
          children: [
            Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: getPhoto(consData)),
            horizontalSpace10,
            Expanded(
              child: SizedBox(
                child: Text(
                  'Dr. ${liveCont.getDoctorFullName(consData)}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: subtitle18Medium.copyWith(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.info_outline,
              size: 30,
            ),
            onPressed: () => Get.to(() => LiveChatInfoScreen(),
                arguments: consData, transition: Transition.rightToLeft),
          ),
          horizontalSpace10,
        ],
      ),
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: StreamBuilder(
                    stream: liveChatCont.getLiveChatMessages(consData),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        return ListView.builder(
                          reverse: true,
                          padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
                          shrinkWrap: true,
                          itemCount: liveChatCont.liveChat.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                bubbleChat(liveChatCont.liveChat[index]),
                                verticalSpace15
                              ],
                            );
                          },
                        );
                      }
                      return const Center(child: Text('Loading ..'));
                    })),
            Align(
              alignment: FractionalOffset.bottomCenter,
              child: SizedBox(
                width: Get.width,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.attach_file,
                            color: kcInfoColor,
                          ),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.add_a_photo,
                            color: kcInfoColor,
                          ),
                          onPressed: liveChatCont.pickImageFromCamera,
                        ),
                        Expanded(
                          child: Obx(showMessage),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.send,
                            color: kcInfoColor,
                          ),
                          onPressed: liveChatCont.sendButton,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bubbleChat(ChatModel chat) {
    if (chat.senderID == auth.currentUser!.uid) {
      return rightBubbleChat(chat);
    }
    return leftBubbleChat(chat);
  }

  Widget leftBubbleChat(ChatModel chat) {
    if (chat.message!.startsWith('https://firebasestorage.googleapis.com/')) {
      //split >>> then if more than 1 ang length, -1 then display as grid
      return Row(
        children: [
          Flexible(
            child: Container(
                constraints: BoxConstraints(maxWidth: Get.width * .7),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: verySoftBlueColor[60],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
                child: Image.network(
                  chat.message!,
                  fit: BoxFit.cover,
                )),
          ),
        ],
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
              constraints: BoxConstraints(maxWidth: Get.width * .7),
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                color: neutralBubbleColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Text(
                chat.message!,
                style: body16Medium.copyWith(height: 1.4),
              )),
        ),
      ],
    );
  }

  Widget rightBubbleChat(ChatModel chat) {
    if (chat.message!.startsWith('https://firebasestorage.googleapis.com/')) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            child: Container(
                constraints: BoxConstraints(maxWidth: Get.width * .7),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: verySoftBlueColor[60],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
                child: Image.network(
                  chat.message!,
                  fit: BoxFit.cover,
                )),
          ),
        ],
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          child: Container(
              constraints: BoxConstraints(maxWidth: Get.width * .7),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: verySoftBlueColor[60],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              child: Text(
                chat.message!,
                style: body16Medium.copyWith(color: Colors.white, height: 1.4),
              )),
        ),
      ],
    );
  }

  Widget getPhoto(LiveConsultationModel model) {
    if (liveCont.getDoctorProfile(model) == '') {
      return CircleAvatar(
        radius: 25,
        backgroundImage: AssetImage(blankProfile),
      );
    }
    return CircleAvatar(
      radius: 25,
      backgroundImage: NetworkImage(liveCont.getDoctorProfile(model)),
    );
  }

  Widget showMessage() {
    if (liveChatCont.image.value.isNotEmpty) {
      return Container(
        height: 100,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFFA9A9A9),
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: SizedBox(
          width: 80,
          height: 80,
          child: Wrap(children: [
            Stack(
              children: [
                Image.file(
                  File(liveChatCont.image.value),
                  width: 80,
                  height: 80,
                  fit: BoxFit.fitWidth,
                ),
                Positioned(
                  right: 5,
                  top: 5,
                  child: InkWell(
                    onTap: liveChatCont.clearImage,
                    child: const Icon(
                      Icons.remove_circle,
                      size: 25,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ),
      );
    }
    /*else if (liveChatCont.image.value.isNotEmpty) {
      show images in grid
      scrollable
    }
    */
    return Container(
      constraints: const BoxConstraints(maxHeight: 100),
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        maxLines: null,
        controller: liveChatCont.chatController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
        ),
        onChanged: (value) {
          return;
        },
        onSaved: (value) => liveChatCont.chatController.text = value!,
      ),
    );
  }
}
