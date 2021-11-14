import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/core/controllers/calling_patient_controller.dart';
import 'package:davnor_medicare/core/controllers/cons_history_controller.dart';
import 'package:davnor_medicare/core/controllers/live_chat_controller.dart';
import 'package:davnor_medicare/core/controllers/live_cons_controller.dart';
import 'package:davnor_medicare/core/controllers/pswd/attached_photos_controller.dart';
import 'package:davnor_medicare/core/models/consultation_model.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:davnor_medicare/ui/screens/doctor/calling.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/widgets/bubble_chat.dart';
import 'package:davnor_medicare/ui/widgets/chat_input.dart';
import 'package:davnor_medicare/ui/widgets/custom_button.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LiveConsultationWeb extends StatelessWidget {
  final AttachedPhotosController controller = Get.find();
  final ConsHistoryController consHController =
      Get.put(ConsHistoryController());
  static LiveConsController liveCont = Get.find();
  final LiveChatController liveChatCont = Get.put(LiveChatController());
  static AuthController authController = Get.find();
  final fetchedData = authController.doctorModel.value;
  final CallingPatientController callController =
      Get.put(CallingPatientController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 7,
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Color(0xFFCBD4E1),
                      ),
                      right: BorderSide(
                        color: Color(0xFFCBD4E1),
                      ),
                    ),
                  ),
                  child: FutureBuilder(
                      future: liveCont.getPatientData(liveCont.liveCons[0]),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return liveConsScreen();
                        }
                        return Center(
                            child: SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator()));
                      }),
                )),
            Expanded(
                flex: 3,
                child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Color(0xFFCBD4E1),
                        ),
                      ),
                    ),
                    height: Get.height,
                    width: Get.width * .2,
                    child: Obx(() => liveCont.doneFetching.value &&
                            liveCont.liveCons.isNotEmpty
                        ? RequestsInfoView(context, liveCont.liveCons[0])
                        : SizedBox())))
          ],
        ),
      ),
    );
  }

  Widget RequestsInfoView(
      BuildContext context, LiveConsultationModel liveCons) {
    return Column(children: <Widget>[
      Container(
        width: Get.width,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color(0xFFCBD4E1),
            ),
          ),
        ),
        child: Column(children: <Widget>[
          verticalSpace15,
          Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              child: getPhotoInfo(liveCons)),
          verticalSpace15,
          Text(
            liveCont.getPatientName(liveCons),
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: subtitle18Medium,
            textAlign: TextAlign.center,
          ),
          verticalSpace25
        ]),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpace35,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: const Text('Actions',
                textAlign: TextAlign.left, style: body16Regular),
          ),
          InkWell(
            onTap: () {
              confirmationDialog();
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              width: Get.width,
              child: const Text('End Consultation',
                  textAlign: TextAlign.left, style: subtitle18Medium),
            ),
          ),
          InkWell(
            onTap: () {
              showDialog(
                  context: context, builder: (context) => skipDialog(liveCons));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              width: Get.width,
              child: const Text('Skip Consultation',
                  textAlign: TextAlign.left, style: subtitle18Medium),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text('Consultation Info',
                    textAlign: TextAlign.left,
                    style:
                        body16Regular.copyWith(color: const Color(0xFF727F8D))),
                verticalSpace20,
                Wrap(
                  runSpacing: 8,
                  children: [
                    const SizedBox(
                      width: 170,
                      child: Text('Patient',
                          textAlign: TextAlign.left, style: body14SemiBold),
                    ),
                    SizedBox(
                      width: 200,
                      child: Text(liveCons.fullName!,
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: body14Regular),
                    ),
                  ],
                ),
                verticalSpace15,
                Wrap(
                  runSpacing: 8,
                  children: [
                    const SizedBox(
                      width: 170,
                      child: Text('Age of Patient',
                          textAlign: TextAlign.left, style: body14SemiBold),
                    ),
                    SizedBox(
                      width: 200,
                      child: Text('${liveCons.age!}',
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: body14Regular),
                    ),
                  ],
                ),
                verticalSpace15,
                Wrap(
                  runSpacing: 8,
                  children: [
                    const SizedBox(
                      width: 170,
                      child: Text('Date Requested',
                          textAlign: TextAlign.left, style: body14SemiBold),
                    ),
                    SizedBox(
                      width: 200,
                      child: Text(
                          liveCont.convertTimeStamp(liveCons.dateRqstd!),
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: body14Regular),
                    ),
                  ],
                ),
                verticalSpace15,
                Wrap(
                  runSpacing: 8,
                  children: [
                    const SizedBox(
                      width: 170,
                      child: Text('Consultation Started',
                          textAlign: TextAlign.left, style: body14SemiBold),
                    ),
                    SizedBox(
                      width: 200,
                      child: Text(
                          liveCont.convertTimeStamp(liveCons.dateConsStart!),
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: body14Regular),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ]);
  }

  Widget topHeaderRequestWeb() {
    return Align(
      alignment: FractionalOffset.topCenter,
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color(0xFFCBD4E1),
            ),
          ),
        ),
        width: Get.width,
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            Row(
              children: [
                Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: getPhoto(liveCont.liveCons[0])),
                horizontalSpace15,
                Text(
                  liveCont.getPatientName(liveCont.liveCons[0]),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: subtitle18Medium.copyWith(color: Colors.black),
                ),
              ],
            ),
            Spacer(),
            StreamBuilder<DocumentSnapshot>(
                stream: firestore
                    .collection('patients')
                    .doc(liveCont.liveCons[0].patientID)
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
                        showErrorDialog(
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
                        showErrorDialog(
                            errorDescription:
                                'Patient is currently on a video call, please try again later');
                      } else {
                        await callPatient();
                      }
                    },
                  );
                }),
            horizontalSpace20,
          ],
        ),
      ),
    );
  }

  Widget liveConsScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        topHeaderRequestWeb(),
        Expanded(
            child: StreamBuilder(
                stream: liveChatCont.getLiveChatMessages(liveCont.liveCons[0]),
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
                            bubbleChat(liveChatCont.liveChat[index], context),
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
              Expanded(
                child: Obx(() => chatInput(
                      liveChatCont,
                    )),
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
        .doc(liveCont.liveCons[0].patientID)
        .collection('incomingCall')
        .doc('value')
        .update({
      'from': 'doctor',
      'isCalling': true,
      'didReject': false,
      'channelId': liveCont.liveCons[0].consID,
      'callerName': 'Dr. ${fetchedData!.lastName!} (${fetchedData!.title!})'
    }).then((value) => Get.to(() => CallPatientScreen(), arguments: [
              liveCont.liveCons[0].patientID,
              liveCont.liveCons[0].consID,
              liveCont.liveCons[0].patient.value!.profileImage,
              liveCont.getPatientName(liveCont.liveCons[0])
            ]));
  }

  void confirmationDialog() {
    return showConfirmationDialog(
      dialogTitle: 'Is the consultation done?',
      dialogCaption:
          'Select YES if you want to end the consultation. Otherwise, select NO',
      onYesTap: () {
        liveCont.endConsultation(liveCont.liveCons[0]);
      },
      onNoTap: () => dismissDialog(),
    );
  }

  Widget skipDialog(LiveConsultationModel consData) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      clipBehavior: Clip.antiAlias,
      contentPadding: const EdgeInsets.symmetric(
          vertical: kIsWeb ? 30 : 20, horizontal: kIsWeb ? 50 : 25),
      children: [
        SizedBox(
          width: kIsWeb ? Get.width * .45 : Get.width * .7,
          child: Column(
            children: [
              Text(
                'To inform the patient',
                style: kIsWeb ? title32Regular : title20Regular,
              ),
              verticalSpace10,
              const Text(
                'Please specify the reason',
                style: body14Regular,
              ),
              kIsWeb ? verticalSpace50 : verticalSpace25,
              TextFormField(
                  controller: liveCont.reason,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'This is a required field';
                    }
                    //! if we want to validate na dapat taas ang words
                    // if (value.length < 10) {
                    //   return 'Description must be at least 10 words';
                    // }
                  },
                  decoration: const InputDecoration(
                    labelText: 'Enter the reason here',
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                  ),
                  maxLines: 10,
                  keyboardType: TextInputType.multiline,
                  onChanged: (value) {
                    return;
                  },
                  onSaved: (value) {
                    liveCont.reason.text = value!;
                  }),
              kIsWeb ? verticalSpace25 : verticalSpace15,
              Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomButton(
                      buttonColor: verySoftBlueColor,
                      onTap: () => liveCont.skipConsultation(
                            consData.consID!,
                            consData.patientID!,
                          ),
                      //'Cons_Request/${consData.patientID!}/cons_req/${consData.consID!}/'),
                      text: 'Submit')),
            ],
          ),
        )
      ],
    );
  }

  Widget getPhotoInfo(LiveConsultationModel model) {
    if (liveCont.getPatientProfile(model) == '') {
      return CircleAvatar(
        radius: 50,
        backgroundImage: AssetImage(blankProfile),
      );
    }
    return CircleAvatar(
      radius: 50,
      backgroundImage: NetworkImage(liveCont.getPatientProfile(model)),
    );
  }
}
