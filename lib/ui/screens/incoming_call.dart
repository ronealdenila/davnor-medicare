import 'dart:io';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/core/controllers/status_controller.dart';
import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jitsi_meet/jitsi_meet.dart';

class CallSession extends StatefulWidget {
  @override
  State<CallSession> createState() => _CallSessionState();
}

class _CallSessionState extends State<CallSession> {
  static AuthController authController = Get.find();
  final fetchedData = authController.patientModel.value!;
  final StatusController stats = Get.find();
  final serverText = TextEditingController();
  final RxBool callAccepted = false.obs;
  final RxString subj = "".obs;

  @override
  void initState() {
    super.initState();
    JitsiMeet.closeMeeting();
    callAccepted.value = false;
    JitsiMeet.addListener(JitsiMeetingListener(
        onConferenceWillJoin: _onConferenceWillJoin,
        onConferenceJoined: _onConferenceJoined,
        onConferenceTerminated: _onConferenceTerminated,
        onError: _onError));
    ever(stats.incCall, (value) {
      if (!stats.incCall[0].isCalling!) {
        JitsiMeet.closeMeeting();
      }
    });
    subj.value = stats.incCall[0].from == 'doctor'
        ? 'Virtual Consultation'
        : 'PSWD Interview';
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
        body: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Center(
            child: kIsWeb
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(() => callAccepted.value
                          ? Padding(
                              padding: const EdgeInsets.only(right: 50),
                              child: webConfig(),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(right: 50),
                              child: meetConfig(),
                            )),
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
      ),
    );
  }

  Future<bool> _onBackPressed() {
    if (callAccepted.value) {
      showSimpleErrorDialog(errorDescription: 'errordialog17'.tr); //TRANSLATE
    } else {
      showSimpleErrorDialog(errorDescription: 'errordialog14'.tr);
    }
    return false as Future<bool>;
  }

  Widget meetConfig() {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80,
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
                      child: Icon(Icons.call_rounded,
                          color: Colors.white, size: 40),
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
      ),
    );
  }

  Widget webConfig() {
    return SingleChildScrollView(
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () async {
                await endCall(auth.currentUser!.uid);
                JitsiMeet.closeMeeting();
              },
              icon: Icon(
                Icons.arrow_back_outlined,
                size: 30,
              )),
          verticalSpace25,
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 130,
              height: 130,
              child: Image.asset(
                logo,
                fit: BoxFit.cover,
              ),
            ),
          ),
          verticalSpace20,
          Text(
            subj.value,
            style: body16Regular,
          ),
        ],
      )),
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
      FeatureFlagEnum.INVITE_ENABLED: false,
      FeatureFlagEnum.RAISE_HAND_ENABLED: false,
      FeatureFlagEnum.TOOLBOX_ALWAYS_VISIBLE: true,
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
    var options = JitsiMeetingOptions(room: stats.incCall[0].channelId!)
      ..serverURL = serverUrl
      ..subject = subj.value
      ..userDisplayName = '${fetchedData.firstName} ${fetchedData.lastName}'
      ..userAvatarURL = '${fetchedData.profileImage}'
      ..audioOnly = false
      ..audioMuted = false
      ..videoMuted = false
      ..featureFlags.addAll(featureFlags)
      ..webOptions = {
        "roomName": stats.incCall[0].channelId!,
        "width": "100%",
        "height": "100%",
        "enableWelcomePage": false,
        "chromeExtensionBanner": null,
        "userInfo": {
          "displayName": '${fetchedData.firstName} ${fetchedData.lastName}'
        },
        "configOverwrite": {
          "prejoinPageEnabled": false,
        },
        "interfaceConfigOverwrite": {
          "TOOLBAR_BUTTONS": [
            "microphone",
            "camera",
            "fullscreen",
            "hangup",
          ]
        },
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
            _onConferenceTerminated(message);
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
    await endCall(auth.currentUser!.uid);
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
    });
  }

  _onError(error) {
    debugPrint("_onError broadcasted: $error");
  }
}
