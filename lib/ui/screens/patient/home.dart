import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/constants/app_strings.dart';
import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/app_controller.dart';
import 'package:davnor_medicare/core/controllers/article_controller.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/core/controllers/live_cons_controller.dart';
import 'package:davnor_medicare/core/controllers/patient/cons_req_controller.dart';
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
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:davnor_medicare/ui/widgets/action_card.dart';
import 'package:davnor_medicare/ui/widgets/article_card.dart';
import 'package:davnor_medicare/ui/widgets/custom_drawer.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PatientHomeScreen extends StatelessWidget {
  static AppController appController = Get.find();
  static AuthController authController = Get.find();
  static ArticleController articleService = Get.put(ArticleController());
  static ConsRequestController consController =
      Get.put(ConsRequestController());
  final fetchedData = authController.patientModel.value;
  final LiveConsController liveCont = Get.put(LiveConsController());
  final List<ArticleModel> articleList = articleService.articlesList;
  static StatusController stats = Get.put(StatusController());

  @override
  Widget build(BuildContext context) {
    appController.initLocalNotif(context);
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              actions: [notificationIcon(), horizontalSpace10],
            ),
            drawer: CustomDrawer(
              accountName: '${fetchedData!.firstName} ${fetchedData!.lastName}',
              accountEmail: fetchedData!.email,
              userProfile: fetchedData!.profileImage == ''
                  ? const Icon(
                      Icons.person,
                      size: 56,
                    )
                  : Image.network(fetchedData!.profileImage!),
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
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                    SizedBox(
                      width: screenWidth(context),
                      child: StreamBuilder<DocumentSnapshot>(
                          stream: stats.getPatientStatus(auth.currentUser!.uid),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.active) {
                              final data =
                                  snapshot.data!.data() as Map<String, dynamic>;
                              return ActionButtons(data);
                            }
                            return ActionButtonsNormal();
                          }),
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
            ),
            floatingActionButton: Obx(getFloatingButton)));
  }

  Widget ActionButtons(Map<String, dynamic> data) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: ActionCard(
            text: 'Request Consultation',
            color: verySoftMagenta[60],
            secondaryColor: verySoftMagentaCustomColor,
            onTap: () {
              if (data['pStatus'] as bool) {
                if (data['hasActiveQueueCons'] as bool) {
                  showErrorDialog(
                      errorTitle:
                          'Sorry, you still have an on progress consultation transaction',
                      errorDescription:
                          'Please proceed to your existing consultation');
                } else {
                  showConfirmationDialog(
                    dialogTitle: dialog1Title,
                    dialogCaption: dialog1Caption,
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
                    errorTitle:
                        'Sorry, only verified users can use this feature',
                    errorDescription:
                        'Please verify your account first in your profile');
              }
            },
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
              if (data['pStatus'] as bool) {
                if (data['hasActiveQueueCons'] as bool &&
                    data['hasActiveQueueMA'] as bool) {
                  Get.to(() => SelectQueueScreen());
                } else if (data['hasActiveQueueCons'] as bool) {
                  Get.to(() => QueueConsScreen());
                } else if (data['hasActiveQueueMA'] as bool) {
                  Get.to(() => QueueMAScreen());
                } else {
                  showErrorDialog(
                      errorTitle: 'Sorry, you have no queue number',
                      errorDescription:
                          'You need to request consultation or medical assistance to be in a queue.');
                }
              } else {
                showErrorDialog(
                    errorTitle:
                        'Sorry, only verified users can use this feature',
                    errorDescription:
                        'Please verify your account first in your profile');
              }
            },
          ),
        ),
      ],
    );
  }

  Widget ActionButtonsNormal() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: ActionCard(
            text: 'Request Consultation',
            color: verySoftMagenta[60],
            secondaryColor: verySoftMagentaCustomColor,
            onTap: () {
              //Snackbar: Please wait while we are currently connecting to the server
            },
          ),
        ),
        Expanded(
          child: ActionCard(
              text: 'Request Medical Assistance',
              color: verySoftOrange[60],
              secondaryColor: verySoftOrangeCustomColor,
              //Note: Has weird transition
              onTap: () {
                //Snackbar: Please wait while we are currently connecting to the server}
              }),
        ),
        Expanded(
          child: ActionCard(
            text: 'View\nQueue',
            color: verySoftRed[60],
            secondaryColor: verySoftRedCustomColor,
            onTap: () {
              //Snackbar: Please wait while we are currently connecting to the server
            },
          ),
        ),
      ],
    );
  }

  Widget notificationIcon() {
    return StreamBuilder<DocumentSnapshot>(
        stream: stats.getPatientStatus(auth.currentUser!.uid),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return notifIconNormal();
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return notifIconNormal();
          }
          final data =
              // ignore: cast_nullable_to_non_nullable
              snapshot.data!.data() as Map<String, dynamic>;
          return data['notifBadge'] as String == '0'
              ? notifIconNormal()
              : notifIconWithBadge(data['notifBadge'] as String);
        });
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

  Widget notifIconWithBadge(String count) {
    return Badge(
      position: BadgePosition.topEnd(top: 1, end: 3),
      badgeContent: Text(
        count,
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

  void currentConsultation() {
    if (liveCont.liveCons.isNotEmpty) {
      Get.to(() => LiveChatScreen(), arguments: liveCont.liveCons[0]);
    }
    showErrorDialog(
        errorTitle: 'You have no current consultation',
        errorDescription: 'Please request consultation first');
  }

  Future<void> resetBadge() async {
    await firestore
        .collection('patients')
        .doc(auth.currentUser!.uid)
        .collection('status')
        .doc('value')
        .update({
      'notifBadge': '0',
    });
  }
}
