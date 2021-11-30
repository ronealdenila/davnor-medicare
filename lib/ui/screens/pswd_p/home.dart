import 'package:auto_size_text/auto_size_text.dart';
import 'package:davnor_medicare/constants/app_strings.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/admin/pswd_staff_list_controller.dart';
import 'package:davnor_medicare/core/controllers/app_controller.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/core/controllers/pswd/accepted_ma_controller.dart';
import 'package:davnor_medicare/core/controllers/pswd/attached_photos_controller.dart';
import 'package:davnor_medicare/core/controllers/navigation_controller.dart';
import 'package:davnor_medicare/core/controllers/pswd/ma_req_list_controller.dart';
import 'package:davnor_medicare/core/controllers/pswd/menu_controller.dart';
import 'package:davnor_medicare/core/controllers/pswd/on_progress_req_controller.dart';
import 'package:davnor_medicare/core/controllers/status_controller.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:davnor_medicare/routes/app_pages.dart';
import 'package:davnor_medicare/ui/screens/pswd_p/helpers/local_navigator.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/widgets/action_card.dart';
import 'package:davnor_medicare/ui/widgets/pswd/side_menu.dart';
import 'package:davnor_medicare/ui/widgets/splash_loading.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//!Resources:
//*https://youtu.be/z7P1OFLw4kY
//*https://youtu.be/udsysUj-X4w
//*https://github.com/filiph/hn_app/tree/episode51-upgrade

class PSWDPersonnelHome extends StatelessWidget {
  static AuthController authController = Get.find();
  final fetchedData = authController.pswdModel.value;
  final GlobalKey<ScaffoldState> scaffoldKeyPSH = GlobalKey();
  final AcceptedMAController acceptedMA =
      Get.put(AcceptedMAController(), permanent: true);
  final StatusController stats = Get.put(StatusController(), permanent: true);
  final AttachedPhotosController pcontroller =
      Get.put(AttachedPhotosController());
  final MenuController menuController =
      Get.put(MenuController(), permanent: true);
  final NavigationController navigationController =
      Get.put(NavigationController());
  final MAReqListController maController =
      Get.put(MAReqListController(), permanent: true);
  final OnProgressReqController opController =
      Get.put(OnProgressReqController(), permanent: true);
  final PSWDStaffListController pListController =
      Get.put(PSWDStaffListController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKeyPSH,
      extendBodyBehindAppBar: true,
      appBar: topNavigationBar(context, scaffoldKeyPSH),
      drawer: Drawer(child: PswdPSideMenu()),
      body: Obx(() =>
          authController.doneInitData.value && !stats.isPSLoading.value
              ? ResponsiveBody()
              : SplashLoading()),
    );
  }
}

class ResponsiveBody extends GetResponsiveView {
  @override
  Widget? builder() {
    if (screen.isDesktop) {
      return DesktopScreen();
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: localNavigator(),
      );
    }
  }
}

class DesktopScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: PswdPSideMenu()),
        Expanded(
          flex: 5,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: localNavigator(),
          ),
        )
      ],
    );
  }
}

AppBar topNavigationBar(
  BuildContext context,
  GlobalKey<ScaffoldState> key,
) {
  final AuthController authController = Get.find();
  final fetchedData = authController.pswdModel.value;
  return AppBar(
    leading: ResponsiveLeading(key),
    elevation: 0,
    backgroundColor: Colors.transparent,
    title: Row(
      children: [
        Spacer(),
        horizontalSpace25,
        DropdownButton(
          icon: const Icon(Icons.keyboard_arrow_down),
          iconSize: 40,
          underline: Container(),
          hint: authController.doneInitData.value
              ? Text(fetchedData!.firstName!,
                  style: const TextStyle(color: Colors.black))
              : Text('Loading...'),
          items: [
            DropdownMenuItem(
              onTap: () {
                navigationController
                    .navigateToWithBack(Routes.PSWD_WEB_PROFILE);
              },
              value: 2,
              child: Text('Profile'),
            ),
            DropdownMenuItem(
              onTap: authController.signOut,
              value: 2,
              child: Text('Logout'),
            )
          ],
          onChanged: (int? newValue) {},
        ),
        horizontalSpace10
      ],
    ),
  );
}

class ResponsiveLeading extends GetResponsiveView {
  ResponsiveLeading(this.scaffoldKeyPSH);
  final GlobalKey<ScaffoldState> scaffoldKeyPSH;
  @override
  Widget? builder() {
    if (screen.isDesktop) {
      return Container();
    } else {
      return IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {
          scaffoldKeyPSH.currentState!.openDrawer();
        },
      );
    }
  }
}

