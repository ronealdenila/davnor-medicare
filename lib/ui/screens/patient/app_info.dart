import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/core/services/url_launcher_service.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppInfoScreen extends StatelessWidget {
  final UrlLauncherService _urlLauncherService = UrlLauncherService();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.chevron_left),
                onPressed: Get.back,
                color: Colors.black,
              ),
            ),
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        logo,
                        fit: BoxFit.cover,
                      ),
                    ),
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
                    Text('Roneal John Denila ', style: caption18RegularNeutral),
                    Text('Hanna Alondra Demegillo',
                        style: caption18RegularNeutral),
                    verticalSpace18,
                    const Text(
                      'Icons used credits to:',
                      textAlign: TextAlign.left,
                      style: subtitle16Bold,
                    ),
                    verticalSpace5,
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
                          Flexible(
                            child: Column(
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
                                ]),
                          ),
                        ]),
                    verticalSpace5,
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            flaticon,
                            fit: BoxFit.fill,
                            height: 50,
                            width: 50,
                          ),
                          horizontalSpace10,
                          Flexible(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Flaticon', style: body14SemiBold),
                                  verticalSpace5,
                                  InkWell(
                                    onTap: () {
                                      _urlLauncherService.launchURL(
                                          'https://www.flaticon.com');
                                    },
                                    child: Text('https://www.flaticon.com',
                                        style: body16RegularUnderlineBlue),
                                  ),
                                ]),
                          ),
                        ]),
                    verticalSpace18,
                    const Text(
                      'Photo used from:',
                      textAlign: TextAlign.left,
                      style: subtitle16Bold,
                    ),
                    verticalSpace5,
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            freepik,
                            fit: BoxFit.fill,
                            height: 50,
                            width: 50,
                          ),
                          horizontalSpace15,
                          Flexible(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Freepik', style: body14SemiBold),
                                  verticalSpace5,
                                  InkWell(
                                    onTap: () {
                                      _urlLauncherService
                                          .launchURL('https://www.freepik.com');
                                    },
                                    child: Text('https://www.freepik.com',
                                        style: body16RegularUnderlineBlue),
                                  ),
                                ]),
                          ),
                        ]),
                    verticalSpace18,
                    const Text(
                      'Splash screen animation from:',
                      textAlign: TextAlign.left,
                      style: subtitle16Bold,
                    ),
                    verticalSpace5,
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            lottiefile,
                            fit: BoxFit.fill,
                            height: 50,
                            width: 50,
                          ),
                          horizontalSpace15,
                          Flexible(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Lottie by: Abdul Latif',
                                      style: body14SemiBold),
                                  verticalSpace5,
                                  InkWell(
                                    onTap: () {
                                      _urlLauncherService
                                          .launchURL('https://lottiefiles.com');
                                    },
                                    child: Text('https://lottiefiles.com',
                                        style: body16RegularUnderlineBlue),
                                  ),
                                ]),
                          )
                        ]),
                    verticalSpace15
                  ]),
            ))));
  }
}
