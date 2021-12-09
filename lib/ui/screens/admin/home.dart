import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/constants/app_strings.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/admin/doctor_list_controller.dart';
import 'package:davnor_medicare/core/controllers/admin/doctor_registration_controller.dart';
import 'package:davnor_medicare/core/controllers/admin/menu_controller.dart';
import 'package:davnor_medicare/core/controllers/admin/pswd_registration_controller.dart';
import 'package:davnor_medicare/core/controllers/admin/pswd_staff_list_controller.dart';
import 'package:davnor_medicare/core/controllers/app_controller.dart';
import 'package:davnor_medicare/core/controllers/navigation_controller.dart';
import 'package:davnor_medicare/routes/app_pages.dart';
import 'package:davnor_medicare/ui/screens/admin/helpers/local_navigator.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/widgets/action_card.dart';
import 'package:davnor_medicare/ui/widgets/admin/side_menu.dart';
import 'package:davnor_medicare/ui/widgets/splash_loading.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:flutter/cupertino.dart';

class AdminHomeScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKeyA = GlobalKey();
  static AuthController authController = Get.find();
  final AdminMenuController menuController =
      Get.put(AdminMenuController(), permanent: true);
  final DoctorListController dListController =
      Get.put(DoctorListController(), permanent: true);
  final DoctorRegistrationController doctorRegistrationController =
      Get.put(DoctorRegistrationController(), permanent: true);
  final PSWDStaffListController pListController =
      Get.put(PSWDStaffListController(), permanent: true);
  final PSWDRegistrationController pswdRegistrationController =
      Get.put(PSWDRegistrationController(), permanent: true);
  final fetchedData = authController.adminModel.value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKeyA,
      extendBodyBehindAppBar: true,
      appBar: topNavigationBar(),
      drawer: Drawer(
        child: AdminSideMenu(),
      ),
      body: Obx(() => authController.doneInitData.value
          ? ResponsiveBody()
          : SplashLoading()),
    );
  }

  AppBar topNavigationBar() {
    return AppBar(
      leading: ResponsiveLeading(scaffoldKeyA),
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
                  navigationController.navigateTo(Routes.ADMIN_PROFILE);
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
        Expanded(child: AdminSideMenu()),
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

//Refactor
class ResponsiveLeading extends GetResponsiveView {
  ResponsiveLeading(this.scaffoldKeyA);
  final GlobalKey<ScaffoldState> scaffoldKeyA;
  @override
  Widget? builder() {
    if (screen.isDesktop) {
      return Container();
    } else {
      return IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {
          scaffoldKeyA.currentState!.openDrawer();
        },
      );
    }
  }
}

class AdminDashboardScreen extends GetView<AdminMenuController> {
  static AuthController authController = Get.find();
  static AppController appController = Get.find();
  final NavigationController navigationController = Get.find();
  final DoctorRegistrationController doctorRegistrationController = Get.find();
  final PSWDRegistrationController pswdRegistrationController = Get.find();
  final fetchedData = authController.adminModel.value;

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
  final AdminMenuController menuController = Get.find();
  final AppController appController = Get.find();
  static AuthController authController = Get.find();
  final fetchedData = authController.adminModel.value;
  final PSWDStaffListController pListController = Get.find();
  final DoctorListController dListController = Get.find();

  @override
  Widget phone() => phoneVersion();

  @override
  Widget tablet() => phoneVersion();

  @override
  Widget desktop() => desktopVersion();

  Widget desktopVersion() {
    return SingleChildScrollView(
      child: Container(
        height: 850,
        child: Column(
          children: [
            Container(
              height: 200,
              margin: const EdgeInsets.all(25),
              padding: const EdgeInsets.all(25),
              width: Get.width,
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
                ],
              ),
            ),
            Expanded(
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
                          height: 482,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 150,
                                child: ActionCard(
                                  text: 'Register a doctor',
                                  onTap: () {
                                    navigationController.navigateToWithBack(
                                        Routes.DOCTOR_REGISTRATION);
                                  },
                                  color: verySoftMagenta[60],
                                  secondaryColor: verySoftMagentaCustomColor,
                                ),
                              ),
                              SizedBox(
                                height: 150,
                                child: ActionCard(
                                  text: 'Add a PSWD\nPersonnel',
                                  onTap: () {
                                    navigationController.navigateToWithBack(
                                        Routes.PSWD_STAFF_REGISTRATION);
                                  },
                                  color: verySoftOrange[60],
                                  secondaryColor: verySoftOrangeCustomColor,
                                ),
                              ),
                              SizedBox(
                                height: 150,
                                child: ActionCard(
                                  text: 'Verify User',
                                  onTap: () {
                                    menuController.changeActiveItemTo(
                                        'Verification Requests');
                                    navigationController.navigateTo(
                                        Routes.VERIFICATION_REQ_LIST);
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
                          'Davnor Medicare Data',
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
                                        height: 482,
                                        width: Get.width * .7,
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
                                                      text: 'As Of Now',
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
                                              medicareDataSubtitle,
                                            ),
                                            verticalSpace20,
                                            Align(
                                              child: Obx(
                                                () => AutoSizeText(
                                                  '${dListController.doctorList.length}',
                                                  style: title130Bold.copyWith(
                                                      color:
                                                          kcVerySoftBlueColor),
                                                  maxLines: 1,
                                                ),
                                              ),
                                            ),
                                            Align(
                                              child:
                                                  DmText.title32Bold('Doctors'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                menuController
                                                    .changeActiveItemTo(
                                                        'List Of Doctors');
                                                navigationController.navigateTo(
                                                    Routes.DOCTOR_LIST);
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  DmText.body16Regular(
                                                      'View Doctors'),
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
                                                    height: 320,
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
                                                    height: 320,
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
                                                            'VERIFIED \nUSERS',
                                                            color: neutralColor,
                                                          ),
                                                        ),
                                                        StreamBuilder<
                                                                DocumentSnapshot>(
                                                            stream: firestore
                                                                .collection(
                                                                    'app_status')
                                                                .doc(
                                                                    'verified_users')
                                                                .snapshots(),
                                                            builder: (context,
                                                                snapshot) {
                                                              if (!snapshot
                                                                      .hasData ||
                                                                  snapshot
                                                                      .hasError) {
                                                                return Text(
                                                                    '0');
                                                              }
                                                              final map =
                                                                  snapshot.data!
                                                                          .data()
                                                                      as Map;
                                                              return Text(
                                                                '${map['count']}',
                                                                style:
                                                                    title90BoldBlue,
                                                              );
                                                            }),
                                                        Align(
                                                          alignment: Alignment
                                                              .bottomRight,
                                                          child: TextButton(
                                                            onPressed: () {
                                                              menuController
                                                                  .changeActiveItemTo(
                                                                      'Verification Requests');
                                                              navigationController
                                                                  .navigateTo(Routes
                                                                      .VERIFICATION_REQ_LIST);
                                                            },
                                                            child:
                                                                Wrap(children: [
                                                              DmText
                                                                  .body16Regular(
                                                                'See Verification Requests',
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
                                              height: 140,
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
          height: 200,
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
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 150,
                            child: ActionCard(
                              text: 'Register a doctor',
                              onTap: () {
                                navigationController.navigateToWithBack(
                                    Routes.DOCTOR_REGISTRATION);
                              },
                              color: verySoftMagenta[60],
                              secondaryColor: verySoftMagentaCustomColor,
                            ),
                          ),
                          SizedBox(
                            height: 150,
                            child: ActionCard(
                              text: 'Add a PSWD Personnel',
                              onTap: () {
                                navigationController.navigateToWithBack(
                                    Routes.PSWD_STAFF_REGISTRATION);
                              },
                              color: verySoftOrange[60],
                              secondaryColor: verySoftOrangeCustomColor,
                            ),
                          ),
                          SizedBox(
                            height: 150,
                            child: ActionCard(
                              text: 'Verify User',
                              onTap: () {
                                menuController.changeActiveItemTo(
                                    'Verification Requests');
                                navigationController
                                    .navigateTo(Routes.VERIFICATION_REQ_LIST);
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
                      'Davnor Medicare Data',
                      color: kcNeutralColor,
                    ),
                    verticalSpace15,
                    Container(
                      height: 447,
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
                                    text: 'As Of Now ',
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
                            medicareDataSubtitle,
                          ),
                          Align(
                            child: Obx(
                              () => AutoSizeText(
                                '${dListController.doctorList.length}',
                                style: title130Bold.copyWith(
                                    color: kcVerySoftBlueColor),
                                maxLines: 1,
                              ),
                            ),
                          ),
                          Align(
                            child: DmText.body16Bold('Doctors'),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: TextButton(
                              onPressed: () {
                                menuController
                                    .changeActiveItemTo('List Of Doctors');
                                navigationController
                                    .navigateTo(Routes.DOCTOR_LIST);
                              },
                              child: Wrap(children: [
                                DmText.body16Regular(
                                  'View Doctors',
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
                          'VERIFIED \nUSERS',
                          color: neutralColor,
                        ),
                      ),
                      Text(
                        '120',
                        style:
                            title130Bold.copyWith(color: kcVerySoftBlueColor),
                      ),
                      TextButton(
                        onPressed: () {
                          menuController
                              .changeActiveItemTo('Verification Requests');
                          navigationController
                              .navigateTo(Routes.VERIFICATION_REQ_LIST);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            DmText.subtitle18Regular(
                              'See Verification Requests',
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
}

class AdminSideMenuItem extends GetView<AdminMenuController> {
  AdminSideMenuItem({required this.itemName, required this.onTap});
  final String? itemName;
  final void Function()? onTap;
  final AdminMenuController menuController = Get.find();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onHover: (value) {
        value
            ? menuController.onHover(itemName!)
            : menuController.onHover('not hovering');
      },
      child: Obx(
        () => Container(
          color: menuController.isHovering(itemName!)!
              ? const Color(0xFFA4A6B3)
              : Colors.transparent,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: menuController.returnIconFor(itemName!),
              ),
              Flexible(
                child: Text(
                  itemName!,
                  style: subtitle18Medium.copyWith(
                    color: menuController.isActive(itemName!)!
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
