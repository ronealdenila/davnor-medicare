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
                child: Text('DavNor Medicare', style: subtitle18RegularOrange),
              ),
              verticalSpace20,
              //sample app info
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
              textAlign: TextAlign.left,
                style: subtitle18Bold
                ),
                Text('Emmalyn Nabiamos',
              style: caption18RegularNeutral
              ),
                Text('Roneal John Denila ',
              style: caption18RegularNeutral
              ),
                Text('Hanna Alondra Demegillo',
              style: caption18RegularNeutral
              ),
              verticalSpace18,
              const Text('Illness Icons from:',
                textAlign: TextAlign.left,
                  style: subtitle18Bold,
                ),
              verticalSpace10,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Image.asset(
                      icons8,
                      fit: BoxFit.fill,
                      height: 50,
                      width: 60,
                ),
                  ),
                  horizontalSpace15,
                  Text('Icons \nhttps://icons8.com',
                style: caption18RegularNeutral
              ),

                ],
              )
                  
            ]),
          )
        )
      )
    );
  }
}
