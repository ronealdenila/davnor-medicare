import 'package:davnor_medicare/core/controllers/cons_history_controller.dart';
import 'package:davnor_medicare/core/models/consultation_model.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:shimmer/shimmer.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:get/get.dart';
import 'package:davnor_medicare/core/controllers/doctor/consultations_controller.dart';

class ConsultationCardWeb extends StatelessWidget {
  ConsultationCardWeb({
    this.consReq,
    this.onItemTap,
  });

  final ConsultationModel? consReq;
  final void Function()? onItemTap;
  static ConsultationsController docConsController = Get.find();
  final ConsultationsController consRequests = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
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
                        child: ClipRRect(child: getPhoto(consReq!)),
                      ),
                      horizontalSpace20,
                      Flexible(
                        child: SizedBox(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                docConsController.getFullName(consReq!),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: body16SemiBold,
                              ),
                              verticalSpace5,
                              Text(
                                '${consReq!.description!}',
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

  Widget getPhoto(ConsultationModel model) {
    if (docConsController.getProfilePhoto(model) == '') {
      return Container(
        color: verySoftBlueColor[100],
        child: Center(
          child: Text('${consRequests.getFirstName(model)[0]}',
              style: title24Regular.copyWith(color: Colors.white)),
        ),
      );
    }
    return Image.network(
      docConsController.getProfilePhoto(model),
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: verySoftBlueColor[100],
          child: Center(
            child: Text('${consRequests.getFirstName(model)[0]}',
                style: title24Regular.copyWith(color: Colors.white)),
          ),
        );
      },
    );
  }
}

Widget loadingCardIndicator() {
  return Column(
    children: [
      Shimmer.fromColors(
        baseColor: neutralColor[10]!,
        highlightColor: Colors.white,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          height: 95,
          width: Get.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      verticalSpace15
    ],
  );
}
