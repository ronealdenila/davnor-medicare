import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:davnor_medicare/ui/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConsForm2Screen extends StatelessWidget {
  const ConsForm2Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CupertinoNavigationBarBackButton(
          color: Colors.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Almost there!',
              style: title40Regular,
            ),
            verticalSpace50,
            const Text(
              'Tell us more about the discomfort',
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
            Align(
              child: SizedBox(
                width: 211,
                child: CustomButton(
                  onTap: () {},
                  text: 'Consult Now',
                  buttonColor: verySoftBlueColor,
                ),
              ),
            ),
            verticalSpace25,
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomRight,
                child: SizedBox(
                  width: 162,
                  child: CustomButton(
                    onTap: () {},
                    text: 'Next',
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
