import 'package:davnor_medicare/core/controllers/cons_controller.dart';
import 'package:davnor_medicare/core/models/category_model.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryCard extends GetView<ConsController> {
  const CategoryCard({
    this.category,
    this.onItemTap,
  });

  final Category? category;
  final void Function()? onItemTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onItemTap,
      child: Card(
        // category!.isSelected! ? verySoftBlueColor[10] :
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        elevation: 5,
        child: SizedBox(
          height: 120,
          width: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 55,
                width: 55,
                child: Image.asset(
                  category!.iconPath!,
                ),
              ),
              verticalSpace5,
              Text(
                category!.title!,
                style: body16Regular,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
