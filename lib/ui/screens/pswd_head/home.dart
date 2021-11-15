import 'package:auto_size_text/auto_size_text.dart';
import 'package:davnor_medicare/constants/app_strings.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/app_controller.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/core/controllers/pswd/attached_photos_controller.dart';
import 'package:davnor_medicare/core/controllers/pswd/menu_controller.dart';
import 'package:davnor_medicare/core/controllers/navigation_controller.dart';
import 'package:davnor_medicare/core/controllers/status_controller.dart';
import 'package:davnor_medicare/routes/app_pages.dart';
import 'package:davnor_medicare/ui/screens/pswd_head/for_approval_list.dart';
import 'package:davnor_medicare/ui/screens/pswd_head/helpers/local_navigator.dart';
import 'package:davnor_medicare/ui/screens/pswd_p/ma_history_list.dart';
import 'package:davnor_medicare/ui/screens/pswd_p/ma_req_list.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/widgets/action_card.dart';
import 'package:davnor_medicare/ui/widgets/pswd/side_menu.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final AppController appController = Get.find();
final StatusController stats = Get.put(StatusController(), permanent: true);
final AuthController authController = Get.find();
final NavigationController navigationController =
    Get.put(NavigationController());
final fetchedData = authController.pswdModel.value;
final MenuController menuController = Get.put(MenuController());

class PSWDHeadHomeScreen extends StatelessWidget {
  final fetchedData = authController.pswdModel.value;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final AttachedPhotosController pswdController =
      Get.put(AttachedPhotosController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: topNavigationBar(
        context,
        scaffoldKey,
        fetchedData!.firstName,
      ),
      drawer: Drawer(
        child: PswdHeadSideMenu(),
      ),
      body: ResponsiveBody(),
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
        Expanded(child: PswdHeadSideMenu()),
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
  String? name,
) {
  return AppBar(
    leading: ResponsiveLeading(key),
    elevation: 0,
    backgroundColor: Colors.transparent,
    title: Row(
      children: [
        Expanded(child: Container()),
        // TO THINK: IconButton(
        //   onPressed: () {},
        //   icon: const Icon(Icons.notifications),
        // ),
        Text(name!, style: const TextStyle(color: Colors.black)),
        DropdownButton(
          icon: const Icon(Icons.keyboard_arrow_down),
          iconSize: 40,
          underline: Container(),
          items: [
            DropdownMenuItem(
              value: 1,
              child: TextButton.icon(
                label: const Text('Profile'),
                onPressed: () {
                  //TO DO - ADD PROFILE FOR PSWD navigationController.navigateTo(Routes.ADMIN_PROFILE);
                },
                icon: const Icon(Icons.account_circle),
                style: TextButton.styleFrom(primary: Colors.black),
              ),
            ),
            DropdownMenuItem(
              value: 2,
              child: TextButton.icon(
                label: const Text('Logout'),
                onPressed: authController.signOut,
                icon: const Icon(Icons.account_circle),
                style: TextButton.styleFrom(primary: Colors.black),
              ),
            )
          ],
          onChanged: (int? newValue) {},
        ),
      ],
    ),
  );
}

class ResponsiveLeading extends GetResponsiveView {
  ResponsiveLeading(this.scaffoldKey);
  final GlobalKey<ScaffoldState> scaffoldKey;
  @override
  Widget? builder() {
    if (screen.isDesktop) {
      return Container();
    } else {
      return IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {
          scaffoldKey.currentState!.openDrawer();
        },
      );
    }
  }
}

class PswdHeadDashboardScreen extends GetView<MenuController> {
  static AuthController authController = Get.find();
  final fetchedData = authController.pswdModel.value;

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
    );
  }
}

class PswdHeadSideMenuItem extends GetView<MenuController> {
  const PswdHeadSideMenuItem({required this.itemName, required this.onTap});
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
                child: controller.pswdHeadreturnIconFor(itemName!),
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

  @override
  Widget phone() => phoneVersion();

  @override
  Widget tablet() => phoneVersion();

