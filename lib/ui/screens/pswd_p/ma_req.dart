import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:davnor_medicare/ui/widgets/custom_button.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class MARequestScreen extends StatelessWidget {
  const MARequestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(authHeader),
                radius: 30,
              ),
              horizontalSpace20,
              Expanded(
                child: Column(children: [
                  Container(
                    height: 25,
                    width: 900,
                    color: Colors.white,
                    child: const Text(
                      'Olivia Broken ',
                      style: body16SemiBold,
                    ),
                  ),
                  Container(
                    height: 25,
                    width: 900,
                    color: Colors.white,
                    child: const Text(
                      'Request Person ',
                      style: subtitle18Medium,
                    ),
                  ),
                ]),
              ),
            ],
          ),
          verticalSpace35,
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
              ),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Text(
                      'Patients Infomation',
                      style: body16Regular,
                    ),
                    verticalSpace15,
                    Text('Patients Name',
                        textAlign: TextAlign.left, style: body14Medium),
                    verticalSpace15,
                    Text('Patients Age',
                        textAlign: TextAlign.left, style: body14Medium),
                    verticalSpace15,
                    Text('Address',
                        textAlign: TextAlign.left, style: body14Medium),
                    verticalSpace15,
                    Text('Gender',
                        textAlign: TextAlign.left, style: body14Medium),
                    verticalSpace15,
                    Text('Patients Type',
                        textAlign: TextAlign.left, style: body14Medium),
                    verticalSpace15,
                  ]),
              horizontalSpace200,
              Expanded(
                child: Column(children: [
                  SizedBox(
                    width: screenWidthPercentage(context, percentage: .3),
                    child: const Text(
                      'Attached Photos',
                      style: caption12RegularNeutral,
                    ),
                  ),
                  verticalSpace10,
                  Container(
                      height: 150,
                      width: 290,
                      decoration: BoxDecoration(
                        color: neutralColor[10],
                        borderRadius: BorderRadius.circular(2),
                      )),
                  verticalSpace10,
                  SizedBox(
                    width: screenWidthPercentage(context, percentage: .3),
                    child: const Text(
                      'Date Requested',
                      style: caption12Regular,
                    ),
                  ),
                ]),
              ),
            ],
          ),
          verticalSpace50,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Align(
                alignment: FractionalOffset.bottomRight,
                child: CustomButton(
                  onTap: () async {},
                  text: 'Accept',
                  buttonColor: verySoftOrange[60],
                  fontSize: 15,
                ),
              ),
              horizontalSpace40,
              Align(
                alignment: FractionalOffset.bottomRight,
                child: CustomButton(
                  onTap: () async {},
                  text: 'Decline',
                  buttonColor: verySoftOrange[60],
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
