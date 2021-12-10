import 'package:davnor_medicare/core/controllers/admin/for_verification_controller.dart';
import 'package:davnor_medicare/core/controllers/navigation_controller.dart';
import 'package:davnor_medicare/routes/app_pages.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/widgets/admin/for_verification_card.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerificationReqListScreen extends StatelessWidget {
  final ForVerificationController vf = Get.find();
  final NavigationController navigationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Users to be Verified',
                textAlign: TextAlign.left, style: title29BoldNeutral80),
            verticalSpace50,
            Flexible(child: Obx(() => requestList(context)))
          ],
        ),
      ),
    );
  }

  Widget requestList(BuildContext context) {
    if (vf.isLoading.value) {
      return Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: const SizedBox(
              height: 24, width: 24, child: CircularProgressIndicator()),
        ),
      );
    }
    if (vf.verifReq.isEmpty && !vf.isLoading.value) {
      return const Text(
        'No verification request at the moment',
        textAlign: TextAlign.center,
        style: body14Medium,
      );
    }
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView.builder(
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
          }),
    );
  }
}
