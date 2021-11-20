import 'package:davnor_medicare/constants/app_items.dart';
import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/core/controllers/live_cons_controller.dart';
import 'package:davnor_medicare/core/controllers/navigation_controller.dart';
import 'package:davnor_medicare/core/controllers/patient/cons_req_controller.dart';
import 'package:davnor_medicare/core/controllers/patient/menu_controller.dart';
import 'package:davnor_medicare/core/services/url_launcher_service.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:davnor_medicare/ui/screens/patient_web/home.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PatientSideMenu extends GetView<PatientMenuController> {
  final ConsRequestController consController = Get.find();
  final NavigationController navigationController = Get.find();
  final LiveConsController liveCont = Get.find();
  final List locale = [
    {'name': 'English', 'locale': Locale('english', 'US')},
    {'name': 'Tagalog', 'locale': Locale('tagalog', 'ph')},
    {'name': 'Bisaya', 'locale': Locale('bisaya', 'ph')},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: sidePanelColor,
      child: ListView(
        children: [
          Column(mainAxisSize: MainAxisSize.min, children: [
            Image.asset(
              logo2,
              fit: BoxFit.contain,
            ),
            ...patientSideMenuItemRoutes
                .map((item) => PatientSideMenuItem(
                    itemName: item.name,
                    onTap: () {
                      if (item.name == 'Live Consultation' &&
                          liveCont.liveCons.isEmpty) {
                        showErrorDialog(
                            errorTitle: 'Sorry you have no live consultation',
                            errorDescription:
                                'Please request consultation first');
                      } else if (item.name == 'Change Language') {
                        buildLanguageDialog(context);
                      } else if (item.name == 'App Info') {
                        appInfoDialog(context);
                      } else {
                        if (!controller.isActive(item.name!)!) {
                          controller.changeActiveItemTo(item.name);
                          navigationController.navigateTo(item.route!);
                        }
                      }
                    }))
                .toList(),
          ])
        ],
      ),
    );
  }

  buildLanguageDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
            title: Text('Choose Your Language'),
            content: Container(
              width: Get.width * .2,
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        child: Text(locale[index]['name']),
                        onTap: () {
                          updateLanguage(locale[index]['locale']);
                        },
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: Colors.blue,
                    );
                  },
                  itemCount: locale.length),
            ),
          );
        });
  }
}

appInfoDialog(BuildContext context) {
  final UrlLauncherService _urlLauncherService = UrlLauncherService();
  showDialog(
      context: context,
      builder: (builder) {
        return AlertDialog(
          content: Container(
              width: Get.width * .3,
              child: SingleChildScrollView(
                  child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          logo,
                          fit: BoxFit.fill,
                          height: 120,
                          width: 120,
                        ),
                      ),
                      verticalSpace10,
                      Align(
                        alignment: Alignment.center,
                        child: Text('DavNor Medicare',
                            style: subtitle18RegularOrange),
                      ),
                      verticalSpace20,
                      Text(
                        'appinfo'.tr,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 18,
                        ),
                      ),
                      verticalSpace20,
                      const Text('Developers:',
                          textAlign: TextAlign.left, style: subtitle18Bold),
                      Text('Emmalyn Nabiamos', style: caption18RegularNeutral),
                      Text('Roneal John Denila ',
                          style: caption18RegularNeutral),
                      Text('Hanna Alondra Demegillo',
                          style: caption18RegularNeutral),
                      verticalSpace18,
                      const Text(
                        'Illnesses Icons from:',
                        textAlign: TextAlign.left,
                        style: subtitle18Bold,
                      ),
                      verticalSpace10,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            icons8,
                            fit: BoxFit.fill,
                            height: 50,
                            width: 50,
                          ),
                          horizontalSpace10,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Icons8', style: body14SemiBold),
                              verticalSpace5,
                              InkWell(
                                onTap: () {
                                  _urlLauncherService
                                      .launchURL('https://icons8.com');
                                },
                                child: Text('https://icons8.com',
                                    style: body16RegularUnderlineBlue),
                              ),
                            ],
                          ),
                        ],
                      )
                    ]),
              ))),
        );
      });
}

updateLanguage(Locale locale) {
  Get.back();
  Get.updateLocale(locale);
}
