import 'package:badges/badges.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/app_controller.dart';
import 'package:davnor_medicare/core/controllers/article_controller.dart';
import 'package:davnor_medicare/core/controllers/live_cons_controller.dart';
import 'package:davnor_medicare/core/controllers/navigation_controller.dart';
import 'package:davnor_medicare/core/controllers/patient/cons_req_controller.dart';
import 'package:davnor_medicare/core/controllers/patient/menu_controller.dart';
import 'package:davnor_medicare/core/controllers/patient/notif_controller.dart';
import 'package:davnor_medicare/core/controllers/status_controller.dart';
import 'package:davnor_medicare/core/models/article_model.dart';
import 'package:davnor_medicare/core/services/url_launcher_service.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:davnor_medicare/routes/app_pages.dart';
import 'package:davnor_medicare/ui/screens/patient/article_item.dart';
import 'package:davnor_medicare/ui/screens/patient/article_list.dart';
import 'package:davnor_medicare/ui/screens/patient_web/helpers/local_navigator.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/widgets/action_card.dart';
import 'package:davnor_medicare/ui/widgets/article_card.dart';
import 'package:davnor_medicare/ui/widgets/patient/notification_card.dart';
import 'package:davnor_medicare/ui/widgets/patient/patient_custom_button.dart';
import 'package:davnor_medicare/ui/widgets/patient/side_menu.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:flutter/cupertino.dart';

class PatientWebHomeScreen extends StatelessWidget {
  static AppController appController = Get.find();
  final PatientMenuController menuController =
      Get.put(PatientMenuController(), permanent: true);
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final NavigationController navigationController =
      Get.put(NavigationController(), permanent: true);
  final LiveConsController liveCont =
      Get.put(LiveConsController(), permanent: true);
  final StatusController stats = Get.put(StatusController(), permanent: true);
  final ArticleController articleService = Get.put(ArticleController());
  final ConsRequestController consController =
      Get.put(ConsRequestController(), permanent: true);
  final NotifController notifController = Get.put(NotifController());

  @override
  Widget build(BuildContext context) {
    appController.initLocalNotif(context);
    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: topNavigationBar(context),
      drawer: Drawer(
        child: PatientSideMenu(),
      ),
      body: ResponsiveBody(),
    );
  }

  Widget notificationIcon(BuildContext context) {
    if (stats.isLoading.value) {
      return notifIconNormal(context);
    }
    return stats.patientStatus[0].notifBadge == 0
        ? notifIconNormal(context)
        : notifIconWithBadge(stats.patientStatus[0].notifBadge!, context);
  }

  Widget notifIconNormal(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(
            context: context, builder: (context) => notificationDialog());
      },
      icon: const Icon(
        Icons.notifications_outlined,
        size: 29,
      ),
    );
  }

  Widget notifIconWithBadge(int count, BuildContext context) {
    return Badge(
      position: BadgePosition.topEnd(top: 1, end: 3),
      badgeContent: Text(
        '$count',
        style: const TextStyle(color: Colors.white),
      ),
      child: IconButton(
        onPressed: () {
          showDialog(
              context: context, builder: (context) => notificationDialog());
          resetBadge();
        },
        icon: const Icon(
          Icons.notifications_outlined,
          size: 29,
        ),
      ),
    );
  }

  Widget notificationDialog() {
    return SimpleDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        contentPadding: EdgeInsets.symmetric(
          vertical: 30,
          horizontal: 50,
        ),
        children: [
          SizedBox(
              width: Get.width * .2,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [Obx(displayNotification)],
                ),
              ))
        ]);
  }

  Widget displayNotification() {
    return notifController.notif.isEmpty
        ? Center(
            child: Text(
              'notif'.tr,
              textAlign: TextAlign.center,
            ),
          )
        : ListView.builder(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            shrinkWrap: true,
            itemCount: notifController.notif.length,
            itemBuilder: (context, index) {
              return NotificationCard(notif: notifController.notif[index]);
            });
  }

  Future<void> resetBadge() async {
    await firestore
        .collection('patients')
        .doc(auth.currentUser!.uid)
        .collection('status')
        .doc('value')
        .update({
      'notifBadge': 0,
    });
  }

  AppBar topNavigationBar(BuildContext context) {
    final AuthController authController = Get.find();
    final fetchedData = authController.patientModel.value;
    return AppBar(
      leading: ResponsiveLeading(scaffoldKey),
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Row(
        children: [
          Spacer(),
          Obx(() => notificationIcon(context)),
          horizontalSpace25,
          DropdownButton(
            icon: const Icon(Icons.keyboard_arrow_down),
            iconSize: 40,
            underline: Container(),
            hint: Text(fetchedData!.firstName!,
                style: const TextStyle(color: Colors.black)),
            items: [
              DropdownMenuItem(
                onTap: () {
                  navigationController.navigateTo(Routes.PATIENT_WEB_PROFILE);
                },
                value: 2,
                child: Text('Profile'),
              ),
              DropdownMenuItem(
                onTap: () {
                  authController.signOut();
                },
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
}

class ResponsiveBody extends GetResponsiveView {
  @override
  Widget? builder() {
    if (screen.isDesktop) {
      return DesktopScreen();
    } else {
      return localNavigator();
    }
  }
}

class DesktopScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: PatientSideMenu()),
        Expanded(
          flex: 5,
          child: localNavigator(),
        )
      ],
    );
  }
}

//Refactor
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

class PatientDashboardScreen extends GetView<PatientMenuController> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 55),
      child: ResponsiveView(context),
    );
  }
}

