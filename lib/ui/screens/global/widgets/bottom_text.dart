import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:flutter/material.dart';

class BottomTextWidget extends StatelessWidget {
  final void Function()? onTap;
  final String? text1;
  final String? text2;

  const BottomTextWidget({Key? key, this.onTap, this.text1, this.text2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: RichText(
        text: TextSpan(
          style: TextStyle(fontWeight: FontWeight.w500),
          children: [
            TextSpan(text: text1, style: TextStyle(color: Colors.black)),
            TextSpan(text: " $text2", style: TextStyle(color: kcInfoColor))
          ],
        ),
      ),
    );
  }
}
