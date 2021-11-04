import 'package:davnor_medicare/constants/asset_paths.dart';
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
      appBar: AppBar(leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () {},
        color: Colors.black,
        ),),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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
                child: Text('Davnor Medicare', style: subtitle18RegularOrange),
              ),
              verticalSpace35,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text('Settings', style: subtitle20Bold),
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
                        const Text(
                          'Change Language',
                          style: subtitle20Medium,
                        ),
                      ]),
                ),
              ),
              verticalSpace10,
              InkWell(
                onTap: () {
                  //go to app info, always credit icons8 website
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
                        const Text(
                          'App Info',
                          style: subtitle20Medium,
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
            title: Text('Choose Your Language'),
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
