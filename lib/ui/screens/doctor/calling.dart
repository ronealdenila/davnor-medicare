import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/calling_patient_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CallPatientScreen extends StatefulWidget {
  @override
  State<CallPatientScreen> createState() => _CallPatientScreenState();
}

class _CallPatientScreenState extends State<CallPatientScreen> {
  final CallingPatientController callController = Get.find();
  final consInfo = Get.arguments;

  @override
  void initState() {
    callController.patientId.value = consInfo[0];
    callController.channelId.value = consInfo[1];
    callController.bindToList(consInfo[0]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        body: SafeArea(child: Obx(() => displayState())),
      ),
    );
  }

  Widget displayState() {
    if (callController.isLoading.value) {
      return CircularProgressIndicator();
    } else if (!callController.isLoading.value &&
        callController.incCall.isEmpty) {
      return Text('Something went wrong');
    }
    return Column(
      children: [
        Text('Calling patient.....'),
        ElevatedButton(
            onPressed: () async {
              await cancelCall(consInfo[0]);
            },
            child: Text('Cancel Call'))
      ],
    );
  }

  Future<bool> _onBackPressed() {
    print('Either you reject the call or accept');
    return false as Future<bool>;
  }
}

Future<void> cancelCall(String patientId) async {
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
