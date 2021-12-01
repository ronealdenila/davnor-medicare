class ArticleModel {
  ArticleModel({
    required this.title,
    required this.content,
    required this.short,
    required this.photoURL,
    required this.source,
  });

  final String? title;
  final String? content;
  final String? photoURL;
  final String? source;
  final String? short;
}
