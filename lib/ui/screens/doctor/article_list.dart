import 'package:flutter/material.dart';
import 'package:davnor_medicare/core/controllers/article_controller.dart';
import 'package:davnor_medicare/ui/widgets/article_card.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:get/get.dart';
import 'package:davnor_medicare/ui/screens/doctor/article_item.dart';

class ArticleListScreen extends StatelessWidget {
  static ArticleController articleService =
      Get.put(ArticleController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Articles',
            style: subtitle18Medium.copyWith(color: Colors.black),
          ),
          toolbarHeight: 50,
        ),
        body: Obx(showArticles));
  }

  Widget showArticles() {
    if (articleService.doneLoading.value &&
        articleService.articlesList.isNotEmpty) {
      return ListView.builder(
          padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
          shrinkWrap: true,
          itemCount: articleService.articlesList.length,
          itemBuilder: (context, index) {
            return ArticleCard(
                title: articleService.articlesList[index].title!,
                content: articleService.articlesList[index].short!,
                photoURL: articleService.articlesList[index].photoURL!,
                textStyleTitle: caption12SemiBold,
                textStyleContent: caption10RegularNeutral,
                onTap: () {
                  goToArticleItemScreen(index);
                });
          });
    } else if (articleService.doneLoading.value &&
        articleService.articlesList.isEmpty) {
      return const Center(child: Text('No articles found'));
    }
    return const Center(
        child: SizedBox(
            width: 20, height: 20, child: CircularProgressIndicator()));
  }

  void goToArticleItemScreen(int index) {
    Get.to(() => ArticleItemScreen(), arguments: index);
  }
}