class ResponsiveView extends GetResponsiveView {
  ResponsiveView(this.context) : super(alwaysUseBuilder: false);
  final BuildContext context;
  static ArticleController articleService = Get.find();
  final List<ArticleModel> articleList = articleService.articlesList;
  final PatientMenuController menuController = Get.find();
  static AuthController authController = Get.find();
  final fetchedData = authController.patientModel.value;
  final ConsRequestController consController = Get.find();
  final LiveConsController liveCont = Get.find();
  final StatusController stats = Get.find();

  @override
  Widget phone() => tabletVersion(context);
  @override
  Widget tablet() => desktopVersion(context);

  @override
  Widget desktop() => desktopVersion(context);

  Widget tabletVersion(BuildContext context) {
    return SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.only(left: 18),
        child: Text(
          'Dashboard',
          style: title32Bold,
        ),
      ),
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
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DmText.title42Bold(
              'Hello, ${fetchedData!.firstName}',
              color: Colors.white,
            ),
          ],
        ),
      ),
    ]));
  }

  Widget desktopVersion(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            height: Get.height - 55,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Text(
                  'Dashboard',
                  style: title32Bold,
                ),
              ),
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DmText.title42Bold(
                      'Hello, ${fetchedData!.firstName}',
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DmText.title24Medium(
                            'homepage'.tr,
                            color: neutralColor,
                          ),
                          verticalSpace15,
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ActionCard(
                                  text: 'action1'.tr,
                                  color: verySoftMagenta[60],
                                  secondaryColor: verySoftMagentaCustomColor,
                                  onTap: () {
                                    if (stats.patientStatus[0].pStatus!) {
                                      if (stats.patientStatus[0]
                                          .hasActiveQueueCons!) {
                                        showErrorDialog(
                                            errorTitle: 'action5'.tr,
                                            errorDescription: 'action6'.tr);
                                      } else {
                                        showConfirmationDialog(
                                          dialogTitle: 'dialog1'.tr,
                                          dialogCaption: 'dialogsub1'.tr,
                                          onYesTap: () {
                                            dismissDialog();
                                            consController
                                                .isConsultForYou.value = true;
                                            navigationController.navigateTo(
                                                Routes.PATIENT_WEB_CONS_FORM);
                                          },
                                          onNoTap: () {
                                            dismissDialog();
                                            consController
                                                .isConsultForYou.value = false;
                                            navigationController.navigateTo(
                                                Routes.PATIENT_WEB_CONS_FORM);
                                          },
                                        );
                                      }
                                    } else {
                                      showErrorDialog(
                                          errorTitle: 'action7'.tr,
                                          errorDescription: 'action8'.tr);
                                    }
                                  },
                                ),
                                ActionCard(
                                    text: 'action2'.tr,
                                    color: verySoftOrange[60],
                                    secondaryColor: verySoftOrangeCustomColor,
                                    onTap: () {
                                      navigationController.navigateTo(
                                          Routes.PATIENT_MA_DETAILS);
                                    }),
                                ActionCard(
                                  text: 'action3'.tr,
                                  color: verySoftRed[60],
                                  secondaryColor: verySoftRedCustomColor,
                                  onTap: () {
                                    if (stats.patientStatus[0].pStatus!) {
                                      if (stats.patientStatus[0]
                                              .hasActiveQueueCons! &&
                                          stats.patientStatus[0]
                                              .hasActiveQueueMA!) {
                                        showDialog(
                                            context: context,
                                            builder: (context) =>
                                                selectQueueDialog());
                                      } else if (stats.patientStatus[0]
                                          .hasActiveQueueCons!) {
                                        navigationController
                                            .navigateTo(Routes.Q_CONS_WEB);
                                      } else if (stats
                                          .patientStatus[0].hasActiveQueueMA!) {
                                        navigationController
                                            .navigateTo(Routes.Q_MA_WEB);
                                      } else {
                                        showErrorDialog(
                                            errorTitle: 'dialog3'.tr,
                                            errorDescription: 'dialogsub3'.tr);
                                      }
                                    } else {
                                      showErrorDialog(
                                          errorTitle: 'action7'.tr,
                                          errorDescription: 'action8'.tr);
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 7,
                      child: Container(
                        padding: const EdgeInsets.only(right: 25),
                        width: Get.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                DmText.title24Medium(
                                  'homepage'.tr,
                                  color: neutralColor,
                                ),
                              ],
                            ),
                            verticalSpace15,
                            Obx(() => showArticles(context)),
                          ],
                        ),
                      )),
                ],
              ),
            ])));
  }

  Widget selectQueueDialog() {
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
          width: Get.width * .4,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            verticalSpace20,
            Text('slctQS'.tr, style: subtitle20Medium),
            verticalSpace20,
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: 230,
                height: 70,
                child: PCustomButton(
                  onTap: () {
                    navigationController.navigateTo(Routes.Q_CONS_WEB);
                  },
                  text: 'btnq1'.tr,
                  buttonColor: verySoftBlueColor[80],
                ),
              ),
            ),
            verticalSpace25,
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: 230,
                height: 70,
                child: PCustomButton(
                  onTap: () {
                    navigationController.navigateTo(Routes.Q_MA_WEB);
                  },
                  text: 'btnq2'.tr,
                  buttonColor: verySoftBlueColor[80],
                ),
              ),
            )
          ]),
        ),
      ],
    );
  }

  Widget showArticles(BuildContext context) {
    final UrlLauncherService urlLauncherService = UrlLauncherService();
    if (articleService.doneLoading.value) {
      return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (context, index) {
              return ArticleCard(
                  title: articleList[index].title!,
                  content: articleList[index].short!,
                  photoURL: articleList[index].photoURL!,
                  textStyleTitle: kIsWeb ? body16SemiBold : caption12SemiBold,
                  textStyleContent:
                      kIsWeb ? body14RegularNeutral : caption10RegularNeutral,
                  height: 115,
                  onTap: () {
                    urlLauncherService.launchURL(
                        '${articleService.articlesList[index].source}');
                  });
            }),
      );
    }
    return const Center(
        child: SizedBox(
            width: 20, height: 20, child: CircularProgressIndicator()));
  }

  void goToArticleItemScreen(int index) {
    Get.to(() => ArticleItemScreen(), arguments: index);
  }

  void seeAllArticles() {
    Get.to(() => ArticleListScreen());
  }
}

class PatientSideMenuItem extends GetView<PatientMenuController> {
  const PatientSideMenuItem({required this.itemName, required this.onTap});
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