class PswdPDashboardScreen extends GetView<MenuController> {
  final AppController appController = Get.find();
  static AuthController authController = Get.find();
  final fetchedData = authController.pswdModel.value;
  final AcceptedMAController acceptedMA = Get.find();
  @override
  Widget build(BuildContext context) {
    //Note: Breakpoint is for desktop lang
    return Scaffold(
        appBar: AppBar(
          leading: Container(),
          title: DmText.title42Bold(
            'Dashboard',
            color: kcNeutralColor[80],
          ),
        ),
        body: SafeArea(child: ResponsiveView(context)),
        floatingActionButton: Obx(getFloatingButton));
  }

  Widget getFloatingButton() {
    if (!acceptedMA.isLoading.value) {
      if (acceptedMA.accMA.isNotEmpty) {
        if (acceptedMA.indexOfLive.value == -1) {
          return const SizedBox(height: 0, width: 0);
        } else {
          return FloatingActionButton(
            backgroundColor: verySoftBlueColor[30],
            elevation: 2,
            onPressed: () {
              navigationController.navigateToWithArgs(
                  Routes.PSWD_ACCEPTED_MA_REQ,
                  arguments: acceptedMA.accMA[acceptedMA.indexOfLive.value]);
            },
            child: const Icon(
              Icons.chat_rounded,
            ),
          );
        }
      }
      return const SizedBox(height: 0, width: 0);
    }
    return const SizedBox(height: 0, width: 0);
  }
}

