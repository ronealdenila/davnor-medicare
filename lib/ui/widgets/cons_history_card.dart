import 'package:davnor_medicare/core/models/consultation_model.dart';
import 'package:flutter/material.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:shimmer/shimmer.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:get/get.dart';
import 'package:davnor_medicare/core/controllers/cons_history_controller.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';

class ConsultationHistoryCard extends StatelessWidget {
  const ConsultationHistoryCard({
    this.consHistory,
    this.onItemTap,
  });

  final ConsultationHistoryModel? consHistory;
  final void Function()? onItemTap;
  static ConsHistoryController consHController = Get.find();
  static AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onItemTap,
          child: Card(
            elevation: 9,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              height: 95,
              width: screenWidth(context),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    SizedBox(
                      width: 75,
                      height: 75,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: getPhoto(consHistory!)),
                    ),
                    horizontalSpace20,
                    SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            (authController.userRole! == 'patient')
                                ? consHController
                                    .getDoctorFullName(consHistory!)
                                : consHistory!.fullName!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: body16SemiBold,
                          ),
                          verticalSpace5,
                          Text(
                            (authController.userRole! == 'patient')
                                ? consHistory!.doc.value!.title!
                                : 'Consultation Date:',
                            style: caption12RegularNeutral,
                            overflow: TextOverflow.ellipsis,
                          ),
                          verticalSpace5,
                          Text(
                            consHistory!.dateConsEnd!,
                            style: caption12Medium,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Visibility(
                            visible: authController.userRole! == 'doctor',
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                verticalSpace5,
                                const Text(
                                  'Requested By:',
                                  style: caption12RegularNeutral,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                verticalSpace5,
                                Text(
                                  consHController
                                      .getPatientFullName(consHistory!),
                                  style: caption12Medium,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        verticalSpace15,
      ],
    );
  }

  Widget getPhoto(ConsultationHistoryModel model) {
    if (authController.userRole! == 'patient') {
      return forPatientHistory(model);
    } else {
      return getDoctorPhoto(model);
    }
  }

  Widget forPatientHistory(ConsultationHistoryModel model) {
    if (model.doc.value!.profileImage! == '') {
      return Image.asset(blankProfile, fit: BoxFit.cover);
    }
    return Image.network(
      model.doc.value!.profileImage!,
      fit: BoxFit.cover,
    );
  }

  Widget getDoctorPhoto(ConsultationHistoryModel model) {
    if (model.patient.value!.profileImage! == '') {
      return Image.asset(blankProfile, fit: BoxFit.cover);
    }
    return Image.network(
      model.patient.value!.profileImage!,
      fit: BoxFit.cover,
    );
  }
}

Widget loadingCardIndicator() {
  return Column(
    children: [
      Card(
        elevation: 9,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Shimmer.fromColors(
          baseColor: neutralColor[10]!,
          highlightColor: Colors.white,
          child: Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
            height: 95,
            width: Get.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      verticalSpace15
    ],
  );
}
