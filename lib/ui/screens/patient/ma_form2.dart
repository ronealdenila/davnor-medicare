import 'dart:io';
//import 'package:davnor_medicare/constants/app_strings.dart';
import 'package:davnor_medicare/constants/app_strings.dart';
import 'package:davnor_medicare/ui/screens/patient/home.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/widgets/custom_button.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:get/get.dart';
import 'package:davnor_medicare/core/controllers/app_controller.dart';
import 'package:davnor_medicare/core/services/logger.dart';
import 'package:davnor_medicare/core/controllers/ma_controller.dart';

class MAForm2Screen extends StatelessWidget {
  final log = getLogger('Cons Form 3');
  final AppController to = Get.find();
  final MAController ma = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CupertinoNavigationBarBackButton(
          color: Colors.black,
          onPressed: () {},
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Upload prescription',
                style: title32Regular,
              ),
              verticalSpace20,
              const Text(
                maForm2Screen,
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
                    onTap: ma.requestMAButton,
                    text: 'Request Assistance',
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
    if (ma.images.isEmpty) {
      return InkWell(
        onTap: () async {
          await to.pickImages(ma.images);
        },
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
        children: List.generate(ma.images.length + 1, (index) {
          if (index == ma.images.length) {
            return Center(
                child: IconButton(
              icon: const Icon(
                Icons.add_circle_outline_rounded,
              ),
              color: verySoftBlueColor[100],
              iconSize: 45,
              onPressed: () async {
                await to.pickImages(ma.images);
              },
            ));
          }
          return Stack(
            children: [
              Image.file(
                File(ma.images[index].path),
                width: 140,
                height: 140,
                fit: BoxFit.fill,
              ),
              Positioned(
                right: 5,
                top: 5,
                child: InkWell(
                  onTap: () {
                    ma.images.remove(ma.images[index]);
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