import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/article_controller.dart';
import 'package:davnor_medicare/core/controllers/doctor/consultations_controller.dart';
import 'package:davnor_medicare/core/controllers/profile_controller.dart';
import 'package:davnor_medicare/core/controllers/status_controller.dart';
import 'package:davnor_medicare/core/models/consultation_model.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:davnor_medicare/ui/screens/doctor/cons_history.dart';
import 'package:davnor_medicare/ui/screens/doctor/cons_req_item.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/widgets/consultation_card.dart';
import 'package:davnor_medicare/ui/widgets/custom_drawer.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:davnor_medicare/ui/screens/doctor/live_cons.dart';
import 'package:get/get.dart';
import 'package:davnor_medicare/ui/screens/doctor/profile.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/core/controllers/live_cons_controller.dart';
import 'package:davnor_medicare/ui/widgets/action_card.dart';
import 'package:davnor_medicare/ui/screens/doctor/article_list.dart';

class DoctorHomeScreen extends StatelessWidget {
  final StatusController stats = Get.put(StatusController(), permanent: true);
  final ConsultationsController consRequests =
      Get.put(ConsultationsController());
  final LiveConsController liveCont =
      Get.put(LiveConsController(), permanent: true);
  static AuthController authController = Get.find();
  final fetchedData = authController.doctorModel.value;
  final ProfileController profileController = Get.put(ProfileController());

