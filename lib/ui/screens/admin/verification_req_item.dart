import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:davnor_medicare/ui/widgets/custom_button.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerificationRequestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(child: ResponsiveView())),
    );
  }
}

class ResponsiveView extends GetResponsiveView {
  ResponsiveView() : super(alwaysUseBuilder: false);

  //TODO(R): Try to achieve phone and tablet must have same view
  @override
  Widget phone() => Column(
        children: [
          SizedBox(
            height: Get.height,
            width: Get.width,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              userInfo(),
              Column(
                children: <Widget>[
                  validID(),
                  verticalSpace35,
                  validIDWithSelfie(),
                ],
              ),
              verticalSpace35,
              screenButtons()
            ]),
          )
        ],
      );

  @override
  Widget tablet() => Column(
        children: [
          SizedBox(
            height: Get.height,
            width: Get.width,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              userInfo(),
              Column(
                children: <Widget>[
                  validID(),
                  verticalSpace35,
                  validIDWithSelfie(),
                ],
              ),
              verticalSpace35,
              screenButtons()
            ]),
          )
        ],
      );

  @override
  Widget desktop() => Column(
        children: [
          SizedBox(
            height: Get.height,
            width: screen.width,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              userInfo(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  validID(),
                  horizontalSpace50,
                  validIDWithSelfie(),
                ],
              ),
              verticalSpace35,
              screenButtons()
            ]),
          ),
        ],
      );

  Widget screenButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CustomButton(
          onTap: () async {},
          text: 'Verify',
          buttonColor: Colors.blue[900],
          fontSize: 15,
        ),
        horizontalSpace40,
        CustomButton(
          onTap: () async {},
          text: 'Cancel',
          buttonColor: Colors.blue[900],
          fontSize: 15,
        ),
      ],
    );
  }

  Widget validID() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Valid ID',
          style: caption12RegularNeutral,
        ),
        verticalSpace15,
        DottedBorder(
          color: customNeutralColor,
          borderType: BorderType.RRect,
          radius: const Radius.circular(5),
          padding: const EdgeInsets.all(5),
          dashPattern: const [7, 7, 7, 7],
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            child: Container(
              width: 250,
              height: 150,
              color: neutralColor[10],
              child: Image.network(
                'https://images.unsplash.com/photo-1579353977828-2a4eab540b9a?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8c2FtcGxlfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80',
                height: 106,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget validIDWithSelfie() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Valid ID with Selfie',
          style: caption12RegularNeutral,
        ),
        verticalSpace15,
        DottedBorder(
          color: customNeutralColor,
          borderType: BorderType.RRect,
          radius: const Radius.circular(5),
          padding: const EdgeInsets.all(5),
          dashPattern: const [7, 7, 7, 7],
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            child: Container(
              width: 250,
              height: 150,
              color: neutralColor[10],
              child: Image.network(
                'https://images.unsplash.com/photo-1579353977828-2a4eab540b9a?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8c2FtcGxlfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80',
                height: 106,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget userInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('FOR ACCOUNT VERIFICATION',
            textAlign: TextAlign.left, style: title24Bold),
        verticalSpace35,
        Row(
          children: [
            CircleAvatar(
              //change to image network puhon
              backgroundImage: AssetImage(
                authHeader,
              ),
              radius: 40,
            ),
            horizontalSpace15,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Text(
                      'First Name:',
                      style: body14Medium,
                    ),
                    horizontalSpace25,
                    Text(
                      'Daenerys',
                      style: subtitle18Bold,
                    ),
                  ],
                ),
                verticalSpace5,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Text(
                      'Last Name:',
                      style: body14Medium,
                    ),
                    horizontalSpace25,
                    Text(
                      'Targaryen',
                      style: subtitle18Bold,
                    ),
                  ],
                ),
                verticalSpace10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Text(
                      'Date Requested',
                      style: caption12Regular,
                    ),
                    horizontalSpace10,
                    Text(
                      'July 01, 2021',
                      style: caption12RegularNeutral,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        verticalSpace50,
        const Text(
          'Attached Photos ',
          style: body14SemiBold,
        ),
        verticalSpace10,
      ],
    );
  }
}
