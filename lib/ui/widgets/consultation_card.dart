import 'package:davnor_medicare/core/models/consultation_model.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:shimmer/shimmer.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:get/get.dart';
import 'package:davnor_medicare/core/controllers/doctor/consultations_controller.dart';

class ConsultationCard extends StatelessWidget {
  const ConsultationCard({
    this.consReq,
    this.onItemTap,
  });

  final ConsultationModel? consReq;
  final void Function()? onItemTap;
  static ConsultationsController docConsController = Get.find();

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
                color: consReq!.isSenior! ? verySoftOrange : Colors.white,
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
                          child: getPhoto(consReq!)),
                    ),
                    horizontalSpace20,
                    SizedBox(
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
                          const Text(
                            'Patient Information:',
                            style: caption12RegularNeutral,
                            overflow: TextOverflow.ellipsis,
                          ),
                          verticalSpace5,
                          Text(
                            '${consReq!.fullName!} (${consReq!.age!})',
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
            ),
          ),
        ),
        verticalSpace15,
      ],
    );
  }

  Widget getPhoto(ConsultationModel model) {
    return Image.network(
      docConsController.getProfilePhoto(model),
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
            height: 75,
            width: 75,
            color: verySoftBlueColor[100],
            child: Center(
              child: Text(
                '${model.fullName![0]}',
                style: title24Regular.copyWith(color: Colors.white),
              ),
            ));
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
