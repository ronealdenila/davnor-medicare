import 'package:davnor_medicare/core/models/consultation_model.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:shimmer/shimmer.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:get/get.dart';
import 'package:davnor_medicare/core/controllers/cons_history_controller.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';

class ConsultationHistoryCardWeb extends StatelessWidget {
  const ConsultationHistoryCardWeb({
    this.consHistory,
    this.onItemTap,
  });

  final ConsultationHistoryModel? consHistory;
  final void Function()? onItemTap;
  static ConsHistoryController consHCont = Get.find();
  static AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          onTap: onItemTap,
          child: Container(
            width: Get.width,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFCBD4E1),
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: getPhoto(consHistory!),
                      ),
                      horizontalSpace20,
                      Flexible(
                        child: SizedBox(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                (authController.userRole! == 'patient')
                                    ? consHCont.getDoctorFullName(consHistory!)
                                    : consHistory!.fullName!,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: body16SemiBold,
                              ),
                              verticalSpace5,
                              Text(
                                consHCont
                                    .convertDate(consHistory!.dateConsEnd!),
                                style: caption12Medium,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
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
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(blankProfile, fit: BoxFit.cover);
      },
    );
  }

  Widget getDoctorPhoto(ConsultationHistoryModel model) {
    if (model.patient.value!.profileImage! == '') {
      return Image.asset(doctorDefault, fit: BoxFit.cover);
    }
    return Image.network(
      model.patient.value!.profileImage!,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(doctorDefault, fit: BoxFit.cover);
      },
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
