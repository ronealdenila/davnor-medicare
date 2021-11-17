import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/core/controllers/cons_history_controller.dart';
import 'package:davnor_medicare/core/controllers/pswd/attached_photos_controller.dart';
import 'package:davnor_medicare/core/models/consultation_model.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/widgets/bubble_chat.dart';
import 'package:davnor_medicare/ui/widgets/consh_card_web.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

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
  final ConsHistoryController consHController =
      Get.put(ConsHistoryController());
  final RxInt selectedIndex = 0.obs;

  @override
  Widget? builder() {
    if (screen.isDesktop) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, bottom: 10),
            child: Text('conshistory'.tr, style: title24BoldWhite),
          ),
          verticalSpace5,
          InkWell(
            onTap: () {
              if (consHController.isLoading.value) {
                print('conslog'.tr);
              } else if (consHController.consHistory.isEmpty) {
                print('conslog1'.tr);
              } else {
                consHController.showDialog(context);
              }
            },
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Container(
                width: 170,
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
          ),
          verticalSpace10,
          Flexible(child: DesktopScreen()),
        ],
      );
    } else {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 10, bottom: 10),
          child: Text('conshistory'.tr, style: title24BoldWhite),
        ),
        verticalSpace5,
        InkWell(
          onTap: () {
            if (consHController.isLoading.value) {
              print('conslog'.tr);
            } else if (consHController.consHistory.isEmpty) {
              print('conslog1'.tr);
            } else {
              consHController.showDialog(context);
            }
          },
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Container(
              width: 170,
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
        ),
        verticalSpace10,
        Flexible(child: TabletScreen())
      ]);
    }
  }

  Widget TabletScreen() {
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
                )),
                child: RequestsListView())),
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
                child: Obx(() => consHController.isLoadingAdditionalData.value
                    ? Shimmer.fromColors(
                        baseColor: neutralColor[10]!,
                        highlightColor: Colors.white,
                        child: SizedBox(
                          height: Get.height,
                          width: Get.width,
                        ),
                      )
                    : RequestsChatView(
                        consHController.consHistory[selectedIndex.value],
                        context)))),
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
                )),
                child: RequestsListView())),
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
                child: Obx(() => consHController.isLoading.value
                    ? SizedBox()
                    : RequestsChatView(
                        consHController.consHistory[selectedIndex.value],
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
                child: Obx(() => consHController.isLoading.value
                    ? SizedBox()
                    : RequestsInfoView(
                        consHController.consHistory[selectedIndex.value]))))
      ],
    );
  }

  Widget RequestsListView() {
    return Obx(() => listBuilder());
  }

  Widget listBuilder() {
    if (consHController.isLoading.value) {
      return Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: const SizedBox(
              height: 24, width: 24, child: CircularProgressIndicator()),
        ),
      );
    }
    if (consHController.consHistory.isEmpty &&
        !consHController.isLoading.value) {
      return Text(
        'conslog3'.tr,
        textAlign: TextAlign.center,
        style: body14Medium,
      );
    }
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: consHController.consHistory.length,
        itemBuilder: (context, index) {
          return displayConsHistory(consHController.consHistory[index], index);
        },
      ),
    );
  }

  Widget displayConsHistory(ConsultationHistoryModel model, index) {
    return FutureBuilder(
      future: consHController.getDoctorData(model),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Obx(
            () => Container(
              color: selectedIndex.value == index
                  ? neutralBubbleColor
                  : Colors.white,
              child: ConsultationHistoryCardWeb(
                consHistory: model,
                onItemTap: () {
                  selectedIndex.value = index;
                  consHController.chatHistory.clear();
                },
              ),
            ),
          );
        }
        return loadingCardIndicator();
      },
    );
  }

  Widget RequestsChatView(
      ConsultationHistoryModel consData, BuildContext context) {
    if (consData.doc.value == null) {
      return Container();
    }
    print(selectedIndex.value);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        screen.isDesktop
            ? topHeaderRequest(consData)
            : topHeaderRequestWeb(consData),
        Expanded(
          child: Obx(() => FutureBuilder(
              future: consHController.getChatHistory(
                  consHController.consHistory[selectedIndex.value]),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListView.builder(
                    reverse: true,
                    padding: const EdgeInsets.fromLTRB(25, 15, 25, 10),
                    shrinkWrap: true,
                    itemCount: consHController.chatHistory.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          bubbleChat(
                              consHController.chatHistory[index], context),
                          verticalSpace15
                        ],
                      );
                    },
                  );
                }
                return Center(
                    child: Container(
                        width: 30,
                        height: 30,
                        child: CircularProgressIndicator()));
              })),
        ),
      ],
    );
  }

  Widget topHeaderRequest(ConsultationHistoryModel consData) {
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
            Text(
              'Dr. ${consHController.getDoctorFullName(consData)}',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: subtitle18Medium.copyWith(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  Widget topHeaderRequestWeb(ConsultationHistoryModel consData) {
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
            Row(
              children: [
                Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: getPhotoHeader(consData)),
                horizontalSpace15,
                Text(
                  'Dr. ${consHController.getDoctorFullName(consData)}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: subtitle18Medium.copyWith(color: Colors.black),
                ),
              ],
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

  Widget getPhotoHeader(ConsultationHistoryModel model) {
    if (consHController.getDoctorProfile(model) == '') {
      return CircleAvatar(
        radius: 25,
        backgroundImage: AssetImage(doctorDefault),
      );
    }
    return CircleAvatar(
      radius: 25,
      foregroundImage: NetworkImage(consHController.getDoctorProfile(model)),
      backgroundImage: AssetImage(doctorDefault),
    );
  }

  Widget getPhoto(ConsultationHistoryModel model) {
    if (consHController.getDoctorProfile(model) == '') {
      return CircleAvatar(
        radius: 50,
        backgroundImage: AssetImage(doctorDefault),
      );
    }
    return CircleAvatar(
      radius: 50,
      foregroundImage: NetworkImage(consHController.getDoctorProfile(model)),
      backgroundImage: AssetImage(doctorDefault),
    );
  }

  Widget RequestsInfoView(ConsultationHistoryModel consData) {
    if (consData.doc.value == null) {
      return Container();
    }
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
          Widget>[
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
              'Dr. ${consHController.getDoctorFullName(consData)}',
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
              Text('conshistory1'.tr,
                  textAlign: TextAlign.left,
                  style:
                      body16Regular.copyWith(color: const Color(0xFF727F8D))),
              verticalSpace20,
              Wrap(
                runSpacing: 8,
                children: [
                  SizedBox(
                    width: 170,
                    child: Text('cons3'.tr,
                        textAlign: TextAlign.left, style: body14SemiBold),
                  ),
                  SizedBox(
                    width: 170,
                    child: Text(consData.fullName!,
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
                  SizedBox(
                    width: 170,
                    child: Text('cons4'.tr,
                        textAlign: TextAlign.left, style: body14SemiBold),
                  ),
                  SizedBox(
                    width: 170,
                    child: Text(consData.age!,
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
                  SizedBox(
                    width: 170,
                    child: Text('cons5'.tr,
                        textAlign: TextAlign.left, style: body14SemiBold),
                  ),
                  SizedBox(
                    width: 170,
                    child: Text(
                        consHController.convertDate(consData.dateRqstd!),
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
                  SizedBox(
                    width: 170,
                    child: Text('cons6'.tr,
                        textAlign: TextAlign.left, style: body14SemiBold),
                  ),
                  SizedBox(
                    width: 170,
                    child: Text(
                        consHController.convertDate(consData.dateConsStart!),
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
                  SizedBox(
                    width: 170,
                    child: Text('cons7'.tr,
                        textAlign: TextAlign.left, style: body14SemiBold),
                  ),
                  SizedBox(
                    width: 170,
                    child: Text(
                        consHController.convertDate(consData.dateConsEnd!),
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: body14Regular),
                  ),
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }

  Widget infoDialog(ConsultationHistoryModel model) {
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
                children: [RequestsInfoView(model)],
              ))
        ]);
  }
}
