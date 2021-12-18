import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/status_controller.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:davnor_medicare/ui/screens/call_session2.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IncomingCallScreen extends StatelessWidget {
  final StatusController stats = Get.find();
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
          body: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: kIsWeb ? 250 : 80,
                    backgroundImage: AssetImage(
                        stats.incCall[0].from == 'doctor'
                            ? doctorDefault
                            : maImage),
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
          )),
    );
  }

  Future<bool> _onBackPressed() {
    showSimpleErrorDialog(errorDescription: 'errordialog14'.tr);
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
    }).then((value) => Get.to(() => CallSessionScreen()));
    //arguments: [auth.currentUser!.uid, stats.incCall[0].channelId]));
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
