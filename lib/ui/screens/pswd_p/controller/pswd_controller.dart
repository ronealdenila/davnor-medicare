import 'package:davnor_medicare/core/services/logger_service.dart.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';

class PSWDController extends GetxController {
  final log = getLogger('PSWD Controller');

  final crslController = CarouselController();
  final String tempFetchedImage =
      'https://firebasestorage.googleapis.com/v0/b/davnor-medicare-15c1d.appspot.com/o/MA%2F0-Pr-fa4607fb-0e76-4853-a952-f7a2fb1bc683image_picker3837953862599466745.jpg?alt=media&token=79ae42f0-0f5e-4488-9c92-28b0a30225f3>>>https://firebasestorage.googleapis.com/v0/b/davnor-medicare-15c1d.appspot.com/o/MA%2F1-Pr-5e2534c8-a07f-4cc1-b996-806407532111image_picker2469979465532642580.jpg?alt=media&token=b85345ff-8785-4ff9-ae6a-08f379bda305>>>https://firebasestorage.googleapis.com/v0/b/davnor-medicare-15c1d.appspot.com/o/MA%2F0-Pr-fa4607fb-0e76-4853-a952-f7a2fb1bc683image_picker3837953862599466745.jpg?alt=media&token=79ae42f0-0f5e-4488-9c92-28b0a30225f3>>>https://firebasestorage.googleapis.com/v0/b/davnor-medicare-15c1d.appspot.com/o/MA%2F1-Pr-5e2534c8-a07f-4cc1-b996-806407532111image_picker2469979465532642580.jpg?alt=media&token=b85345ff-8785-4ff9-ae6a-08f379bda305>>>https://firebasestorage.googleapis.com/v0/b/davnor-medicare-15c1d.appspot.com/o/MA%2F0-Pr-fa4607fb-0e76-4853-a952-f7a2fb1bc683image_picker3837953862599466745.jpg?alt=media&token=79ae42f0-0f5e-4488-9c92-28b0a30225f3>>>https://firebasestorage.googleapis.com/v0/b/davnor-medicare-15c1d.appspot.com/o/MA%2F1-Pr-5e2534c8-a07f-4cc1-b996-806407532111image_picker2469979465532642580.jpg?alt=media&token=b85345ff-8785-4ff9-ae6a-08f379bda305>>>';
  final RxList<String> fetchedImages = RxList<String>([]);
  RxInt selectedIndex = 0.obs;

  @override
  void onInit() {
    splitFetchedImage();
    super.onInit();
  }

  void splitFetchedImage() {
    fetchedImages.value = tempFetchedImage.split('>>>');
    log.wtf(fetchedImages);
  }

  void animateToSlide(int index) => crslController.animateToPage(index);
  //next & prev function should be added here soon
  //instead of calling controller.crslController.nextPage
}
