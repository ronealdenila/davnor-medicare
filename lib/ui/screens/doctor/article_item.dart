import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:davnor_medicare/core/models/article_model.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/core/controllers/article_controller.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

class ArticleItemScreen extends StatelessWidget {
  static ArticleController articleService = Get.find();
  final List<ArticleModel> articleList = articleService.articlesList;
  final int index = Get.arguments as int;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: screenWidth(context),
                height: 220,
                child: Hero(
                  tag: articleList[index].title!,
                  child:
                      // Image.network(
                      //   articleList[index].photoURL!,
                      //   fit: BoxFit.cover,
                      // ),
                      Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        articleList[index].photoURL!,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        top: 0,
                        child: CupertinoNavigationBarBackButton(
                          onPressed: Get.back,
                          /*Wala koy makita sample item sa figma so wala ko
                            kabalo unsa na color dria (R)*/
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                transform: Matrix4.translationValues(0, -20, 0),
                width: screenWidth(context),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Column(
                    children: [
                      verticalSpace15,
                      Html(data: articleList[index].content, style: {
                        'h1': Style(
                          fontFamily: 'Inter',
                        ),
                        'p': Style(
                          fontSize: const FontSize(15),
                          fontFamily: 'Inter',
                        ),
                        'li': Style(
                          fontSize: const FontSize(15),
                          fontFamily: 'Inter',
                        ),
                        'blockquote': Style(
                          fontWeight: FontWeight.w600,
                          fontSize: const FontSize(16),
                          fontStyle: FontStyle.italic,
                          fontFamily: 'Inter',
                        ),
                      }),
                      verticalSpace10,
                      const Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'See original source here:',
                          style: body16SemiBold,
                        ),
                      ),
                      verticalSpace5,
                      //TODO: URL Launcher for this Source
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          '${articleList[index].source} ',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              fontStyle: FontStyle.italic,
                              fontFamily: 'Inter',
                              color: verySoftBlueColor[100]),
                        ),
                      ),
                      verticalSpace15,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}