class PswdPSideMenuItem extends GetView<MenuController> {
  const PswdPSideMenuItem({required this.itemName, required this.onTap});
  final String? itemName;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onHover: (value) {
        value
            ? controller.onHover(itemName!)
            : controller.onHover('not hovering');
      },
      child: Obx(
        () => Container(
          color: controller.isHovering(itemName!)!
              ? const Color(0xFFA4A6B3)
              : Colors.transparent,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: controller.returnIconFor(itemName!),
              ),
              Flexible(
                child: Text(
                  itemName!,
                  style: subtitle18Medium.copyWith(
                    color: controller.isActive(itemName!)!
                        ? infoColor
                        : neutralColor[60],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ResponsiveView extends GetResponsiveView {
  ResponsiveView(this.context) : super(alwaysUseBuilder: false);
  final BuildContext context;
  final StatusController stats = Get.find();
  final AttachedPhotosController pcontroller = Get.find();
  final MenuController menuController = Get.find();
  static AuthController authController = Get.find();
  final fetchedData = authController.pswdModel.value;
  final AppController appController = Get.find();
  final MAReqListController maController = Get.find();
  final OnProgressReqController opController = Get.find();
  final PSWDStaffListController pListController = Get.find();

  @override
  Widget phone() => phoneVersion();

  @override
  Widget tablet() => phoneVersion();

  @override
  Widget desktop() => desktopVersion();

  Widget desktopVersion() {
    return SingleChildScrollView(
      child: Container(
        height: Get.height - 95,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(25),
              padding: const EdgeInsets.all(25),
              width: Get.width,
              height: Get.height * .2,
              decoration: const BoxDecoration(
                color: kcVerySoftBlueColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
              ),
              child: Row(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: DmText.title42Bold(
                      'Hello, ${fetchedData!.firstName}',
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DmText.title24Bold(
                              'MA STATUS',
                              color: Colors.white,
                            ),
                            verticalSpace15,
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              padding: EdgeInsets.all(12),
                              child: Obx(
                                () => stats.isPSLoading.value
                                    ? Text('Loading..')
                                    : DmText.subtitle20Medium(
                                        stats.pswdPStatus[0].isCutOff!
                                            ? 'Ready to Accept Request'
                                            : 'Cut Off',
                                        color: neutralColor[60],
                                      ),
                              ),
                            ),
                          ],
                        ),
                        horizontalSpace35,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DmText.title24Bold(
                              'PSWD FUND STATUS',
                              color: Colors.white,
                            ),
                            verticalSpace15,
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              padding: EdgeInsets.all(12),
                              child: Obx(
                                () => stats.isPSLoading.value
                                    ? Text('Loading..')
                                    : DmText.subtitle20Medium(
                                        stats.pswdPStatus[0].hasFunds!
                                            ? 'Available'
                                            : 'Unavailable',
                                        color: neutralColor[60],
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              child: Expanded(
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            // color: Colors.blue,
                            child: DmText.title24Medium(
                              'Actions',
                              color: neutralColor,
                            ),
                          ),
                          verticalSpace15,
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 150,
                                  child: ActionCard(
                                    text: 'Change MA\nStatus',
                                    onTap: () {
                                      showConfirmationDialog(
                                        dialogTitle: 'Changing MA Status',
                                        dialogCaption:
                                            'Select YES if you want to change the current status to its opposite. Otherwise, select NO',
                                        onYesTap: () async {
                                          await changeIsCutOff();
                                        },
                                        onNoTap: () {
                                          dismissDialog();
                                        },
                                      );
                                    },
                                    color: verySoftMagenta[60],
                                    secondaryColor: verySoftMagentaCustomColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 150,
                                  child: ActionCard(
                                    text: 'Change PSWD \nFund Status',
                                    onTap: () {
                                      showConfirmationDialog(
                                        dialogTitle: 'Changing PSWD MA Fund',
                                        dialogCaption:
                                            'Select YES if you want to change the current status to its opposite. Otherwise, select NO',
                                        onYesTap: () async {
                                          await changeHasFunds();
                                        },
                                        onNoTap: () {
                                          dismissDialog();
                                        },
                                      );
                                    },
                                    color: verySoftOrange[60],
                                    secondaryColor: verySoftOrangeCustomColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 150,
                                  child: ActionCard(
                                    text: 'View MA History',
                                    onTap: () {
                                      menuController.changeActiveItemTo(
                                          'Medical Assistance History');
                                      navigationController
                                          .navigateTo(Routes.MA_HISTORY_LIST);
                                    },
                                    color: verySoftRed[60],
                                    secondaryColor: verySoftRedCustomColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          verticalSpace25,
                          DmText.title24Medium(
                            'Medical Assistance Status',
                            color: kcNeutralColor,
                          ),
                          verticalSpace15,
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Container(
                                          width: Get.width * .7,
                                          height: 470,
                                          padding: const EdgeInsets.all(25),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withOpacity(
                                                    0.5), //color of shadow
                                                spreadRadius: 5, //spread radius
                                                blurRadius: 7, // blur radius
                                                offset: const Offset(4,
                                                    8), //  changes position of shadow
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: RichText(
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: 'As Of Today ',
                                                        style: title32Bold.copyWith(
                                                            color:
                                                                kcNeutralColor),
                                                      ),
                                                      TextSpan(
                                                        text:
                                                            '(${appController.dateNow})',
                                                        style:
                                                            subtitle18Regular,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              DmText.subtitle18Regular(
                                                medicareDataSubtitleforPSWD,
                                              ),
                                              verticalSpace20,
                                              Align(
                                                child: Obx(
                                                  () => AutoSizeText(
                                                    '${maController.maRequests.length}',
                                                    style: title130Bold.copyWith(
                                                        color:
                                                            kcVerySoftBlueColor),
                                                    maxLines: 1,
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                child: DmText.title32Bold(
                                                    'People'),
                                              ),
                                              // verticalSpace50,
                                              TextButton(
                                                onPressed: () {
                                                  menuController
                                                      .changeActiveItemTo(
                                                          'MA Request');
                                                  navigationController
                                                      .navigateTo(
                                                          Routes.MA_REQ_LIST);
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    DmText.body16Regular(
                                                        'View MA Request'),
                                                    const Icon(
                                                        Icons.chevron_right),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 25),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          flex: 6,
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      height: Get.height * .35,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.5), //color of shadow
                                                            spreadRadius:
                                                                3, //spread radius
                                                            blurRadius:
                                                                4, // blur radius
                                                            offset: const Offset(
                                                                4,
                                                                8), // position of shadow
                                                          ),
                                                        ],
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          AutoSizeText(
                                                            'The application has',
                                                            style: body16Regular
                                                                .copyWith(
                                                              color:
                                                                  kcNeutralColor,
                                                            ),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 1,
                                                          ),
                                                          Obx(
                                                            () => AutoSizeText(
                                                              '${pListController.pswdList.length}',
                                                              style: title130Bold
                                                                  .copyWith(
                                                                      color:
                                                                          kcVerySoftBlueColor),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              maxLines: 1,
                                                            ),
                                                          ),
                                                          DmText
                                                              .subtitle20Medium(
                                                            'PSWD Personnel',
                                                          ),
                                                          const AutoSizeText(
                                                            cardSubtitle1,
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                            textAlign: TextAlign
                                                                .center,
                                                            maxLines: 2,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  horizontalSpace25,
                                                  Expanded(
                                                    flex: 2,
                                                    child: Container(
                                                      height: Get.height * .35,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 30),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.5), //color of shadow
                                                            spreadRadius:
                                                                5, //spread radius
                                                            blurRadius:
                                                                7, // blur radius
                                                            offset: const Offset(
                                                                4,
                                                                8), // / changes position of shadow
                                                          ),
                                                        ],
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: DmText
                                                                .title24Medium(
                                                              'ON PROGRESS REQUEST TODAY',
                                                              color:
                                                                  neutralColor,
                                                            ),
                                                          ),
                                                          Obx(
                                                            () => Text(
                                                              '${opController.onProgressList.length}',
                                                              style:
                                                                  title90BoldBlue,
                                                            ),
                                                          ),
                                                          Align(
                                                            alignment: Alignment
                                                                .bottomRight,
                                                            child: TextButton(
                                                              onPressed: () {
                                                                menuController
                                                                    .changeActiveItemTo(
                                                                        'On Progress Request');
                                                                navigationController
                                                                    .navigateTo(
                                                                        Routes
                                                                            .ON_PROGRESS_REQ_LIST);
                                                              },
                                                              child: Wrap(
                                                                  children: [
                                                                    DmText
                                                                        .body16Regular(
                                                                      'View On Progress Request',
                                                                    ),
                                                                    const Icon(Icons
                                                                        .chevron_right),
                                                                  ]),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              verticalSpace20,
                                              Container(
                                                // color: Colors.green,
                                                padding:
                                                    const EdgeInsets.all(25),
                                                width: Get.width,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(
                                                              0.5), //color of shadow
                                                      spreadRadius:
                                                          5, //spread radius
                                                      blurRadius:
                                                          7, // blur radius
                                                      offset: const Offset(4,
                                                          8), //  changes position of shadow
                                                    ),
                                                  ],
                                                ),
                                                child: Column(
                                                  children: [
                                                    DmText.title32Bold(
                                                      'DavNor Medicare',
                                                      color: kcNeutralColor,
                                                    ),
                                                    DmText.body16Regular(
                                                      cardSubtitle2,
                                                      color: kcNeutralColor,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget phoneVersion() {
    return SingleChildScrollView(
      child: Column(children: [
        Container(
          margin: const EdgeInsets.all(25),
          padding: const EdgeInsets.all(25),
          width: Get.width,
          height: Get.height * .2,
          decoration: const BoxDecoration(
            color: kcVerySoftBlueColor,
            borderRadius: BorderRadius.all(
              Radius.circular(50),
            ),
          ),
          child: Wrap(
            runSpacing: 15,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: DmText.title24Bold(
                  'Hello, ${fetchedData!.firstName}',
                  color: Colors.white,
                ),
              ),
              Wrap(
                runSpacing: 8,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DmText.subtitle18Medium(
                        'MA STATUS',
                        color: Colors.white,
                      ),
                      verticalSpace5,
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.all(12),
                        child: Obx(
                          () => stats.isPSLoading.value
                              ? Text('Loading..')
                              : DmText.body16SemiBold(
                                  stats.pswdPStatus[0].isCutOff!
                                      ? 'Ready to Accept Request'
                                      : 'Cut Off',
                                  color: neutralColor[60],
                                ),
                        ),
                      ),
                    ],
                  ),
                  horizontalSpace35,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DmText.subtitle18Medium(
                        'PSWD FUND STATUS',
                        color: Colors.white,
                      ),
                      verticalSpace5,
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.all(12),
                        child: Obx(
                          () => stats.isPSLoading.value
                              ? Text('Loading..')
                              : DmText.body16SemiBold(
                                  stats.pswdPStatus[0].hasFunds!
                                      ? 'Available'
                                      : 'Unavailable',
                                  color: neutralColor[60],
                                ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(25),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      // color: Colors.blue,
                      child: DmText.title24Medium(
                        'Actions',
                        color: neutralColor,
                      ),
                    ),
                    verticalSpace15,
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 150,
                            child: ActionCard(
                              text: 'Change MA Status',
                              onTap: () {
                                showConfirmationDialog(
                                  dialogTitle: 'Changing MA Status',
                                  dialogCaption:
                                      'Select YES if you want to change the current status to its opposite. Otherwise, select NO',
                                  onYesTap: () async {
                                    await changeIsCutOff();
                                  },
                                  onNoTap: () {
                                    dismissDialog();
                                  },
                                );
                              },
                              color: verySoftMagenta[60],
                              secondaryColor: verySoftMagentaCustomColor,
                            ),
                          ),
                          SizedBox(
                            height: 150,
                            child: ActionCard(
                              text: 'Change PSWD Fund Status',
                              onTap: () {
                                showConfirmationDialog(
                                  dialogTitle: 'Changing PSWD MA Fund',
                                  dialogCaption:
                                      'Select YES if you want to change the current status to its opposite. Otherwise, select NO',
                                  onYesTap: () async {
                                    await changeHasFunds();
                                  },
                                  onNoTap: () {
                                    dismissDialog();
                                  },
                                );
                              },
                              color: verySoftOrange[60],
                              secondaryColor: verySoftOrangeCustomColor,
                            ),
                          ),
                          SizedBox(
                            height: 150,
                            child: ActionCard(
                              text: 'View MA History',
                              onTap: () {
                                menuController.changeActiveItemTo(
                                    'Medical Assistance History');
                                navigationController
                                    .navigateTo(Routes.MA_HISTORY_LIST);
                              },
                              color: verySoftRed[60],
                              secondaryColor: verySoftRedCustomColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                margin: const EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DmText.title24Medium(
                      'Medical Assistance Status',
                      color: kcNeutralColor,
                    ),
                    verticalSpace15,
                    Container(
                      height: 470,
                      padding: const EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.grey.withOpacity(0.5), //color of shadow
                            spreadRadius: 5, //spread radius
                            blurRadius: 7, // blur radius
                            offset: const Offset(
                                4, 8), //  changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'As Of Today ',
                                    style: title32Bold.copyWith(
                                        color: kcNeutralColor),
                                  ),
                                  TextSpan(
                                    text: '(${appController.dateNow})',
                                    style: subtitle18Regular,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          DmText.subtitle18Regular(
                            medicareDataSubtitleforPSWD,
                          ),
                          Align(
                            child: Obx(
                              () => AutoSizeText(
                                '${maController.maRequests.length}',
                                style: title130Bold.copyWith(
                                    color: kcVerySoftBlueColor),
                                maxLines: 1,
                              ),
                            ),
                          ),
                          Align(
                            child: DmText.body16Bold('People'),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: TextButton(
                              onPressed: () {
                                menuController.changeActiveItemTo('MA Request');
                                navigationController
                                    .navigateTo(Routes.MA_REQ_LIST);
                              },
                              child: Wrap(children: [
                                DmText.body16Regular(
                                  'View MA Request',
                                ),
                                const Icon(Icons.chevron_right),
                              ]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: Get.height * .35,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), //color of shadow
                        spreadRadius: 3, //spread radius
                        blurRadius: 4, // blur radius
                        offset: const Offset(4, 8), // position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AutoSizeText(
                        'The application has',
                        style: body16Regular.copyWith(
                          color: kcNeutralColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      Obx(
                        () => AutoSizeText(
                          '${pListController.pswdList.length}',
                          style:
                              title130Bold.copyWith(color: kcVerySoftBlueColor),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      DmText.subtitle20Medium(
                        'PSWD Personnel',
                      ),
                      const AutoSizeText(
                        cardSubtitle1,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ),
              horizontalSpace25,
              Expanded(
                flex: 2,
                child: Container(
                  height: Get.height * .35,
                  padding: const EdgeInsets.only(left: 30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), //color of shadow
                        spreadRadius: 5, //spread radius
                        blurRadius: 7, // blur radius
                        offset:
                            const Offset(4, 8), // / changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: DmText.title24Medium(
                          'ON PROGRESS REQUEST TODAY',
                          color: neutralColor,
                        ),
                      ),
                      Obx(
                        () => Text(
                          '${opController.onProgressList.length}',
                          style: title90BoldBlue,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          menuController
                              .changeActiveItemTo('On Progress Request');
                          navigationController
                              .navigateTo(Routes.ON_PROGRESS_REQ_LIST);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            DmText.subtitle18Regular(
                              'View On Progress Request',
                            ),
                            const Icon(Icons.chevron_right),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        verticalSpace15,
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Container(
            padding: const EdgeInsets.all(25),
            width: Get.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5), //color of shadow
                  spreadRadius: 5, //spread radius
                  blurRadius: 7, // blur radius
                  offset: const Offset(4, 8), //  changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: [
                DmText.title32Bold(
                  'DavNor Medicare',
                  color: kcNeutralColor,
                ),
                DmText.body16Regular(
                  cardSubtitle2,
                  color: kcNeutralColor,
                ),
              ],
            ),
          ),
        ),
        verticalSpace25,
      ]),
    );
  }

  Future<void> changeHasFunds() async {
    await firestore
        .collection('pswd_status')
        .doc('status')
        .update({'hasFunds': !(stats.pswdPStatus[0].hasFunds!)}).then(
            (value) => dismissDialog());
  }

  Future<void> changeIsCutOff() async {
    await firestore
        .collection('pswd_status')
        .doc('status')
        .update({'isCutOff': !(stats.pswdPStatus[0].isCutOff!)}).then(
            (value) => dismissDialog());
  }
}
