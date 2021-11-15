import 'package:davnor_medicare/core/models/verification_req_model.dart';
import 'package:davnor_medicare/ui/widgets/admin/custom_button.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:get/get.dart';
import 'package:davnor_medicare/core/controllers/admin/for_verification_controller.dart';
import 'package:shimmer/shimmer.dart';

class ForVerificationCard extends StatelessWidget {
  ForVerificationCard({
    this.verifiReq,
    this.onItemTap,
  });

  final VerificationReqModel? verifiReq;
  final void Function()? onItemTap;
  final ForVerificationController vf = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
        child: FutureBuilder(
          future: vf.getPatientData(verifiReq!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return card();
            }
            return loadingCard();
          },
        ));
  }

  Widget card() {
    return Container(
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
                  getPhoto(verifiReq!),
                  horizontalSpace20,
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          vf.getFullName(verifiReq!),
                          style: subtitle18Bold,
                        ),
                        verticalSpace5,
                        Row(
                          children: [
                            const Text(
                              'Request Date',
                              style: caption12Medium,
                            ),
                            horizontalSpace10,
                            Text(
                              vf.convertTimeStamp(verifiReq!.dateRqstd!),
                              style: caption12RegularNeutral,
                            ),
                          ],
                        ),
                      ]),
                ],
              ),
            ],
          ),
          AdminButton(onItemTap: onItemTap, buttonText: 'View Details'),
        ],
      ),
    );
  }

  Widget loadingCard() {
    return Shimmer.fromColors(
      baseColor: neutralColor[10]!,
      highlightColor: Colors.white,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: neutralColor[10],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: Get.width,
        height: 105,
      ),
    );
  }

  Widget getPhoto(VerificationReqModel model) {
    if (vf.getProfilePhoto(model) == '') {
      return CircleAvatar(
        radius: 35,
        backgroundImage: AssetImage(blankProfile),
      );
    }
    return CircleAvatar(
      radius: 35,
      foregroundImage: NetworkImage(vf.getProfilePhoto(model)),
      backgroundImage: AssetImage(blankProfile),
    );
  }
}
