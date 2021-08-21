import 'package:davnor_medicare/core/controllers/appController.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DoctorApplicationInstructionScreen extends StatelessWidget {
  final AppController appController = AppController.to;

  static const emailScheme = 'mailto:davnor.medicare@gmail.com?subject=Davnor Medicare Doctor Application';
  static const formUrl = 'https://forms.gle/WKWnBsG9EuivmY1dA';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CupertinoNavigationBarBackButton(
          color: Colors.black,
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Text(
              'Join Our Team',
              textAlign: TextAlign.center,
              style: title24Bold,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: Text(
              'Together lets provide healthcare, improve life, and help our community.',
              style: body14Regular,
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 35),
            child: Text(
              'Are you concerned for the health of our community? Extend your care and medical skills by joining as a doctor here in DavNor MediCare. Together we can provide free online consultation, improve everyone’s lives, and feel rewarded for helping others in times of need.',
              textAlign: TextAlign.justify,
              style: body16Regular,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 35),
            child: Text(
              'In DavNor MediCare, we only want the best healthcare for our patients. Thats why before accepting clinicians to join our team, we ensure that they are licensed to practice medicine and can provide the level of services we guarantee to our people.',
              textAlign: TextAlign.justify,
              style: body16Regular,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 35),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 35),
            child: Text(
              'For Interested Doctors:',
              textAlign: TextAlign.left,
              style: body16SemiBold,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 35),
            child: GestureDetector(
              onTap: () => appController
                  .launchURL(formUrl),
              child: Text(
                'Join us here',
                textAlign: TextAlign.left,
                style: body14RegularUnderline.copyWith(color: kcInfoColor),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 35),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 35),
            child: Text(
              'For any inquiries, please email us at:',
              textAlign: TextAlign.left,
              style: body16SemiBold,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 35),
            child: GestureDetector(
              onTap: () => appController.launchURL(emailScheme),
              child: Text(
                'davnor.medicare@gmail.com',
                textAlign: TextAlign.left,
                style: body14Regular.copyWith(color: kcInfoColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
