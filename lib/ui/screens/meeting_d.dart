import 'dart:io';
import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/core/controllers/calling_patient_controller.dart';
import 'package:davnor_medicare/core/controllers/live_cons_controller.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jitsi_meet/jitsi_meet.dart';

class Meeting extends StatefulWidget {
  @override
  _MeetingState createState() => _MeetingState();
}

class _MeetingState extends State<Meeting> {
  static AuthController authController = Get.find();
  final serverText = TextEditingController();
  final subjectText = TextEditingController(text: "Virtual Consultation");
  final name =
      '${authController.doctorModel.value!.firstName!} ${authController.doctorModel.value!.lastName!}';
  final CallingPatientController callController =
      Get.put(CallingPatientController(), permanent: true);
  final LiveConsController liveCont = Get.find();
  final RxBool doneLoad = false.obs;

  @override
  void initState() {
    super.initState();
    JitsiMeet.closeMeeting();
    callController.bindToList(liveCont.liveCons[0].patientID!);
    JitsiMeet.addListener(JitsiMeetingListener(
        onConferenceWillJoin: _onConferenceWillJoin,
        onConferenceJoined: _onConferenceJoined,
        onConferenceTerminated: _onConferenceTerminated,
        onError: _onError));
    Future.delayed(const Duration(seconds: 3), () {
      _joinMeeting();
      doneLoad.value = true;
    });
    ever(callController.incCall, (value) {
      if (callController.incCall[0].didReject! &&
          callController.incCall[0].from! == authController.userRole) {
        Get.back();
        callController.showRejectedCallDialog();
        JitsiMeet.closeMeeting();
      } else if (!callController.incCall[0].isCalling! &&
          callController.incCall[0].from! == authController.userRole) {
        Get.back();
        JitsiMeet.closeMeeting();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    JitsiMeet.removeAllListeners();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: width * 0.30,
                            child: meetConfig(),
                          ),
                          Container(
                              width: width * 0.60,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                    color: Colors.white54,
                                    child: SizedBox(
                                      width: width * 0.60 * 0.70,
                                      height: width * 0.60 * 0.70,
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
              ))),
    );
  }

  Future<bool> _onBackPressed() {
    showSimpleErrorDialog(errorDescription: "Please end the call first");
    return false as Future<bool>;
  }

  Widget meetConfig() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
            'Virtual Consultation',
            style: body16Regular,
          ),
          verticalSpace18,
          Obx(
            () => Visibility(
              visible: !doneLoad.value,
              child: Center(
                child: const SizedBox(
                    height: 24, width: 24, child: CircularProgressIndicator()),
              ),
            ),
          )
        ],
      ),
    );
  }

  _joinMeeting() async {
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
      } else if (Platform.isIOS) {
        // Disable PIP on iOS as it looks weird
        featureFlags[FeatureFlagEnum.PIP_ENABLED] = false;
      }
    }
    // Define meetings options here
    var options = JitsiMeetingOptions(room: liveCont.liveCons[0].consID!)
      ..serverURL = serverUrl
      ..subject = "Virtual Consultation"
      ..userDisplayName = name
      ..audioOnly = false
      ..audioMuted = false
      ..videoMuted = false
      ..featureFlags.addAll(featureFlags)
      ..webOptions = {
        "roomName": liveCont.liveCons[0].consID!,
        "width": "100%",
        "height": "100%",
        "enableWelcomePage": false,
        " prejoinPageEnabled": false,
        "chromeExtensionBanner": null,
        "userInfo": {"displayName": name}
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
    doneLoad.value = true;
  }

  void _onConferenceJoined(message) {
    debugPrint("_onConferenceJoined broadcasted with message: $message");
    doneLoad.value = true;
  }

  void _onConferenceTerminated(message) async {
    debugPrint("_onConferenceTerminated broadcasted with message: $message");
    await endCall(liveCont.liveCons[0].patientID!);
    Get.back();
    JitsiMeet.closeMeeting();
  }

  _onError(error) {
    debugPrint("_onError broadcasted: $error");
  }

  Widget getPhoto(String img) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        kIsWeb ? 100 : 60,
      ),
      child: Image.network(
        img,
        fit: BoxFit.cover,
        height: kIsWeb ? 100 : 60,
        width: kIsWeb ? 100 : 60,
        errorBuilder: (context, error, stackTrace) {
          return Container(
              height: kIsWeb ? 120 : 80,
              width: kIsWeb ? 120 : 80,
              color: verySoftBlueColor[100],
              child: Center(
                child: Text(
                  '${liveCont.liveCons[0].fullName![0]}',
                  style: title36Regular.copyWith(color: Colors.white),
                ),
              ));
        },
      ),
    );
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
    });
  }
}
