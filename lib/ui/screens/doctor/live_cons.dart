import 'dart:io';
import 'dart:ui';
import 'package:davnor_medicare/core/controllers/live_chat_controller.dart';
import 'package:davnor_medicare/core/controllers/live_cons_controller.dart';
import 'package:davnor_medicare/core/models/consultation_model.dart';
import 'package:davnor_medicare/ui/screens/doctor/live_cons_info.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:davnor_medicare/core/models/chat_model.dart';
import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/constants/firebase.dart';

class LiveConsultationScreen extends StatelessWidget {
  static LiveConsController liveCont = Get.find();
  final LiveConsultationModel consData = Get.arguments as LiveConsultationModel;
  final LiveChatController liveChatCont = Get.put(LiveChatController());
  RxList<String> displayImages = RxList<String>([]);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
          future: liveCont.getPatientData(consData),
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
            horizontalSpace15,
            Expanded(
              child: SizedBox(
                child: Text(
                  liveCont.getPatientName(consData),
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
              Icons.videocam_outlined,
              size: 30,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.info_outline,
              size: 30,
            ),
            onPressed: () => Get.to(() => LiveConsInfoScreen(),
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
                      return const Text('Loading ..');
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
                          onPressed: liveChatCont.pickMultiImage,
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
      displayImages.value = chat.message!.split('>>>');
      if (displayImages.length == 1) {
        //display single image
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
      } else {
        //display multiple image
        displayImages.removeLast();
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
                child: GridView.count(
                  shrinkWrap: true,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  crossAxisCount:
                      displayImages.length < 3 ? displayImages.length : 3,
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
    if (liveCont.getPatientProfile(model) == '') {
      return CircleAvatar(
        radius: 25,
        backgroundImage: AssetImage(blankProfile),
      );
    }
    return CircleAvatar(
      radius: 25,
      backgroundImage: NetworkImage(liveCont.getPatientProfile(model)),
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
    } else if (liveChatCont.images.isNotEmpty) {
      return Container(
        height: (liveChatCont.images.length < 3) ? 100 : 170,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFFA9A9A9),
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Center(
          child: GridView.count(
            shrinkWrap: true,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            crossAxisCount: 3,
            children: List.generate(liveChatCont.images.length, (index) {
              return Container(
                height: 68.5,
                color: verySoftBlueColor,
                child: Center(
                  child: Wrap(children: [
                    Stack(
                      children: [
                        Image.file(
                          File(liveChatCont.images[index].path),
                          fit: BoxFit.fill,
                          height: 68.5,
                        ),
                        Positioned(
                          right: 5,
                          top: 5,
                          child: InkWell(
                            onTap: () {
                              liveChatCont.images
                                  .remove(liveChatCont.images[index]);
                            },
                            child: const Icon(
                              Icons.remove_circle,
                              size: 20,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]),
                ),
              );
            }),
          ),
        ),
      );
    }
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
