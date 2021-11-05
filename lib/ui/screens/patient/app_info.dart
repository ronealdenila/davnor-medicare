import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppInfoScreen extends StatelessWidget {

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
                child: Text('Davnor Medicare', style: subtitle18RegularOrange),
              ),
              verticalSpace20,

              //sample app info
             const Text(
                'DavNor Medicare offers public services, such as free medical consultation, and PSWD’s medical assistance program to the people. ',
                textAlign: TextAlign.justify,
                style: subtitle18Regular,
              ),
            ]),
          )
        )
      )
    );
  }
}