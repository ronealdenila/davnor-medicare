import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:davnor_medicare/ui/widgets/custom_button.dart';

import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';

class ConsForm3Screen extends StatefulWidget {
  const ConsForm3Screen({Key? key}) : super(key: key);

  @override
  _ConsForm3ScreenState createState() => _ConsForm3ScreenState();
}

class _ConsForm3ScreenState extends State<ConsForm3Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Upload past prescription or laboratory results',
              style: title32Regular,
            ),
            verticalSpace50,
            const Text(
              'Select and upload images to support your follow-up consultation',
              style: subtitle18Regular,
            ),
            verticalSpace20,
            DottedBorder(
              borderType: BorderType.RRect,
              radius: const Radius.circular(12),
              padding: const EdgeInsets.all(12),
              dashPattern: const [8, 8, 8, 8],
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                child: Container(
                  width: screenWidth(context),
                  height: 186,
                  color: neutralColor[10],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Icon(
                          Icons.file_upload_outlined,
                          size: 67,
                          color: neutralColor[60],
                        ),
                      ),
                      verticalSpace10,
                      Text(
                        'Upload here',
                        style: subtitle18RegularNeutral,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: SizedBox(
                  width: 211,
                  child: CustomButton(
                    onTap: () {},
                    text: 'Consult Now',
                    buttonColor: verySoftBlueColor,
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