  @override
  Widget desktop() => desktopVersion();
}

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
                              ActionCard(
                                text: 'View For \nApproval \nRequests',
                                onTap: () async {
                                  menuController
                                      .changeActiveItemTo('For Approval');
                                  navigationController
                                      .navigateTo(Routes.FOR_APPROVAL_LIST);
                                },
                                color: verySoftMagenta[60],
                                secondaryColor: verySoftMagentaCustomColor,
                              ),
                              ActionCard(
                                text: 'View On \nProgress \nRequests',
                                onTap: () async {
                                  menuController.changeActiveItemTo(
                                      'On Progress Request');
                                  navigationController
                                      .navigateTo(Routes.ON_PROGRESS_REQ_LIST);
                                },
                                color: verySoftOrange[60],
                                secondaryColor: verySoftOrangeCustomColor,
                              ),
                              ActionCard(
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
                                                      style: subtitle18Regular,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            DmText.subtitle18Regular(
                                              medicalStatusSubtitle2,
                                            ),
                                            verticalSpace20,
                                            Align(
                                              child: AutoSizeText(
                                                '12',
                                                style: title130Bold.copyWith(
                                                    color: kcVerySoftBlueColor),
                                                maxLines: 1,
                                              ),
                                            ),
                                            Align(
                                              child: DmText.title32Bold(
                                                  'Requests'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                menuController
                                                    .changeActiveItemTo(
                                                        'For Approval');
                                                navigationController.navigateTo(
                                                    Routes.FOR_APPROVAL_LIST);
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  DmText.body16Regular(
                                                      'View MA Requests for Approval'),
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
                                                          BorderRadius.circular(
                                                              10),
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
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                        ),
                                                        AutoSizeText(
                                                          '3',
                                                          style: title130Bold
                                                              .copyWith(
                                                                  color:
                                                                      kcVerySoftBlueColor),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                        ),
                                                        DmText.subtitle20Medium(
                                                          'PSWD Personnel',
                                                        ),
                                                        const AutoSizeText(
                                                          cardSubtitle1,
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
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
                                                          BorderRadius.circular(
                                                              10),
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
                                                            color: neutralColor,
                                                          ),
                                                        ),
                                                        Text(
                                                          '120',
                                                          style:
                                                              title90BoldBlue,
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
                                                                  .navigateTo(Routes
                                                                      .ON_PROGRESS_REQ_LIST);
                                                            },
                                                            child:
                                                                Wrap(children: [
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
                                              padding: const EdgeInsets.all(25),
                                              width: Get.width,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey.withOpacity(
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
                        ActionCard(
                          text: 'View For Approval Requests',
                          onTap: () async {
                            menuController.changeActiveItemTo('For Approval');
                            navigationController
                                .navigateTo(Routes.FOR_APPROVAL_LIST);
                          },
                          color: verySoftMagenta[60],
                          secondaryColor: verySoftMagentaCustomColor,
                        ),
                        ActionCard(
                          text: 'View On Progress Requests',
                          onTap: () async {
                            menuController
                                .changeActiveItemTo('On Progress Request');
                            navigationController
                                .navigateTo(Routes.ON_PROGRESS_REQ_LIST);
                          },
                          color: verySoftOrange[60],
                          secondaryColor: verySoftOrangeCustomColor,
                        ),
                        ActionCard(
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
                          color: Colors.grey.withOpacity(0.5), //color of shadow
                          spreadRadius: 5, //spread radius
                          blurRadius: 7, // blur radius
                          offset:
                              const Offset(4, 8), //  changes position of shadow
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
                          medicalStatusSubtitle2,
                        ),
                        Align(
                          child: AutoSizeText(
                            '12',
                            style: title130Bold.copyWith(
                                color: kcVerySoftBlueColor),
                            maxLines: 1,
                          ),
                        ),
                        Align(
                          child: DmText.body16Bold('Requests'),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                            onPressed: () {
                              menuController.changeActiveItemTo('For Approval');
                              navigationController
                                  .navigateTo(Routes.FOR_APPROVAL_LIST);
                            },
                            child: Wrap(children: [
                              DmText.body16Regular(
                                  'View MA Requests for Approval'),
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
                    AutoSizeText(
                      '3',
                      style: title130Bold.copyWith(color: kcVerySoftBlueColor),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
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
                    Text(
                      '120',
                      style: title130Bold.copyWith(color: kcVerySoftBlueColor),
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
      .update({'hasFunds': !(stats.pswdPStatus[0].hasFunds!)});
}

Future<void> changeIsCutOff() async {
  await firestore
      .collection('pswd_status')
      .doc('status')
      .update({'isCutOff': !(stats.pswdPStatus[0].isCutOff!)});
}
