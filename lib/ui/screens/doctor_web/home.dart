import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/app_controller.dart';
import 'package:davnor_medicare/core/controllers/article_controller.dart';
import 'package:davnor_medicare/core/controllers/calling_patient_controller.dart';
import 'package:davnor_medicare/core/controllers/cons_history_controller.dart';
import 'package:davnor_medicare/core/controllers/doctor/consultations_controller.dart';
import 'package:davnor_medicare/core/controllers/doctor/doctor_functions.dart';
import 'package:davnor_medicare/core/controllers/doctor/menu_controller.dart';
import 'package:davnor_medicare/core/controllers/live_cons_controller.dart';
import 'package:davnor_medicare/core/controllers/navigation_controller.dart';
import 'package:davnor_medicare/core/controllers/status_controller.dart';
import 'package:davnor_medicare/core/services/url_launcher_service.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:davnor_medicare/routes/app_pages.dart';
import 'package:davnor_medicare/ui/screens/doctor_web/helpers/local_navigator.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/widgets/action_card.dart';
import 'package:davnor_medicare/ui/widgets/article_card.dart';
import 'package:davnor_medicare/ui/widgets/doctor/side_menu_doctor.dart';
import 'package:davnor_medicare/ui/widgets/splash_loading.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:flutter/cupertino.dart';

class DoctorWebHomeScreen extends StatelessWidget {
  final DoctorMenuController menuController =
      Get.put(DoctorMenuController(), permanent: true);
  final GlobalKey<ScaffoldState> scaffoldKeyD = GlobalKey();
  final NavigationController navigationController =
      Get.put(NavigationController(), permanent: true);
  final LiveConsController liveCont =
      Get.put(LiveConsController(), permanent: true);
  final ConsHistoryController consHController =
      Get.put(ConsHistoryController(), permanent: true);
  final ConsultationsController consRequests =
      Get.put(ConsultationsController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKeyD,
      extendBodyBehindAppBar: true,
      appBar: topNavigationBar(),
      drawer: Drawer(
        child: DoctorSideMenu(),
      ),
      body: Obx(() => authController.doneInitData.value
          ? ResponsiveBody()
          : SplashLoading()),
    );
  }

  AppBar topNavigationBar() {
    final AuthController authController = Get.find();
    final fetchedData = authController.doctorModel.value;
    return AppBar(
      leading: ResponsiveLeading(scaffoldKeyD),
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
                      .navigateToWithBack(Routes.DOC_WEB_PROFILE);
                },
                value: 2,
                child: Text('Profile'),
              ),
              DropdownMenuItem(
                onTap: () async {
                  await goOffline();
                  await authController.signOut();
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
        Expanded(child: DoctorSideMenu()),
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
  ResponsiveLeading(this.scaffoldKeyD);
  final GlobalKey<ScaffoldState> scaffoldKeyD;
  @override
  Widget? builder() {
    if (screen.isDesktop) {
      return Container();
    } else {
      return IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {
          scaffoldKeyD.currentState!.openDrawer();
        },
      );
    }
  }
}

final ArticleController articleService = Get.put(ArticleController());
final StatusController stats = Get.put(StatusController(), permanent: true);
final RxInt count = 1.obs;
final RxInt countAdd = 1.obs; //for additionals

class DoctorDashboardScreen extends GetView<DoctorMenuController> {
  final ArticleController articleService = Get.find();
  final ConsultationsController consRequests = Get.find();
  final LiveConsController liveCont = Get.find();
  static AuthController authController = Get.find();
  static AppController appController = Get.find();
  final NavigationController navigationController = Get.find();
  final fetchedData = authController.doctorModel.value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 55),
      child: ResponsiveView(context),
    );
  }
}

