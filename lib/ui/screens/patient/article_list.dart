import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/ui/widgets/article_card.dart';
import 'package:davnor_medicare/core/models/article_model.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:get/get.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/screens/patient/article_item.dart';

class ArticleListScreen extends StatelessWidget {
  ArticleListScreen({Key? key}) : super(key: key);
  static AuthController authController = Get.find();
  final List<ArticleModel> articleList = authController.articlesList;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: verySoftBlueColor[100],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              children: [
                const Text(
                  'Articles',
                  style: subtitle20Medium,
                ),
                verticalSpace15,
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: articleList.length,
                    itemBuilder: (context, index) {
                      return ArticleCard(
                          title: articleList[index].title!,
                          content: articleList[index].short!,
                          photoURL: articleList[index].photoURL!,
                          textStyleTitle: caption12SemiBold,
                          textStyleContent: caption10RegularNeutral,
                          height: 115,
                          onTap: () {
                            goToArticleItemScreen(index);
                          });
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void goToArticleItemScreen(int index) {
    Get.to(() => ArticleItemScreen(), arguments: index);
  }
}
