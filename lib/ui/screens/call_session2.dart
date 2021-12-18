import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/core/controllers/calling_patient_controller.dart';
import 'package:davnor_medicare/core/controllers/live_cons_controller.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'dart:io' show Platform;

class CallSessionScreen extends StatefulWidget {
  @override
  State<CallSessionScreen> createState() => _CallSessionScreenState();
}

class _CallSessionScreenState extends State<CallSessionScreen> {
  final AuthController authController = Get.find();
  final serverText = TextEditingController();
  final subjectText = TextEditingController(text: "Virtual Consultation");
  final RxString name = "".obs;
  final CallingPatientController callController = Get.find();
  final LiveConsController liveCont = Get.find();
  final RxBool doneLoad = false.obs;

  @override
  void initState() {
    super.initState();
    callController.bindToList(liveCont.liveCons[0].patientID!);
    if (authController.userRole == 'doctor') {
      name.value =
          '${authController.doctorModel.value!.firstName!} ${authController.doctorModel.value!.lastName!}';
    } else {
      name.value =
          '${authController.pswdModel.value!.firstName!} ${authController.pswdModel.value!.lastName!}';
    }
    JitsiMeet.addListener(JitsiMeetingListener(
        onConferenceWillJoin: _onConferenceWillJoin,
        onConferenceJoined: _onConferenceJoined,
        onConferenceTerminated: _onConferenceTerminated,
        onError: _onError));
    ever(callController.incCall, (value) {
      if (!callController.isLoading.value) {
        if (callController.incCall[0].patientJoined!) {
          _joinMeeting();
        }
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
    return MaterialApp(
      home: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: kIsWeb ? Obx(() => webMeet()) : meetConfig(),
        ),
      ),
    );
  }

  Widget webMeet() {
    if (callController.isLoading.value) {
      return Center(
        child: const SizedBox(
            height: 24, width: 24, child: CircularProgressIndicator()),
      );
    } else if (!callController.incCall[0].patientJoined! &&
        !callController.isLoading.value) {
      return meetConfig();
    }
    return Container(
        width: Get.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
              color: Colors.white54,
              child: SizedBox(
                width: Get.width * 0.70,
                height: Get.width * 0.70,
                child: JitsiMeetConferencing(
                  extraJS: [
                    // extraJs setup example
                    '<script>function echo(){console.log("echo!!!")};</script>',
                    '<script src="https://code.jquery.com/jquery-3.5.1.slim.js" integrity="sha256-DrT5NfxfbHvMHux31Lkhxg42LY6of8TaYyK50jnxRnM=" crossorigin="anonymous"></script>'
                  ],
                ),
              )),
        ));
  }

  Widget meetConfig() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // getPhoto(liveCont.liveCons[0].patient.value!.profileImage!),
          verticalSpace35,
          Text(
            'Calling...',
            style: subtitle20Regular,
          ),
          verticalSpace15,
          // Text(
          //   '${liveCont.liveCons[0].patient.value!.firstName!} ${liveCont.liveCons[0].patient.value!.lastName!}',
          //   style: subtitle18Medium,
          // ),
          verticalSpace5,
          Text(
            '(Patient)',
            style: body16Regular,
          ),
          verticalSpace50,
          ElevatedButton(
            onPressed: () async {
              await endCall(liveCont.liveCons[0].patientID!);
              Get.back();
              JitsiMeet.closeMeeting();
            },
            child: Icon(Icons.close_rounded, color: Colors.white, size: 40),
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              padding: EdgeInsets.all(12),
              primary: Colors.red,
            ),
          ),
          verticalSpace5,
          Text('Cancel Call'),
        ],
      ),
    );
  }

  _joinMeeting() async {
    print('joining..');
    String? serverUrl = serverText.text.trim().isEmpty ? null : serverText.text;

    // Enable or disable any feature flag here
    // If feature flag are not provided, default values will be used
    // Full list of feature flags (and defaults) available in the README
    Map<FeatureFlagEnum, bool> featureFlags = {
      FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
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
      ..userDisplayName = name.value
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
        "userInfo": {"displayName": name.value}
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
