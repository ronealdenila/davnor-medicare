import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationFeedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text(
          'Notifications',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          shrinkWrap: true,
          itemCount: 10,
          itemBuilder: (context, index) {
            return SizedBox(
              width: Get.width,
              child: Column(
                children: [
                  verticalSpace10,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: getPhoto()),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text.rich(
                                  TextSpan(
                                    style: body14Regular,
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: 'The admin ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(text: 'has accepted your '),
                                      TextSpan(
                                          text: 'verification request',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                                verticalSpace5,
                                Text(
                                  // ignore: lines_longer_than_80_chars
                                  '"Dili klaro ang valid ID na giprovice nimo maam. Palg ko ang ko pasend usab"',
                                  style: body14Regular.copyWith(
                                      color: Colors.black87),
                                ),
                                verticalSpace10,
                                const Text(
                                  '3 mins ago',
                                  style: caption12RegularNeutral,
                                ),
                                verticalSpace10,
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                ],
              ),
            );
          }),
    ));
  }
}

Widget getPhoto() {
  //if (liveCont.getDoctorProfile(model) == '') {
  return CircleAvatar(
    radius: 20,
    backgroundImage: AssetImage(blankProfile),
  );
  //}
  // return CircleAvatar(
  //   radius: 25,
  //   backgroundImage: NetworkImage(liveCont.getDoctorProfile(model)),
  // );
}
