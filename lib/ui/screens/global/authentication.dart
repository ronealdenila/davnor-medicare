import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/core/controllers/appController.dart';
import 'package:davnor_medicare/ui/screens/global/widgets/bottom_text.dart';
import 'package:davnor_medicare/ui/screens/global/widgets/login.dart';
import 'package:davnor_medicare/ui/screens/global/widgets/signup.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthenticationScreen extends StatelessWidget {
  final AppController _appController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(
          () => SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: screenWidth(context),
                  padding: EdgeInsets.all(25),
                  child: Stack(
                    children: [
                      Visibility(
                        visible: !_appController.isLoginWidgetDisplayed.value,
                        child: IconButton(
                          onPressed: () {
                            _appController.changeDisplayedAuthWidget();
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            size: 36,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          logo,
                          height:
                              screenHeightPercentage(context, percentage: .2),
                          // fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                    visible: _appController.isLoginWidgetDisplayed.value,
                    child: LoginWidget()),
                Visibility(
                    visible: !_appController.isLoginWidgetDisplayed.value,
                    child: SignupWidget()),
                SizedBox(
                  height: 10,
                ),
                Visibility(
                  visible: _appController.isLoginWidgetDisplayed.value,
                  child: BottomTextWidget(
                    onTap: () {
                      _appController.changeDisplayedAuthWidget();
                    },
                    text1: "Don\'t have an account?",
                    text2: "Signup here!",
                  ),
                ),
                // Visibility(
                //   visible: !_appController.isLoginWidgetDisplayed.value,
                //   child: BottomTextWidget(
                //     onTap: () {
                //       _appController.changeDisplayedAuthWidget();
                //     },
                //     text1: "Already have an account?",
                //     text2: "Sign in!!",
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