  final RxInt count = 1.obs;
  final RxInt countAdd = 1.obs; //for additionals

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: verySoftBlueColor,
            ),
            drawer: CustomDrawer(
              forDoctorDrawer: true,
              accountName: '${fetchedData!.firstName} ${fetchedData!.lastName}',
              accountEmail: fetchedData!.email,
              userProfile: displayProfile(),
              onProfileTap: () => Get.to(() => DoctorProfileScreen()),
              onCurrentConsultTap: () {
                if (liveCont.liveCons.isNotEmpty) {
                  Get.to(() => LiveConsultationScreen(),
                      arguments: liveCont.liveCons[0]);
                } else {
                  showErrorDialog(
                      errorTitle: 'No current consultation',
                      errorDescription: 'Please accept consultation request');
                }
              },
              onConsultHisoryTap: () => Get.to(() => DocConsHistoryScreen()),
              onLogoutTap: authController.signOut,
            ),
            backgroundColor: verySoftBlueColor,
            body: SizedBox(
              width: Get.width,
              height: Get.height,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          verticalSpace20,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Text(
                                'Hello',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 32,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Dr. ${fetchedData!.lastName}!',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'DOCTOR STATUS',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Obx(() => doctorStatus()),
                          verticalSpace10,
                        ]),
                  ),
                  Expanded(
                    child: Container(
                      width: Get.width,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(55),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          verticalSpace50,
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: SizedBox(
                                width: Get.width,
                                child: Obx(() => actionCards(context))),
                          ),
                          verticalSpace35,
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25),
                            child: Text(
                              'Consultation Requests',
                              style: body16SemiBold,
                            ),
                          ),
                          verticalSpace18,
                          Expanded(child: Obx(() => requestList())),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            floatingActionButton: Obx(getFloatingButton)));
  }

  Widget actionCards(BuildContext context) {
    if (!stats.isLoading.value) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ActionCard(
                text: 'Change Status',
                color: verySoftMagenta[60],
                secondaryColor: verySoftMagentaCustomColor,
                onTap: () {
                  if (stats.doctorStatus[0].dStatus!) {
                    showDialog(
                        context: context,
                        builder: (context) => offlineDialog());
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) => detailsDialogCons1());
                  }
                }),
          ),
          Expanded(
            child: ActionCard(
                text: 'Add More Patients to Examine',
                color: verySoftOrange[60],
                secondaryColor: verySoftOrangeCustomColor,
                onTap: () {
                  if (stats.doctorStatus[0].dStatus!) {
                    showDialog(
                        context: context,
                        builder: (context) => detailsDialogCons2());
                  } else {
                    showErrorDialog(
                        errorTitle: "Could not process your request",
                        errorDescription:
                            "You can't make an additional when status is unavailable. Please make sure your status is available");
                  }
                }),
          ),
          Expanded(
            child: ActionCard(
                text: 'Read \nHealth Articles',
                color: verySoftRed[60],
                secondaryColor: verySoftRedCustomColor,
                onTap: () => Get.to(() => ArticleListScreen())),
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ActionCard(
                text: 'Change Status',
                color: verySoftMagenta[60],
                secondaryColor: verySoftMagentaCustomColor,
                onTap: () {
                  print(stats.isLoading.value);
                  showErrorDialog(
                      errorTitle: '',
                      errorDescription:
                          'Please wait while we are currently connecting to the server');
                }),
          ),
          Expanded(
            child: ActionCard(
                text: 'Add More Patients to Examine',
                color: verySoftOrange[60],
                secondaryColor: verySoftOrangeCustomColor,
                onTap: () {
                  showErrorDialog(
                      errorTitle: '',
                      errorDescription:
                          'Please wait while we are currently connecting to the server');
                }),
          ),
          Expanded(
              child: ActionCard(
                  text: 'Read \nHealth Articles',
                  color: verySoftRed[60],
                  secondaryColor: verySoftRedCustomColor,
                  onTap: () {
                    showErrorDialog(
                        errorTitle: '',
                        errorDescription:
                            'Please wait while we are currently connecting to the server');
                  })),
        ],
      );
    }
  }

  Widget doctorStatus() {
    if (!stats.isLoading.value) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            stats.doctorStatus[0].numToAccomodate != 0
                ? '${stats.doctorStatus[0].accomodated} out of ${stats.doctorStatus[0].numToAccomodate} patients'
                : '',
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            elevation: 5,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                stats.doctorStatus[0].dStatus!
                    ? 'Available for Consultation'
                    : 'Unavailable',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: verySoftBlueColor,
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return loadingDoctorStats();
    }
  }

  Widget loadingDoctorStats() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          elevation: 5,
          child: const Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              'Loading..',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: verySoftBlueColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget offlineDialog() {
    return SimpleDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        contentPadding: const EdgeInsets.symmetric(
            vertical: 30, horizontal: kIsWeb ? 50 : 20),
        children: [
          SizedBox(
              width: Get.width * .7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Change Status',
                    textAlign: TextAlign.center,
                    style: kIsWeb ? title32Regular : subtitle20Bold,
                  ),
                  verticalSpace15,
                  const Text(
                    'It looks like you want to change your status from available to unavailable',
                    textAlign: TextAlign.center,
                    style: kIsWeb ? title32Regular : body16Regular,
                  ),
                  verticalSpace25,
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: ElevatedButton(
                        onPressed: () async {
                          //final num = data['numToAccomodate'];
                          //num to accomodate - accomodate = result
                          //consSlot - result
                          await firestore
                              .collection('doctors')
                              .doc(fetchedData!.userID!)
                              .collection('status')
                              .doc('value')
                              .update({
                            'accomodated': 0,
                            'numToAccomodate': 0,
                            'dStatus': false
                          }).then((value) {
                            //TO THINK - the offline should affect the slot available consSlot - num in category
                            //nptify all patient
                            dismissDialog();
                            print('Changed status');
                            count.value = 1;
                          }).catchError((error) {
                            showErrorDialog(
                                errorTitle: 'ERROR!',
                                errorDescription: 'Something went wrong');
                          });
                        },
                        child: Text('GO OFFLINE NOW'),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          primary: Color(0xFF0280FD),
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18),
                          ),
                        ),
                      )),
                  verticalSpace15,
                  Text(
                    'By clicking this button your status will be unavailable and all patients waiting will be notified',
                    textAlign: TextAlign.center,
                    style: kIsWeb ? title32Regular : body14RegularNeutral,
                  ),
                ],
              ))
        ]);
  }

  Widget detailsDialogCons1() {
    return SimpleDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        contentPadding: const EdgeInsets.symmetric(
            vertical: 30, horizontal: kIsWeb ? 50 : 20),
        children: [
          SizedBox(
              width: Get.width * .7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Change Status',
                    textAlign: TextAlign.center,
                    style: kIsWeb ? title32Regular : subtitle20Bold,
                  ),
                  verticalSpace15,
                  const Text(
                    'Please state the number of patient you want to accomodate',
                    textAlign: TextAlign.center,
                    style: kIsWeb ? title32Regular : body16Regular,
                  ),
                  verticalSpace25,
                  counter(),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: ElevatedButton(
                        onPressed: () async {
                          await firestore
                              .collection('doctors')
                              .doc(fetchedData!.userID!)
                              .collection('status')
                              .doc('value')
                              .update({
                            'accomodated': 0,
                            'numToAccomodate': count.value,
                            'dStatus': true
                          }).then((value) {
                            dismissDialog();
                            print('Changed status');
                            count.value = 1;
                          }).catchError((error) {
                            showErrorDialog(
                                errorTitle: 'ERROR!',
                                errorDescription: 'Something went wrong');
                          });
                        },
                        child: Text('Ready for Consultation'),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          primary: Color(0xFF0280FD),
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18),
                          ),
                        ),
                      )),
                  verticalSpace15,
                  Text(
                    'By clicking this button your status will be available and you will be able to receive consultation requests',
                    textAlign: TextAlign.center,
                    style: kIsWeb ? title32Regular : body14RegularNeutral,
                  ),
                ],
              ))
        ]);
  }

  Widget detailsDialogCons2() {
    return SimpleDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        contentPadding: const EdgeInsets.symmetric(
            vertical: 30, horizontal: kIsWeb ? 50 : 20),
        children: [
          SizedBox(
              width: Get.width * .7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Add more patient to examine',
                    textAlign: TextAlign.center,
                    style: kIsWeb ? title32Regular : subtitle20Bold,
                  ),
                  verticalSpace15,
                  const Text(
                    'Please input the value of how many patients you want to add to examine.',
                    textAlign: TextAlign.center,
                    style: kIsWeb ? title32Regular : body16Regular,
                  ),
                  verticalSpace25,
                  counterAddittional(),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: ElevatedButton(
                        onPressed: () async {
                          await firestore
                              .collection('doctors')
                              .doc(fetchedData!.userID!)
                              .collection('status')
                              .doc('value')
                              .update({
                            'numToAccomodate':
                                FieldValue.increment(countAdd.value)
                          }).then((value) {
                            dismissDialog();
                            print('Add count');
                            countAdd.value = 1;
                          }).catchError((error) {
                            showErrorDialog(
                                errorTitle: 'ERROR!',
                                errorDescription: 'Something went wrong');
                          });
                        },
                        child: Text('Add count'),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          primary: Color(0xFF0280FD),
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18),
                          ),
                        ),
                      ))
                ],
              ))
        ]);
  }

  Widget displayProfile() {
    return StreamBuilder<DocumentSnapshot>(
        stream: profileController.getProfileDoctor(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading');
          }
          final data = snapshot.data!.data() as Map<String, dynamic>;
          if (data['profileImage'] == '') {
            return CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(doctorDefault),
            );
          }
          return CircleAvatar(
            radius: 50,
            foregroundImage: NetworkImage(data['profileImage']),
            backgroundImage: AssetImage(doctorDefault),
          );
        });
  }

  Widget getFloatingButton() {
    if (!liveCont.isLoading.value) {
      if (liveCont.liveCons.isNotEmpty) {
        return FloatingActionButton(
          backgroundColor: verySoftBlueColor[30],
          elevation: 2,
          onPressed: () {
            Get.to(() => LiveConsultationScreen(),
                arguments: liveCont.liveCons[0]);
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

  Widget requestList() {
    if (consRequests.isLoading.value) {
      return Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: const SizedBox(
              height: 24, width: 24, child: CircularProgressIndicator()),
        ),
      );
    } else if (consRequests.consultations.isEmpty &&
        !consRequests.isLoading.value) {
      return const Center(child: Text('No consultation request at the moment'));
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      shrinkWrap: true,
      itemCount: consRequests.consultations.length,
      itemBuilder: (context, index) {
        return displayConsultations(consRequests.consultations[index], index);
      },
    );
  }

  Widget displayConsultations(ConsultationModel model, int index) {
    return FutureBuilder(
      future: consRequests.getPatientData(model),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ConsultationCard(
              consReq: model,
              onItemTap: () {
                Get.to(() => ConsRequestItemScreen(), arguments: model);
                consRequests.mobileIndex.value = index;
              });
        }
        return loadingCardIndicator();
      },
    );
  }

  Widget counter() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      ElevatedButton(
        onPressed: () {
          if (count.value != 1) {
            count.value = count.value - 1;
          }
        },
        child: Icon(
          Icons.expand_more,
        ),
        style: ElevatedButton.styleFrom(
          primary: Color(0xFF0280FD),
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(15),
          ),
        ),
      ),
      SizedBox(
        width: 60,
        child: Obx(
          () => Text(
            '${count.value}',
            textAlign: TextAlign.center,
            style: subtitle18Bold,
          ),
        ),
      ),
      ElevatedButton(
        onPressed: () {
          count.value = count.value + 1;
        },
        child: Icon(
          Icons.expand_less_rounded,
        ),
        style: ElevatedButton.styleFrom(
          primary: Color(0xFF0280FD),
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(15),
          ),
        ),
      )
    ]);
  }

  Widget counterAddittional() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      ElevatedButton(
        onPressed: () {
          if (countAdd.value != 1) {
            countAdd.value = countAdd.value - 1;
          }
        },
        child: Icon(
          Icons.expand_more,
        ),
        style: ElevatedButton.styleFrom(
          primary: Color(0xFF0280FD),
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(15),
          ),
        ),
      ),
      SizedBox(
        width: 60,
        child: Obx(
          () => Text(
            '${countAdd.value}',
            textAlign: TextAlign.center,
            style: subtitle18Bold,
          ),
        ),
      ),
      ElevatedButton(
        onPressed: () {
          countAdd.value = countAdd.value + 1;
        },
        child: Icon(
          Icons.expand_less_rounded,
        ),
        style: ElevatedButton.styleFrom(
          primary: Color(0xFF0280FD),
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(15),
          ),
        ),
      )
    ]);
  }

  // Future<void> minusCategorySlot() async {
  //   await firestore
  //       .collection('cons_status')
  //       .doc(fetchedData!.categoryID!)
  //       .update({'consSlot': currentCount + countAdd.value});
  // }
}
