import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:davnor_medicare/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class MARequestScreen extends StatelessWidget {
  const MARequestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 200, vertical: 30),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(authHeader),
                radius: 29,
              ),
              horizontalSpace20,
              Expanded(
                child: Column(children: [
                  Container(
                    height: 25,
                    width: 1500,
                    color: Colors.white,
                    child: const Text(
                      'Olivia Broken ',
                      style: body16SemiBold,
                    ),
                  ),
                  Container(
                    height: 25,
                    width: 1500,
                    color: Colors.white,
                    child: const Text(
                      'Request Person ',
                      style: body14Medium,
                    ),
                  ),
                ]),
              ),
            ],),
            verticalSpace25,
          Row(
              children: [
                const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
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
                  ]
                  ), 
                Padding(
                  padding: const EdgeInsets.fromLTRB(55, 0, 0, 0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const <Widget>[
                        Text('',),
                        verticalSpace15,
                        Text('Arya Stark',
                        style: caption12RegularNeutral),
                        verticalSpace15,
                        Text('22',
                        style: caption12RegularNeutral),
                        verticalSpace15,
                        Text('San Miguel Tagum City',
                        style: caption12RegularNeutral),
                        verticalSpace15,
                        Text('Female',
                        style: caption12RegularNeutral),
                        verticalSpace15,
                        Text('Pregnant Women',
                        style: caption12RegularNeutral),
                        verticalSpace15,
                    ]),
                ),
          Expanded(
            child: Column(children: [
            const  SizedBox(
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
                  )),
              verticalSpace10,
            ]),
          ),
          ],),
          Row(
          children: [
            const Padding(
            padding: EdgeInsets.symmetric(horizontal: 297),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Text(
              'Date Requested',
              style: caption12SemiBold,
            ),
            verticalSpace15,
            ]), 
            Padding(
              padding: const EdgeInsets.fromLTRB(55, 0, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text('July 01, 2021 (9:00 am)',
                  style: caption12RegularNeutral,),
                  verticalSpace15,
                ]),
                ),
              ]),
          verticalSpace35,
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 400),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Align(
                    alignment: FractionalOffset.bottomLeft,
                    child: CustomButton(
                      onTap: () async {},
                      text: 'Accept',
                      buttonColor: verySoftOrange[60],
                      fontSize: 15,
                    ),
                  ),
                  horizontalSpace50,
                  Align(
                    alignment: FractionalOffset.bottomRight,
                    child: CustomButton(
                      onTap: () async {},
                      text: 'Decline',
                      buttonColor: verySoftOrange[60],
                      fontSize: 15,
                ),
              ),
            ]),
        ]),
        ])
      ),
    );
  }
}
