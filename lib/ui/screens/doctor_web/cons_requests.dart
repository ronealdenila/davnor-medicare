import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/core/controllers/doctor/consultations_controller.dart';
import 'package:davnor_medicare/core/controllers/attached_photos_controller.dart';
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
  final ConsultationsController consRequests = Get.find();
  final RxBool errorPhoto = false.obs;
  final RxBool errorPhoto2 = false.obs;
  //final ConsultationsController doctorHomeController = Get.find();

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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            flex: 3,
            child: Container(
                width: Get.width * .3, child: Obx(() => RequestsListView()))),
        Expanded(
            flex: 6,
            child: Container(
                width: Get.width * .7,
                child: Obx(() => RequestsChatView(context)))),
      ],
    );
  }

  Widget DesktopScreen() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            flex: 3,
            child: Container(
                width: Get.width * .3,
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Color(0xFFCBD4E1),
                    ),
                  ),
                ),
                child: Obx(() => RequestsListView()))),
        Expanded(
            flex: 6,
            child: Container(
                width: Get.width * .7,
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Color(0xFFCBD4E1),
                    ),
                    left: BorderSide(
                      color: Color(0xFFCBD4E1),
                    ),
                    right: BorderSide(
                      color: Color(0xFFCBD4E1),
                    ),
                  ),
                ),
                child: Obx(() => RequestsChatView(context)))),
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
                child: Obx(() => RequestsInfoView())))
      ],
    );
  }

  Widget RequestsListView() {
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
      return Text(
        'No consultation request at the moment',
        textAlign: TextAlign.center,
      );
    }
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: consRequests.consultations.length,
        itemBuilder: (context, index) {
          return displayConsultations(consRequests.consultations[index], index);
        },
      ),
    );
  }

  Widget displayConsultations(ConsultationModel model, int index) {
    return FutureBuilder(
      future: consRequests.getPatientData(model),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Obx(
            () => Container(
              color: consRequests.selectedIndex.value == index
                  ? neutralBubbleColor
                  : Colors.white,
              child: ConsultationCardWeb(
                  consReq: model,
                  onItemTap: () {
                    consRequests.selectedIndex.value = index;
                  }),
            ),
          );
        }
        return loadingCardIndicator();
      },
    );
  }

  Widget RequestsChatView(BuildContext context) {
    if (consRequests.isLoading.value || consRequests.consultations.isEmpty) {
      return Container();
    }
    if (consRequests
            .consultations[consRequests.selectedIndex.value].data.value ==
        null) {
      return Container();
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        screen.isDesktop
            ? topHeaderRequest(
                consRequests.consultations[consRequests.selectedIndex.value])
            : topHeaderRequestWeb(
                consRequests.consultations[consRequests.selectedIndex.value]),
        Expanded(
          child: ListView(
            padding: EdgeInsets.fromLTRB(15, 5, 15, 15),
            shrinkWrap: true,
            children: [
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Container(
                            constraints: BoxConstraints(
                                maxWidth:
                                    Get.width * (screen.isDesktop ? .2 : .45)),
                            padding: const EdgeInsets.all(15),
                            decoration: const BoxDecoration(
                              color: verySoftBlueColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            child: Text(
                              consRequests
                                  .consultations[
                                      consRequests.selectedIndex.value]
                                  .description!,
                              style: body16Medium.copyWith(
                                  height: 1.4, color: Colors.white),
                            )),
                      ),
                    ],
                  ),
                  verticalSpace15,
                  displayImages(
                      context,
                      consRequests
                          .consultations[consRequests.selectedIndex.value]),
                ],
              ),
            ],
          ),
        ),
        startConsultationButton(
            consRequests.consultations[consRequests.selectedIndex.value],
            consRequests.selectedIndex.value)
      ],
    );
  }

  Widget topHeaderRequest(ConsultationModel consData) {
    return Align(
      alignment: FractionalOffset.topCenter,
      child: Container(
        width: Get.width,
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: getPhotoHeader(consData)),
            horizontalSpace15,
            Flexible(
              child: Text(
                consRequests.getFullName(consData),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: subtitle18Medium.copyWith(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget topHeaderRequestWeb(ConsultationModel consData) {
    return Align(
      alignment: FractionalOffset.topCenter,
      child: Container(
        width: Get.width,
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            Flexible(
              child: Row(
                children: [
                  Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: getPhotoHeader(consData)),
                  horizontalSpace15,
                  Flexible(
                    child: Text(
                      consRequests.getFullName(consData),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: subtitle18Medium.copyWith(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: IconButton(
                icon: const Icon(
                  Icons.info_outline,
                  size: 30,
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => infoDialog(consData));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getPhotoHeader(ConsultationModel model) {
    return CircleAvatar(
        radius: 25,
        foregroundImage: NetworkImage(consRequests.getProfilePhoto(model)),
        onForegroundImageError: (_, __) {
          errorPhoto2.value = true;
        },
        backgroundColor: Colors.grey,
        child: Obx(
          () => errorPhoto2.value
              ? Text(
                  '${consRequests.getFirstName(model)[0]}',
                )
              : SizedBox(
                  height: 0,
                  width: 0,
                ),
        ));
  }

  Widget startConsultationButton(ConsultationModel consData, int index) {
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
                  if (index == 0) {
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

  Widget RequestsInfoView() {
    if (consRequests.isLoading.value || consRequests.consultations.isEmpty) {
      return SizedBox();
    }
    if (consRequests
            .consultations[consRequests.selectedIndex.value].data.value ==
        null) {
      return SizedBox();
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
        Widget>[
      Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color(0xFFCBD4E1),
            ),
          ),
        ),
        width: Get.width,
        child: Column(children: <Widget>[
          verticalSpace15,
          Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              child: getPhoto(consRequests
                  .consultations[consRequests.selectedIndex.value])),
          verticalSpace20,
          Text(
            consRequests.getFullName(
                consRequests.consultations[consRequests.selectedIndex.value]),
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
            style: subtitle18Medium,
            textAlign: TextAlign.center,
          ),
          verticalSpace25
        ]),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalSpace35,
            Text('Consultation Info',
                textAlign: TextAlign.left,
                style: body16Regular.copyWith(color: const Color(0xFF727F8D))),
            verticalSpace20,
            Wrap(
              runSpacing: 8,
              children: [
                const SizedBox(
                  width: 170,
                  child: Text('Patient',
                      textAlign: TextAlign.left, style: body14SemiBold),
                ),
                SizedBox(
                  width: 170,
                  child: Text(
                      consRequests
                          .consultations[consRequests.selectedIndex.value]
                          .fullName!,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: body14Regular),
                ),
              ],
            ),
            verticalSpace15,
            Wrap(
              runSpacing: 8,
              children: [
                const SizedBox(
                  width: 170,
                  child: Text('Age of Patient',
                      textAlign: TextAlign.left, style: body14SemiBold),
                ),
                SizedBox(
                  width: 170,
                  child: Text(
                      consRequests
                          .consultations[consRequests.selectedIndex.value].age!,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: body14Regular),
                ),
              ],
            ),
            verticalSpace15,
            Wrap(
              runSpacing: 8,
              children: [
                const SizedBox(
                  width: 170,
                  child: Text('Date Requested',
                      textAlign: TextAlign.left, style: body14SemiBold),
                ),
                SizedBox(
                  width: 170,
                  child: Text(
                      consRequests.convertTimeStamp(consRequests
                          .consultations[consRequests.selectedIndex.value]
                          .dateRqstd!),
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: body14Regular),
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
    return CircleAvatar(
        radius: 50,
        foregroundImage: NetworkImage(consRequests.getProfilePhoto(model)),
        onForegroundImageError: (_, __) {
          errorPhoto.value = true;
        },
        backgroundColor: Colors.grey,
        child: Obx(
          () => errorPhoto.value
              ? Text(
                  '${consRequests.getFirstName(model)[0]}',
                )
              : SizedBox(
                  height: 0,
                  width: 0,
                ),
        ));
  }

  Widget displayImages(BuildContext context, ConsultationModel consData) {
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
              constraints: BoxConstraints(
                  maxWidth: Get.width * (screen.isDesktop ? .2 : .45)),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: verySoftBlueColor,
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
            constraints: BoxConstraints(
                maxWidth: Get.width * (screen.isDesktop ? .2 : .45)),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: verySoftBlueColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
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
        ),
      ],
    );
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
                height: Get.height * .7,
                width: Get.height * .7,
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
          height: 110,
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

  Widget infoDialog(ConsultationModel model) {
    return SimpleDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        contentPadding: EdgeInsets.symmetric(
          vertical: 30,
          horizontal: 50,
        ),
        children: [
          SizedBox(
              width: Get.width * .5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [RequestsInfoView()],
              ))
        ]);
  }
}
