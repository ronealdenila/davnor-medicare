import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:davnor_medicare/ui/widgets/admin/verification_req_card.dart';
import 'package:flutter/material.dart';
import 'package:davnor_medicare/ui/screens/admin/verification_req_item.dart';
import 'package:davnor_medicare/core/controllers/admin_for_verif_controller.dart';
import 'package:get/get.dart';

class VerificationReqListScreen extends StatelessWidget {
  //final VerificationRequestController vf = Get.find();

  static VerificationRequestController vf =
      Get.put(VerificationRequestController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Users to be Verified',
                textAlign: TextAlign.left, style: title24BoldNeutral80),
            verticalSpace50,
            Expanded(child: Obx(requestList))
          ],
        ),
      ),
    );
  }

  Widget requestList() {
    if (vf.verifReq.isNotEmpty) {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: vf.verifReq.length,
          itemBuilder: (context, index) {
            return VerificationReqCard(
                verifiReq: vf.verifReq[index],
                onItemTap: () {
                  Get.to(
                    () => VerificationReqItemScreen(),
                    arguments: index,
                  );
                });
          });
    }
    return const Text('No verification request at the moment');
  }
}
