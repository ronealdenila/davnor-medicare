import 'package:davnor_medicare/core/models/verification_req_model.dart';
import 'package:flutter/material.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:get/get.dart';

class VerificationReqCard extends StatelessWidget {
  const VerificationReqCard({
    this.verificationReq,
    this.onItemTap,
  });

  final VerificationReqModel? verificationReq;
  final void Function()? onItemTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: neutralColor[10],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: Get.width,
        height: 105,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(authHeader),
                      radius: 35,
                    ),
                    horizontalSpace20,
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            verificationReq!.patientID!,
                            style: subtitle18Bold,
                          ),
                          verticalSpace5,
                          Row(
                            children: [
                              const Text(
                                'Request Date',
                                style: caption12Medium,
                              ),
                              horizontalSpace15,
                              Text(
                                '${verificationReq!.dateRqstd}',
                                style: caption12RegularNeutral,
                              ),
                            ],
                          ),
                        ]),
                  ],
                ),
              ],
            ),
            InkWell(
              onTap: onItemTap,
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: const Color(0xFF063373),
                  ),
                  child: const Text(
                    'View Details',
                    style: subtitle18BoldWhite,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}