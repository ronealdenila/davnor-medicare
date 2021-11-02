import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/core/controllers/doctor/consultations_controller.dart';
import 'package:davnor_medicare/core/controllers/status_controller.dart';
import 'package:davnor_medicare/core/models/consultation_model.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:davnor_medicare/ui/screens/doctor/cons_req_info.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:davnor_medicare/constants/asset_paths.dart';

class ConsRequestItemScreen extends StatelessWidget {
  final ConsultationsController doctorHomeController = Get.find();
  final ConsultationModel consData = Get.arguments as ConsultationModel;
  static AuthController authController = Get.find();
  final fetchedData = authController.doctorModel.value;
  final StatusController stats = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          elevation: 1,
          title: Row(
            children: [
              Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: getPhoto(consData)),
              horizontalSpace15,
              Expanded(
                child: SizedBox(
                  child: Text(
                    doctorHomeController.getFullName(consData),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: subtitle18Medium.copyWith(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.info_outline,
                size: 30,
              ),
              onPressed: () => Get.to(() => ConsReqInfoScreen(),
                  arguments: consData, transition: Transition.rightToLeft),
            ),
            horizontalSpace10,
          ],
        ),
        body: SizedBox(
          width: Get.width,
          height: Get.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(25),
                      child: Column(
                        children: [
                          Row(
                            //Bubble chat
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Container(
                                    constraints: BoxConstraints(
                                        maxWidth: Get.width * .7),
                                    padding: const EdgeInsets.all(15),
                                    decoration: const BoxDecoration(
                                      color: neutralBubbleColor,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                    ),
                                    child: Text(
                                      consData.description!,
                                      style: body16Medium.copyWith(height: 1.4),
                                    )),
                              ),
                            ],
                          ),
                          verticalSpace15,
                          displayImages(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              startConsultationButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget startConsultationButton() {
    return StreamBuilder<DocumentSnapshot>(
        stream: stats.getDoctorStatus(fetchedData!.userID!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final data = snapshot.data!.data() as Map<String, dynamic>;
            return Align(
              alignment: FractionalOffset.bottomCenter,
              child: Container(
                color: customNeutralColor2,
                width: Get.width,
                height: 100,
                child: Center(
                  child: InkWell(
                    onTap: () {
                      if (data['hasOngoingCons']) {
                        showErrorDialog(
                            errorTitle:
                                'Sorry, you still have an on progress consultation',
                            errorDescription:
                                'Please make sure to end your accepted consultation first before starting new one');
                      } else {
                        //showLoading();
                        //TO DO: Move cons_request data to live_cons
                        //chat senderID of patient for description + imgs if not null
                        //user uid of the current user
                        //then delete consID sa cons_request
                        doctorHomeController
                            .updateDocStatus(fetchedData!.userID!);
                        //dismissDialog();
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: verySoftBlueColor[60],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: 255,
                      height: 43,
                      child: Center(
                        child: Text(
                          'Start Consultation',
                          style: body16SemiBold.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
          return Align(
            alignment: FractionalOffset.bottomCenter,
            child: Container(
              color: customNeutralColor2,
              width: Get.width,
              height: 100,
              child: Center(
                child: InkWell(
                  onTap: () {
                    //please wait, we are still fetching.. try again;
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: verySoftBlueColor[60],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: 255,
                    height: 43,
                    child: Center(
                      child: Text(
                        'Start Consultation',
                        style: body16SemiBold.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget getPhoto(ConsultationModel model) {
    if (doctorHomeController.getProfilePhoto(model) == '') {
      return CircleAvatar(
        radius: 25,
        backgroundImage: AssetImage(blankProfile),
      );
    }
    return CircleAvatar(
      radius: 25,
      backgroundImage:
          NetworkImage(doctorHomeController.getProfilePhoto(model)),
    );
  }

  Widget displayImages() {
    if (consData.imgs != '' &&
        consData.imgs!.startsWith('https://firebasestorage.googleapis.com/')) {
      final displayImages = consData.imgs!.split('>>>');
      if (displayImages.length == 1) {
        return displaySingleImage(consData.imgs!);
      } else if (displayImages.length > 1) {
        displayImages.removeLast(); //remove excess >>> ""
        return displayMultipleImages(displayImages);
      }
    }
    return SizedBox(height: 0, width: 0);
  }

  Widget displaySingleImage(String img) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
              constraints: BoxConstraints(maxWidth: Get.width * .7),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: neutralBubbleColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Image.network(
                img,
                fit: BoxFit.cover,
              )),
        ),
      ],
    );
  }

  Widget displayMultipleImages(List<String> displayImages) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            constraints: BoxConstraints(maxWidth: Get.width * .7),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: neutralBubbleColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              crossAxisCount:
                  displayImages.length < 3 ? displayImages.length : 3,
              children: List.generate(displayImages.length, (index) {
                return Container(
                  height: 68.5,
                  color: Colors.white,
                  child: Center(
                      child: Image.network(
                    displayImages[index],
                    fit: BoxFit.cover,
                  )),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}
