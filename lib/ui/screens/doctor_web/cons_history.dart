import 'package:davnor_medicare/core/controllers/cons_history_controller.dart';
import 'package:davnor_medicare/core/controllers/attached_photos_controller.dart';
import 'package:davnor_medicare/core/models/consultation_model.dart';
import 'package:davnor_medicare/helpers/validator.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/widgets/bubble_chat.dart';
import 'package:davnor_medicare/ui/widgets/consh_card_web.dart';
import 'package:davnor_medicare/ui/widgets/patient/custom_text_form_field.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_responsive.dart';

class ConsHistoryWeb extends StatelessWidget {
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
  final _scrollController1 = ScrollController();
  final _scrollController2 = ScrollController();
  final _scrollController3 = ScrollController();
  final RxBool firedOnce = false.obs;

  @override
  Widget? builder() {
    if (screen.isDesktop) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, bottom: 10),
            child: DmText.title24Bold(
              'Consultation History',
              color: kcNeutralColor[80],
            ),
          ),
          verticalSpace5,
          Row(children: [
            horizontalSpace10,
            SizedBox(
              width: 350,
              child: CustomTextFormField(
                controller: consHController.searchKeyword,
                labelText: 'Search here...',
                onChanged: (value) {
                  if (consHController.searchKeyword.text == '') {
                    consHController.consHistory
                        .assignAll(consHController.filteredListforDoc);
                  }
                },
                validator: Validator().notEmpty,
                onSaved: (value) => consHController.searchKeyword.text = value!,
              ),
            ),
            horizontalSpace10,
            Row(
              children: [
                InkWell(
                  onTap: () {
                    print(consHController.searchKeyword.text);
                    consHController.filterForDoctor(
                        name: consHController.searchKeyword.text);
                  },
                  child: Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: verySoftBlueColor[100],
                      ),
                      child: const Icon(
                        Icons.search_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),
                verticalSpace15,
                InkWell(
                  onTap: () {
                    consHController.refreshD();
                  },
                  child: Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: verySoftBlueColor[100],
                      ),
                      child: const Icon(
                        Icons.refresh,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ]),
          verticalSpace10,
          Flexible(child: DesktopScreen()),
        ],
      );
    } else {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 55, bottom: 10),
          child: DmText.title24Bold(
            'Consultation History',
            color: kcNeutralColor[80],
          ),
        ),
        verticalSpace5,
        Row(children: [
          horizontalSpace10,
          SizedBox(
            width: 350,
            child: CustomTextFormField(
              controller: consHController.searchKeyword,
              labelText: 'Search here...',
              onChanged: (value) {
                if (consHController.searchKeyword.text == '') {
                  consHController.consHistory
                      .assignAll(consHController.filteredListforDoc);
                }
              },
              validator: Validator().notEmpty,
              onSaved: (value) => consHController.searchKeyword.text = value!,
            ),
          ),
          horizontalSpace10,
          InkWell(
            onTap: () {
              print(consHController.searchKeyword.text);
              consHController.filterForDoctor(
                  name: consHController.searchKeyword.text);
            },
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: verySoftBlueColor[100],
                ),
                child: const Icon(
                  Icons.search_rounded,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ),
        ]),
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
      return const Text(
        'No Consultation History',
        textAlign: TextAlign.center,
        style: body14Medium,
      );
    }
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView.builder(
        controller: _scrollController2,
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
      future: consHController.getPatientData(model),
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

                  firedOnce.value = false;
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
    if (consHController.consHistory[selectedIndex.value].patient.value ==
            null ||
        consHController.consHistory.isEmpty) {
      return Container();
    }

    firedOnce.value = true;
    print(selectedIndex.value);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        screen.isDesktop
            ? topHeaderRequest(consHController.consHistory[selectedIndex.value])
            : topHeaderRequestWeb(
                consHController.consHistory[selectedIndex.value]),
        Expanded(
          child: Obx(() => firedOnce.value == false
              ? FutureBuilder(
                  future: consHController.getChatHistory(
                      consHController.consHistory[selectedIndex.value]),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return ListView.builder(
                        controller: _scrollController3,
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
                  })
              : SizedBox(
                  width: 0,
                  height: 0,
                )),
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
              consHController.getPatientName(consData),
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
                  consHController.getPatientName(consData),
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
    return CircleAvatar(
        radius: 25,
        foregroundImage: NetworkImage(consHController.getPatientProfile(model)),
        onForegroundImageError: (_, __) {
          errorPhoto2.value = true;
        },
        backgroundColor: verySoftBlueColor[100],
        child: Obx(
          () => errorPhoto2.value
              ? Text(
                  '${consHController.getPatientFirstName(model)[0]}',
                  style: body20Regular.copyWith(color: Colors.white),
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
        foregroundImage: NetworkImage(consHController.getPatientProfile(model)),
        onForegroundImageError: (_, __) {
          errorPhoto.value = true;
        },
        backgroundColor: verySoftBlueColor[100],
        child: Obx(
          () => errorPhoto.value
              ? Text(
                  '${consHController.getPatientFirstName(model)[0]}',
                  style: title36Regular.copyWith(color: Colors.white),
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
    if (consHController.consHistory[selectedIndex.value].patient.value ==
        null) {
      return Container();
    }
    return SingleChildScrollView(
      controller: _scrollController1,
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
              consHController.getPatientName(
                  consHController.consHistory[selectedIndex.value]),
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
                  style:
                      body16Regular.copyWith(color: const Color(0xFF727F8D))),
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
                  const SizedBox(
                    width: 170,
                    child: Text('Age of Patient',
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
                  const SizedBox(
                    width: 170,
                    child: Text('Date Requested',
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
                  const SizedBox(
                    width: 170,
                    child: Text('Consultation Started',
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
                  const SizedBox(
                    width: 170,
                    child: Text('Consultation Ended',
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
                children: [RequestsInfoView()],
              ))
        ]);
  }
}
