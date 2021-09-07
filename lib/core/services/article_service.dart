import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/models/article_model.dart';
import 'package:davnor_medicare/core/services/logger_service.dart.dart';
import 'package:get/get.dart';

class ArticleService extends GetxController {
  final log = getLogger('Article Service');

  List<ArticleModel> articlesList = [];
  late ArticleModel _initArticle;

  String? title;
  String? content;
  String? photoURL;
  String? source;
  String? short;

  @override
  void onReady() {
    log.i('onReady | Article Service is ready');
    super.onReady();
    _initArticleList();
  }

  Future<void> _initArticleList() async {
    log.i('_initArticleList | Initiliazing Articles');
    await getArticlesList();
    articlesList = getArticles();
  }

  List<ArticleModel> getArticles() {
    log.i('getArticles | Returning Articles');
    return articlesList;
  }

  Future<void> getArticlesList() async {
    log.i('getArticlesList | Returning List of Articles');
    final CollectionReference articles = firestore.collection('articles');
    await articles.get().then((QuerySnapshot querySnapshot) {
      // ignore: avoid_function_literals_in_foreach_calls
      querySnapshot.docs.forEach((doc) {
        title = doc['title'] as String;
        content = doc['content'] as String;
        photoURL = doc['photoURL'] as String;
        source = doc['source'] as String;
        short = doc['short'] as String;
        _initArticle = ArticleModel(
            title: title,
            content: content,
            photoURL: photoURL,
            source: source,
            short: short);
        articlesList.add(_initArticle);
      });
    });
  }
}
