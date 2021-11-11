class ArticleModel {
  ArticleModel({
    required this.title,
    required this.content,
    required this.short,
    required this.photoURL,
    required this.source,
  });

//TO DO: Try to remove this bunch of codes (check first if this is not needed)
  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
        title: json['title'] as String,
        content: json['content'] as String,
        photoURL: json['photoURL'] as String,
        source: json['source'] as String,
        short: json['short'] as String,
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'content': content,
        'photoURL': photoURL,
        'source': source,
        'short': short,
      };

  final String? title;
  final String? content;
  final String? photoURL;
  final String? source;
  final String? short;
}
