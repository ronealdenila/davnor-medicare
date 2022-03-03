import 'package:carousel_slider/carousel_slider.dart';
import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/core/controllers/app_controller.dart';
import 'package:davnor_medicare/core/controllers/ma_history_controller.dart';
import 'package:davnor_medicare/core/controllers/attached_photos_controller.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/widgets/patient/dialog_button.dart';
import 'package:davnor_medicare/ui/widgets/patient/mah_card_web.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MaHistoryWebScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveBody(context),
    );
  }
}

class ResponsiveBody extends GetResponsiveView {
  ResponsiveBody(this.context);
  final BuildContext context;
  final AttachedPhotosController controller = Get.find();
  final MAHistoryController maHController = Get.put(MAHistoryController());
  final RxInt selectedIndex = 0.obs;
  final AppController appController = Get.find();
  final _scrollController1 = ScrollController();
  final _scrollController2 = ScrollController();
  final RxBool doneLoad = false.obs;
  final RxBool firedOnce = false.obs;

  @override
  Widget? builder() {
    //if (screen.isDesktop) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, bottom: 10),
        child: Text('conshistory'.tr, style: title24BoldWhite),
      ),
      verticalSpace5,
      Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                if (maHController.isLoading.value) {
                  showSimpleErrorDialog(errorDescription: 'conslog'.tr);
                } else if (maHController.maHistoryList.isEmpty) {
                  showSimpleErrorDialog(errorDescription: 'conslog1'.tr);
                } else {
                  maHController.showDialog(context);
                  selectedIndex.value = 0;
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: verySoftBlueColor[100],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'conslog2'.tr,
                      style: body14Medium.copyWith(color: Colors.white),
                    ),
                    horizontalSpace5,
                    const Icon(
                      Icons.calendar_today,
                      color: Colors.white,
                      size: 30,
                    ),
                  ],
                ),
              ),
            ),
            horizontalSpace18,
            SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    maHController.refresh();
                  },
                  child: Text(
                    'Reload',
                    style: body14SemiBoldWhite,
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(12),
                    primary: verySoftBlueColor[100],
                  ),
                )),
          ],
        ),
      ),
      verticalSpace10,
      Flexible(child: DesktopScreen())
    ]);
    // }
  }

  Widget DesktopScreen() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            flex: 3,
            child: Container(
                width: Get.width * .3,
                height: Get.height,
                decoration: const BoxDecoration(
                    border: Border(
                  top: BorderSide(
                    color: Color(0xFFCBD4E1),
                  ),
                  right: BorderSide(
                    color: Color(0xFFCBD4E1),
                  ),
                )),
                child: Obx(() => RequestsListView()))),
        Expanded(
            flex: 7,
            child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Color(0xFFCBD4E1),
                    ),
                  ),
                ),
                height: Get.height,
                width: Get.width * .7,
                child: SingleChildScrollView(
                  controller: _scrollController2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Obx(
                      () => RequestsInfoView(),
                    ),
                  ),
                )))
      ],
    );
  }

  Widget RequestsListView() {
    if (maHController.isLoading.value) {
      return Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: const SizedBox(
              height: 24, width: 24, child: CircularProgressIndicator()),
        ),
      );
    } else if (maHController.maHistoryList.isEmpty &&
        !maHController.isLoading.value) {
      return Text(
        'mahrec'.tr,
        textAlign: TextAlign.center,
        style: body14Medium,
      );
    }

    firedOnce.value
        ? null
        : maHController.filteredListforP.assignAll(maHController.maHistoryList);
    firedOnce.value = true;
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView.builder(
        controller: _scrollController1,
        shrinkWrap: true,
        itemCount: maHController.filteredListforP.length,
        itemBuilder: (context, index) {
          return Obx(() => Container(
                color: selectedIndex.value == index
                    ? verySoftOrange
                    : Colors.white,
                child: MAHistoryWCard(
                    maHistory: maHController.filteredListforP[index],
                    onTap: () {
                      selectedIndex.value = index;
                    }),
              ));
        },
      ),
    );
  }

  Widget RequestsInfoView() {
    if (maHController.maHistoryList.isEmpty || maHController.isLoading.value) {
      return SizedBox();
    }
    if (maHController.filtering.value &&
        maHController.filteredListforP.length == 0) {
      return SizedBox();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        verticalSpace35,
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.start,
          runSpacing: 25,
          children: [
            SizedBox(width: 500, child: displayPatientInfo()),
            SizedBox(width: 320, child: attachedPhotos()),
          ],
        ),
        verticalSpace35,
      ],
    );
  }

  Widget displayPatientInfo() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        "Patient's Infomation",
        style: subtitle20MediumNeutral,
      ),
      verticalSpace15,
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: 120,
            child: Text('Patient Name',
                textAlign: TextAlign.left, style: caption15Medium),
          ),
          Flexible(
            child: Text(
                maHController.filteredListforP[selectedIndex.value].fullName!,
                style: caption15RegularNeutral),
          ),
        ],
      ),
      verticalSpace15,
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
              width: 120,
              child: Text('Patient Age',
                  textAlign: TextAlign.left, style: caption15Medium)),
          Flexible(
            child: Text(
                maHController.filteredListforP[selectedIndex.value].age!,
                style: caption15RegularNeutral),
          ),
        ],
      ),
      verticalSpace15,
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
              width: 120,
              child: Text('Address',
                  textAlign: TextAlign.left, style: caption15Medium)),
          Flexible(
            child: Text(
                maHController.filteredListforP[selectedIndex.value].address!,
                style: caption15RegularNeutral),
          ),
        ],
      ),
      verticalSpace15,
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
              width: 120,
              child: Text('Gender',
                  textAlign: TextAlign.left, style: caption15Medium)),
          Flexible(
            child: Text(
                maHController.filteredListforP[selectedIndex.value].gender!,
                style: caption15RegularNeutral),
          ),
        ],
      ),
      verticalSpace15,
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: 120,
            child: Text('Patient Type',
                textAlign: TextAlign.left, style: caption15Medium),
          ),
          Flexible(
            child: Text(
                maHController.filteredListforP[selectedIndex.value].type!,
                style: caption15RegularNeutral),
          ),
        ],
      ),
      medicalAssistanceInfo()
    ]);
  }

  Widget medicalAssistanceInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        verticalSpace35,
        Text(
          'MA Request Infomation',
          style: subtitle20MediumNeutral,
        ),
        verticalSpace15,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              width: 120,
              child: Text('Received by',
                  textAlign: TextAlign.left, style: caption15Medium),
            ),
            Flexible(
              child: Text(
                  maHController
                      .filteredListforP[selectedIndex.value].receivedBy!,
                  style: caption15RegularNeutral),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalSpace15,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                    width: 120,
                    child: Text('Pharmacy',
                        textAlign: TextAlign.left, style: caption15Medium)),
                Flexible(
                  child: Text(
                      maHController
                          .filteredListforP[selectedIndex.value].pharmacy!,
                      style: caption15RegularNeutral),
                ),
              ],
            ),
            verticalSpace15,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                    width: 120,
                    child: Text('Medicine Worth',
                        textAlign: TextAlign.left, style: caption15Medium)),
                Flexible(
                  child: Text(
                      'Php ${maHController.filteredListforP[selectedIndex.value].medWorth!}',
                      style: caption15RegularNeutral),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget attachedPhotos() {
    controller.splitFetchedImage(
        '${maHController.filteredListforP[selectedIndex.value].validID}>>>${maHController.filteredListforP[selectedIndex.value].prescriptions}');
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 310,
            child: Text(
              'Attached Photos',
              style: subtitle18MediumNeutral,
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
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              crossAxisCount: 3,
              children:
                  List.generate(controller.fetchedImages.length - 1, (index) {
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
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(grayBlank, fit: BoxFit.cover);
                    },
                  ),
                );
              }),
            ),
          ),
          verticalSpace20,
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(
              width: 120,
              child: Text(
                'Date Requested',
                style: caption15SemiBold,
              ),
            ),
            horizontalSpace20,
            Flexible(
              child: Text(
                appController.convertTimeStamp(maHController
                    .filteredListforP[selectedIndex.value].dateRqstd!),
                style: caption15RegularNeutral,
              ),
            ),
          ]),
          verticalSpace10,
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(
              width: 130,
              child: Text(
                'Date MA Claimed',
                style: caption15SemiBold,
              ),
            ),
            horizontalSpace10,
            Flexible(
              child: Text(
                appController.convertTimeStamp(maHController
                    .filteredListforP[selectedIndex.value].dateClaimed!),
                style: caption15RegularNeutral,
              ),
            )
          ]),
        ]);
  }

  Widget attachedPhotosDialog() {
    return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      contentPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: SizedBox(
              width: 130,
              child: ErrorDialogButton(
                buttonText: 'Open Image',
                onTap: () async {
                  await controller.launchOpenImage();
                },
              ),
            ),
          ),
        ),
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
