import 'package:carousel_slider/carousel_slider.dart';
import 'package:davnor_medicare/core/services/logger_service.dart';
import 'package:get/get.dart';

class AttachedPhotosController extends GetxController {
  final log = getLogger('Attached Photos Controller');

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
}
