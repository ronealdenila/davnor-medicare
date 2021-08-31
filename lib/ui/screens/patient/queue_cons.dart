import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:flutter/material.dart';

class QueueConsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'YOUR  QUEUE NUMBER',
              style: subtitle18Medium,
            ),
            verticalSpace15,
            Center(
              child: Text(
                'C00',
                style: title90BoldBlue,
              ),
            ),
            verticalSpace25,
            Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                width: screenWidth(context),
                height: 260,
                decoration: BoxDecoration(
                  color: verySoftBlueColor[80],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    verticalSpace18,
                    Text('General Pediatrics'.toUpperCase(),
                        style: subtitle20BoldWhite), //Department
                    verticalSpace5,
                    const Text('Online Cardiologist',
                        style: subtitle18RegularWhite),
                    verticalSpace10,
                    Container(
                      width: screenWidth(context),
                      height: 137,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            verticalSpace35,
                            Text(
                              'SERVING NOW',
                              style: subtitle18MediumNeutral,
                            ),
                            verticalSpace10,
                            Center(
                              child: Text(
                                'C00',
                                style: title42BoldNeutral100,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    verticalSpace10,
                    InkWell(
                      onTap: () {}, //See More Screen
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'More info',
                            style: subtitle18RegularWhite,
                          ),
                          horizontalSpace5,
                          Container(
                            height: 24,
                            width: 24,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.arrow_forward_outlined,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //Specialty
                  ],
                ),
              ),
            ),
            verticalSpace25,
            const Center(
              child: Text(
                '0 PEOPLE WAITING',
                style: subtitle20Medium,
              ),
            )
          ],
        ),
      ),
    );
  }
}
