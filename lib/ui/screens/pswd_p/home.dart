import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/core/controllers/pswd/attached_photos_controller.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';

//!Resources:
//*https://youtu.be/z7P1OFLw4kY
//*https://youtu.be/udsysUj-X4w
//*https://github.com/filiph/hn_app/tree/episode51-upgrade

class PSWDPersonnelHomeScreen extends GetResponsiveView {
  final AttachedPhotosController pswdController =
      Get.put(AttachedPhotosController());
  @override
  Widget? builder() => screen.isDesktop
      ? PSWDPersonnelHomeScreenDesktop()
      : screen.isPhone
          ? PSWDPersonnelHomeScreenMobile()
          : PSWDPersonnelHomeScreenTablet();
}

class PSWDPersonnelHomeScreenDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final children = [
      AppDrawer(),
      DashboardScreen(),
    ];
    return Scaffold(
      body: Row(
        children: children,
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Center(
        child: Text('Dashboard Screen'),
      ),
    );
  }
}

class PSWDPersonnelHomeScreenTablet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final children = [
      DashboardScreen(),
      AppDrawer(),
    ];
    return Scaffold(
      body: Column(
        children: children,
      ),
    );
  }
}

class PSWDPersonnelHomeScreenMobile extends StatelessWidget {
  static AuthController authController = Get.find();

  final fetchedData = authController.pswdModel.value;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            size: 30,
          ),
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
        ),
      ),
      drawer: AppDrawer(),
      body: Column(
        children: [
          DashboardScreen(),
        ],
      ),
    );
  }
}

class AppDrawer extends GetResponsiveView {
  @override
  Widget? builder() {
    return screen.isDesktop
        ? AppDrawerDesktop()
        : screen.isPhone
            ? AppDrawerMobile()
            : AppDrawerTablet();
  }

  static List<Widget> getDrawerOptions() {
    return [
      DrawerOption(
        title: 'Dashboard',
        iconData: Icons.dashboard,
      ),
      DrawerOption(
        title: 'Medical Assistance Request',
        iconData: Icons.do_disturb,
      ),
    ];
  }
}

class AppDrawerDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      decoration: const BoxDecoration(
        color: sidePanelColor,
        boxShadow: [
          BoxShadow(blurRadius: 16, color: Colors.black12),
        ],
      ),
      child: Column(
        children: [
          Image.asset(
            logo,
            fit: BoxFit.fill,
            height: 120,
            width: 120,
          ),
          ...AppDrawer.getDrawerOptions(),
        ],
      ),
    );
  }
}

class AppDrawerTablet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      decoration: const BoxDecoration(
        color: sidePanelColor,
        boxShadow: [
          BoxShadow(
            blurRadius: 16,
            color: Colors.black12,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: AppDrawer.getDrawerOptions(),
      ),
    );
  }
}

class AppDrawerMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      decoration: const BoxDecoration(
        color: sidePanelColor,
        boxShadow: [
          BoxShadow(
            blurRadius: 16,
            color: Colors.black12,
          ),
        ],
      ),
      child: Column(
        children: AppDrawer.getDrawerOptions(),
      ),
    );
  }
}

class DrawerOption extends GetResponsiveView {
  DrawerOption({
    required this.title,
    required this.iconData,
  });
  final String? title;
  final IconData? iconData;

  @override
  Widget builder() => screen.isDesktop
      ? DrawerOptionDesktop(title: title, iconData: iconData)
      : screen.isPhone
          ? DrawerOptionsMobile(title: title, iconData: iconData)
          : DrawerOptionTablet(title: title, iconData: iconData);
}

class DrawerOptionDesktop extends StatelessWidget {
  const DrawerOptionDesktop({required this.title, required this.iconData});
  final String? title;
  final IconData? iconData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 25),
      height: 80,
      child: Row(
        children: [
          Icon(
            iconData,
            size: 25,
          ),
          Text(title!),
        ],
      ),
    );
  }
}

class DrawerOptionTablet extends StatelessWidget {
  const DrawerOptionTablet({required this.title, required this.iconData});
  final String? title;
  final IconData? iconData;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 152,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            iconData,
            size: 45,
          ),
          Text(
            title!,
          )
        ],
      ),
    );
  }
}

class DrawerOptionsMobile extends StatelessWidget {
  const DrawerOptionsMobile({this.title, this.iconData});
  final String? title;
  final IconData? iconData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 25),
      height: 80,
      child: Row(
        children: [
          Icon(
            iconData,
            size: 25,
          ),
          Text(
            title!,
          ),
        ],
      ),
    );
  }
}
