import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/core/controllers/doctor/consultations_controller.dart';
import 'package:davnor_medicare/core/controllers/pswd/attached_photos_controller.dart';
import 'package:davnor_medicare/core/models/consultation_model.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:davnor_medicare/ui/screens/doctor_web/home.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/widgets/cons_card_web.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_responsive.dart';
import 'package:shimmer/shimmer.dart';

class ConsRequestsWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: ResponsiveBody(context),
      ),
    );
  }
}

class ResponsiveBody extends GetResponsiveView {
  ResponsiveBody(this.context);
  final BuildContext context;
  final AttachedPhotosController controller = Get.find();
  final ConsultationsController consRequests =
      Get.put(ConsultationsController());
  final ConsultationsController doctorHomeController = Get.find();
  final RxInt selectedIndex = 0.obs;
  final RxBool displayData = false.obs;

  @override
  Widget? builder() {
    if (screen.isDesktop) {
      return DesktopScreen();
    } else {
      return TabletScreen();
    }
  }

  Widget TabletScreen() {
    return Row(
      children: [Text('sds')],
    );
  }

  Widget DesktopScreen() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            flex: 3,
            child: Container(width: Get.width * .3, child: RequestsListView())),
        Expanded(
            flex: 6,
            child: Container(
                width: Get.width * .7,
                child: Obx(() => consRequests.isLoadingPatientData.value
                    ? Shimmer.fromColors(
                        baseColor: neutralColor[10]!,
                        highlightColor: Colors.white,
                        child: SizedBox(
                          height: Get.height,
                          width: Get.width,
                        ),
                      )
                    : RequestsChatView(
                        consRequests.consultations[selectedIndex.value],
                        context)))),
        Expanded(
            flex: 3,
            child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Color(0xFFCBD4E1),
                    ),
                  ),
                ),
                height: Get.height,
                width: Get.width * .2,
                child: Obx(() => consRequests.isLoadingPatientData.value
                    ? Shimmer.fromColors(
                        baseColor: neutralColor[10]!,
                        highlightColor: Colors.white,
                        child: SizedBox(
                          height: Get.height,
                          width: Get.width,
                        ),
                      )
                    : RequestsInfoView(
                        consRequests.consultations[selectedIndex.value]))))
      ],
    );
  }

  Widget RequestsListView() {
    return SizedBox();
  }

  Widget RequestsChatView(ConsultationModel consData, BuildContext context) {
    return SizedBox();
  }

  Widget RequestsInfoView(ConsultationModel consData) {
    return SizedBox();
  }
}
