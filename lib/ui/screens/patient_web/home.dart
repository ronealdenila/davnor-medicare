import 'package:davnor_medicare/core/controllers/navigation_controller.dart';
import 'package:davnor_medicare/core/controllers/patient/menu_controller.dart';
import 'package:davnor_medicare/ui/screens/patient_web/helpers/local_navigator.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
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
  final PatientMenuController menuController =
      Get.put(PatientMenuController(), permanent: true);
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
        child: PatientSideMenu(),
      ),
      body: ResponsiveBody(),
    );
  }

  AppBar topNavigationBar() {
    final AuthController authController = Get.find();
    final fetchedData = authController.patientModel.value;
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
                    //TO DO: SHOULD NAVIGATE TO Patient PROFILE MAKE PROFILE SCREEN FIRST
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
  // final ArticleController articleService = Get.find();
  // final ConsultationsController consRequests =
  //     Get.put(ConsultationsController());
  // final LiveConsController liveCont =
  //     Get.put(LiveConsController(), permanent: true);
  static AuthController authController = Get.find();
  final NavigationController navigationController = Get.find();
  final fetchedData = authController.patientModel.value;

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

  @override
  Widget phone() => tabletVersion(context);
  @override
  Widget tablet() => tabletVersion(context);

  @override
  Widget desktop() => desktopVersion(context);
}

Widget tabletVersion(BuildContext context) {
  PatientMenuController menuController = Get.find();
  final AuthController authController = Get.find();
  final fetchedData = authController.patientModel.value;
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
  PatientMenuController menuController = Get.find();
  final AuthController authController = Get.find();
  final fetchedData = authController.patientModel.value;
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
          ])));
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
