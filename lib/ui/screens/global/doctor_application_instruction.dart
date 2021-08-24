import 'package:davnor_medicare/constants/app_strings.dart';
import 'package:davnor_medicare/core/controllers/app_controller.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DoctorApplicationInstructionScreen extends StatelessWidget {
  final AppController appController = AppController.to;

  static const emailScheme = doctorapplicationinstructionParagraph0;
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
    const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Text(
              'Join Our Team',
              textAlign: TextAlign.center,
              style: title24Bold,
            ),
          ),
    const Padding(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: Text(
              doctorapplicationinstructionParagraph1,
              style: body14Regular,
              textAlign: TextAlign.center,
            ),
          ),
    const Padding(
            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 35),
            child: Text(
              doctorapplicationinstructionParagraph2,
              textAlign: TextAlign.justify,
              style: body16Regular,
            ),
          ),
    const Padding(
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 35),
            child: Text(
              doctorapplicationinstructionParagraph3,
              textAlign: TextAlign.justify,
              style: body16Regular,
            ),
          ),
    const Padding(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 35),
          ),
    const Padding(
            padding: EdgeInsets.symmetric(horizontal: 35),
            child: Text(
              'For Interested Doctors:',
              textAlign: TextAlign.left,
              style: body16SemiBold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 35),
            child: GestureDetector(
              onTap: () => appController
                  .launchURL(formUrl),
              child: Text(
                'Join us here',
                textAlign: TextAlign.left,
                style: body14RegularUnderline.copyWith(color: infoColor),
              ),
            ),
          ),
    const Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 35),
          ),
    const Padding(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 35),
            child: Text(
              'For any inquiries, please email us at:',
              textAlign: TextAlign.left,
              style: body16SemiBold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 35),
            child: GestureDetector(
              onTap: () => appController.launchURL(emailScheme),
              child: Text(
                'davnor.medicare@gmail.com',
                textAlign: TextAlign.left,
                style: body14Regular.copyWith(color: infoColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
