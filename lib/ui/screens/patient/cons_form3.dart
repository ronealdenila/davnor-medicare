import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:davnor_medicare/ui/screens/patient/home.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:davnor_medicare/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:davnor_medicare/constants/app_strings.dart';
import 'package:davnor_medicare/core/services/logger.dart';

// ignore: must_be_immutable
class ConsForm3Screen extends StatelessWidget {
  final log = getLogger('Cons Form 3');
  RxList<Asset> images = RxList<Asset>();
  List<Asset> resultList = [];

  //I Fetch ang code from database then i set sa variable;
  String generatedCode = 'C025';

  Future<void> pickImages() async {
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: images,
        materialOptions: const MaterialOptions(
          actionBarTitle: 'FlutterCorner.com',
        ),
      );
    } on Exception catch (e) {
      log.i('pickImages | $e');
    }
    images.value = resultList;
  }

  @override
  Widget build(BuildContext context) {
    final dialog = 'Your priority number is $generatedCode.\n$dialog5Caption';
    return Scaffold(
      backgroundColor: Colors.white,
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
                      child: Obx(getWidget),
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
                    onTap: () {
                      showDefaultDialog(
                        dialogTitle: dialog5Title,
                        dialogCaption: dialog,
                        onConfirmTap: () {
                          Get.to(() => PatientHomeScreen());
                        },
                      );
                    },
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

  Widget getWidget() {
    if (images.isEmpty) {
      return InkWell(
        onTap: pickImages,
        child: Padding(
          padding: const EdgeInsets.all(20),
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
      child: Column(
        children: [
          GridView.count(
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
                  iconSize: 58,
                  onPressed: pickImages,
                ));
              }
              return AssetThumb(
                asset: images[index],
                width: 140,
                height: 140,
              );
            }),
          ),
          verticalSpace15,
          ElevatedButton(
              onPressed: () {
                images.value = [];
              },
              child: const Text('Clear All Photos')),
        ],
      ),
    );
  }
}
