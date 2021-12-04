import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomButton extends Container {
  CustomButton({
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
        style: body16SemiBold.copyWith(
          //fontSize: fontSize,
          color: Colors.white,
        ),
      ),
    );
  }
}

class PSWDButton extends StatelessWidget {
  const PSWDButton({
    required this.onItemTap,
    required this.buttonText,
  });

  final void Function()? onItemTap;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onItemTap,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        child: Container(
          padding:
              EdgeInsets.symmetric(vertical: kIsWeb ? 25 : 15, horizontal: 40),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: verySoftOrange[60],
          ),
          child: Text(
            buttonText,
            style: subtitle18BoldBlack,
          ),
        ),
      ),
    );
  }
}
