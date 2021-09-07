import 'package:get/get.dart';

class Category {
  Category({
    required this.iconPath,
    required this.title,
    this.isSelected,
  });
  String? iconPath;
  String? title;
  bool? isSelected;
}
