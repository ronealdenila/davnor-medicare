import 'package:davnor_medicare/core/controllers/admin/for_verification_controller.dart';
import 'package:davnor_medicare/routes/app_pages.dart';
import 'package:davnor_medicare/ui/screens/admin/helpers/local_navigator.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/widgets/admin/for_verification_card.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerificationReqListScreen extends StatelessWidget {
  final ForVerificationController vf = Get.put(ForVerificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(onPressed: () {}, 
            icon: Icon(Icons.arrow_back_outlined,
            size: 30,)),

            Text('Users to be Verified',
                textAlign: TextAlign.left, style: title29BoldNeutral80),
            verticalSpace50,
            requestList()
          ],
        ),
      ),
    );
  }

  Widget requestList() {
    return StreamBuilder(
        stream: vf.getCollection(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (vf.verifReq.isNotEmpty) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: vf.verifReq.length,
                  itemBuilder: (context, index) {
                    return ForVerificationCard(
                        verifiReq: vf.verifReq[index],
                        onItemTap: () {
                          navigationController.navigateToWithArgs(
                              Routes.VERIFICATION_REQ_ITEM,
                              arguments: vf.verifReq[index]);
                        });
                  });
            } else {
              return const Text('No verification request at the moment');
            }
          }
          return const SizedBox(
              width: 20, height: 20, child: CircularProgressIndicator());
        });
  }
}
