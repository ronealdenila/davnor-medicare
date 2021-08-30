import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.title,
    required this.iconPath,
    required this.onTap,
    required this.isSelected,
  }) : super(key: key);

  final String title;
  final String iconPath;
  final Function() onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: isSelected ? verySoftBlueColor[10] : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        elevation: 5,
        child: SizedBox(
          height: 120,
          width: 120,
          child: Center(
            child: Wrap(
              direction: Axis.vertical,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                SizedBox(
                  height: 55,
                  width: 55,
                  child: Image.asset(
                    iconPath,
                  ),
                ),
                verticalSpace5,
                Text(
                  title,
                  style: body16Regular,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
