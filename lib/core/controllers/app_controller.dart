import 'package:davnor_medicare/core/services/logger.dart';
import 'package:davnor_medicare/ui/screens/patient/cons_form.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/widgets/patient/dialog_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class AppController extends GetxController {
  static AppController to = Get.find();
  final log = getLogger('App Controller');

  //This is where to put the app logics e.g. toggle check box

  RxBool isObscureText = true.obs;
  RxBool isCheckboxChecked = false.obs;

  RxBool isConsultForYou = true.obs;

  bool toggleTextVisibility() {
    log.i('toggleTextVisibility | Toggle Text Visibility');
    return isObscureText.value = !isObscureText.value;
  }

  Future<void> launchURL(String url) async {
    log.i('launchURL | Launched at URL: $url');
    await canLaunch(url)
        ? await launch(url)
        : Get.defaultDialog(title: 'Could not launch $url');
  }

  Future<void> requestConsultation() async {
    await Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Stack(
          children: <Widget>[
            Container(
              height: 284,
              width: 343,
              padding: const EdgeInsets.only(
                top: 18,
              ),
              margin: const EdgeInsets.only(top: 13, right: 8),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                      color: Colors.black26,
                    ),
                  ]),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(30),
                    child: Text(
                      'Is the Consultation for you?',
                      style: title24Bold,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                      style: body16SemiBold.copyWith(color: neutralColor[60]),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      DialogButton(
                        buttonText: 'Yes',
                        onTap: () {
                          isConsultForYou.value = true;
                          Get.to(() => ConsFormScreen());
                        },
                      ),
                      DialogButton(
                        buttonText: 'No',
                        onTap: () {
                          isConsultForYou.value = false;
                          Get.to(() => ConsFormScreen());
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              right: 20,
              top: 20,
              child: GestureDetector(
                onTap: Get.back,
                child: Align(
                  alignment: Alignment.topRight,
                  child: CircleAvatar(
                    radius: 14,
                    //TO BE REGISTERED ON APP COLOR
                    backgroundColor: const Color(0xFFE3E6E8),
                    child: Icon(Icons.close, color: neutralColor[100]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
