import 'package:davnor_medicare_ui/src/shared/app_colors.dart';
import 'package:davnor_medicare_ui/src/shared/styles.dart';
import 'package:flutter/material.dart';

class DmText extends StatelessWidget {
  final String text;
  final TextStyle style;

  const DmText.title90Bold(this.text) : style = title90Bold;
  const DmText.title58Regular(this.text) : style = title58Regular;
  const DmText.subtitle20Bold(this.text) : style = subtitle20Bold;
  const DmText.subtitle20Medium(this.text) : style = subtitle20Medium;
  const DmText.body16Regular(this.text) : style = body16Regular;
  const DmText.body16Bold(this.text) : style = body16Bold;

  DmText.body(this.text, {Color color = kcNeutralWhiteColor})
      : style = body16Regular.copyWith(color: color);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
    );
  }
}
