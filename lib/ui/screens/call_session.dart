import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:davnor_medicare/constants/app_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

class CallSessionScreen extends StatefulWidget {
  @override
  State<CallSessionScreen> createState() => _CallSessionScreenState();
}

class _CallSessionScreenState extends State<CallSessionScreen> {
  late final RtcEngine _engine;
  late String tokenId;
  bool isJoined = false,
      switchCamera = true,
      switchRender = true,
      isLoading = true;
  List<int> remoteUid = [];

  @override
  void initState() {
    getToken();

    _initEngine();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _engine.destroy();
  }

  Future<void> getToken() async {
    const url =
        'https://davnor-medicare.herokuapp.com/access_token?channel=tester';
    // const link =
    //     "https://AgoraTokenServer.emmalynnabiamos.repl.co/access_token?channelName=tester";
    final response = await http.get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    print(data["token"]);
    setState(() {
      tokenId = data["token"];
    });
    Future.delayed(const Duration(seconds: 1))
        .then((value) => setState(() => isLoading = false));
  }

  _initEngine() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      await [Permission.microphone, Permission.camera].request();
    }

    _engine = await RtcEngine.createWithContext(RtcEngineContext(appId));
    this._addListeners();

    await _engine.enableVideo();
    await _engine.startPreview();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(ClientRole.Broadcaster);

    _joinChannel();
  }

  _addListeners() {
    _engine.setEventHandler(RtcEngineEventHandler(
      joinChannelSuccess: (channel, uid, elapsed) {
        print('joinChannelSuccess ${channel} ${uid} ${elapsed}');
        setState(() {
          isJoined = true;
        });
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
      },
      leaveChannel: (stats) {
        print('leaveChannel ${stats.toJson()}');
        setState(() {
          isJoined = false;
          remoteUid.clear();
        });
      },
    ));
  }

  void _joinChannel() async {
    await _engine.joinChannel(tokenId, "tester", null, 0);
  }

  void _leaveChannel() async {
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
            body: SafeArea(
                child: isLoading
                    ? CircularProgressIndicator()
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
                                Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Icon(
                                      Icons.call_end_rounded,
                                      color: Colors.white,
                                      size: 40,
                                    ),
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
                                          //mic func
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
    return Expanded(
      child: Stack(
        children: [
          RtcLocalView.SurfaceView(),
          Align(
            alignment: Alignment.topLeft,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.of(remoteUid.map(
                  (e) => GestureDetector(
                    onTap: this._switchRender,
                    child: Container(
                      width: 120,
                      height: 120,
                      child: RtcRemoteView.SurfaceView(
                        uid: e,
                        channelId: "tester",
                      ),
                    ),
                  ),
                )),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<bool> _onBackPressed() {
    print('Either you reject the call or accept');
    return false as Future<bool>;
  }
}
