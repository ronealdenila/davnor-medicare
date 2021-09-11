import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:davnor_medicare/ui/widgets/admin/for_verification_card.dart';
import 'package:flutter/material.dart';
import 'package:davnor_medicare/ui/screens/admin/verification_req_item.dart';
import 'package:davnor_medicare/core/controllers/admin/for_verification_controller.dart';
import 'package:get/get.dart';

class VerificationReqListScreen extends StatelessWidget {
  static ForVerificationController vf = Get.put(ForVerificationController());

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
                          Get.to(
                            () => VerificationReqItemScreen(),
                            arguments: vf.verifReq[index],
                          );
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
