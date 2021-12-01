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

class ConsHistoryWebScreen extends StatelessWidget {
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
  final ConsHistoryController consHController = Get.find();
  final RxInt selectedIndex = 0.obs;
  final RxBool errorPhoto = false.obs;
  final RxBool errorPhoto2 = false.obs;

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
          Row(
            children: [
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
              SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    child: Icon(
                      Icons.refresh,
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: verySoftBlueColor[100],
                    ),
                    onPressed: () {
                      consHController.refresh();
                    },
                  )),
            ],
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
            flex: 6,
            child: Container(
                width: Get.width * .7,
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Color(0xFFCBD4E1),
                    ),
                  ),
                ),
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
            flex: 6,
            child: Container(
                width: Get.width * .7,
                height: Get.height,
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
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
    if (consHController.isLoading.value) {
      return Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: const SizedBox(
              height: 24, width: 24, child: CircularProgressIndicator()),
        ),
      );
    } else if (consHController.consHistory.isEmpty &&
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

  Widget RequestsChatView(BuildContext context) {
    if (consHController.consHistory.isEmpty) {
      return Container();
    }

    if (consHController.consHistory[selectedIndex.value].doc.value == null ||
        consHController.consHistory.isEmpty) {
      return Container();
    }
    print(selectedIndex.value);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        screen.isDesktop
            ? topHeaderRequest(consHController.consHistory[selectedIndex.value])
            : topHeaderRequestWeb(
                consHController.consHistory[selectedIndex.value]),
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
                      context: context, builder: (context) => infoDialog());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getPhotoHeader(ConsultationHistoryModel model) {
    return CircleAvatar(
        radius: 25,
        foregroundImage: NetworkImage(consHController.getDoctorProfile(model)),
        onForegroundImageError: (_, __) {
          errorPhoto.value = true;
        },
        backgroundColor: Colors.grey,
        child: Obx(
          () => errorPhoto.value
              ? Text(
                  '${consHController.getDoctorFirstName(model)[0]}',
                )
              : SizedBox(
                  height: 0,
                  width: 0,
                ),
        ));
  }

  Widget getPhoto(ConsultationHistoryModel model) {
    return CircleAvatar(
        radius: 50,
        foregroundImage: NetworkImage(consHController.getDoctorProfile(model)),
        onForegroundImageError: (_, __) {
          errorPhoto2.value = true;
        },
        backgroundColor: Colors.grey,
        child: Obx(
          () => errorPhoto2.value
              ? Text(
                  '${consHController.getDoctorFirstName(model)[0]}',
                )
              : SizedBox(
                  height: 0,
                  width: 0,
                ),
        ));
  }

  Widget RequestsInfoView() {
    if (consHController.consHistory.isEmpty) {
      return Container();
    }
    if (consHController.consHistory[selectedIndex.value].doc.value == null) {
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
                child:
                    getPhoto(consHController.consHistory[selectedIndex.value])),
            verticalSpace20,
            Text(
              'Dr. ${consHController.getDoctorFullName(consHController.consHistory[selectedIndex.value])}',
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
                    child: Text(
                        consHController
                            .consHistory[selectedIndex.value].fullName!,
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
                    child: Text(
                        consHController.consHistory[selectedIndex.value].age!,
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
                        consHController.convertDate(consHController
                            .consHistory[selectedIndex.value].dateRqstd!),
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
                        consHController.convertDate(consHController
                            .consHistory[selectedIndex.value].dateConsStart!),
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
                        consHController.convertDate(consHController
                            .consHistory[selectedIndex.value].dateConsEnd!),
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

  Widget infoDialog() {
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
