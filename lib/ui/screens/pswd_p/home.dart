import 'package:auto_size_text/auto_size_text.dart';
import 'package:davnor_medicare/constants/app_items.dart';
import 'package:davnor_medicare/constants/app_strings.dart';
import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/core/controllers/pswd/on_progress_req_controller.dart';
import 'package:davnor_medicare/core/controllers/pswd/menu_controller.dart';
import 'package:davnor_medicare/ui/screens/pswd_p/helpers/local_navigator.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:davnor_medicare/ui/widgets/action_card.dart';
import 'package:davnor_medicare/ui/widgets/pswd/side_menu.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//!Resources:
//*https://youtu.be/z7P1OFLw4kY
//*https://youtu.be/udsysUj-X4w
//*https://github.com/filiph/hn_app/tree/episode51-upgrade

class PSWDPersonnelHome extends StatelessWidget {
  final OnProgressReqController pswdController =
      Get.put(OnProgressReqController());
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  static AuthController authController = Get.find();
  final fetchedData = authController.pswdModel.value;

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
      drawer: Drawer(child: PswdPSideMenu()),
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
  String? name,
) {
  return AppBar(
    leading: ResponsiveLeading(key),
    elevation: 0,
    backgroundColor: Colors.transparent,
    title: Row(
      children: [
        Expanded(child: Container()),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications),
        ),
        Text(name!, style: const TextStyle(color: Colors.black)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_drop_down)),
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

class PswdPDashboardScreen extends GetView<MenuController> {
  static AuthController authController = Get.find();
  final OnProgressReqController homeController = Get.find();
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
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(25),
              padding: const EdgeInsets.all(25),
              width: context.width,
              height: context.height * .2,
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
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                padding: const EdgeInsets.all(20),
                              ),
                              child: DmText.subtitle20Medium(
                                'Ready to Accept Requests',
                                color: neutralColor[60],
                              ),
                              onPressed: () {},
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
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                padding: const EdgeInsets.all(20),
                              ),
                              child: DmText.subtitle20Medium(
                                'Available',
                                color: neutralColor[60],
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      // color: Colors.amber,
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
                          Expanded(
                            flex: 6,
                            child: Container(
                              alignment: Alignment.centerLeft,
                              // color: Colors.cyanAccent,
                              child: Column(
                                children: [
                                  ActionCard(
                                    text: 'Change MA Status',
                                    onTap: () {},
                                    color: verySoftMagenta[60],
                                    secondaryColor: verySoftMagentaCustomColor,
                                  ),
                                  ActionCard(
                                    text: 'Change PSWD Fund Status',
                                    onTap: () {},
                                    color: verySoftOrange[60],
                                    secondaryColor: verySoftOrangeCustomColor,
                                  ),
                                  ActionCard(
                                    text: 'View MA History',
                                    onTap: () {},
                                    color: verySoftRed[60],
                                    secondaryColor: verySoftRedCustomColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      // color: Colors.cyan,
                      margin: const EdgeInsets.all(25),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            // color: Colors.yellowAccent,
                            child: DmText.title24Medium(
                              'Medical Assistance Status',
                              color: kcNeutralColor,
                            ),
                          ),
                          verticalSpace15,
                          Expanded(
                            flex: 6,
                            child: Container(
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
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'As Of Today ',
                                            style: title32Bold.copyWith(
                                                color: kcNeutralColor),
                                          ),
                                          TextSpan(
                                            text: '(${homeController.dateNow})',
                                            style: subtitle18Regular,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // verticalSpace15,

                                  DmText.subtitle18Regular(
                                    medicalStatusSubtitle1,
                                  ),
                                  // verticalSpace20,
                                  Align(
                                    child: AutoSizeText(
                                      '40',
                                      style: title150Bold.copyWith(
                                          color: kcVerySoftBlueColor),
                                      maxLines: 1,
                                    ),
                                    // DmText.title150Bold(
                                    //   '40',
                                    //   color: kcVerySoftBlueColor,
                                    // ),
                                  ),
                                  Align(
                                    child: DmText.title32Bold('People'),
                                  ),
                                  // verticalSpace50,
                                  TextButton(
                                    onPressed: () {},
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        DmText.subtitle18Regular(
                                            'View MA Request'),
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
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      // color: Colors.lime,
                      margin: const EdgeInsets.all(25),
                      child: Column(
                        children: [
                          DmText.title24Medium(
                            '',
                          ),
                          verticalSpace15,
                          Expanded(
                            flex: 6,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        height: context.height * .3,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(
                                                  0.5), //color of shadow
                                              spreadRadius: 3, //spread radius
                                              blurRadius: 4, // blur radius
                                              offset: const Offset(4,
                                                  8), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            AutoSizeText(
                                              'ON PROGRESS REQUEST TODAY',
                                              style: title24Medium.copyWith(
                                                color: kcNeutralColor,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                            // DmText.title24Medium(
                                            //     'ON PROGRESS REQUESTS TODAY'),
                                            // DmText.title150Bold('2'),
                                            AutoSizeText(
                                              '2',
                                              style: title150Bold.copyWith(
                                                  color: kcVerySoftBlueColor),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                            TextButton(
                                              onPressed: () {},
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  DmText.subtitle18Regular(
                                                      'View MA Request'),
                                                  const Icon(
                                                      Icons.chevron_right),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    horizontalSpace25,
                                    Expanded(
                                      child: Container(
                                        height: context.height * .3,
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
                                                  8), // / changes position of shadow
                                            ),
                                          ],
                                        ),
                                        // padding: const EdgeInsets.all(25),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            AutoSizeText(
                                              'The application has',
                                              style: body16Regular.copyWith(
                                                  color: neutralColor),
                                              maxLines: 1,
                                            ),
                                            // DmText.body16Regular(
                                            //     'The application has'),
                                            DmText.title150Bold(
                                              '3',
                                              color: kcVerySoftBlueColor,
                                            ),
                                            const AutoSizeText(
                                              'PSWD Personnel',
                                              style: subtitle20Medium,
                                              maxLines: 1,
                                            ),
                                            // DmText.subtitle20Medium(
                                            //     'PSWD Personnel'),
                                            const AutoSizeText(
                                              cardSubtitle1,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              textAlign: TextAlign.center,
                                              maxLines: 2,
                                            ),
                                            // DmText.body16Regular(
                                            //   'in-charge of Medical Assistance (MA)',
                                            // ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                verticalSpace50,
                                Container(
                                  // color: Colors.green,
                                  padding: const EdgeInsets.all(25),
                                  width: context.width,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey
                                            .withOpacity(0.5), //color of shadow
                                        spreadRadius: 5, //spread radius
                                        blurRadius: 7, // blur radius
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
    );
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
