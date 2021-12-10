import 'package:carousel_slider/carousel_slider.dart';
import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/core/controllers/attached_photos_controller.dart';
import 'package:davnor_medicare/core/services/url_launcher_service.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/widgets/patient/dialog_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhotoViewerScreen extends StatelessWidget {
  final AttachedPhotosController controller = Get.find();
  final UrlLauncherService _urlLauncherService = UrlLauncherService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: GestureDetector(
                    onHorizontalDragEnd: (DragEndDetails details) {
                      if (details.primaryVelocity! > 0) {
                        controller.prevPhoto();
                      } else if (details.primaryVelocity! < 0) {
                        controller.nextPhoto();
                      }
                    },
                    child: Container(
                      width: Get.width,
                      color: Colors.grey,
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
                ),
                forMultiplePhotos()
              ],
            ),
            Positioned(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: Get.back,
                      child: Icon(
                        Icons.arrow_back_outlined,
                        color: neutralColor[100],
                        size: 30,
                      ),
                    ),
                    SizedBox(
                      width: 130,
                      child: ErrorDialogButton(
                        buttonText: 'Open Image',
                        onTap: () async {
                          if (controller.fetchedImages.length == 1) {
                            _urlLauncherService
                                .launchURL(controller.fetchedImages[0]);
                          } else {
                            await controller.launchOpenImage();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
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

  Widget forMultiplePhotos() {
    if (controller.fetchedImages.length == 1) {
      return SizedBox(
        height: 0,
        width: 0,
      );
    }
    return SizedBox(
      height: 60,
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
                              height: 50,
                              width: 50,
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
    );
  }
}
