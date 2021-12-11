import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/core/controllers/calling_patient_controller.dart';
import 'package:davnor_medicare/core/controllers/cons_history_controller.dart';
import 'package:davnor_medicare/core/controllers/doctor/consultations_controller.dart';
import 'package:davnor_medicare/core/controllers/doctor/menu_controller.dart';
import 'package:davnor_medicare/core/controllers/live_chat_controller.dart';
import 'package:davnor_medicare/core/controllers/live_cons_controller.dart';
import 'package:davnor_medicare/core/controllers/attached_photos_controller.dart';
import 'package:davnor_medicare/core/models/chat_model.dart';
import 'package:davnor_medicare/core/models/consultation_model.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:davnor_medicare/routes/app_pages.dart';
import 'package:davnor_medicare/ui/screens/doctor/calling.dart';
import 'package:davnor_medicare/ui/screens/doctor_web/helpers/local_navigator.dart';
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

class LiveConsultationWeb extends StatefulWidget {
  static AuthController authController = Get.find();

  @override
  State<LiveConsultationWeb> createState() => _LiveConsultationWebState();
}

class _LiveConsultationWebState extends State<LiveConsultationWeb> {
  final AttachedPhotosController controller = Get.find();
  final ConsHistoryController consHController = Get.find();
  final LiveConsController liveCont = Get.find();
  final LiveChatController liveChatCont = Get.put(LiveChatController());
  final fetchedData = LiveConsultationWeb.authController.doctorModel.value;
  final CallingPatientController callController =
      Get.put(CallingPatientController());
  final ConsultationsController consRequests = Get.find();
  final DoctorMenuController menuController = Get.find();
  final RxBool errorPhoto = false.obs;
  final RxBool errorPhoto2 = false.obs;
  final _scrollController1 = ScrollController();
  final _scrollController2 = ScrollController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    liveCont.doneFetching.value = false;
    super.initState();
  }

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
    return SingleChildScrollView(
      controller: _scrollController2,
      child: Column(children: <Widget>[
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
                    context: context,
                    builder: (context) => skipDialog(liveCons));
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
                      style: body16Regular.copyWith(
                          color: const Color(0xFF727F8D))),
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
            verticalSpace15
          ],
        ),
      ]),
    );
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
            child: StreamBuilder<QuerySnapshot>(
                stream: liveChatCont.getLiveChatMessages(liveCont.liveCons[0]),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError || !snapshot.hasData) {
                    return Text('Something went wrong');
                  } else if (snapshot.hasData) {
                    return ListView(
                      controller: _scrollController1,
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
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Image.network(
        liveCont.getPatientProfile(model),
        fit: BoxFit.cover,
        height: 50,
        width: 50,
        errorBuilder: (context, error, stackTrace) {
          return Container(
              height: 50,
              width: 50,
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
                  onPressed: () {
                    liveChatCont.sendButtonWeb();
                  }),
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
      onYesTap: () async {
        await liveCont.endConsultation(liveCont.liveCons[0]);
        menuController.changeActiveItemTo('Dashboard');
        navigationController.navigateTo(Routes.DOC_WEB_HOME);
        consHController.refreshD();
        consRequests.selectedIndex.value = 0;
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
          child: Form(
            key: formKey,
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
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            await liveCont.skipConsultation(
                              consData.consID!,
                              consData.patientID!,
                            );
                            formKey.currentState!.reset();
                            liveCont.reason.clear();
                            menuController.changeActiveItemTo('Dashboard');
                            navigationController
                                .navigateTo(Routes.DOC_WEB_HOME);
                            consRequests.selectedIndex.value = 0;
                          }
                        },
                        text: 'Submit')),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget getPhotoInfo(LiveConsultationModel model) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: Image.network(
        liveCont.getPatientProfile(model),
        fit: BoxFit.cover,
        height: 100,
        width: 100,
        errorBuilder: (context, error, stackTrace) {
          return Container(
              height: 100,
              width: 100,
              color: verySoftBlueColor[100],
              child: Center(
                child: Text(
                  '${liveCont.getPatientFirstName(model)[0]}',
                  style: title36Regular.copyWith(color: Colors.white),
                ),
              ));
        },
      ),
    );
  }
}
