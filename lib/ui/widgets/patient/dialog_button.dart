import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:flutter/material.dart';

class DialogButton extends StatelessWidget {
  const DialogButton({
    required this.buttonText,
    this.onTap,
  });

  final String? buttonText;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        primary: dialogButtonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      child: Text(
        buttonText!,
        style: body14SemiBold,
      ),
    );
  }
}
