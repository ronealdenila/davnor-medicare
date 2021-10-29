import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';

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
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: verySoftOrange[60],
          ),
          child: Text(
            buttonText,
            style: subtitle18BoldWhite,
          ),
        ),
      ),
    );
  }
}
