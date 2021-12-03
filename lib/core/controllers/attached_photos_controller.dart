import 'package:carousel_slider/carousel_slider.dart';
import 'package:davnor_medicare/core/services/logger_service.dart';
import 'package:davnor_medicare/core/services/url_launcher_service.dart';
import 'package:get/get.dart';
import 'dart:async';

class AttachedPhotosController extends GetxController {
  final log = getLogger('Attached Photos Controller');
  final UrlLauncherService _urlLauncherService = UrlLauncherService();

  final crslController = CarouselController();
  final RxList<String> fetchedImages = RxList<String>([]);
  RxInt selectedIndex = 0.obs;

  Future<void> splitFetchedImage(String images) async {
    fetchedImages.value = images.split('>>>');
    log.wtf(fetchedImages);
  }

  void animateToSlide(int index) => crslController.animateToPage(index);

  void nextPhoto() => crslController.nextPage();

  void prevPhoto() => crslController.previousPage();

  // Future<void> downloadImage() async {
  //   final ref = storage.refFromURL(fetchedImages[selectedIndex.value]);
  //   Directory appDocDir = await getApplicationDocumentsDirectory();
  //   File downloadToFile = File('${appDocDir.path}/${ref.name}');
  //   print('${downloadToFile}');
  //   await storage.ref('${ref.fullPath}').writeToFile(downloadToFile);
  // }

  Future<void> launchOpenImage() async {
    _urlLauncherService.launchURL(fetchedImages[selectedIndex.value]);
  }
}
