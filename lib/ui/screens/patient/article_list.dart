import 'package:flutter/material.dart';
import 'package:davnor_medicare/core/controllers/article_controller.dart';
import 'package:davnor_medicare/ui/widgets/article_card.dart';
import 'package:davnor_medicare/core/models/article_model.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:get/get.dart';
import 'package:davnor_medicare/ui/screens/patient/article_item.dart';

class ArticleListScreen extends StatelessWidget {
  static ArticleController articleService = Get.find();
  final List<ArticleModel> articleList = articleService.articlesList;

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
      body: ListView.builder(
          padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
          shrinkWrap: true,
          itemCount: articleList.length,
          itemBuilder: (context, index) {
            return ArticleCard(
                title: articleList[index].title!,
                content: articleList[index].short!,
                photoURL: articleList[index].photoURL!,
                textStyleTitle: caption12SemiBold,
                textStyleContent: caption10RegularNeutral,
                onTap: () {
                  goToArticleItemScreen(index);
                });
          }),
    );
  }

  void goToArticleItemScreen(int index) {
    Get.to(() => ArticleItemScreen(), arguments: index);
  }
}
