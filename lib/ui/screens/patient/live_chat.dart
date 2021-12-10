import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/core/controllers/live_chat_controller.dart';
import 'package:davnor_medicare/core/controllers/live_cons_controller.dart';
import 'package:davnor_medicare/core/models/chat_model.dart';
import 'package:davnor_medicare/core/models/consultation_model.dart';
import 'package:davnor_medicare/ui/screens/patient/home.dart';
import 'package:davnor_medicare/ui/screens/patient/live_chat_info.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/widgets/bubble_chat.dart';
import 'package:davnor_medicare/ui/widgets/chat_input.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LiveChatScreen extends StatefulWidget {
  @override
  State<LiveChatScreen> createState() => _LiveChatScreenState();
}

class _LiveChatScreenState extends State<LiveChatScreen> {
  final LiveConsultationModel consData = Get.arguments as LiveConsultationModel;
  final LiveChatController liveChatCont = Get.put(LiveChatController());
  final LiveConsController liveCont = Get.find();

  @override
  void initState() {
    super.initState();
    ever(liveCont.liveCons, (value) {
      if (liveCont.liveCons.isEmpty) {
        Get.offAll(() => PatientHomeScreen());
      }
    });
  }

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
              child: Text(
                'Dr. ${liveCont.getDoctorFullName(consData)}',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: subtitle18Medium.copyWith(color: Colors.black),
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
                child: StreamBuilder<QuerySnapshot>(
                    stream:
                        liveChatCont.getLiveChatMessages(liveCont.liveCons[0]),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong');
                      }
                      if (snapshot.connectionState == ConnectionState.active) {
                        return ListView(
                          reverse: true,
                          padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
                          shrinkWrap: true,
                          children: snapshot.data!.docs.map((item) {
                            Map<String, dynamic> data =
                                item.data()! as Map<String, dynamic>;
                            if (data['dateCreated'] == null) {
                              return SizedBox(
                                width: 0,
                                height: 0,
                              );
                            }
                            ChatModel model = ChatModel.fromJson(
                                item.data()! as Map<String, dynamic>);
                            return Column(
                              children: [
                                bubbleChat(model, context),
                                verticalSpace15
                              ],
                            );
                          }).toList(),
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
    return ClipRRect(
      borderRadius: BorderRadius.circular(55),
      child: Image.network(
        liveCont.getDoctorProfile(model),
        fit: BoxFit.cover,
        height: 55,
        width: 55,
        errorBuilder: (context, error, stackTrace) {
          return Container(
              height: 55,
              width: 55,
              color: verySoftBlueColor[100],
              child: Center(
                child: Text(
                  '${liveCont.getDoctorFirstName(model)[0]}',
                  style: title24Regular.copyWith(color: Colors.white),
                ),
              ));
        },
      ),
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
                  onPressed: () {
                    liveChatCont.sendButton();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
