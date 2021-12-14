import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/core/controllers/live_chat_controller.dart';
import 'package:davnor_medicare/core/controllers/live_cons_controller.dart';
import 'package:davnor_medicare/core/controllers/patient/menu_controller.dart';
import 'package:davnor_medicare/core/models/chat_model.dart';
import 'package:davnor_medicare/core/models/consultation_model.dart';
import 'package:davnor_medicare/routes/app_pages.dart';
import 'package:davnor_medicare/ui/screens/patient_web/helpers/local_navigator.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/widgets/bubble_chat.dart';
import 'package:davnor_medicare/ui/widgets/chat_input.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LiveConsWebScreen extends StatefulWidget {
  @override
  State<LiveConsWebScreen> createState() => _LiveConsWebScreenState();
}

class _LiveConsWebScreenState extends State<LiveConsWebScreen> {
  final PatientMenuController menuController = Get.find();
  static AuthController authController = Get.find();
  final LiveChatController liveChatCont = Get.put(LiveChatController());
  final fetchedData = authController.patientModel.value;
  final LiveConsController liveCont = Get.find();
  final _scrollController1 = ScrollController();
  final _scrollController2 = ScrollController();

  @override
  void initState() {
    super.initState();
    liveCont.doneFetching.value = false;
    ever(liveCont.liveCons, (value) {
      if (liveCont.liveCons.isEmpty) {
        menuController.changeActiveItemTo('Dashboard');
        navigationController.navigateTo(Routes.PATIENT_WEB_HOME);
      }
    });
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
                      future: liveCont.getDoctorData(liveCont.liveCons[0]),
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
              'Dr. ${liveCont.getDoctorFullName(liveCons)}',
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              style: subtitle18Medium,
              textAlign: TextAlign.center,
            ),
            verticalSpace5,
            Text(
              liveCons.doc.value!.title!,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: body14Regular.copyWith(color: const Color(0xFF727F8D)),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text('livechat'.tr,
                      textAlign: TextAlign.left,
                      style: body16Regular.copyWith(
                          color: const Color(0xFF727F8D))),
                  verticalSpace20,
                  Wrap(
                    runSpacing: 8,
                    children: [
                      SizedBox(
                        width: 170,
                        child: Text('chat1'.tr,
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
                      SizedBox(
                        width: 170,
                        child: Text('chat2'.tr,
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
                      SizedBox(
                        width: 170,
                        child: Text('chat3'.tr,
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
                      SizedBox(
                        width: 170,
                        child: Text('chat4'.tr,
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
          mainAxisAlignment: MainAxisAlignment.center,
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
                  'Dr. ${liveCont.getDoctorFullName(liveCont.liveCons[0])}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: subtitle18Medium.copyWith(color: Colors.black),
                ),
              ],
            ),
            Spacer(),
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
                  if (snapshot.hasError) {
                    return const Center(
                        child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(),
                    ));
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
    );
  }

  Widget getPhoto(LiveConsultationModel model) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Image.network(
        liveCont.getDoctorProfile(model),
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
                  '${liveCont.getDoctorFirstName(model)[0]}',
                  style: title24Regular.copyWith(color: Colors.white),
                ),
              ));
        },
      ),
    );
  }

  Widget getPhotoInfo(LiveConsultationModel model) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: Image.network(
        liveCont.getDoctorProfile(model),
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
                  '${liveCont.getDoctorFirstName(model)[0]}',
                  style: title36Regular.copyWith(color: Colors.white),
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
}
