import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/doctor/consultations_controller.dart';
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
  final ConsultationsController consRequests =
      Get.put(ConsultationsController());
  final LiveConsController liveCont = Get.put(LiveConsController());
  static AuthController authController = Get.find();
  final fetchedData = authController.doctorModel.value;
  static StatusController stats = Get.put(StatusController());

  //data needed for consultation process: Fetch the stream
  final int slot = 10;
  final RxInt count = 1.obs;
  final RxInt countAdd = 1.obs; //for additionals
  final bool isAvailable = true;

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
              userProfile: fetchedData!.profileImage == ''
                  ? const Icon(
                      Icons.person,
                      size: 56,
                    )
                  : Image.network(fetchedData!.profileImage!),
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
                          doctorStatus(),
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
                                width: Get.width, child: actionCards(context)),
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
                          Expanded(child: requestList()),
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
    return StreamBuilder<DocumentSnapshot>(
        stream: stats.getDoctorStatus(fetchedData!.userID!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final data = snapshot.data!.data() as Map<String, dynamic>;
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ActionCard(
                      text: 'Change Status',
                      color: verySoftMagenta[60],
                      secondaryColor: verySoftMagentaCustomColor,
                      onTap: () {
                        if (data['dStatus']) {
                          print('for para maka offline');
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
                        if (data['dStatus']) {
                          showDialog(
                              context: context,
                              builder: (context) =>
                                  detailsDialogCons2(data['numToAccomodate']));
                        } else {
                          print(
                              'Cant add when offline. Please change your status to be available');
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
          }
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ActionCard(
                    text: 'Change Status',
                    color: verySoftMagenta[60],
                    secondaryColor: verySoftMagentaCustomColor,
                    onTap: () {
                      //Snackbar: Please wait while we are currently connecting to the server},
                    }),
              ),
              Expanded(
                child: ActionCard(
                    text: 'Add More Patients to Examine',
                    color: verySoftOrange[60],
                    secondaryColor: verySoftOrangeCustomColor,
                    onTap: () {
                      //Snackbar: Please wait while we are currently connecting to the server},
                    }),
              ),
              Expanded(
                  child: ActionCard(
                      text: 'Read \nHealth Articles',
                      color: verySoftRed[60],
                      secondaryColor: verySoftRedCustomColor,
                      onTap: () {
                        //Snackbar: Please wait while we are currently connecting to the server},
                      })),
            ],
          );
        });
  }

  Widget doctorStatus() {
    return StreamBuilder<DocumentSnapshot>(
        stream: stats.getDoctorStatus(fetchedData!.userID!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final data = snapshot.data!.data() as Map<String, dynamic>;
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  data['dStatus']
                      ? '${data['accomodated']} out of ${data['numToAccomodate']} patients'
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
                      data['dStatus']
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
          }
          return loadingDoctorStats();
        });
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

  Widget detailsDialogCons1() {
    return SimpleDialog(
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
                      child: TextButton(
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
                              //snack bar for ERROR DIALOG
                              print("Something went wrong");
                            });
                          },
                          child: Text('Ready for Consultation'))),
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

  Widget detailsDialogCons2(int currentCount) {
    return SimpleDialog(
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
                      child: TextButton(
                          onPressed: () async {
                            await firestore
                                .collection('doctors')
                                .doc(fetchedData!.userID!)
                                .collection('status')
                                .doc('value')
                                .update({
                              'numToAccomodate': currentCount + countAdd.value
                            }).then((value) {
                              dismissDialog();
                              print('Add count');
                              countAdd.value = 1;
                            }).catchError((error) {
                              //snack bar for ERROR DIALOG
                              print("Something went wrong");
                            });
                          },
                          child: Text('Add count'))),
                ],
              ))
        ]);
  }

  Widget getFloatingButton() {
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

  Widget requestList() {
    return StreamBuilder(
        stream: consRequests.getCollection(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (consRequests.consultations.isNotEmpty) {
              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                shrinkWrap: true,
                itemCount: consRequests.consultations.length,
                itemBuilder: (context, index) {
                  return displayConsultations(
                      consRequests.consultations[index]);
                },
              );
            } else {
              return const Center(
                  child: Text('No consultation request at the moment'));
            }
          }
          return const Center(
              child: SizedBox(
                  width: 24, height: 24, child: CircularProgressIndicator()));
        });
  }

  Widget displayConsultations(ConsultationModel model) {
    return FutureBuilder(
      future: consRequests.getPatientData(model),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ConsultationCard(
              consReq: model,
              onItemTap: () {
                Get.to(() => ConsRequestItemScreen(), arguments: model);
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
}
