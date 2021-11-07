import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/calling_patient_controller.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/widgets/consultation_card.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CallPatientScreen extends StatefulWidget {
  @override
  State<CallPatientScreen> createState() => _CallPatientScreenState();
}

class _CallPatientScreenState extends State<CallPatientScreen> {
  final CallingPatientController callController =
      Get.put(CallingPatientController());

  final String patientId = 'WZbt7uQkDNd53rT3yhW1MumSIBN2';

  @override
  void initState() {
    callController.bindToList(patientId);
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
      return Text('No data');
    }
    return Column(
      children: [
        Text('Calling patient.....'),
        ElevatedButton(
            onPressed: () async {
              await cancelCall(patientId); //clear data?
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
    'patientJoined': false
  }).then((value) => Get.back());
}
