import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:davnor_medicare/ui/screens/pswd_p/controller/attached_photos_controller.dart';

final AttachedPhotosController controller = Get.find();

class PSWDItemView extends GetResponsiveView {
  PSWDItemView(this.context, this.status) : super(alwaysUseBuilder: false);
  final String status;
  final BuildContext context;

  @override
  Widget phone() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpace35,
          patientInfo(),
          verticalSpace35,
          attachedPhotos(),
          verticalSpace35,
        ],
      );

  @override
  Widget tablet() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpace35,
          patientInfo(),
          verticalSpace35,
          attachedPhotos(),
          verticalSpace35,
        ],
      );

  @override
  Widget desktop() => Column(
        children: [
          verticalSpace35,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              patientInfo(),
              attachedPhotos(),
            ],
          ),
          verticalSpace35,
        ],
      );

  Widget patientInfo() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(authHeader),
            radius: 29,
          ),
          horizontalSpace20,
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
            Text(
              'Olivia Broken ',
              style: subtitle18Bold,
            ),
            verticalSpace5,
            Text(
              'Request Person ',
              style: caption12Medium,
            ),
          ]),
          horizontalSpace20,
          Visibility(
            visible: status == 'accepted',
            child: IconButton(
              icon: const Icon(
                Icons.videocam_rounded,
                color: verySoftBlueCustomColor,
              ),
              onPressed: () {
                //call request patient for interview
              },
            ),
          )
        ],
      ),
      verticalSpace25,
      Text(
        "Patient's Infomation",
        style: subtitle18MediumNeutral,
      ),
      verticalSpace15,
      Row(
        children: const [
          SizedBox(
            width: 120,
            child: Text('Patient Name',
                textAlign: TextAlign.left, style: caption12Medium),
          ),
          Text('Arya Stark', style: caption12RegularNeutral),
        ],
      ),
      verticalSpace15,
      Row(
        children: const [
          SizedBox(
              width: 120,
              child: Text('Patient Age',
                  textAlign: TextAlign.left, style: caption12Medium)),
          Text('22', style: caption12RegularNeutral),
        ],
      ),
      verticalSpace15,
      Row(
        children: const [
          SizedBox(
              width: 120,
              child: Text('Address',
                  textAlign: TextAlign.left, style: caption12Medium)),
          Text('San Miguel Tagum City', style: caption12RegularNeutral),
        ],
      ),
      verticalSpace15,
      Row(
        children: const [
          SizedBox(
              width: 120,
              child: Text('Gender',
                  textAlign: TextAlign.left, style: caption12Medium)),
          Text('Female', style: caption12RegularNeutral),
        ],
      ),
      verticalSpace15,
      Row(
        children: const [
          SizedBox(
            width: 120,
            child: Text('Patient Type',
                textAlign: TextAlign.left, style: caption12Medium),
          ),
          Text('Pregnant Women', style: caption12RegularNeutral),
        ],
      ),
      Visibility(visible: status != 'request', child: medicalAssistanceInfo())
    ]);
  }

  Widget medicalAssistanceInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        verticalSpace35,
        Text(
          'MA Request Infomation',
          style: subtitle18MediumNeutral,
        ),
        verticalSpace15,
        Row(
          children: const [
            SizedBox(
              width: 120,
              child: Text('Received by',
                  textAlign: TextAlign.left, style: caption12Medium),
            ),
            Text('Maam Grace', style: caption12RegularNeutral),
          ],
        ),
        Visibility(
          visible: status == 'medReady' || status == 'completed',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace15,
              Row(
                children: const [
                  SizedBox(
                      width: 120,
                      child: Text('Pharmacy',
                          textAlign: TextAlign.left, style: caption12Medium)),
                  Text('Rose Pharmacy', style: caption12RegularNeutral),
                ],
              ),
              verticalSpace15,
              Row(
                children: const [
                  SizedBox(
                      width: 120,
                      child: Text('Medicine Worth',
                          textAlign: TextAlign.left, style: caption12Medium)),
                  Text('Php 800.00', style: caption12RegularNeutral),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget attachedPhotos() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(
        width: 310,
        child: Text(
          'Attached Photos',
          style: caption12RegularNeutral,
        ),
      ),
      verticalSpace20,
      Container(
        width: 310,
        height: 170,
        decoration: BoxDecoration(
          color: neutralColor[10],
          borderRadius: BorderRadius.circular(2),
        ),
        child: GridView.count(
          shrinkWrap: true,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          crossAxisCount: 3,
          children: List.generate(controller.fetchedImages.length - 1, (index) {
            return GestureDetector(
              onTap: () {
                controller.selectedIndex.value = index;
                showDialog(
                    context: context,
                    builder: (context) => attachedPhotosDialog());
              },
              child: Image.network(
                controller.fetchedImages[index],
                width: 5,
                height: 5,
                fit: BoxFit.fill,
              ),
            );
          }),
        ),
      ),
      verticalSpace20,
      Row(children: const [
        SizedBox(
          width: 120,
          child: Text(
            'Date Requested',
            style: caption12SemiBold,
          ),
        ),
        horizontalSpace15,
        Text(
          'July 01, 2021 (9:00 am)',
          style: caption12RegularNeutral,
        ),
      ]),
      verticalSpace10,
      Visibility(
        visible: status == 'completed',
        child: Row(children: const [
          SizedBox(
            width: 120,
            child: Text(
              'Date MA Claimed',
              style: caption12SemiBold,
            ),
          ),
          horizontalSpace15,
          Text(
            'July 01, 2021 (9:00 am)',
            style: caption12RegularNeutral,
          ),
        ]),
      ),
    ]);
  }
}

Widget attachedPhotosDialog() {
  return SimpleDialog(
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
    ),
  );
}
