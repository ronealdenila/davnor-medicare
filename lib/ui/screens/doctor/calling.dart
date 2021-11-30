import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/calling_patient_controller.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CallPatientScreen extends StatefulWidget {
  @override
  State<CallPatientScreen> createState() => _CallPatientScreenState();
}

class _CallPatientScreenState extends State<CallPatientScreen> {
  final CallingPatientController callController = Get.find();
  final consInfo = Get.arguments;
  final RxBool errorPhoto = false.obs;
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
        body: SafeArea(child: Center(child: Obx(() => displayState()))),
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
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        getPhoto(consInfo[2]),
        verticalSpace35,
        Text(
          'Calling...',
          style: subtitle20Regular,
        ),
        verticalSpace15,
        Text(
          '${consInfo[3]}',
          style: subtitle18Medium,
        ),
        verticalSpace5,
        Text(
          '(Patient)',
          style: body16Regular,
        ),
        verticalSpace50,
        ElevatedButton(
          onPressed: () async {
            await cancelCall(consInfo[0]);
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
    );
  }

  Future<bool> _onBackPressed() {
    print('Either you reject the call or accept');
    return false as Future<bool>;
  }

  Widget getPhoto(String img) {
    return CircleAvatar(
        radius: kIsWeb ? 120 : 80,
        foregroundImage: NetworkImage(img),
        onForegroundImageError: (_, __) {
          errorPhoto.value = true;
        },
        backgroundColor: Colors.grey,
        child: Obx(
          () => errorPhoto.value
              ? Text(
                  '${consInfo[3][0]}',
                )
              : SizedBox(
                  height: 0,
                  width: 0,
                ),
        ));
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
