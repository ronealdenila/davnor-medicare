import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_responsive.dart';

class ConsFormWebScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveBody(context),
    );
  }
}

class ResponsiveBody extends GetResponsiveView {
  ResponsiveBody(this.context);
  final BuildContext context;

  @override
  Widget? builder() {
    return SingleChildScrollView(
        child: Container(
      height: Get.height,
      child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              verticalSpace50,
              Expanded(
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 6,
                          child: Container(
                            width: Get.width * .6,
                            decoration: const BoxDecoration(
                                color: Colors.pink,
                                border: Border(
                                  right: BorderSide(
                                    color: Color(0xFFCBD4E1),
                                  ),
                                )),
                          )),
                      Expanded(
                        flex: 4,
                        child: Container(
                          width: Get.width * .4,
                          color: Colors.red,
                        ),
                      )
                    ]),
              ),
            ],
          )),
    ));
  }
}
