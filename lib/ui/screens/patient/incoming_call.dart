import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/status_controller.dart';
import 'package:davnor_medicare/ui/screens/call_session.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IncomingCallScreen extends StatelessWidget {
  final StatusController stats = Get.find();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
          body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text('${stats.incCall[0].callerName}'),
              Text('is calling....'),
              Row(
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        await acceptCall();
                        print('ACCEPTED');
                      },
                      child: Text('Accept')),
                  ElevatedButton(
                      onPressed: () async {
                        await rejectCall(); //clear data except from
                      },
                      child: Text('Reject Call')),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }

  Future<bool> _onBackPressed() {
    print('Either you reject the call or accept');
    return false as Future<bool>;
  }

  Future<void> acceptCall() async {
    await firestore
        .collection('patients')
        .doc(auth.currentUser!.uid)
        .collection('incomingCall')
        .doc('value')
        .update({
      'patientJoined': true,
    }).then((value) => Get.to(() => CallSessionScreen(),
            arguments: [auth.currentUser!.uid, stats.incCall[0].channelId]));
  }
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
  }).then((value) => Get.back());
}
