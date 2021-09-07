import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:davnor_medicare/ui/screens/pswd_p/ma_attached_photos.dart';

class PSWDItemView extends GetResponsiveView {
  PSWDItemView(this.temp, this.status) : super(alwaysUseBuilder: false);
  final String temp;
  final RxList<String> imgs = RxList<String>();
  final String status;

  @override
  Widget phone() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpace35,
          patientInfo(),
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
          patientInfo(),
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
              patientInfo(),
              attachedPhotos(),
            ],
          ),
          verticalSpace35,
        ],
      );

  Widget patientInfo() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(authHeader),
            radius: 29,
          ),
          horizontalSpace20,
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
            Text(
              'Olivia Broken ',
              style: subtitle18Bold,
            ),
            verticalSpace5,
            Text(
              'Request Person ',
              style: caption12Medium,
            ),
          ]),
        ],
      ),
      verticalSpace25,
      Text(
        "Patient's Infomation",
        style: subtitle18MediumNeutral,
      ),
      verticalSpace15,
      Row(
        children: const [
          SizedBox(
            width: 120,
            child: Text('Patient Name',
                textAlign: TextAlign.left, style: caption12Medium),
          ),
          Text('Arya Stark', style: caption12RegularNeutral),
        ],
      ),
      verticalSpace15,
      Row(
        children: const [
          SizedBox(
              width: 120,
              child: Text('Patient Age',
                  textAlign: TextAlign.left, style: caption12Medium)),
          Text('22', style: caption12RegularNeutral),
        ],
      ),
      verticalSpace15,
      Row(
        children: const [
          SizedBox(
              width: 120,
              child: Text('Address',
                  textAlign: TextAlign.left, style: caption12Medium)),
          Text('San Miguel Tagum City', style: caption12RegularNeutral),
        ],
      ),
      verticalSpace15,
      Row(
        children: const [
          SizedBox(
              width: 120,
              child: Text('Gender',
                  textAlign: TextAlign.left, style: caption12Medium)),
          Text('Female', style: caption12RegularNeutral),
        ],
      ),
      verticalSpace15,
      Row(
        children: const [
          SizedBox(
            width: 120,
            child: Text('Patient Type',
                textAlign: TextAlign.left, style: caption12Medium),
          ),
          Text('Pregnant Women', style: caption12RegularNeutral),
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
          children: const [
            SizedBox(
              width: 120,
              child: Text('Received by',
                  textAlign: TextAlign.left, style: caption12Medium),
            ),
            Text('Maam Grace', style: caption12RegularNeutral),
          ],
        ),
        Visibility(
          visible: status == 'medReady' || status == 'completed',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace15,
              Row(
                children: const [
                  SizedBox(
                      width: 120,
                      child: Text('Pharmacy',
                          textAlign: TextAlign.left, style: caption12Medium)),
                  Text('Rose Pharmacy', style: caption12RegularNeutral),
                ],
              ),
              verticalSpace15,
              Row(
                children: const [
                  SizedBox(
                      width: 120,
                      child: Text('Medicine Worth',
                          textAlign: TextAlign.left, style: caption12Medium)),
                  Text('Php 800.00', style: caption12RegularNeutral),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget attachedPhotos() {
    imgs.value = temp.split('>>>');
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(
        width: 310,
        child: Text(
          'Attached Photos',
          style: caption12RegularNeutral,
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
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: GridView.count(
            shrinkWrap: true,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            crossAxisCount: 3,
            children: List.generate(imgs.length - 1, (index) {
              return InkWell(
                onTap: () {
                  Get.to(() => AttachedPhotosScreen(),
                      arguments: [index, imgs]);
                },
                child: Image.network(
                  imgs[index],
                  width: 5,
                  height: 5,
                  fit: BoxFit.fill,
                ),
              );
            }),
          ),
        ),
      ),
      verticalSpace20,
      Row(children: const [
        SizedBox(
          width: 120,
          child: Text(
            'Date Requested',
            style: caption12SemiBold,
          ),
        ),
        horizontalSpace15,
        Text(
          'July 01, 2021 (9:00 am)',
          style: caption12RegularNeutral,
        ),
      ]),
      verticalSpace10,
      Visibility(
        visible: status == 'completed',
        child: Row(children: const [
          SizedBox(
            width: 120,
            child: Text(
              'Date MA Claimed',
              style: caption12SemiBold,
            ),
          ),
          horizontalSpace15,
          Text(
            'July 01, 2021 (9:00 am)',
            style: caption12RegularNeutral,
          ),
        ]),
      ),
    ]);
  }
}
