import 'package:auto_size_text/auto_size_text.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/app_controller.dart';
import 'package:davnor_medicare/core/controllers/doctor/consultations_controller.dart';
import 'package:davnor_medicare/core/controllers/doctor/menu_controller.dart';
import 'package:davnor_medicare/core/controllers/live_cons_controller.dart';
import 'package:davnor_medicare/core/controllers/navigation_controller.dart';
import 'package:davnor_medicare/core/controllers/status_controller.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:davnor_medicare/ui/screens/doctor_web/helpers/local_navigator.dart';
import 'package:davnor_medicare/ui/screens/doctor/article_list.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/widgets/action_card.dart';
import 'package:davnor_medicare/ui/widgets/doctor/side_menu_doctor.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:flutter/cupertino.dart';

class DoctorWebHomeScreen extends StatelessWidget {
  final DoctorMenuController menuController =
      Get.put(DoctorMenuController(), permanent: true);
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final NavigationController navigationController =
      Get.put(NavigationController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: topNavigationBar(),
      drawer: Drawer(
        child: DoctorSideMenu(),
      ),
      body: ResponsiveBody(),
    );
  }

  AppBar topNavigationBar() {
    final AuthController authController = Get.find();
    final fetchedData = authController.doctorModel.value;
    return AppBar(
      leading: ResponsiveLeading(scaffoldKey),
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Row(
        children: [
          Expanded(child: Container()),
          Text(fetchedData!.firstName!,
              style: const TextStyle(color: Colors.black)),
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
                    //TO DO: SHOULD NAVIGATE TO DOCTOR PROFILE
                    //navigationController.navigateTo(Routes.ADMIN_PROFILE);
                  },
                  icon: const Icon(Icons.person_outline),
                  style: TextButton.styleFrom(primary: Colors.black),
                ),
              ),
              DropdownMenuItem(
                value: 2,
                child: TextButton.icon(
                  label: const Text('Logout'),
                  onPressed: authController.signOut,
                  icon: const Icon(Icons.logout_outlined),
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

final StatusController stats = Get.put(StatusController(), permanent: true);
final RxInt count = 1.obs;
final RxInt countAdd = 1.obs; //for additionals

class DoctorDashboardScreen extends GetView<DoctorMenuController> {
  final ConsultationsController consRequests =
      Get.put(ConsultationsController());
  final LiveConsController liveCont =
      Get.put(LiveConsController(), permanent: true);
  static AuthController authController = Get.find();
  static AppController appController = Get.find();
  final NavigationController navigationController = Get.find();
  final fetchedData = authController.doctorModel.value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Container(),
          title: DmText.title42Bold(
            'Dashboard',
            color: kcNeutralColor[80],
          ),
        ),
        body: ResponsiveView(context));
  }
}

class ResponsiveView extends GetResponsiveView {
  ResponsiveView(this.context) : super(alwaysUseBuilder: false);

  final BuildContext context;

  // @override
  // Widget phone() => phoneVersion();

  // @override
  // Widget tablet() => phoneVersion();

  @override
  Widget desktop() => desktopVersion(context);
}

