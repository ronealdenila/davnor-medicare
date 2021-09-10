import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/core/controllers/pswd/home_controller.dart';
import 'package:davnor_medicare/routes/app_pages.dart';
import 'package:davnor_medicare/ui/screens/pswd_p/helpers/local_navigator.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:davnor_medicare/core/controllers/pswd/menu_controller.dart';
import 'package:davnor_medicare/core/controllers/pswd/navigation_controller.dart';

//!Resources:
//*https://youtu.be/z7P1OFLw4kY
//*https://youtu.be/udsysUj-X4w
//*https://github.com/filiph/hn_app/tree/episode51-upgrade

//!TO be refactoooor
//TODO(R): item name must be removed when on tablet/phone resolution

class PSWDPersonnelHome extends StatelessWidget {
  final HomeController pswdController = Get.put(HomeController());
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: topNavigationBar(context, scaffoldKey),
      drawer: Drawer(child: SideMenu()),
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
        Expanded(child: SideMenu()),
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
        const Text('PSWD Personnel', style: TextStyle(color: Colors.black)),
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

class SideMenu extends GetView<MenuController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: sidePanelColor,
      child: ListView(
        children: [
          Column(mainAxisSize: MainAxisSize.min, children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Image.asset(
                logo,
                fit: BoxFit.fill,
                height: 120,
                width: 120,
              ),
            ),
            ...sideMenuItemRoutes
                .map((item) => SideMenuItem(
                    itemName: item.name,
                    onTap: () {
                      if (!controller.isActive(item.name!)!) {
                        controller.changeActiveItemTo(item.name);
                        navigationController.navigateTo(item.route!);
                      }
                    }))
                .toList(),
          ])
        ],
      ),
    );
  }
}

class DashboardScreen extends GetView<MenuController> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        verticalSpace50,
        Container(
          margin: const EdgeInsets.only(top: 20),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              controller.activeItem.value,
              style: title32Regular,
            ),
          ),
        ),
      ],
    );
  }
}

class MenuItem {
  MenuItem(this.name, this.route);

  final String? name;
  final String? route;
}

List<MenuItem> sideMenuItemRoutes = [
  MenuItem('Dashboard', Routes.DASHBOARD),
  MenuItem('Medical Assistance Request', Routes.PSWD_MA_REQ_LIST),
];

class SideMenuItem extends GetView<MenuController> {
  const SideMenuItem({required this.itemName, required this.onTap});
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
