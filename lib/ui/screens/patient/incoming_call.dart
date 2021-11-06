import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IncomingCallScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
          body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text('Someone is CAlling...'),
              ElevatedButton(
                  onPressed: () {
                    print('ACCEPTED');
                  },
                  child: Text('Accept')),
              ElevatedButton(
                  onPressed: () async {
                    await rejectCall(); //clear data?
                  },
                  child: Text('Reject Call'))
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
}

Future<void> rejectCall() async {
  await firestore
      .collection('patients')
      .doc(auth.currentUser!.uid)
      .collection('incomingCall')
      .doc('value')
      .update({'isCalling': false});
}
