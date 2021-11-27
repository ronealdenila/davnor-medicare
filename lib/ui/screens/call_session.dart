import 'dart:convert';

import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

final AuthController authController = Get.find();

class CallSessionScreen extends StatefulWidget {
  @override
  State<CallSessionScreen> createState() => _CallSessionScreenState();
}

class _CallSessionScreenState extends State<CallSessionScreen> {
  final consInfo = Get.arguments; //0 - patientId, 1 - channelId
  late RtcEngine _engine;
  late String tokenId;
  bool isJoined = false,
      switchCamera = true,
      switchRender = true,
      isLoading = true;
  List<int> remoteUid = [];

  @override
  void initState() {
    _initEngine();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _engine.destroy();
  }

  Future<void> getToken() async {
    final url =
        'https://davnor-medicare.herokuapp.com/access_token?channel=${consInfo[1]}';
    final response = await http.get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    print(data["token"]);
    setState(() {
      tokenId = data["token"];
    });
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
          _joinChannel();
          isLoading = false;
        }));
  }

  _initEngine() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      await [Permission.microphone, Permission.camera].request();
    }

    _engine = await RtcEngine.createWithContext(
        RtcEngineContext('369277470acc4438b3622bf48f4b0b7d'));
    this._addListeners();

    await _engine.enableVideo();
    await _engine.startPreview();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(ClientRole.Broadcaster);

    await getToken();
  }

  _addListeners() {
    _engine.setEventHandler(RtcEngineEventHandler(
      joinChannelSuccess: (channel, uid, elapsed) {
        print('joinChannelSuccess ${channel} ${uid} ${elapsed}');
        if (authController.userRole != 'patient') {
          otherJoinedSuccess();
        }
        isJoined = true;
      },
      userJoined: (uid, elapsed) {
        print('userJoined  ${uid} ${elapsed}');
        setState(() {
          remoteUid.add(uid);
        });
      },
      userOffline: (uid, reason) {
        print('userOffline  ${uid} ${reason}');
        setState(() {
          remoteUid.removeWhere((element) => element == uid);
        });
        leaveSuccess();
      },
      leaveChannel: (stats) {
        print('leaveChannel ${stats.toJson()}');
        leaveSuccess();
        isJoined = false;
        remoteUid.clear();
      },
    ));
  }

  Future<void> _joinChannel() async {
    final int userUid = authController.userRole == 'patient' ? 0 : 1;
    await _engine.joinChannel(tokenId, consInfo[1], null, userUid);
  }

  Future<void> _leaveChannel() async {
    await _engine.leaveChannel();
  }

  _switchCamera() {
    _engine.switchCamera().then((value) {
      setState(() {
        switchCamera = !switchCamera;
      });
    }).catchError((err) {
      print('switchCamera $err');
    });
  }

  _switchRender() {
    setState(() {
      switchRender = !switchRender;
      remoteUid = List.of(remoteUid.reversed);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
                child: isLoading
                    ? Center(
                        child: SizedBox(
                            height: kIsWeb ? 35 : 24,
                            width: kIsWeb ? 35 : 24,
                            child: CircularProgressIndicator()))
                    : Stack(
                        children: [
                          _renderVideo(),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: IconButton(
                                        onPressed: () {
                                          _switchCamera();
                                        },
                                        icon: Icon(
                                          Icons.flip_camera_ios_outlined,
                                          color: Colors.grey[800],
                                          size: 27,
                                        )),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    _leaveChannel();
                                  },
                                  child: Icon(Icons.call_end_rounded,
                                      color: Colors.white, size: 40),
                                  style: ElevatedButton.styleFrom(
                                    shape: CircleBorder(),
                                    padding: EdgeInsets.all(12),
                                    primary: Colors.red,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: IconButton(
                                        onPressed: () {
                                          //TO THINK - wheter mag add ug mic func
                                        },
                                        icon: Icon(
                                          Icons.mic,
                                          color: Colors.grey[800],
                                          size: 27,
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ))));
  }

  _renderVideo() {
    return Stack(
      children: [
        RtcLocalView.SurfaceView(),
        Align(
          alignment: Alignment.topLeft,
          child: Row(
            children: List.of(remoteUid.map(
              (e) => GestureDetector(
                onTap: this._switchRender,
                child: Container(
                  width: 120,
                  height: 120,
                  child: RtcRemoteView.SurfaceView(
                    uid: e,
                    channelId: consInfo[1],
                  ),
                ),
              ),
            )),
          ),
        )
      ],
    );
  }

//LEAVE SHOULD RESET
  Future<void> leaveSuccess() async {
    await firestore
        .collection('patients')
        .doc(consInfo[0])
        .collection('incomingCall')
        .doc('value')
        .update({
      'patientJoined': false,
      'isCalling': false,
      'didReject': false,
      'otherJoined': false,
      'channelId': '',
      'from': '',
      'callerName': ''
    }).then((value) {
      _engine.destroy();
      Get.back();
      Get.back();
    });
  }

  Future<void> otherJoinedSuccess() async {
    await firestore
        .collection('patients')
        .doc(consInfo[0])
        .collection('incomingCall')
        .doc('value')
        .update({'otherJoined': true});
  }

  Future<bool> _onBackPressed() {
    print('Either you reject the call or accept');
    return false as Future<bool>;
  }
}
