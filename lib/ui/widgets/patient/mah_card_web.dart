import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/core/controllers/ma_history_controller.dart';
import 'package:davnor_medicare/core/models/med_assistance_model.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:get/get.dart';

class MAHistoryWCard extends StatelessWidget {
  MAHistoryWCard({
    required this.maHistory,
    required this.onTap,
  });

  final MAHistoryModel? maHistory;
  final void Function()? onTap;
  final MAHistoryController maHController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
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
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  SizedBox(
                    width: 75,
                    height: 75,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        maImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  horizontalSpace20,
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          maHController
                              .convertTimeStamp(maHistory!.dateClaimed!),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: body16SemiBold,
                        ),
                        verticalSpace5,
                        const Text(
                          'Medicine Worth',
                          style: caption12RegularNeutral,
                        ),
                        verticalSpace5,
                        Text(
                          'Php ${maHistory!.medWorth}',
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
      ],
    );
  }
}