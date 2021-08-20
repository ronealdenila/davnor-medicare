import 'package:flutter/material.dart';

class CustomButton extends Container {
  final Function? onTap;
  final String? text;
  final Color color;
  final Color textColor;
  final Color splashColor;
  final double fontSize;
  final double buttonPadding;

  CustomButton({
    required this.onTap,
    required this.text,
    this.buttonPadding = 15,
    this.splashColor = Colors.blueGrey,
    this.fontSize = 16,
    this.color = Colors.blue,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      splashColor: this.splashColor,
      onPressed: () => this.onTap!(),
      color: this.color,
      child: Text(
        this.text!,
        style: TextStyle(
          color: this.textColor,
          fontSize: this.fontSize,
        ),
      ),
      padding: EdgeInsets.all(buttonPadding),
    );
  }
}
