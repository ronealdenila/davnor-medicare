import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/core/models/article_model.dart';

class ArticleService {
  final FirebaseFirestore _instance = FirebaseFirestore.instance;

  List<ArticleModel> _articlesList = [];
  late ArticleModel _initArticle;
  String? title;
  String? content;
  String? photoURL;
  String? source;
  Timestamp? date;

  List<ArticleModel> getArticles() {
    return _articlesList;
  }

  Future<void> getArticlesList() async {
    final CollectionReference articles = _instance.collection('articles');
    await articles.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        title = doc['title'] as String;
        content = doc['content'] as String;
        photoURL = doc['photoURL'] as String;
        source = doc['source'] as String;
        date = doc['date'] as Timestamp;
        _initArticle = ArticleModel(
            title: title,
            content: content,
            photoURL: photoURL,
            source: source,
            date: date);
        _articlesList.add(_initArticle);
      });
    });
  }
}