Widget showArticles(BuildContext context) {
  final UrlLauncherService urlLauncherService = UrlLauncherService();
  if (articleService.doneLoading.value &&
      articleService.articlesList.isNotEmpty) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: articleService.articlesList.length,
          itemBuilder: (context, index) {
            return ArticleCard(
                title: articleService.articlesList[index].title!,
                content: articleService.articlesList[index].short!,
                photoURL: articleService.articlesList[index].photoURL!,
                textStyleTitle: caption12SemiBold,
                textStyleContent: caption10RegularNeutral,
                height: 115,
                onTap: () {
                  urlLauncherService.launchURL(
                      '${articleService.articlesList[index].source}');
                });
          }),
    );
  } else if (articleService.doneLoading.value &&
      articleService.articlesList.isEmpty) {
    return const Center(child: Text('No articles found'));
  }
  return const Center(
      child:
          SizedBox(width: 20, height: 20, child: CircularProgressIndicator()));
}

class ResponsiveView extends GetResponsiveView {
  ResponsiveView(this.context) : super(alwaysUseBuilder: false);

  final BuildContext context;

  @override
  Widget phone() => tabletVersion(context);
  @override
  Widget tablet() => tabletVersion(context);

  @override
  Widget desktop() => desktopVersion(context);
}

Widget tabletVersion(BuildContext context) {
  final DoctorMenuController menuController = Get.find();
  final AuthController authController = Get.find();
  final fetchedData = authController.doctorModel.value;
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DmText.title32Bold(
            'Hello, Dr. ${fetchedData!.lastName}',
            color: Colors.white,
          ),
          verticalSpace10,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'DOCTOR STATUS',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              Obx(() => doctorStatus()),
            ],
          ),
        ],
      ),
    ),
    Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                          text: 'Change Status',
                          color: verySoftMagenta[60],
                          secondaryColor: verySoftMagentaCustomColor,
                          onTap: () {
                            if (stats.doctorStatus[0].dStatus!) {
                              showDialog(
                                  context: context,
                                  builder: (context) => offlineDialog());
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (context) => detailsDialogCons1());
                            }
                          }),
                      ActionCard(
                          text: 'Add More \nPatients \nto Examine',
                          color: verySoftOrange[60],
                          secondaryColor: verySoftOrangeCustomColor,
                          onTap: () {
                            if (stats.doctorStatus[0].dStatus!) {
                              showDialog(
                                  context: context,
                                  builder: (context) => detailsDialogCons2(
                                      stats.doctorStatus[0].numToAccomodate!));
                            } else {
                              showErrorDialog(
                                  errorTitle: "Could not process your request",
                                  errorDescription:
                                      "You can't make an additional when status is unavailable. Please make sure your status is available");
                            }
                          }),
                      ActionCard(
                          text: 'View Consultation Requests',
                          color: verySoftRed[60],
                          secondaryColor: verySoftRedCustomColor,
                          onTap: () {
                            menuController.changeActiveItemTo('Dashboard');
                            navigationController
                                .navigateTo(Routes.DOC_WEB_HOME);
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DmText.title24Medium(
                'Your Data',
                color: kcNeutralColor,
              ),
              verticalSpace15,
              Padding(
                padding: const EdgeInsets.only(right: 25),
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        height: 470,
                        padding: const EdgeInsets.all(25),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey
                                  .withOpacity(0.5), //color of shadow
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
                              child: Text(
                                'As Of Now',
                                style:
                                    title32Bold.copyWith(color: kcNeutralColor),
                              ),
                            ),
                            DmText.subtitle18Regular(
                              'The overall number of patients you have examine through the appplication',
                            ),
                            verticalSpace20,
                            Align(
                              child: Obx(
                                () => AutoSizeText(
                                  stats.isLoading.value
                                      ? '0'
                                      : '${stats.doctorStatus[0].overall!}',
                                  style: title130Bold.copyWith(
                                      color: kcVerySoftBlueColor),
                                  maxLines: 1,
                                ),
                              ),
                            ),
                            Align(
                              child: DmText.title32Bold('Patients'),
                            ),
                            TextButton(
                              onPressed: () {
                                menuController
                                    .changeActiveItemTo('Consultation History');
                                navigationController
                                    .navigateTo(Routes.CONS_HISTORY_WEB);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  DmText.body16Regular(
                                      'View Consultation History'),
                                  const Icon(Icons.chevron_right),
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
    Container(
      padding: const EdgeInsets.all(25),
      width: Get.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DmText.title24Medium(
            'Articles',
            color: kcNeutralColor,
          ),
          verticalSpace15,
          Obx(() => showArticles(context)),
        ],
      ),
    )
  ]));
}

