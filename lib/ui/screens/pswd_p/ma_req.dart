import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:davnor_medicare/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const String temp =
    'https://firebasestorage.googleapis.com/v0/b/davnor-medicare-15c1d.appspot.com/o/MA%2F0-Pr-fa4607fb-0e76-4853-a952-f7a2fb1bc683image_picker3837953862599466745.jpg?alt=media&token=79ae42f0-0f5e-4488-9c92-28b0a30225f3>>>https://firebasestorage.googleapis.com/v0/b/davnor-medicare-15c1d.appspot.com/o/MA%2F1-Pr-5e2534c8-a07f-4cc1-b996-806407532111image_picker2469979465532642580.jpg?alt=media&token=b85345ff-8785-4ff9-ae6a-08f379bda305>>>https://firebasestorage.googleapis.com/v0/b/davnor-medicare-15c1d.appspot.com/o/MA%2F0-Pr-fa4607fb-0e76-4853-a952-f7a2fb1bc683image_picker3837953862599466745.jpg?alt=media&token=79ae42f0-0f5e-4488-9c92-28b0a30225f3>>>https://firebasestorage.googleapis.com/v0/b/davnor-medicare-15c1d.appspot.com/o/MA%2F1-Pr-5e2534c8-a07f-4cc1-b996-806407532111image_picker2469979465532642580.jpg?alt=media&token=b85345ff-8785-4ff9-ae6a-08f379bda305>>>https://firebasestorage.googleapis.com/v0/b/davnor-medicare-15c1d.appspot.com/o/MA%2F0-Pr-fa4607fb-0e76-4853-a952-f7a2fb1bc683image_picker3837953862599466745.jpg?alt=media&token=79ae42f0-0f5e-4488-9c92-28b0a30225f3>>>https://firebasestorage.googleapis.com/v0/b/davnor-medicare-15c1d.appspot.com/o/MA%2F1-Pr-5e2534c8-a07f-4cc1-b996-806407532111image_picker2469979465532642580.jpg?alt=media&token=b85345ff-8785-4ff9-ae6a-08f379bda305>>>';
final RxList<String> imgs = RxList<String>();

class MARequestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    imgs.value = temp.split('>>>');
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(child: ResponsiveView()),
        ));
  }
}

class ResponsiveView extends GetResponsiveView {
  ResponsiveView() : super(alwaysUseBuilder: false);

  @override
  Widget phone() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpace35,
          patientInfo(),
          verticalSpace35,
          attachedPhotos(),
          verticalSpace35,
          screenButtons(),
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
          screenButtons(),
          verticalSpace35,
        ],
      );

  @override
  Widget desktop() => Column(
        children: [
          verticalSpace35,
          Row(
            children: [
              patientInfo(),
              Padding(
                padding: const EdgeInsets.fromLTRB(300, 0, 0, 0),
                child: attachedPhotos(),
              ),
            ],
          ),
          verticalSpace35,
          screenButtons(),
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
      verticalSpace15,
    ]);
  }

  Widget attachedPhotos() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(
        width: 310,
        child: Text(
          'Attached Photos',
          style: caption12RegularNeutral,
        ),
      ),
      verticalSpace10,
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
              return Image.network(
                imgs[index],
                width: 5,
                height: 5,
                fit: BoxFit.fill,
              );
            }),
          ),
        ),
      ),
      verticalSpace10,
      Row(children: const [
        Text(
          'Date Requested',
          style: caption12SemiBold,
        ),
        horizontalSpace15,
        Text(
          'July 01, 2021 (9:00 am)',
          style: caption12RegularNeutral,
        ),
      ]),
    ]);
  }

  Widget screenButtons() {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      CustomButton(
        onTap: () async {},
        text: 'Accept',
        buttonColor: verySoftOrange[60],
        fontSize: 15,
      ),
      horizontalSpace25,
      CustomButton(
        onTap: () async {},
        text: 'Decline',
        buttonColor: verySoftOrange[60],
        fontSize: 15,
      ),
    ]);
  }
}
