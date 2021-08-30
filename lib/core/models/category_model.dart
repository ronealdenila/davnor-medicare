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

//for testing
class Item {
  const Item(this.name);
  final String name;
}
