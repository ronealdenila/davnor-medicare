import 'package:davnor_medicare/ui/screens/pswd_p/controller/pswd_controller.dart';
import 'package:davnor_medicare/ui/widgets/pswd/ma_item_view.dart';
import 'package:flutter/material.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:get/get.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:davnor_medicare/ui/widgets/custom_button.dart';

class MARequestScreen extends StatelessWidget {
  final PSWDController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              const SizedBox(
                width: 310,
                child: Text('Attached Photos'),
              ),
              verticalSpace20,
              Container(
                width: 310,
                height: 170,
                decoration: BoxDecoration(
                  color: neutralColor[10],
                  borderRadius: BorderRadius.circular(2),
                ),
                child: GridView.count(
                  shrinkWrap: true,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  crossAxisCount: 3,
                  children: List.generate(
                    controller.fetchedImages.length - 1,
                    (index) {
                      return GestureDetector(
                        onTap: () => showDialog(
                          context: context,
                          builder: (context) => SimpleDialog(
                            children: [
                              Image.network(
                                controller.fetchedImages[index],
                                width: context.width * .7,
                                height: context.height * .5,
                              ),
                              Container(
                                color: Colors.black,
                                height: 300,
                                width: context.width * .5,
                                child: ClipRRect(
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: List.generate(
                                      controller.fetchedImages.length - 1,
                                      (index) => GestureDetector(
                                        onTap: () =>
                                            controller.toggleSingleImage(index),
                                        child: Obx(
                                          () => Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: controller.selectedIndex
                                                            .value ==
                                                        index
                                                    ? Colors.blueAccent
                                                    : Colors.white,
                                                width: 3,
                                              ),
                                            ),
                                            child: Image.network(
                                              controller.fetchedImages[index],
                                              width: context.width * .2,
                                              height: context.height * .3,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        child: Image.network(
                          controller.fetchedImages[index],
                          width: 5,
                          height: 5,
                          fit: BoxFit.fill,
                        ),
                      );
                    },
                  ),
                ),
              ),
              //request accepted transferred approved medReady completed
              screenButtons(),
              verticalSpace35,
            ],
          ),
        ),
      ),
    );
  }
}

Widget screenButtons() {
  return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
    CustomButton(
      onTap: () async {},
      text: 'Accept',
      buttonColor: verySoftOrange[60],
      fontSize: 15,
    ),
    horizontalSpace25,
    CustomButton(
      onTap: () async {},
      text: 'Decline',
      buttonColor: verySoftOrange[60],
      fontSize: 15,
    ),
  ]);
}
