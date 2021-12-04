import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/app_controller.dart';
import 'package:davnor_medicare/core/controllers/article_controller.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/core/controllers/cons_history_controller.dart';
import 'package:davnor_medicare/core/controllers/live_cons_controller.dart';
import 'package:davnor_medicare/core/controllers/patient/cons_req_controller.dart';
import 'package:davnor_medicare/core/controllers/profile_controller.dart';
import 'package:davnor_medicare/core/controllers/status_controller.dart';
import 'package:davnor_medicare/core/models/article_model.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:davnor_medicare/ui/screens/patient/article_item.dart';
import 'package:davnor_medicare/ui/screens/patient/article_list.dart';
import 'package:davnor_medicare/ui/screens/patient/cons_form.dart';
import 'package:davnor_medicare/ui/screens/patient/cons_history.dart';
import 'package:davnor_medicare/ui/screens/patient/live_chat.dart';
import 'package:davnor_medicare/ui/screens/patient/ma_description.dart';
import 'package:davnor_medicare/ui/screens/patient/ma_history.dart';
import 'package:davnor_medicare/ui/screens/patient/notification_feed.dart';
import 'package:davnor_medicare/ui/screens/patient/profile.dart';
import 'package:davnor_medicare/ui/screens/patient/queue_cons.dart';
import 'package:davnor_medicare/ui/screens/patient/queue_ma.dart';
import 'package:davnor_medicare/ui/screens/patient/select_queue_screen.dart';
import 'package:davnor_medicare/ui/screens/patient/settings.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/widgets/action_card.dart';
import 'package:davnor_medicare/ui/widgets/article_card.dart';
import 'package:davnor_medicare/ui/widgets/custom_drawer.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PatientHomeScreen extends StatelessWidget {
  static ArticleController articleService =
      Get.put(ArticleController(), permanent: true);

  final List<ArticleModel> articleList = articleService.articlesList;
  final ConsRequestController consController = Get.put(ConsRequestController());
  final ConsHistoryController consHController =
      Get.put(ConsHistoryController(), permanent: true);
  final AppController appController = Get.find();
  static AuthController authController = Get.find();
  final fetchedData = authController.patientModel.value;
  final LiveConsController liveCont =
      Get.put(LiveConsController(), permanent: true);
  final StatusController stats = Get.put(StatusController(), permanent: true);
  final ProfileController profileController = Get.put(ProfileController());
  final RxBool errorPhoto = false.obs;

  @override
  Widget build(BuildContext context) {
    appController.initLocalNotif(context);
    return Scaffold(
        appBar: AppBar(
          actions: [Obx(() => notificationIcon()), horizontalSpace10],
        ),
        drawer: CustomDrawer(
          accountName: '${fetchedData!.firstName} ${fetchedData!.lastName}',
          accountEmail: fetchedData!.email,
          userProfile: displayProfile(),
          onProfileTap: () => Get.to(() => PatientProfileScreen()),
          onCurrentConsultTap: currentConsultation,
          onConsultHisoryTap: () => Get.to(() => ConsHistoryScreen()),
          onMedicalHistoryTap: () => Get.to(() => MAHistoryScreen()),
          onSettingsTap: () => Get.to(() => SettingScreen()),
          onLogoutTap: authController.signOut,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
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
                Text(
                  'homepage'.tr,
                  style: body16SemiBold,
                ),
                verticalSpace10,
                Container(width: Get.width, child: ActionButtons()),
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
                        'action4'.tr,
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
        ),
        floatingActionButton: Obx(getFloatingButton));
  }

  Widget displayProfile() {
    return StreamBuilder<DocumentSnapshot>(
        stream: profileController.getProfilePatient(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey,
            );
          }
          final data = snapshot.data!.data() as Map<String, dynamic>;
          return CircleAvatar(
            radius: 50,
            foregroundImage: NetworkImage(data['profileImage']),
            onForegroundImageError: (_, __) {
              errorPhoto.value = true;
            },
            child: Obx(
              () => errorPhoto.value
                  ? Text(
                      '${fetchedData!.firstName![0]}',
                      style: subtitle18Bold,
                    )
                  : SizedBox(
                      height: 0,
                      width: 0,
                    ),
            ),
          );
        });
  }

  Widget ActionButtons() {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ActionCard(
              text: 'action1'.tr,
              color: verySoftMagenta[60],
              secondaryColor: verySoftMagentaCustomColor,
              onTap: () {
                if (stats.isLoading.value) {
                  showSimpleErrorDialog(errorDescription: 'errordialog1'.tr);
                } else {
                  if (stats.patientStatus[0].pStatus!) {
                    if (stats.patientStatus[0].hasActiveQueueCons!) {
                      showErrorDialog(
                          errorTitle: 'action5'.tr,
                          errorDescription: 'action6'.tr);
                    } else {
                      showConfirmationDialog(
                        dialogTitle: 'dialog1'.tr,
                        dialogCaption: 'dialogsub1'.tr,
                        onYesTap: () {
                          consController.isConsultForYou.value = true;
                          Get.to(() => ConsFormScreen());
                        },
                        onNoTap: () {
                          consController.isConsultForYou.value = false;
                          Get.to(() => ConsFormScreen());
                        },
                      );
                    }
                  } else {
                    showErrorDialog(
                        errorTitle: 'action7'.tr,
                        errorDescription: 'action8'.tr);
                  }
                }
              },
            ),
          ),
          Expanded(
            child: ActionCard(
                text: 'action2'.tr,
                color: verySoftOrange[60],
                secondaryColor: verySoftOrangeCustomColor,
                onTap: () {
                  if (stats.isLoading.value) {
                    showSimpleErrorDialog(errorDescription: 'errordialog1'.tr);
                  } else {
                    Get.to(() => MADescriptionScreen());
                  }
                }),
          ),
          Expanded(
            child: ActionCard(
              text: 'action3'.tr,
              color: verySoftRed[60],
              secondaryColor: verySoftRedCustomColor,
              onTap: () {
                if (stats.isLoading.value) {
                  showSimpleErrorDialog(errorDescription: 'errordialog1'.tr);
                } else {
                  if (stats.patientStatus[0].pStatus!) {
                    if (stats.patientStatus[0].hasActiveQueueCons! &&
                        stats.patientStatus[0].hasActiveQueueMA!) {
                      Get.to(() => SelectQueueScreen());
                    } else if (stats.patientStatus[0].hasActiveQueueCons!) {
                      Get.to(() => QueueConsScreen());
                    } else if (stats.patientStatus[0].hasActiveQueueMA!) {
                      Get.to(() => QueueMAScreen());
                    } else {
                      showErrorDialog(
                          errorTitle: 'dialog3'.tr,
                          errorDescription: 'dialogsub3'.tr);
                    }
                  } else {
                    showErrorDialog(
                        errorTitle: 'action7'.tr,
                        errorDescription: 'action8'.tr);
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget notificationIcon() {
    if (stats.isLoading.value) {
      return notifIconNormal();
    }
    return stats.patientStatus[0].notifBadge == 0
        ? notifIconNormal()
        : notifIconWithBadge(stats.patientStatus[0].notifBadge!);
  }

  Widget notifIconNormal() {
    return IconButton(
      onPressed: () {
        Get.to(() => NotificationFeedScreen());
      },
      icon: const Icon(
        Icons.notifications_outlined,
        size: 29,
      ),
    );
  }

  Widget notifIconWithBadge(int count) {
    return Badge(
      position: BadgePosition.topEnd(top: 1, end: 3),
      badgeContent: Text(
        '$count',
        style: const TextStyle(color: Colors.white),
      ),
      child: IconButton(
        onPressed: () {
          Get.to(() => NotificationFeedScreen());
          resetBadge();
        },
        icon: const Icon(
          Icons.notifications_outlined,
          size: 29,
        ),
      ),
    );
  }

  Widget getFloatingButton() {
    if (!liveCont.isLoading.value) {
      if (liveCont.liveCons.isNotEmpty) {
        return FloatingActionButton(
          backgroundColor: verySoftBlueColor[30],
          elevation: 2,
          onPressed: () {
            Get.to(() => LiveChatScreen(), arguments: liveCont.liveCons[0]);
          },
          child: const Icon(
            Icons.chat_rounded,
          ),
        );
      }
      return const SizedBox(height: 0, width: 0);
    }
    return const SizedBox(height: 0, width: 0);
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

  void currentConsultation() {
    if (liveCont.liveCons.isNotEmpty) {
      Get.to(() => LiveChatScreen(), arguments: liveCont.liveCons[0]);
    }
    showErrorDialog(errorTitle: 'action9'.tr, errorDescription: 'action10'.tr);
  }

  Future<void> resetBadge() async {
    await firestore
        .collection('patients')
        .doc(auth.currentUser!.uid)
        .collection('status')
        .doc('value')
        .update({
      'notifBadge': 0,
    });
  }
}