Widget desktopVersion(BuildContext context) {
  DoctorMenuController menuController = Get.find();
  final AuthController authController = Get.find();
  final fetchedData = authController.doctorModel.value;
  return SingleChildScrollView(
    child: Container(
      height: Get.height - 55,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                  'Hello, Dr. ${fetchedData!.lastName}',
                  color: Colors.white,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'DOCTOR STATUS',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    Obx(() => doctorStatus()),
                  ],
                ),
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
                                  text: 'Change Status',
                                  color: verySoftMagenta[60],
                                  secondaryColor: verySoftMagentaCustomColor,
                                  onTap: () {
                                    if (stats.doctorStatus[0].dStatus!) {
                                      showDialog(
                                          context: context,
                                          builder: (context) =>
                                              offlineDialog());
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (context) =>
                                              detailsDialogCons1());
                                    }
                                  }),
                              ActionCard(
                                  text: 'Add More \nPatients \nto Examine',
                                  color: verySoftOrange[60],
                                  secondaryColor: verySoftOrangeCustomColor,
                                  onTap: () {
                                    if (stats.doctorStatus[0].dStatus!) {
                                      showDialog(
                                          context: context,
                                          builder: (context) =>
                                              detailsDialogCons2(stats
                                                  .doctorStatus[0]
                                                  .numToAccomodate!));
                                    } else {
                                      showErrorDialog(
                                          errorTitle:
                                              "Could not process your request",
                                          errorDescription:
                                              "You can't make an additional when status is unavailable. Please make sure your status is available");
                                    }
                                  }),
                              ActionCard(
                                  //TO DO: CHANGE THIS
                                  text: 'View Consultation Requests',
                                  color: verySoftRed[60],
                                  secondaryColor: verySoftRedCustomColor,
                                  onTap: () {
                                    menuController
                                        .changeActiveItemTo('Dashboard');
                                    navigationController
                                        .navigateTo(Routes.DOC_WEB_HOME);
                                  }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        verticalSpace25,
                        DmText.title24Medium(
                          'Your Data',
                          color: kcNeutralColor,
                        ),
                        verticalSpace15,
                        Container(
                          child: Column(
                            children: [
                              Container(
                                width: Get.width * .7,
                                height: 470,
                                padding: const EdgeInsets.all(25),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey
                                          .withOpacity(0.5), //color of shadow
                                      spreadRadius: 5, //spread radius
                                      blurRadius: 7, // blur radius
                                      offset: const Offset(
                                          4, 8), //  changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'As Of Now',
                                        style: title32Bold.copyWith(
                                            color: kcNeutralColor),
                                      ),
                                    ),
                                    DmText.subtitle18Regular(
                                      'The overall number of patients you have examine through the appplication',
                                    ),
                                    verticalSpace20,
                                    Align(
                                      child: Obx(
                                        () => AutoSizeText(
                                          stats.isLoading.value
                                              ? '0'
                                              : '${stats.doctorStatus[0].overall!}',
                                          style: title130Bold.copyWith(
                                              color: kcVerySoftBlueColor),
                                          maxLines: 1,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      child: DmText.title32Bold('Patients'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        menuController.changeActiveItemTo(
                                            'Consultation History');
                                        navigationController.navigateTo(
                                            Routes.CONS_HISTORY_WEB);
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          DmText.body16Regular(
                                              'View Consultation History'),
                                          const Icon(Icons.chevron_right),
                                        ],
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
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          verticalSpace25,
                          DmText.title24Medium(
                            'Articles',
                            color: kcNeutralColor,
                          ),
                          verticalSpace15,
                          Container(
                            height: 470,
                            child: SingleChildScrollView(
                              child: Obx(() => showArticles(context)),
                            ),
                          ),
                        ],
                      ),
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

class DoctorSideMenuItem extends GetView<DoctorMenuController> {
  const DoctorSideMenuItem({required this.itemName, required this.onTap});
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

//OBX
Widget doctorStatus() {
  if (!stats.isLoading.value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          elevation: 5,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              stats.doctorStatus[0].dStatus!
                  ? 'Available for Consultation'
                  : 'Unavailable',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15,
                color: verySoftBlueColor,
              ),
            ),
          ),
        ),
        Text(
          stats.doctorStatus[0].numToAccomodate != 0
              ? '${stats.doctorStatus[0].accomodated} out of ${stats.doctorStatus[0].numToAccomodate} patients'
              : '',
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 15,
            color: Colors.white,
          ),
        ),
      ],
    );
  } else {
    return loadingDoctorStats();
  }
}

