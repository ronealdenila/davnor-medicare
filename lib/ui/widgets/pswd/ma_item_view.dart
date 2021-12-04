import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/app_controller.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/core/controllers/calling_patient_controller.dart';
import 'package:davnor_medicare/core/controllers/attached_photos_controller.dart';
import 'package:davnor_medicare/core/models/general_ma_req_model.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:davnor_medicare/ui/screens/doctor/calling.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/widgets/patient/dialog_button.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PSWDItemView extends GetResponsiveView {
  PSWDItemView(this.context, this.status, this.model)
      : super(alwaysUseBuilder: false);
  final GeneralMARequestModel model;
  final String status;
  final BuildContext context;
  final RxBool doneLoad = false.obs;
  final RxBool errorPhoto = false.obs;

  final AttachedPhotosController controller = Get.find();
  static AuthController authController = Get.find();
  final AppController appController = Get.find();
  final fetchedData = authController.pswdModel.value;
  final CallingPatientController callController =
      Get.put(CallingPatientController(), permanent: true);

  @override
  Widget phone() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpace35,
          displayPatientInfo(),
          verticalSpace35,
          attachedPhotos(),
          verticalSpace35,
        ],
      );

  @override
  Widget tablet() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpace35,
          displayPatientInfo(),
          verticalSpace35,
          attachedPhotos(),
          verticalSpace35,
        ],
      );

  @override
  Widget desktop() => Column(
        children: [
          verticalSpace35,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              displayPatientInfo(),
              attachedPhotos(),
            ],
          ),
          verticalSpace35,
        ],
      );

  Widget displayPatientInfo() {
    if (!doneLoad.value) {
      return FutureBuilder(
        future: appController.getPatientData(model),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            doneLoad.value = true;
            return patientInfo();
          }
          return const Center(
              child: SizedBox(
                  width: 24, height: 24, child: CircularProgressIndicator()));
        },
      );
    }
    return patientInfo();
  }

  Widget patientInfo() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        children: [
          getPhoto(model),
          horizontalSpace20,
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              appController.getFullName(model),
              style: subtitle20Bold,
            ),
            verticalSpace5,
            const Text(
              'Request Person ',
              style: caption16Medium,
            ),
          ]),
          horizontalSpace20,
          Visibility(
            visible:
                status == 'accepted' && authController.userRole == 'pswd-p',
            child: StreamBuilder<DocumentSnapshot>(
                stream: firestore
                    .collection('patients')
                    .doc(model.requesterID)
                    .collection('incomingCall')
                    .doc('value')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError || !snapshot.hasData) {
                    return IconButton(
                      icon: Icon(
                        Icons.videocam_rounded,
                        color: verySoftBlueCustomColor,
                      ),
                      onPressed: () async {
                        showSimpleErrorDialog(
                            errorDescription: 'Something went wrong');
                      },
                    );
                  }
                  final data = snapshot.data!.data() as Map<String, dynamic>;
                  return IconButton(
                    icon: Icon(
                      Icons.videocam_rounded,
                      color: verySoftBlueCustomColor,
                    ),
                    onPressed: () async {
                      if (data['patientJoined'] && data['otherJoined']) {
                        showSimpleErrorDialog(
                            errorDescription:
                                'Patient is currently on a video call, please try again later');
                      } else {
                        await interviewPatient();
                      }
                    },
                  );
                }),
          )
        ],
      ),
      verticalSpace25,
      Text(
        "Patient's Infomation",
        style: subtitle24MediumNeutral,
      ),
      verticalSpace15,
      Row(
        children: [
          const SizedBox(
            width: 120,
            child: Text('Patient Name',
                textAlign: TextAlign.left, style: caption18Medium),
          ),
          horizontalSpace15,
          Text(model.fullName!, style: caption16RegularNeutral),
        ],
      ),
      verticalSpace15,
      Row(
        children: [
          const SizedBox(
              width: 120,
              child: Text('Patient Age',
                  textAlign: TextAlign.left, style: caption18Medium)),
           horizontalSpace15,
          Text(model.age!, style: caption16RegularNeutral),
        ],
      ),
      verticalSpace15,
      Row(
        children: [
          const SizedBox(
              width: 120,
              child: Text('Address',
                  textAlign: TextAlign.left, style: caption18Medium)),
           horizontalSpace15,
          Text(model.address!, style: caption16RegularNeutral),
        ],
      ),
      verticalSpace15,
      Row(
        children: [
          const SizedBox(
              width: 120,
              child: Text('Gender',
                  textAlign: TextAlign.left, style: caption18Medium)),
           horizontalSpace15,
          Text(model.gender!, style: caption16RegularNeutral),
        ],
      ),
      verticalSpace15,
      Row(
        children: [
          const SizedBox(
            width: 120,
            child: Text('Patient Type',
                textAlign: TextAlign.left, style: caption18Medium),
          ),
           horizontalSpace15,
          Text(model.type!, style: caption16RegularNeutral),
        ],
      ),
      Visibility(visible: status != 'request', child: medicalAssistanceInfo())
    ]);
  }

  Widget medicalAssistanceInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        verticalSpace35,
        Text(
          'MA Request Infomation',
          style: subtitle18MediumNeutral,
        ),
        verticalSpace15,
        Row(
          children: [
            const SizedBox(
              width: 120,
              child: Text('Received by',
                  textAlign: TextAlign.left, style: caption18Medium),
            ),
             horizontalSpace15,
            Text(model.receivedBy!, style: caption16RegularNeutral),
          ],
        ),
        Visibility(
          visible: status == 'medReady' || status == 'completed',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace15,
              Row(
                children: [
                  const SizedBox(
                      width: 120,
                      child: Text('Pharmacy',
                          textAlign: TextAlign.left, style: caption18Medium)),
                   horizontalSpace15,
                  Text(model.pharmacy!, style: caption16RegularNeutral),
                ],
              ),
              verticalSpace15,
              Row(
                children: [
                  const SizedBox(
                      width: 120,
                      child: Text('Medicine Worth',
                          textAlign: TextAlign.left, style: caption18Medium)),
                   horizontalSpace15,
                  Text('Php ${model.medWorth}', style: caption16RegularNeutral),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> interviewPatient() async {
    await firestore
        .collection('patients')
        .doc(model.requesterID)
        .collection('incomingCall')
        .doc('value')
        .update({
      'from': 'pswd-p',
      'isCalling': true,
      'didReject': false,
      'channelId': model.maID,
      'callerName': '${fetchedData!.lastName!} (PSWD Personnel)'
    }).then((value) => Get.to(() => CallPatientScreen(), arguments: [
              model.requesterID,
              model.maID,
              model.requester.value!.profileImage,
              appController.getFullName(model)
            ]));
  }

  Widget attachedPhotos() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            width: 310,
            child: Text(
              'Attached Photos',
              style: caption16RegularNeutral,
            ),
          ),
          verticalSpace20,
          Container(
            width: 310,
            height: 170,
            decoration: BoxDecoration(
              color: neutralColor[10],
              borderRadius: BorderRadius.circular(2),
            ),
            child: GridView.count(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              crossAxisCount: 3,
              children:
                  List.generate(controller.fetchedImages.length - 1, (index) {
                return GestureDetector(
                  onTap: () {
                    controller.selectedIndex.value = index;
                    showDialog(
                        context: context,
                        builder: (context) => attachedPhotosDialog());
                  },
                  child: Image.network(
                    controller.fetchedImages[index],
                    width: 5,
                    height: 5,
                    fit: BoxFit.fill,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(grayBlank, fit: BoxFit.cover);
                    },
                  ),
                );
              }),
            ),
          ),
          verticalSpace20,
          Row(children: [
            const SizedBox(
              width: 120,
              child: Text(
                'Date Requested',
                style: caption16SemiBold,
              ),
            ),
            horizontalSpace15,
            Text(
              appController.convertTimeStamp(model.dateRqstd!),
              style: caption16RegularNeutral,
            ),
          ]),
          verticalSpace10,
          Visibility(
            visible: status == 'completed',
            child: Row(children: [
              const SizedBox(
                width: 120,
                child: Text(
                  'Date MA Claimed',
                  style: caption16SemiBold,
                ),
              ),
              horizontalSpace15,
              displayDateClaimed(model),
            ]),
          ),
        ]);
  }

  Widget displayDateClaimed(GeneralMARequestModel model) {
    if (status == 'completed') {
      return Text(
        appController.convertTimeStamp(model.dateClaimed!),
        style: caption16RegularNeutral,
      );
    }
    return const SizedBox(
      width: 0,
      height: 0,
    );
  }

  Widget getPhoto(GeneralMARequestModel model) {
    return CircleAvatar(
        radius: 29,
        foregroundImage: NetworkImage(appController.getProfilePhoto(model)),
        onForegroundImageError: (_, __) {
          errorPhoto.value = true;
        },
        backgroundColor: Colors.grey,
        child: Obx(
          () => errorPhoto.value
              ? Text(
                  '${appController.getFirstName(model)[0]}',
                )
              : SizedBox(
                  height: 0,
                  width: 0,
                ),
        ));
  }

  Widget attachedPhotosDialog() {
    return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      contentPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: SizedBox(
              width: 130,
              child: ErrorDialogButton(
                buttonText: 'Open Image',
                onTap: () async {
                  await controller.launchOpenImage();
                },
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: IconButton(
                onPressed: controller.prevPhoto,
                icon: const Icon(
                  Icons.arrow_back_ios_rounded,
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                height: Get.height * .7,
                width: Get.width * .7,
                color: Colors.transparent,
                child: Obx(
                  () => CarouselSlider.builder(
                    carouselController: controller.crslController,
                    itemCount: controller.fetchedImages.length - 1,
                    itemBuilder: (context, index, realIndex) {
                      return buildImage(index);
                    },
                    options: CarouselOptions(
                        initialPage: controller.selectedIndex.value,
                        viewportFraction: 1,
                        height: double.infinity,
                        enlargeCenterPage: true,
                        enableInfiniteScroll: false,
                        onPageChanged: (index, reason) =>
                            controller.selectedIndex.value = index),
                  ),
                ),
              ),
            ),
            Expanded(
              child: IconButton(
                onPressed: controller.nextPhoto,
                icon: const Icon(
                  Icons.arrow_forward_ios_rounded,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 110,
          width: Get.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.fetchedImages.length - 1,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Center(
                          child: Obx(
                            () => Container(
                              padding: const EdgeInsets.all(6),
                              color: index == controller.selectedIndex.value
                                  ? verySoftBlueColor
                                  : Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  controller.selectedIndex.value = index;
                                  controller.animateToSlide(index);
                                },
                                child: Image.network(
                                  controller.fetchedImages[index],
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(grayBlank,
                                        fit: BoxFit.cover);
                                  },
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildImage(int index) {
    return Container(
      color: Colors.grey,
      child: Image.network(
        controller.fetchedImages[index],
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(grayBlank, fit: BoxFit.cover);
        },
      ),
    );
  }
}
