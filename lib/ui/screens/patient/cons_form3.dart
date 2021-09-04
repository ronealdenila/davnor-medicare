import 'dart:io';
import 'package:davnor_medicare/core/controllers/cons_controller.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:davnor_medicare/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:davnor_medicare/core/controllers/app_controller.dart';
import 'package:davnor_medicare/constants/app_strings.dart';
import 'package:davnor_medicare/core/services/logger.dart';

class ConsForm3Screen extends StatelessWidget {
  final log = getLogger('Cons Form 3');
  final AppController appController = Get.put(AppController());
  final ConsController consController = Get.put(ConsController());

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
              const Text(
                'Upload past prescription or laboratory results',
                style: title32Regular,
              ),
              verticalSpace50,
              const Text(
                consForm3Description,
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
                    onTap: consController.submitConsultRequest,
                    text: 'Consult Now',
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
    final images = consController.images;
    if (images.isEmpty) {
      return InkWell(
        onTap: () async {
          await consController.pickMultiImage();
          // await appController.pickImages(images);
        },
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
                'Upload here',
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
          if (index == images.length) {
            return Center(
                child: IconButton(
              icon: const Icon(
                Icons.add_circle_outline_rounded,
              ),
              color: verySoftBlueColor[100],
              iconSize: 45,
              onPressed: () async {
                await consController.pickMultiImage();
              },
            ));
          }
          return Stack(
            children: [
              Image.file(
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
                    images.remove(images[index]);
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
