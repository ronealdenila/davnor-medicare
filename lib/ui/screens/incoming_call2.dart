import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/core/controllers/live_cons_controller.dart';
import 'package:davnor_medicare/core/controllers/status_controller.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'dart:io' show Platform;

class IncomingCallPatientScreen2 extends StatefulWidget {
  //PATIENT
  @override
  State<IncomingCallPatientScreen2> createState() =>
      _IncomingCallPatientScreenState2();
}

class _IncomingCallPatientScreenState2
    extends State<IncomingCallPatientScreen2> {
  static AuthController authController = Get.find();
  final LiveConsController liveCont = Get.find();
  final StatusController stats = Get.find();
  final serverText = TextEditingController();
  final nameText = authController.patientModel.value!.email!;
  final emailText = authController.patientModel.value!.email!;
  final RxBool callAccepted = false.obs;

  @override
  void initState() {
    super.initState();
    JitsiMeet.addListener(JitsiMeetingListener(
        onConferenceWillJoin: _onConferenceWillJoin,
        onConferenceJoined: _onConferenceJoined,
        onConferenceTerminated: _onConferenceTerminated,
        onError: _onError));
  }

  @override
  void dispose() {
    super.dispose();
    JitsiMeet.removeAllListeners();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Incoming Call',
            style: subtitle18Medium.copyWith(color: Colors.black),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: kIsWeb
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: Get.width * 0.30,
                      child: meetConfig(),
                    ),
                    Container(
                        width: Get.width * 0.60,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                              color: Colors.white54,
                              child: SizedBox(
                                width: Get.width * 0.60 * 0.70,
                                height: Get.width * 0.60 * 0.70,
                                child: JitsiMeetConferencing(
                                  extraJS: [
                                    // extraJs setup example
                                    '<script>function echo(){console.log("echo!!!")};</script>',
                                    '<script src="https://code.jquery.com/jquery-3.5.1.slim.js" integrity="sha256-DrT5NfxfbHvMHux31Lkhxg42LY6of8TaYyK50jnxRnM=" crossorigin="anonymous"></script>'
                                  ],
                                ),
                              )),
                        ))
                  ],
                )
              : meetConfig(),
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() {
    if (callAccepted.value) {
      print('Please end the call first'); //TRANSLATE
    } else {
      showSimpleErrorDialog(errorDescription: 'errordialog14'.tr);
    }
    return false as Future<bool>;
  }

  Widget meetConfig() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: kIsWeb ? 250 : 80,
            backgroundImage: AssetImage(
                stats.incCall[0].from == 'doctor' ? doctorDefault : maImage),
          ),
          verticalSpace35,
          Text(
            '${stats.incCall[0].callerName}',
            style: subtitle18Medium,
          ),
          verticalSpace5,
          Text(
            'is calling....',
            style: body16Regular,
          ),
          verticalSpace50,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await acceptCall();
                    },
                    child:
                        Icon(Icons.call_rounded, color: Colors.white, size: 40),
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(12),
                      primary: Color(0xFF11d87b),
                    ),
                  ),
                  verticalSpace5,
                  Text('Accept')
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await rejectCall(); //clear data except from
                    },
                    child: Icon(Icons.close_rounded,
                        color: Colors.white, size: 40),
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(12),
                      primary: Colors.red,
                    ),
                  ),
                  verticalSpace5,
                  Text('Reject'),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Future<void> acceptCall() async {
    await firestore
        .collection('patients')
        .doc(auth.currentUser!.uid)
        .collection('incomingCall')
        .doc('value')
        .update({
      'patientJoined': true,
    }).then((value) async {
      callAccepted.value = true;
      await _joinMeeting();
    });
  }

  Future<void> rejectCall() async {
    await firestore
        .collection('patients')
        .doc(auth.currentUser!.uid)
        .collection('incomingCall')
        .doc('value')
        .update({
      'isCalling': false,
      'didReject': true,
      'patientJoined': false,
      'otherJoined': false,
      'channelId': '',
      'callerName': ''
    }).then((value) {
      Get.back();
      callAccepted.value = false;
      JitsiMeet.closeMeeting();
    });
  }

  _joinMeeting() async {
    print('clicked join');
    String? serverUrl = serverText.text.trim().isEmpty ? null : serverText.text;

    // Enable or disable any feature flag here
    // If feature flag are not provided, default values will be used
    // Full list of feature flags (and defaults) available in the README
    Map<FeatureFlagEnum, bool> featureFlags = {
      FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
      FeatureFlagEnum.RECORDING_ENABLED: false,
      FeatureFlagEnum.LIVE_STREAMING_ENABLED: false,
      FeatureFlagEnum.CLOSE_CAPTIONS_ENABLED: false,
      FeatureFlagEnum.CHAT_ENABLED: false,
      FeatureFlagEnum.MEETING_PASSWORD_ENABLED: false,
      FeatureFlagEnum.CALENDAR_ENABLED: false,
    };
    if (!kIsWeb) {
      // Here is an example, disabling features for each platform
      if (Platform.isAndroid) {
        // Disable ConnectionService usage on Android to avoid issues (see README)
        featureFlags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
      }
    } // Define meetings options here
    var options = JitsiMeetingOptions(room: liveCont.liveCons[0].consID!)
      ..serverURL = serverUrl
      ..subject = "Virtual Consultation"
      ..userDisplayName = nameText
      ..userEmail = emailText
      ..audioOnly = false
      ..audioMuted = false
      ..videoMuted = false
      ..featureFlags.addAll(featureFlags)
      ..webOptions = {
        "roomName": "Virtual Consultation",
        "width": "100%",
        "height": "100%",
        "enableWelcomePage": false,
        "chromeExtensionBanner": null,
        "userInfo": {"displayName": nameText}
      };

    debugPrint("JitsiMeetingOptions: $options");
    await JitsiMeet.joinMeeting(
      options,
      listener: JitsiMeetingListener(
          onConferenceWillJoin: (message) {
            debugPrint("${options.room} will join with message: $message");
          },
          onConferenceJoined: (message) {
            debugPrint("${options.room} joined with message: $message");
          },
          onConferenceTerminated: (message) {
            debugPrint("${options.room} terminated with message: $message");
          },
          genericListeners: [
            JitsiGenericListener(
                eventName: 'readyToClose',
                callback: (dynamic message) {
                  debugPrint("readyToClose callback");
                }),
          ]),
    );
  }

  void _onConferenceWillJoin(message) {
    debugPrint("_onConferenceWillJoin broadcasted with message: $message");
  }

  void _onConferenceJoined(message) {
    debugPrint("_onConferenceJoined broadcasted with message: $message");
  }

  void _onConferenceTerminated(message) async {
    debugPrint("_onConferenceTerminated broadcasted with message: $message");
    await endCall(liveCont.liveCons[0].patientID!);
    JitsiMeet.closeMeeting();
  }

  Future<void> endCall(String patientId) async {
    await firestore
        .collection('patients')
        .doc(patientId)
        .collection('incomingCall')
        .doc('value')
        .update({
      'isCalling': false,
      'didReject': false,
      'patientJoined': false,
      'otherJoined': false,
      'channelId': '',
      'callerName': '',
      'from': ''
    }).then((value) => Get.back());
  }

  _onError(error) {
    debugPrint("_onError broadcasted: $error");
  }
}
