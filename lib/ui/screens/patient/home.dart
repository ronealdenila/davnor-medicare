import 'package:davnor_medicare/constants/app_strings.dart';
import 'package:davnor_medicare/core/controllers/app_controller.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/core/services/article_service.dart';
import 'package:davnor_medicare/ui/screens/patient/cons_form.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/ui/widgets/patient/dialog_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:davnor_medicare/ui/widgets/action_card.dart';
import 'package:davnor_medicare/ui/widgets/article_card.dart';
import 'package:davnor_medicare/core/models/article_model.dart';
import 'package:davnor_medicare/ui/screens/patient/article_list.dart';
import 'package:davnor_medicare/ui/screens/patient/article_item.dart';

class PatientHomeScreen extends StatelessWidget {
  static AuthController authController = Get.find();
  static ArticleService articleService = Get.find();
  static AppController appController = Get.find();
  final fetchedData = authController.patientModel.value;
  final List<ArticleModel> articleList = articleService.articlesList;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications_outlined,
                ),
              ),
              IconButton(
                onPressed: () {
                  authController.signOut();
                },
                icon: const Icon(Icons.logout),
              ),
            ],
          ),
          drawer: Drawer(
            child: TextButton(
              onPressed: () {
                //Get.to(() => ---);
              },
              child: const Text('Profile'),
            ),
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Hello',
                    style: title32Regular,
                  ),
                  verticalSpace5,
                  Text(
                    '${fetchedData!.firstName}!',
                    style: subtitle20Medium,
                  ),
                  verticalSpace25,
                  SizedBox(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(13),
                        child:
                            Image.asset(patientHomeHeader, fit: BoxFit.fill)),
                  ),
                  verticalSpace25,
                  const Text(
                    'How can we help you?',
                    style: body16SemiBold,
                  ),
                  verticalSpace10,
                  SizedBox(
                    width: screenWidth(context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ActionCard(
                            text: 'Request Consultation',
                            textStyle: body14SemiBoldWhite,
                            height: 107,
                            color: verySoftMagenta[60],
                            secondaryColor: verySoftMagentaCustomColor,
                            secondaryWidth: 99,
                            secondaryHeight: 25,
                            //Refactor me
                            onTap: () => Get.dialog(
                              Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16)),
                                elevation: 0,
                                backgroundColor: Colors.transparent,
                                child: Stack(
                                  children: <Widget>[
                                    Container(
                                      height: 284,
                                      width: 343,
                                      padding: const EdgeInsets.only(
                                        top: 18,
                                      ),
                                      margin: const EdgeInsets.only(
                                          top: 13, right: 8),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          boxShadow: const <BoxShadow>[
                                            BoxShadow(
                                              color: Colors.black26,
                                            ),
                                          ]),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: <Widget>[
                                          const Padding(
                                            padding: EdgeInsets.all(30),
                                            child: Text(
                                              dialogConsultationScreenTitle,
                                              style: title24Bold,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Text(
                                              dialogConsultationScreenCaption,
                                              style: body16SemiBold.copyWith(
                                                  color: neutralColor[60]),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          verticalSpace10,
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              DialogButton(
                                                buttonText: 'Yes',
                                                onTap: () {
                                                  appController.isConsultForYou
                                                      .value = true;
                                                  Get.to(
                                                      () => ConsFormScreen());
                                                },
                                              ),
                                              DialogButton(
                                                buttonText: 'No',
                                                onTap: () {
                                                  appController.isConsultForYou
                                                      .value = false;
                                                  Get.to(
                                                      () => ConsFormScreen());
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      right: 20,
                                      top: 20,
                                      child: GestureDetector(
                                        onTap: Get.back,
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: CircleAvatar(
                                            radius: 14,
                                            //TO BE REGISTERED ON APP COLOR
                                            backgroundColor:
                                                const Color(0xFFE3E6E8),
                                            child: Icon(Icons.close,
                                                color: neutralColor[100]),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ActionCard(
                              text: 'Request Medical Assistance',
                              textStyle: body14SemiBoldWhite,
                              height: 107,
                              color: verySoftOrange[60],
                              secondaryColor: verySoftOrangeCustomColor,
                              secondaryWidth: 99,
                              secondaryHeight: 25,
                              onTap: () {}),
                        ),
                        Expanded(
                          child: ActionCard(
                              text: 'View\nQueue',
                              textStyle: body14SemiBoldWhite,
                              height: 107,
                              color: verySoftRed[60],
                              secondaryColor: verySoftRedCustomColor,
                              secondaryWidth: 99,
                              secondaryHeight: 25,
                              onTap: () {}),
                        ),
                      ],
                    ),
                  ),
                  verticalSpace25,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Health Articles',
                        style: body16SemiBold,
                      ),
                      InkWell(
                        onTap: seeAllArticles,
                        child: Text(
                          'See all',
                          style: body14RegularNeutral,
                        ),
                      ),
                    ],
                  ),
                  verticalSpace18,
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: 3,
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
          )),
    );
  }

  void goToArticleItemScreen(int index) {
    Get.to(() => ArticleItemScreen(), arguments: index);
  }

  void seeAllArticles() {
    Get.to(() => ArticleListScreen());
  }
}
