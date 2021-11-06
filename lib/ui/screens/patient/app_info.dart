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
             const Text(
                'DavNor Medicare is a multiplatform-based application that offers free online consultation and Medical Assistance from PSWD. The application intends to help people efficiently to connect to the doctors virtually to have a regular checkup and receive free medicine. It has a feature of translation such as English, Tagalog, and Bisaya to help them use the application without any trouble. And lastly, only the residents of Davao del Norte can use the application.',
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
              const Text('Credits:',
                textAlign: TextAlign.left,
                  style: subtitle18Bold,
                ),
                Text('https://icons8.com',
              style: caption18RegularNeutral
              ),
              verticalSpace10,    
            ]),
          )
        )
      )
    );
  }
}