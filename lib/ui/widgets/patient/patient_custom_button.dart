import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:flutter/material.dart';

class PCustomButton extends Container {
  PCustomButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.buttonPadding = const EdgeInsets.all(15),
    this.splashColor = Colors.blueGrey,
    this.buttonColor,
    this.fontSize,
  }) : super(key: key);

  final Function? onTap;
  final String? text;
  final Color? buttonColor;
  final Color splashColor;
  final double? fontSize;
  final EdgeInsetsGeometry? buttonPadding;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      splashColor: splashColor,
      onPressed: () => onTap!(),
      color: buttonColor,
      padding: buttonPadding,
      child: Text(
        text!,
        style: title24Bold.copyWith(
          fontSize: fontSize,
          color: Colors.white,
        ),
      ),
    );
  }
}