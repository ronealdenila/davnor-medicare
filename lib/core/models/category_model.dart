class Category {
  Category({
    required this.iconPath,
    required this.title,
    this.isSelected = false,
  });
  String? iconPath;
  String? title;
  bool? isSelected;
}
