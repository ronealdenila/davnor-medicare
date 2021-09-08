import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AttachedPhotosScreen extends StatelessWidget {
  final dynamic args = Get.arguments;
  final RxList<String> imgs = RxList<String>();
  final controller = CarouselController();
  final RxInt activeInx = 0.obs;
  final RxBool isSelected = false.obs;

  @override
  Widget build(BuildContext context) {
    activeInx.value = args[0] as int;
    imgs.value = args[1] as List<String>;
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          verticalSpace50,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: IconButton(
                  onPressed: controller.previousPage,
                  icon: const Icon(
                    Icons.arrow_back_ios_rounded,
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: CarouselSlider.builder(
                  carouselController: controller,
                  itemCount: imgs.length - 1,
                  itemBuilder: (context, index, realIndex) {
                    final image = imgs[index];
                    return buildImage(image, index);
                  },
                  options: CarouselOptions(
                      initialPage: activeInx.value,
                      viewportFraction: 1,
                      height: Get.height * .7,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: false,
                      onPageChanged: (index, reason) =>
                          activeInx.value = index),
                ),
              ),
              Expanded(
                child: IconButton(
                  onPressed: controller.nextPage,
                  icon: const Icon(
                    Icons.arrow_forward_ios_rounded,
                  ),
                ),
              ),
            ],
          ),
          verticalSpace35,
          Obx(buildImgIndicator),
        ],
      ),
    )));
  }

  Widget buildImage(String image, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      color: Colors.grey,
      child: Image.network(
        image,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget buildImgIndicator() {
    return SizedBox(
      height: 112,
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: imgs.length - 1,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Center(
                      child: Obx(
                        () => Container(
                          padding: const EdgeInsets.all(6),
                          color: index == activeInx.value
                              ? verySoftBlueColor
                              : Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              activeInx.value = index;
                              animateToSlide(index);
                            },
                            child: Image.network(
                              imgs[index],
                              height: index == activeInx.value ? 100 : 90,
                              width: index == activeInx.value ? 100 : 90,
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
    );
  }

  void animateToSlide(int index) => controller.animateToPage(index);
}
