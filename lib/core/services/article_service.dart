import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/core/models/article_model.dart';
import 'package:davnor_medicare/core/services/logger.dart';
import 'package:get/get.dart';

class ArticleService extends GetxController {
  final log = getLogger('Article Service');
  static ArticleService to = Get.find();

  final List<ArticleModel> _articlesList = [];
  List<ArticleModel> articlesList = [];
  late ArticleModel _initArticle;

  String? title;
  String? content;
  String? photoURL;
  String? source;
  Timestamp? date;

  @override
  void onReady() {
    log.i('onReady | Article Service is ready');
    super.onReady();
    _initArticleList();
  }

  Future<void> _initArticleList() async {
    log.i('_initArticleList | Initiliazing Articles');
    // await getArticlesList();
    articlesList = getArticles();
  }

  List<ArticleModel> getArticles() {
    log.i('getArticles | Returning Articles');
    return _articlesList;
  }

  // Future<void> getArticlesList() async {
  //   log.i('getArticlesList | Returning List of Articles');
  //   final CollectionReference articles =
  //       firebaseFirestore.collection('articles');
  //   await articles.get().then(
  //     (QuerySnapshot querySnapshot) {
  //       querySnapshot.docs.forEach(
  //         (doc) {
  //           title = doc['title'] as String;
  //           content = doc['content'] as String;
  //           photoURL = doc['photoURL'] as String;
  //           source = doc['source'] as String;
  //           // date = doc['date'] as Timestamp;
  //           _initArticle = ArticleModel(
  //             title: title,
  //             content: content,
  //             photoURL: photoURL,
  //             source: source,
  //             // date: date,
  //           );
  //           _articlesList.add(_initArticle);
  //         },
  //       );
  //     },
  //   );
  // }
}
