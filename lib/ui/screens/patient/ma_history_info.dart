import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/core/controllers/ma_history_controller.dart';
import 'package:davnor_medicare/core/controllers/pswd/attached_photos_controller.dart';
import 'package:davnor_medicare/core/models/med_assistance_model.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/widgets/custom_button.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MAHistoryInfoScreen extends StatelessWidget {
  final MAHistoryController maHController = Get.find();
  final MAHistoryModel maHistoryItem = Get.arguments as MAHistoryModel;
  final AttachedPhotosController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('mahistory1'.tr,
                          textAlign: TextAlign.justify,
                          style: subtitle20Medium.copyWith(
                              color: const Color(0xFF64748B))),
                    ]),
                verticalSpace20,
                Row(
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 160,
                                child: Text('mah3'.tr,
                                    textAlign: TextAlign.left,
                                    style: body16SemiBold),
                              ),
                              SizedBox(
                                width: Get.width - 220,
                                child: Text(maHistoryItem.fullName!,
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: body16Regular.copyWith(
                                        color: const Color(0xFF64748B))),
                              ),
                            ],
                          ),
                          verticalSpace20,
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 160,
                                child: Text('mah4'.tr,
                                    textAlign: TextAlign.left,
                                    style: body16SemiBold),
                              ),
                              SizedBox(
                                width: Get.width - 220,
                                child: Text(maHistoryItem.age!,
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: body16Regular.copyWith(
                                        color: const Color(0xFF64748B))),
                              ),
                            ],
                          ),
                          verticalSpace20,
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 160,
                                child: Text('mah5'.tr,
                                    textAlign: TextAlign.left,
                                    style: body16SemiBold),
                              ),
                              SizedBox(
                                width: Get.width - 220,
                                child: Text(maHistoryItem.address!,
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: body16Regular.copyWith(
                                        color: const Color(0xFF64748B))),
                              ),
                            ],
                          ),
                          verticalSpace20,
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 160,
                                child: Text('mah6'.tr,
                                    textAlign: TextAlign.left,
                                    style: body16SemiBold),
                              ),
                              SizedBox(
                                width: Get.width - 220,
                                child: Text(maHistoryItem.gender!,
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: body16Regular.copyWith(
                                        color: const Color(0xFF64748B))),
                              ),
                            ],
                          ),
                          verticalSpace20,
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 160,
                                child: Text('mah7'.tr,
                                    textAlign: TextAlign.left,
                                    style: body16SemiBold),
                              ),
                              SizedBox(
                                width: Get.width - 220,
                                child: Text(maHistoryItem.type!,
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: body16Regular.copyWith(
                                        color: const Color(0xFF64748B))),
                              ),
                            ],
                          ),
                        ]),
                  ],
                ),
                verticalSpace35,
                Text('mah8'.tr,
                    textAlign: TextAlign.justify,
                    style: subtitle20Medium.copyWith(
                        color: const Color(0xFF64748B))),
                verticalSpace20,
                Row(
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 160,
                                child: Text('mah9'.tr,
                                    textAlign: TextAlign.left,
                                    style: body16SemiBold),
                              ),
                              SizedBox(
                                width: Get.width - 220,
                                child: Text('Maam ${maHistoryItem.receivedBy}',
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: body16Regular.copyWith(
                                        color: const Color(0xFF64748B))),
                              ),
                            ],
                          ),
                          verticalSpace20,
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 160,
                                child: Text('mah10'.tr,
                                    textAlign: TextAlign.left,
                                    style: body16SemiBold),
                              ),
                              SizedBox(
                                width: Get.width - 220,
                                child: Text(maHistoryItem.pharmacy!,
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: body16Regular.copyWith(
                                        color: const Color(0xFF64748B))),
                              ),
                            ],
                          ),
                          verticalSpace20,
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 160,
                                child: Text('mah11'.tr,
                                    textAlign: TextAlign.left,
                                    style: body16SemiBold),
                              ),
                              SizedBox(
                                width: Get.width - 220,
                                child: Text('Php ${maHistoryItem.medWorth}',
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: body16Regular.copyWith(
                                        color: const Color(0xFF64748B))),
                              ),
                            ],
                          ),
                          verticalSpace20,
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 160,
                                child: Text('mah12'.tr,
                                    textAlign: TextAlign.left,
                                    style: body16SemiBold),
                              ),
                              SizedBox(
                                width: Get.width - 220,
                                child: Text(
                                    maHController.convertTimeStamp(
                                        maHistoryItem.dateRqstd!),
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: body16Regular.copyWith(
                                        color: const Color(0xFF64748B))),
                              ),
                            ],
                          ),
                          verticalSpace20,
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 160,
                                child: Text('mah13'.tr,
                                    textAlign: TextAlign.left,
                                    style: body16SemiBold),
                              ),
                              SizedBox(
                                width: Get.width - 220,
                                child: Text(
                                    maHController.convertTimeStamp(
                                        maHistoryItem.dateClaimed!),
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: body16Regular.copyWith(
                                        color: const Color(0xFF64748B))),
                              ),
                            ],
                          ),
                        ]),
                  ],
                ),
                verticalSpace25,
                Align(
                  alignment: FractionalOffset.bottomLeft,
                  child: CustomButton(
                    onTap: () async {
                      //TO DO - Open Dialog ang show the attached photos (Valid ID + Prescription)
                      controller.splitFetchedImage(
                          '${maHistoryItem.validID}>>>${maHistoryItem.prescriptions}>>>');
                      showDialog(
                          context: context,
                          builder: (context) => attachedPhotosDialog());
                    },
                    text: 'mah14'.tr,
                    buttonColor: verySoftBlueColor,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget attachedPhotosDialog() {
    return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      contentPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: IconButton(
                onPressed: controller.prevPhoto,
                icon: const Icon(
                  Icons.arrow_back_ios_rounded,
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                height: Get.height * .7,
                width: Get.width * .7,
                color: Colors.transparent,
                child: Obx(
                  () => CarouselSlider.builder(
                    carouselController: controller.crslController,
                    itemCount: controller.fetchedImages.length - 1,
                    itemBuilder: (context, index, realIndex) {
                      return buildImage(index);
                    },
                    options: CarouselOptions(
                        initialPage: controller.selectedIndex.value,
                        viewportFraction: 1,
                        height: double.infinity,
                        enlargeCenterPage: true,
                        enableInfiniteScroll: false,
                        onPageChanged: (index, reason) =>
                            controller.selectedIndex.value = index),
                  ),
                ),
              ),
            ),
            Expanded(
              child: IconButton(
                onPressed: controller.nextPhoto,
                icon: const Icon(
                  Icons.arrow_forward_ios_rounded,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 110,
          width: Get.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.fetchedImages.length - 1,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Center(
                          child: Obx(
                            () => Container(
                              padding: const EdgeInsets.all(6),
                              color: index == controller.selectedIndex.value
                                  ? verySoftBlueColor
                                  : Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  controller.selectedIndex.value = index;
                                  controller.animateToSlide(index);
                                },
                                child: Image.network(
                                  controller.fetchedImages[index],
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(grayBlank,
                                        fit: BoxFit.cover);
                                  },
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildImage(int index) {
    return Container(
      color: Colors.grey,
      child: Image.network(
        controller.fetchedImages[index],
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(grayBlank, fit: BoxFit.cover);
        },
      ),
    );
  }
}