Widget loadingDoctorStats() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: <Widget>[
      Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        elevation: 5,
        child: const Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            'Loading..',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: verySoftBlueColor,
            ),
          ),
        ),
      ),
    ],
  );
}

//DIALOGS
Widget offlineDialog() {
  return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      contentPadding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      children: [
        SizedBox(
            width: Get.width * .3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Change Status',
                  textAlign: TextAlign.center,
                  style: title24Bold,
                ),
                verticalSpace15,
                const Text(
                  'It looks like you want to change your status from available to unavailable',
                  textAlign: TextAlign.center,
                  style: body16Regular,
                ),
                verticalSpace20,
                Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      onPressed: () async {
                        await goOffline();
                      },
                      child: Text(
                        'GO OFFLINE NOW',
                        style: body16Regular,
                      ),
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                        primary: Color(0xFF0280FD),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15),
                        ),
                      ),
                    )),
                verticalSpace15,
                Text(
                  'By clicking this button your status will be unavailable and you will not be able to receive any new consultation requests any more',
                  textAlign: TextAlign.center,
                  style: body14RegularNeutral,
                ),
              ],
            ))
      ]);
}

Future<void> goOffline() async {
  final AuthController authController = Get.find();
  final fetchedData = authController.doctorModel.value;
  final DoctorFunctions func = DoctorFunctions();

  final total = stats.doctorStatus[0].numToAccomodate! -
      stats.doctorStatus[0].accomodated!;
  await firestore
      .collection('doctors')
      .doc(fetchedData!.userID!)
      .collection('status')
      .doc('value')
      .update({'accomodated': 0, 'numToAccomodate': 0, 'dStatus': false}).then(
          (value) async {
    await func.updateSlot(total);
    dismissDialog();
    print('Changed status');
    count.value = 1;
  }).catchError((error) {
    showErrorDialog(
        errorTitle: 'ERROR!', errorDescription: 'Something went wrong');
  });
}

Widget detailsDialogCons1() {
  final AuthController authController = Get.find();
  final fetchedData = authController.doctorModel.value;
  return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      contentPadding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      children: [
        SizedBox(
            width: Get.width * .3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Change Status',
                  textAlign: TextAlign.center,
                  style: title24Bold,
                ),
                verticalSpace15,
                const Text(
                  'Please state the number of patient you want to accomodate',
                  textAlign: TextAlign.center,
                  style: subtitle18Regular,
                ),
                verticalSpace25,
                counter(),
                verticalSpace20,
                Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      onPressed: () async {
                        await firestore
                            .collection('doctors')
                            .doc(fetchedData!.userID!)
                            .collection('status')
                            .doc('value')
                            .update({
                          'accomodated': 0,
                          'numToAccomodate': count.value,
                          'dStatus': true
                        }).then((value) async {
                          await firestore
                              .collection('cons_status')
                              .doc(fetchedData.categoryID!)
                              .update({
                            'consSlot': FieldValue.increment(count.value)
                          });
                          dismissDialog();
                          print('Changed status');
                          count.value = 1;
                        }).catchError((error) {
                          showErrorDialog(
                              errorTitle: 'ERROR!',
                              errorDescription: 'Something went wrong');
                        });
                      },
                      child: Text(
                        'Ready for Consultation',
                        style: body16Regular,
                      ),
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        primary: Color(0xFF0280FD),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18),
                        ),
                      ),
                    )),
                verticalSpace15,
                Text(
                  'By clicking this button your status will be available and you will be able to receive consultation requests',
                  textAlign: TextAlign.center,
                  style: body14RegularNeutral,
                ),
              ],
            ))
      ]);
}

