class Category {
  Category({
    required this.iconPath,
    required this.title,
    required this.specialist,
    this.categoryID = '',
  });
  String? iconPath;
  String? title;
  String? specialist;
  String? categoryID;
}