Widget desktopVersion(BuildContext context) {
  final AuthController authController = Get.find();

  final fetchedData = authController.doctorModel.value;
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
                  alignment: Alignment.centerLeft,
                  child: DmText.title42Bold(
                    'Hello, Dr. ${fetchedData!.lastName}',
                    color: Colors.white,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'DOCTOR STATUS',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
                Obx(() => doctorStatus()),
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
                                  text: 'Read \nHealth Articles',
                                  color: verySoftRed[60],
                                  secondaryColor: verySoftRedCustomColor,
                                  //TO DO: DOC ARTICLE SCREEN??
                                  onTap: () =>
                                      Get.to(() => ArticleListScreen())),
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
                          'Your Data',
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
                                              child: AutoSizeText(
                                                '12',
                                                style: title130Bold.copyWith(
                                                    color: kcVerySoftBlueColor),
                                                maxLines: 1,
                                              ),
                                            ),
                                            Align(
                                              child: DmText.title32Bold(
                                                  'Patients'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                //TO DO - NAVIGATE TO CONS HISTORY
                                                // menuController
                                                //     .changeActiveItemTo(
                                                //         'List Of Doctors');
                                                // navigationController.navigateTo(
                                                //     Routes.DOCTOR_LIST);
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  DmText.body16Regular(
                                                      'View Consultation History'),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      //TO DO - ARTICLE LIST HERE
                                      Text('ARTICLE LISTs HERE'),
                                      Text('ARTICLE LISTs HERE'),
                                      Text('ARTICLE LISTs HERE'),
                                      Text('ARTICLE LISTs HERE'),
                                      Text('ARTICLE LISTs HERE'),
                                      Text('ARTICLE LISTs HERE'),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          stats.doctorStatus[0].numToAccomodate != 0
              ? '${stats.doctorStatus[0].accomodated} out of ${stats.doctorStatus[0].numToAccomodate} patients'
              : '',
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
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
                fontSize: 14,
                color: verySoftBlueColor,
              ),
            ),
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
  final AuthController authController = Get.find();
  final fetchedData = authController.doctorModel.value;
  return SimpleDialog(
      contentPadding: const EdgeInsets.symmetric(
          vertical: 30, horizontal: kIsWeb ? 50 : 20),
      children: [
        SizedBox(
            width: Get.width * .7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Change Status',
                  textAlign: TextAlign.center,
                  style: kIsWeb ? title32Regular : subtitle20Bold,
                ),
                verticalSpace15,
                const Text(
                  'It looks like you still have some patients waiting',
                  textAlign: TextAlign.center,
                  style: kIsWeb ? title32Regular : body16Regular,
                ),
                verticalSpace25,
                Align(
                    alignment: Alignment.bottomCenter,
                    child: TextButton(
                        onPressed: () async {
                          await firestore
                              .collection('doctors')
                              .doc(fetchedData!.userID!)
                              .collection('status')
                              .doc('value')
                              .update({'dStatus': false}).then((value) {
                            dismissDialog();
                            print('Changed status');
                            count.value = 1;
                          }).catchError((error) {
                            showErrorDialog(
                                errorDescription: 'Something went wrong!');
                          });
                        },
                        child: Text('ACCOMMODATE MY PATIENTS FIRST'))),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: TextButton(
                        onPressed: () async {
                          //final num = data['numToAccomodate'];
                          await firestore
                              .collection('doctors')
                              .doc(fetchedData!.userID!)
                              .collection('status')
                              .doc('value')
                              .update({
                            'accomodated': 0,
                            'numToAccomodate': 0,
                            'dStatus': false
                          }).then((value) {
                            //TO THINK - the offline should affect the slot available consSlot - num in category
                            dismissDialog();
                            print('Changed status');
                            count.value = 1;
                          }).catchError((error) {
                            showErrorDialog(
                                errorDescription: 'Something went wrong');
                          });
                        },
                        child: Text('GO OFFLINE NOW'))),
                verticalSpace15,
                Text(
                  'By clicking this button your status will be unavailable and you will not be able to receive any new consultation requests any more',
                  textAlign: TextAlign.center,
                  style: kIsWeb ? title32Regular : body14RegularNeutral,
                ),
              ],
            ))
      ]);
}

Widget detailsDialogCons1() {
  final AuthController authController = Get.find();
  final fetchedData = authController.doctorModel.value;
  return SimpleDialog(
      contentPadding: const EdgeInsets.symmetric(
          vertical: 30, horizontal: kIsWeb ? 50 : 20),
      children: [
        SizedBox(
            width: Get.width * .7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Change Status',
                  textAlign: TextAlign.center,
                  style: kIsWeb ? title32Regular : subtitle20Bold,
                ),
                verticalSpace15,
                const Text(
                  'Please state the number of patient you want to accomodate',
                  textAlign: TextAlign.center,
                  style: kIsWeb ? title32Regular : body16Regular,
                ),
                verticalSpace25,
                counter(),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: TextButton(
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
                          }).then((value) {
                            dismissDialog();
                            print('Changed status');
                            count.value = 1;
                          }).catchError((error) {
                            showErrorDialog(
                                errorDescription: 'Something went wrong');
                          });
                        },
                        child: Text('Ready for Consultation'))),
                verticalSpace15,
                Text(
                  'By clicking this button your status will be available and you will be able to receive consultation requests',
                  textAlign: TextAlign.center,
                  style: kIsWeb ? title32Regular : body14RegularNeutral,
                ),
              ],
            ))
      ]);
}

Widget detailsDialogCons2(int currentCount) {
  final AuthController authController = Get.find();
  final fetchedData = authController.doctorModel.value;
  return SimpleDialog(
      contentPadding: const EdgeInsets.symmetric(
          vertical: 30, horizontal: kIsWeb ? 50 : 20),
      children: [
        SizedBox(
            width: Get.width * .7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Add more patient to examine',
                  textAlign: TextAlign.center,
                  style: title32Regular,
                ),
                verticalSpace15,
                const Text(
                  'Please input the value of how many patients you want to add to examine.',
                  textAlign: TextAlign.center,
                  style: title32Regular,
                ),
                verticalSpace25,
                counterAddittional(),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: TextButton(
                        onPressed: () async {
                          await firestore
                              .collection('doctors')
                              .doc(fetchedData!.userID!)
                              .collection('status')
                              .doc('value')
                              .update({
                            'numToAccomodate': currentCount + countAdd.value
                          }).then((value) {
                            dismissDialog();
                            print('Add count');
                            countAdd.value = 1;
                          }).catchError((error) {
                            showErrorDialog(
                                errorDescription: 'Something went wrong');
                          });
                        },
                        child: Text('Add count'))),
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
