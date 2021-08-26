import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:flutter/material.dart';

class CustomButton extends Container {
  CustomButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.buttonPadding = 15,
    this.splashColor = Colors.blueGrey,
    this.buttonColor,
    this.fontSize,
  }) : super(key: key);

  final Function? onTap;
  final String? text;
  final Color? buttonColor;
  final Color splashColor;
  final double? fontSize;
  final double buttonPadding;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      splashColor: splashColor,
      onPressed: () => onTap!(),
      color: buttonColor,
      padding: EdgeInsets.all(buttonPadding),
      child: Text(
        text!,
        style: subtitle20Medium.copyWith(
          fontSize: fontSize,
          color: Colors.white,
        ),
      ),
    );
  }
}
