import 'package:davnor_medicare/constants/app_strings.dart';
import 'package:davnor_medicare/core/controllers/app_controller.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/core/controllers/patient/cons_req_controller.dart';
import 'package:davnor_medicare/core/controllers/article_controller.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:davnor_medicare/ui/screens/patient/cons_history.dart';
import 'package:davnor_medicare/ui/screens/patient/live_chat.dart';
import 'package:davnor_medicare/ui/screens/patient/ma_description.dart';
import 'package:davnor_medicare/ui/screens/patient/ma_history.dart';
import 'package:davnor_medicare/ui/screens/patient/profile.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/ui/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:davnor_medicare/ui/widgets/action_card.dart';
import 'package:davnor_medicare/ui/widgets/article_card.dart';
import 'package:davnor_medicare/core/models/article_model.dart';
import 'package:davnor_medicare/ui/screens/patient/article_list.dart';
import 'package:davnor_medicare/ui/screens/patient/article_item.dart';

class PatientHomeScreen extends StatelessWidget {
  static AuthController authController = Get.find();
  static ArticleController articleService = Get.put(ArticleController());
  static ConsController consController = Get.put(ConsController());
  final fetchedData = authController.patientModel.value;
  final List<ArticleModel> articleList = articleService.articlesList;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          floatingActionButton: fetchedData!.hasActiveQueue!
              ? FloatingActionButton(
                  onPressed: () {
                    Get.to(() => LiveChatScreen());
                  },
                  child: const Icon(Icons.message),
                )
              : Container(),
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications_outlined,
                ),
              ),
            ],
          ),
          drawer: CustomDrawer(
            accountName: fetchedData!.firstName,
            accountEmail: fetchedData!.email,
            userProfile: fetchedData!.profileImage == ''
                ? const Icon(
                    Icons.person,
                    size: 56,
                  )
                : Image.network(fetchedData!.profileImage!),
            onProfileTap: () => Get.to(() => PatientProfileScreen()),
            onCurrentConsultTap: () => Get.to(() => LiveChatScreen()),
            onConsultHisoryTap: () => Get.to(() => ConsHistoryScreen()),
            onMedicalHistoryTap: () => Get.to(() => MAHistoryScreen()),
            onSettingsTap: () => Get.to(() => MAHistoryScreen()),
            onLogoutTap: authController.signOut,
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
                      child: Image.asset(patientHomeHeader, fit: BoxFit.fill),
                    ),
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
                            color: verySoftMagenta[60],
                            secondaryColor: verySoftMagentaCustomColor,
                            onTap: consController.checkRequestConsultation,
                          ),
                        ),
                        Expanded(
                          child: ActionCard(
                            text: 'Request Medical Assistance',
                            color: verySoftOrange[60],
                            secondaryColor: verySoftOrangeCustomColor,
                            //Note: Has weird transition
                            onTap: () => Get.to(
                              () => MADescriptionScreen(),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ActionCard(
                            text: 'View\nQueue',
                            color: verySoftRed[60],
                            secondaryColor: verySoftRedCustomColor,
                            onTap: () {
                              //sa business logic na ata ta magdecide kung
                              //kani nga dialog mag appear for now dria nako
                              //ibutang (R)
                              showDefaultDialog(
                                dialogTitle: dialogQueue1,
                                dialogCaption: dialogQueue2,
                                textConfirm: 'Okay',
                                onConfirmTap: Get.back,
                              );
                            },
                          ),
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
                  Obx(showArticles)
                ],
              ),
            ),
          )),
    );
  }

  Widget showArticles() {
    if (articleService.doneLoading.value) {
      return ListView.builder(
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
          });
    }
    return const Center(
        child: SizedBox(
            width: 20, height: 20, child: CircularProgressIndicator()));
  }

  void goToArticleItemScreen(int index) {
    Get.to(() => ArticleItemScreen(), arguments: index);
  }

  void seeAllArticles() {
    Get.to(() => ArticleListScreen());
  }
}
