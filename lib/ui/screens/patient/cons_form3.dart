import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:davnor_medicare/ui/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ConsForm3Screen extends StatelessWidget {
  const ConsForm3Screen({Key? key}) : super(key: key);

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
            verticalSpace18,
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Enter your description here?',
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
              ),
              maxLines: 6,
              keyboardType: TextInputType.multiline,
            ),
            verticalSpace18,
            verticalSpace25,
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
