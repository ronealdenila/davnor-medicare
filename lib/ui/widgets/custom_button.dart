import 'package:flutter/material.dart';

class CustomButton extends Container {
  CustomButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.buttonPadding = 15,
    this.splashColor = Colors.blueGrey,
    this.fontSize = 16,
    this.colors,
    this.textColor = Colors.white,
  }) : super(key: key);

  final Function? onTap;
  final String? text;
  final Color? colors;
  final Color textColor;
  final Color splashColor;
  final double fontSize;
  final double buttonPadding;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      splashColor: splashColor,
      onPressed: () => onTap!(),
      color: colors,
      padding: EdgeInsets.all(buttonPadding),
      child: Text(
        text!,
        style: TextStyle(
          color: textColor,
          fontSize: fontSize,
        ),
      ),
    );
  }
}