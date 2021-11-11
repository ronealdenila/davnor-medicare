import 'dart:io';
import 'dart:typed_data';
import 'package:davnor_medicare/core/controllers/patient/cons_req_controller.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:davnor_medicare/ui/widgets/custom_button.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:davnor_medicare/constants/app_strings.dart';

class ConsForm3Screen extends GetView<ConsRequestController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'consform16'.tr,
                style: title32Regular,
              ),
              verticalSpace50,
              Text(
                'consform17'.tr,
                style: subtitle18Regular,
              ),
              verticalSpace20,
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
                      child: Obx(getPrescriptionAndLabResults),
                    );
                  }),
                ),
              ),
              verticalSpace25,
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 211,
                  child: CustomButton(
                    onTap: controller.submitConsultRequest,
                    text: 'consform19'.tr,
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

  Widget getPrescriptionAndLabResults() {
    final images = controller.images;
    if (images.isEmpty) {
      return InkWell(
        onTap: controller.pickForFollowUpImagess,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
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
                'consform18'.tr,
                style: subtitle18RegularNeutral,
              )
            ],
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(8),
      child: GridView.count(
        shrinkWrap: true,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        crossAxisCount: 3,
        children: List.generate(images.length + 1, (index) {
          if (index == controller.images.length) {
            return Center(
              child: IconButton(
                icon: const Icon(
                  Icons.add_circle_outline_rounded,
                ),
                color: verySoftBlueColor[100],
                iconSize: 45,
                onPressed: controller.pickForFollowUpImagess,
              ),
            );
          }
          return Stack(
            children: [
              kIsWeb
                  ? Image.network(images[index].path)
                  : Image.file(
                      File(images[index].path),
                      width: 140,
                      height: 140,
                      fit: BoxFit.fill,
                    ),
              Positioned(
                right: 5,
                top: 5,
                child: InkWell(
                  onTap: () {
                    controller.images.remove(images[index]);
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
    );
  }
}
