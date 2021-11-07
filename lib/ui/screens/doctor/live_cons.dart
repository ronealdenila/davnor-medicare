import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/live_chat_controller.dart';
import 'package:davnor_medicare/core/controllers/live_cons_controller.dart';
import 'package:davnor_medicare/core/models/consultation_model.dart';
import 'package:davnor_medicare/ui/screens/doctor/calling.dart';
import 'package:davnor_medicare/ui/screens/doctor/live_cons_info.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/widgets/chat_input.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/ui/widgets/bubble_chat.dart';

class LiveConsultationScreen extends StatelessWidget {
  static LiveConsController liveCont = Get.find();
  final LiveConsultationModel consData = Get.arguments as LiveConsultationModel;
  final LiveChatController liveChatCont = Get.put(LiveChatController());

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
                body: Center(
                    child: SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator())));
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
            onPressed: () async {
              await callPatient();
            },
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
                                bubbleChat(
                                  liveChatCont.liveChat[index],
                                ),
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
              child: chatStack(),
            ),
          ],
        ),
      ),
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

  Widget chatStack() {
    return SizedBox(
      width: Get.width,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                child: Obx(() => chatInput(liveChatCont)),
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
    );
  }

  Future<void> callPatient() async {
    await firestore
        .collection('patients')
        .doc('WZbt7uQkDNd53rT3yhW1MumSIBN2')
        //.doc(consData.patientID)
        .collection('incomingCall')
        .doc('value')
        .update({
      'isCalling': true,
      'didReject': false,
      'patientJoined': false
    }).then((value) => Get.to(() => CallPatientScreen()));
  }
}
