import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:flutter/material.dart';

class BottomTextWidget extends StatelessWidget {
  const BottomTextWidget({
    Key? key,
    this.onTap,
    this.text1,
    this.text2,
  }) : super(key: key);

  final void Function()? onTap;
  final String? text1;
  final String? text2;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: RichText(
        text: TextSpan(
          style: body14SemiBold,
          children: [
            TextSpan(text: text1, style: const TextStyle(color: Colors.black)),
            TextSpan(text: ' $text2', style: const TextStyle(color: infoColor))
          ],
        ),
      ),
    );
  }
}
