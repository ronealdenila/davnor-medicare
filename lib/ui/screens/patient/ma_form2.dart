import 'dart:io';
import 'dart:typed_data';
import 'package:davnor_medicare/constants/app_strings.dart';
import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/widgets/custom_button.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:get/get.dart';
import 'package:davnor_medicare/core/controllers/patient/ma_req_controller.dart';

class MAForm2Screen extends GetView<MARequestController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CupertinoNavigationBarBackButton(
          color: Colors.black,
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'maform10'.tr,
                style: title32Regular,
              ),
              verticalSpace20,
              Text(
                'maform11'.tr,
                style: subtitle18Regular,
              ),
              verticalSpace25,
              DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(12),
                padding: const EdgeInsets.all(12),
                dashPattern: const [8, 8, 8, 8],
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  child: LayoutBuilder(builder:
                      (BuildContext context, BoxConstraints constraints) {
                    return Container(
                      width: screenWidth(context),
                      color: neutralColor[10],
                      child: Obx(getPrescription),
                    );
                  }),
                ),
              ),
              verticalSpace25,
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 300,
                  child: CustomButton(
                    onTap: controller.requestMAButton,
                    text: 'maform13'.tr,
                    buttonColor: verySoftBlueColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getPrescription() {
    if (controller.images.isEmpty) {
      return InkWell(
        onTap: controller.pickMultiImageS,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 80),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.file_upload_outlined,
                size: 67,
                color: neutralColor[60],
              ),
              verticalSpace10,
              Text(
                'maform12'.tr,
                style: subtitle18RegularNeutral,
              )
            ],
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Obx(
        () => GridView.count(
          shrinkWrap: true,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          crossAxisCount: 3,
          children: List.generate(controller.images.length + 1, (index) {
            if (index == controller.images.length) {
              return Center(
                child: IconButton(
                  icon: const Icon(
                    Icons.add_circle_outline_rounded,
                  ),
                  color: verySoftBlueColor[100],
                  iconSize: 45,
                  onPressed: controller.pickMultiImageS,
                ),
              );
            }
            return Stack(
              children: [
                kIsWeb
                    ? Image.network(controller.images[index].path)
                    : Image.file(
                        File(controller.images[index].path),
                        width: 140,
                        height: 140,
                        fit: BoxFit.fill,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(grayBlank, fit: BoxFit.cover);
                        },
                      ),
                Positioned(
                  right: 5,
                  top: 5,
                  child: InkWell(
                    onTap: () {
                      controller.images.removeAt(index);
                    },
                    child: const Icon(
                      Icons.remove_circle,
                      size: 25,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
