import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/core/controllers/doctor/consultations_controller.dart';
import 'package:davnor_medicare/core/controllers/pswd/attached_photos_controller.dart';
import 'package:davnor_medicare/core/controllers/status_controller.dart';
import 'package:davnor_medicare/core/models/consultation_model.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:davnor_medicare/ui/screens/doctor/cons_req_info.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:davnor_medicare/constants/asset_paths.dart';

final AttachedPhotosController controller = Get.find();

class ConsRequestItemScreen extends StatelessWidget {
  final ConsultationsController consRequests = Get.find();
  final ConsultationModel consData = Get.arguments as ConsultationModel;
  static AuthController authController = Get.find();
  final fetchedData = authController.doctorModel.value;
  final StatusController stats = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          elevation: 1,
          title: Row(
            children: [
              Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: getPhoto(consData)),
              horizontalSpace15,
              Expanded(
                child: SizedBox(
                  child: Text(
                    consRequests.getFullName(consData),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: subtitle18Medium.copyWith(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.info_outline,
                size: 30,
              ),
              onPressed: () => Get.to(() => ConsReqInfoScreen(),
                  arguments: consData, transition: Transition.rightToLeft),
            ),
            horizontalSpace10,
          ],
        ),
        body: SizedBox(
          width: Get.width,
          height: Get.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(25),
                      child: Column(
                        children: [
                          Row(
                            //Bubble chat
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Container(
                                    constraints: BoxConstraints(
                                        maxWidth: Get.width * .7),
                                    padding: const EdgeInsets.all(15),
                                    decoration: const BoxDecoration(
                                      color: neutralBubbleColor,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                    ),
                                    child: Text(
                                      consData.description!,
                                      style: body16Medium.copyWith(height: 1.4),
                                    )),
                              ),
                            ],
                          ),
                          verticalSpace15,
                          displayImages(context),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              startConsultationButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget startConsultationButton() {
    return Align(
      alignment: FractionalOffset.bottomCenter,
      child: Container(
        color: customNeutralColor2,
        width: Get.width,
        height: 100,
        child: Center(
          child: InkWell(
            onTap: () {
              if (stats.doctorStatus[0].dStatus!) {
                if (stats.doctorStatus[0].hasOngoingCons!) {
                  showErrorDialog(
                      errorTitle:
                          'Sorry, you still have an on progress consultation',
                      errorDescription:
                          'Please make sure to end your accepted consultation first before starting new one');
                } else {
                  if (consRequests.mobileIndex.value == 0) {
                    if (stats.doctorStatus[0].numToAccomodate! >
                        stats.doctorStatus[0].accomodated!) {
                      consRequests.startConsultation(consData);
                    } else {
                      showErrorDialog(
                          errorTitle:
                              'Looks like you already accomodated your desired number of patient',
                          errorDescription:
                              'You can add more number to accomodate');
                    }
                  } else {
                    showErrorDialog(
                        errorTitle: 'Please select the first request',
                        errorDescription:
                            'You are not allowed to accept request that are not the first one');
                  }
                }
              } else {
                showErrorDialog(
                    errorTitle:
                        'Please make sure to change your status to available',
                    errorDescription:
                        'You are not allowed to accept request when unavailable');
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: verySoftBlueColor[60],
                borderRadius: BorderRadius.circular(10),
              ),
              width: 255,
              height: 43,
              child: Center(
                child: Text(
                  'Start Consultation',
                  style: body16SemiBold.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getPhoto(ConsultationModel model) {
    if (consRequests.getProfilePhoto(model) == '') {
      return CircleAvatar(
        radius: 25,
        backgroundImage: AssetImage(blankProfile),
      );
    }
    return CircleAvatar(
      radius: 25,
      foregroundImage: NetworkImage(consRequests.getProfilePhoto(model)),
      backgroundImage: AssetImage(blankProfile),
    );
  }

  Widget displayImages(BuildContext context) {
    if (consData.imgs != '' &&
        consData.imgs!.startsWith('https://firebasestorage.googleapis.com/')) {
      final displayImages = consData.imgs!.split('>>>');
      if (displayImages.length == 1) {
        return displaySingleImage(consData.imgs!, context);
      } else if (displayImages.length > 1) {
        displayImages.removeLast(); //remove excess >>> ""
        return displayMultipleImages(displayImages, context);
      }
    }
    return SizedBox(height: 0, width: 0);
  }

  Widget displaySingleImage(String img, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
              constraints: BoxConstraints(maxWidth: Get.width * .7),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: neutralBubbleColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => attachedPhotoDialog(img));
                },
                child: Image.network(
                  img,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(grayBlank, fit: BoxFit.cover);
                  },
                ),
              )),
        ),
      ],
    );
  }

  Widget displayMultipleImages(
      List<String> displayImages, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            constraints: BoxConstraints(maxWidth: Get.width * .7),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: neutralBubbleColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              crossAxisCount:
                  displayImages.length < 3 ? displayImages.length : 3,
              children: List.generate(displayImages.length, (index) {
                return Container(
                  height: 68.5,
                  color: Colors.white,
                  child: Center(
                      child: InkWell(
                    onTap: () {
                      controller.fetchedImages.assignAll(displayImages);
                      controller.selectedIndex.value = index;
                      showDialog(
                          context: context,
                          builder: (context) => attachedPhotosDialog());
                    },
                    child: Image.network(
                      displayImages[index],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(grayBlank, fit: BoxFit.cover);
                      },
                    ),
                  )),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
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
              height: kIsWeb ? Get.height * .7 : Get.height * .8,
              width: kIsWeb ? Get.height * .7 : Get.width * .9,
              color: Colors.transparent,
              child: Obx(
                () => CarouselSlider.builder(
                  carouselController: controller.crslController,
                  itemCount: controller.fetchedImages.length,
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
        height: kIsWeb ? 110 : 60,
        width: Get.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.fetchedImages.length,
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
                                height: kIsWeb ? 100 : 50,
                                width: kIsWeb ? 100 : 50,
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
      fit: BoxFit.fitWidth,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(grayBlank, fit: BoxFit.cover);
      },
    ),
  );
}

Widget attachedPhotoDialog(String imgURL) {
  return SimpleDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    contentPadding: EdgeInsets.zero,
    titlePadding: EdgeInsets.zero,
    children: [
      Container(
        decoration: const BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(
              Radius.circular(40),
            )),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        width: Get.width * .9,
        child: Container(
          color: Colors.white,
          child: Image.network(
            imgURL,
            fit: BoxFit.fitHeight,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(grayBlank, fit: BoxFit.cover);
            },
          ),
        ),
      ),
    ],
  );
}