Widget detailsDialogCons2(int currentCount) {
  final AuthController authController = Get.find();
  final fetchedData = authController.doctorModel.value;
  return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      contentPadding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      children: [
        SizedBox(
            width: Get.width * .2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Add more patient to examine',
                  textAlign: TextAlign.center,
                  style: title24Bold,
                ),
                verticalSpace15,
                const Text(
                  'Please input the value of how many patients you want to add to examine.',
                  textAlign: TextAlign.center,
                  style: subtitle18Regular,
                ),
                verticalSpace25,
                counterAddittional(),
                verticalSpace20,
                Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      onPressed: () async {
                        await firestore
                            .collection('doctors')
                            .doc(fetchedData!.userID!)
                            .collection('status')
                            .doc('value')
                            .update({
                          'numToAccomodate':
                              FieldValue.increment(countAdd.value)
                        }).then((value) async {
                          await firestore
                              .collection('cons_status')
                              .doc(fetchedData.categoryID!)
                              .update({
                            'consSlot': FieldValue.increment(countAdd.value)
                          });
                          dismissDialog();
                          countAdd.value = 1;
                        }).catchError((error) {
                          showErrorDialog(
                              errorTitle: 'ERROR!',
                              errorDescription: 'Something went wrong');
                        });
                      },
                      child: Text(
                        'Add count',
                        style: body16Regular,
                      ),
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        primary: Color(0xFF0280FD),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18),
                        ),
                      ),
                    )),
              ],
            ))
      ]);
}

//FUNCTIONS
Widget counter() {
  return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
    ElevatedButton(
      onPressed: () {
        if (count.value != 1) {
          count.value = count.value - 1;
        }
      },
      child: Icon(
        Icons.expand_more,
      ),
      style: ElevatedButton.styleFrom(
        primary: Color(0xFF0280FD),
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(15),
        ),
      ),
    ),
    SizedBox(
      width: 60,
      child: Obx(
        () => Text(
          '${count.value}',
          textAlign: TextAlign.center,
          style: subtitle18Bold,
        ),
      ),
    ),
    ElevatedButton(
      onPressed: () {
        count.value = count.value + 1;
      },
      child: Icon(
        Icons.expand_less_rounded,
      ),
      style: ElevatedButton.styleFrom(
        primary: Color(0xFF0280FD),
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(15),
        ),
      ),
    )
  ]);
}

Widget counterAddittional() {
  return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
    ElevatedButton(
      onPressed: () {
        if (countAdd.value != 1) {
          countAdd.value = countAdd.value - 1;
        }
      },
      child: Icon(
        Icons.expand_more,
      ),
      style: ElevatedButton.styleFrom(
        primary: Color(0xFF0280FD),
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(15),
        ),
      ),
    ),
    SizedBox(
      width: 60,
      child: Obx(
        () => Text(
          '${countAdd.value}',
          textAlign: TextAlign.center,
          style: subtitle18Bold,
        ),
      ),
    ),
    ElevatedButton(
      onPressed: () {
        countAdd.value = countAdd.value + 1;
      },
      child: Icon(
        Icons.expand_less_rounded,
      ),
      style: ElevatedButton.styleFrom(
        primary: Color(0xFF0280FD),
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(15),
        ),
      ),
    )
  ]);
}
