import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/core/controllers/doctor/consultations_controller.dart';
import 'package:davnor_medicare/core/models/consultation_model.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/widgets/cons_card_web.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_responsive.dart';

class ConsRequestsWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: ResponsiveBody(),
      ),
    );
  }
}

class ResponsiveBody extends GetResponsiveView {
  final ConsultationsController consRequests =
      Get.put(ConsultationsController());
  static ConsultationsController doctorHomeController = Get.find();
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
                width: Get.width * .6,
                color: Colors.greenAccent,
                child: RequestsChatView())),
        Expanded(
            flex: 4,
            child: Container(
                width: Get.width * .3,
                child: Obx(() => consRequests.isLoading.value
                    ? SizedBox(
                        height: 0,
                        width: 0,
                      )
                    : RequestsInfoView(consRequests.consultations[0]))))
      ],
    );
  }

  Widget RequestsListView() {
    return requestList();
  }

  Widget requestList() {
    if (consRequests.isLoading.value) {
      return Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: const SizedBox(
              height: 24, width: 24, child: CircularProgressIndicator()),
        ),
      );
    }
    if (consRequests.consultations.isEmpty && !consRequests.isLoading.value) {
      return const Center(child: Text('No consultation request at the moment'));
    }
    return ListView.builder(
      padding: const EdgeInsets.only(right: 10),
      shrinkWrap: true,
      itemCount: consRequests.consultations.length,
      itemBuilder: (context, index) {
        return displayConsultations(consRequests.consultations[index]);
      },
    );
  }

  Widget displayConsultations(ConsultationModel model) {
    return FutureBuilder(
      future: consRequests.getPatientData(model),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ConsultationCardWeb(
              consReq: model,
              onItemTap: () {
                //Get.to(() => ConsRequestItemScreen(), arguments: model);
              });
        }
        return loadingCardIndicator();
      },
    );
  }

  Widget RequestsChatView() {
    return Text('Chat');
  }

  Widget RequestsInfoView(ConsultationModel consData) {
    return ListView(children: <Widget>[
      Container(
        width: Get.width,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color(0xFFCBD4E1),
            ),
          ),
        ),
        child: Column(children: <Widget>[
          verticalSpace15,
          Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              child: getPhoto(consData)),
          verticalSpace20,
          Text(
            doctorHomeController.getFullName(consData),
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: subtitle18Medium,
            textAlign: TextAlign.center,
          ),
          verticalSpace25
        ]),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalSpace35,
            Text('Consultation Info',
                textAlign: TextAlign.left,
                style: body16Regular.copyWith(color: const Color(0xFF727F8D))),
            verticalSpace20,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 170,
                  child: Text('Patient',
                      textAlign: TextAlign.left, style: body14SemiBold),
                ),
                Flexible(
                  child: SizedBox(
                    width: Get.width - 230,
                    child: Text(consData.fullName!,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: body14Regular),
                  ),
                ),
              ],
            ),
            verticalSpace15,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 170,
                  child: Text('Age of Patient',
                      textAlign: TextAlign.left, style: body14SemiBold),
                ),
                Flexible(
                  child: SizedBox(
                    width: Get.width - 230,
                    child: Text(consData.age!,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: body14Regular),
                  ),
                ),
              ],
            ),
            verticalSpace15,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 170,
                  child: Text('Date Requested',
                      textAlign: TextAlign.left, style: body14SemiBold),
                ),
                Flexible(
                  child: SizedBox(
                    width: Get.width - 230,
                    child: Text(
                        doctorHomeController
                            .convertTimeStamp(consData.dateRqstd!),
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: body14Regular),
                  ),
                ),
              ],
            ),
            verticalSpace15,
          ],
        ),
      ),
    ]);
  }

  Widget getPhoto(ConsultationModel model) {
    if (doctorHomeController.getProfilePhoto(model) == '') {
      return CircleAvatar(
        radius: 50,
        backgroundImage: AssetImage(blankProfile),
      );
    }
    return CircleAvatar(
      radius: 50,
      backgroundImage:
          NetworkImage(doctorHomeController.getProfilePhoto(model)),
    );
  }
}
