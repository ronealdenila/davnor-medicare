import 'package:davnor_medicare_ui/src/shared/app_colors.dart';
import 'package:davnor_medicare_ui/src/shared/styles.dart';
import 'package:flutter/material.dart';

class DmButton extends StatelessWidget {
  final String title;
  final bool disabled;
  final bool busy;
  final void Function()? onTap;
  final bool outline;
  final Widget? leading;

  const DmButton({
    Key? key,
    required this.title,
    this.disabled = false,
    this.busy = false,
    this.onTap,
    this.leading,
  })  : outline = false,
        super(key: key);

  const DmButton.outline({
    required this.title,
    this.onTap,
    this.leading,
  })  : disabled = false,
        busy = false,
        outline = true;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 350),
        width: double.infinity,
        height: 50,
        alignment: Alignment.center,
        decoration: !outline
            ? BoxDecoration(
                color: !disabled ? kcVerySoftBlueColor : kcNeutralWhiteColor,
                borderRadius: BorderRadius.circular(8),
              )
            : BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: kcVerySoftBlueCustomColor,
                  width: 1,
                )),
        child: !busy
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (leading != null) leading!,
                  if (leading != null) SizedBox(width: 5),
                  Text(
                    title,
                    style: subtitle20Medium.copyWith(
                      color: !outline ? Colors.white : kcVerySoftBlueColor,
                    ),
                  ),
                ],
              )
            : CircularProgressIndicator(
                strokeWidth: 8,
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
      ),
    );
  }
}