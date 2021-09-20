import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(child: ResponsiveView())),
    );
  }
}

class ResponsiveView extends GetResponsiveView {
  ResponsiveView() : super(alwaysUseBuilder: false);

  @override
  Widget phone() => Column(
        children: [
          SizedBox(
            height: Get.height,
            width: Get.width,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              verticalSpace35,
              admProfile(),
            ]),
          )
        ],
      );

  @override
  Widget tablet() => Column(
        children: [
          SizedBox(
            height: Get.height,
            width: Get.width,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              verticalSpace35,
              admProfile(),
            ]),
          )
        ],
      );

  @override
  Widget desktop() => Column(
        children: [
          SizedBox(
            height: Get.height,
            width: screen.width,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              verticalSpace35,
              admProfile(),
            ]),
          ),
        ],
      );

  Widget admProfile() {
    return Center(
        child: Column(children: [
      horizontalSpace200,
      CircleAvatar(
        backgroundImage: AssetImage(authHeader),
        radius: 50,
      ),
      verticalSpace18,
      const Text(
        'Sarsa Stark',
        style: body16Bold,
      ),
      verticalSpace10,
      const Text(
        'admin@gmail.com',
        style: body14Regular,
      ),
      verticalSpace50,
      Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
        const Icon(Icons.lock_outline),
        InkWell(
          onTap: () {},
          child: const Text(
            'Change Password',
            style: body14Regular,
          ),
        ),
      ])
    ]));
  }
}
