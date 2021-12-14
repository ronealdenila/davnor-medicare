import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/core/controllers/calling_patient_controller.dart';
import 'package:davnor_medicare/core/controllers/live_chat_controller.dart';
import 'package:davnor_medicare/core/controllers/live_cons_controller.dart';
import 'package:davnor_medicare/core/controllers/attached_photos_controller.dart';
import 'package:davnor_medicare/core/models/chat_model.dart';
import 'package:davnor_medicare/core/models/consultation_model.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:davnor_medicare/ui/screens/doctor/calling.dart';
import 'package:davnor_medicare/ui/screens/doctor/live_cons_info.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/widgets/chat_input.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:davnor_medicare/ui/widgets/bubble_chat.dart';

class LiveConsultationScreen extends StatelessWidget {
  static LiveConsController liveCont = Get.find();
  final LiveConsultationModel consData = Get.arguments as LiveConsultationModel;
  final LiveChatController liveChatCont = Get.put(LiveChatController());
  static AuthController authController = Get.find();
  final fetchedData = authController.doctorModel.value;
  final AttachedPhotosController controller = Get.find();
  final CallingPatientController callController =
      Get.put(CallingPatientController());

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
              child: Text(
                liveCont.getPatientName(consData),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: subtitle18Medium.copyWith(color: Colors.black),
              ),
            ),
          ],
        ),
        actions: [
          StreamBuilder<DocumentSnapshot>(
              stream: firestore
                  .collection('patients')
                  .doc(consData.patientID)
                  .collection('incomingCall')
                  .doc('value')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError || !snapshot.hasData) {
                  return IconButton(
                    icon: const Icon(
                      Icons.videocam_outlined,
                      size: 30,
                    ),
                    onPressed: () async {
                      showSimpleErrorDialog(
                          errorDescription: 'Something went wrong');
                    },
                  );
                }
                final data = snapshot.data!.data() as Map<String, dynamic>;
                return IconButton(
                  icon: const Icon(
                    Icons.videocam_outlined,
                    size: 30,
                  ),
                  onPressed: () async {
                    if (data['patientJoined'] && data['otherJoined']) {
                      showSimpleErrorDialog(
                          errorDescription:
                              'Patient is currently on a video call, please try again later');
                    } else {
                      await callPatient();
                    }
                  },
                );
              }),
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
                child: StreamBuilder<QuerySnapshot>(
                    stream: liveChatCont.getLiveChatMessages(consData),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return const Center(
                            child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(),
                        ));
                      } else if (snapshot.hasData) {
                        return ListView(
                          reverse: true,
                          padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
                          shrinkWrap: true,
                          children: snapshot.data!.docs.map((item) {
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
                      return const Center(
                          child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(),
                      ));
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
        liveCont.getPatientProfile(model),
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
                  '${liveCont.getPatientFirstName(model)[0]}',
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
                },
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
        .doc(consData.patientID)
        .collection('incomingCall')
        .doc('value')
        .update({
      'from': 'doctor',
      'isCalling': true,
      'didReject': false,
      'channelId': consData.consID,
      'callerName': 'Dr. ${fetchedData!.lastName!} (${fetchedData!.title!})'
    }).then((value) => Get.to(() => CallPatientScreen(), arguments: [
              consData.patientID,
              consData.consID,
              consData.patient.value!.profileImage,
              liveCont.getPatientName(consData)
            ]));
  }
}
