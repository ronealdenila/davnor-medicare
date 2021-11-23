import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
            width: kIsWeb ? Get.width * .2 : Get.width * .7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/splash-animation.json', repeat: true),
                Text(
                  'Davnor MediCare',
                  style: body16Regular,
                )
              ],
            )),
      ),
    );
  }
}
