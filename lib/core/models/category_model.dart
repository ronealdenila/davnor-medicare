class Category {
  Category({
    required this.iconPath,
    required this.title,
  });
  String? iconPath;
  String? title;
}

//for testing
class Item {
  const Item(this.name);
  final String name;
}