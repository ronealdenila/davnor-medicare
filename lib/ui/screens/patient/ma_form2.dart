//import 'package:davnor_medicare/constants/app_strings.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/widgets/custom_button.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';

class MAForm2Screen extends StatelessWidget {
  const MAForm2Screen({Key? key}) : super(key: key);

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
              'Upload prescription',
              style: title32Regular,
            ),
            verticalSpace20,
            const Text(
              'Please upload a valid prescription issued not more than a month',
              style: subtitle18Regular,
            ),
            verticalSpace25,
            DottedBorder(
              borderType: BorderType.RRect,
              radius: const Radius.circular(12),
              padding: const EdgeInsets.all(12),
              dashPattern: const [8, 8, 8, 8],
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                child: Container(
                  width: screenWidth(context),
                  height: 355,
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
                  width: 300,
                  child: CustomButton(
                    onTap: () {},
                    text: 'Request Assistance',
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
