import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/ui/screens/patient/app_info.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final List locale = [
  {'name': 'English', 'locale': Locale('english', 'US')},
  {'name': 'Tagalog', 'locale': Locale('tagalog', 'ph')},
  {'name': 'Bisaya', 'locale': Locale('bisaya', 'ph')},
];

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          iconSize: 30.0,
          onPressed: () {
            Get.back();
          },
          color: Colors.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  logo,
                  fit: BoxFit.contain,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text('setting'.tr, 
                style: subtitle20Bold),
              ),
              verticalSpace20,
              InkWell(
                onTap: () {
                  buildLanguageDialog(context);
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        horizontalSpace20,
                        SizedBox(
                            width: 50,
                            child: const Icon(
                              Icons.translate_outlined,
                              size: 25,
                            )),
                        Flexible(
                          child: Text(
                            'setting1'.tr,
                            style: subtitle18Medium,
                          ),
                        ),
                      ]),
                ),
              ),
              verticalSpace10,
              InkWell(
                onTap: () {
                  Get.to(() => AppInfoScreen());
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        horizontalSpace20,
                        SizedBox(
                            width: 50,
                            child: const Icon(
                              Icons.info_outline_rounded,
                              size: 25,
                            )),
                        Flexible(
                          child: Text(
                            'setting2'.tr,
                            style: subtitle18Medium,
                          ),
                        ),
                      ]),
                ),
              ),
            ]),
      ),
    );
  }

  buildLanguageDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
            title: Text('setting3'.tr),
            content: Container(
              width: double.maxFinite,
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

updateLanguage(Locale locale) {
  Get.back();
  Get.updateLocale(locale);
}
