import 'package:davnor_medicare/constants/app_strings.dart';
import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:davnor_medicare/ui/widgets/custom_button.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class VerificationRequestScreen extends StatelessWidget {
  const VerificationRequestScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        backgroundColor: Colors.white,
        body:  Container(  
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Text('FOR ACCOUNT VERIFICATION',
                    textAlign: TextAlign.left,
                    style: title24Bold),
                    verticalSpace35,
                    ]
                ),
                verticalSpace15,
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(authHeader),
                      radius: 30,
                    ),
                    horizontalSpace10,
                    Expanded(
                    child: Column(children: [
                      Container(height: 25, width: 900,
                      color: Colors.white,
                      child: const Text('Firstname: ',
                      style: body14Medium,),),
                      Container(height: 25, width: 900,
                      color: Colors.white,
                      child: const Text('Lastname: ',
                      style: body14Medium,),),
                      Container(height: 25, width: 900,
                      color: Colors.white,
                      child: const Text('Date Requested: ',
                      style: caption12Regular,),),
                    ]),
                   ),
                    ], 
                  ),
                   verticalSpace25,
                    const Text('Attached Photos ',
                      style: caption12Medium,),
                  verticalSpace10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                    SizedBox(
                      width: screenWidthPercentage(context, percentage: .4),
                      child: const Text(
                        'Valid ID',
                        style: caption12RegularNeutral,
                        ),
                      ),
                    const SizedBox(
                          width: 500,
                          child:  Text(
                            'Valid ID with Selfie',
                            style: caption12RegularNeutral,
                            ),
                          ),
                        ],
                  ), 

                  verticalSpace10,
                  Row(
                 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                  DottedBorder(
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(12),
                      padding: const EdgeInsets.all(12),
                      dashPattern: const [8, 8, 8, 8],
                      child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                        child: Container(
                          width: 300,
                          height: 110,
                        // height: 155,
                          color: neutralColor[10],
                        ),
                      ),
                    ),
                      horizontalSpace80,
                  DottedBorder(
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(12),
                      padding: const EdgeInsets.all(12),
                      dashPattern: const [8, 8, 8, 8],
                      child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                        child: Container(
                          width: 300,
                          height: 110,
                        // height: 155,
                          color: neutralColor[10],
                          ),
                        ),
                      ),
                  ]),

                  verticalSpace35,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Align(
                        alignment: FractionalOffset.bottomRight,
                        child: CustomButton(
                          onTap: () async {
                            },
                            text: 'Verify',
                            buttonColor: Colors.blue[900],
                            fontSize: 15,
                            ),
                          ),
                    horizontalSpace40,
                      Align(
                        alignment: FractionalOffset.bottomRight,
                        child: CustomButton(
                          onTap: () async {
                            },
                            text: 'Cancel',
                            buttonColor: Colors.blue[900],
                            fontSize: 15,
                          ),
                        ),
                      ],
                ), 
          ]
        ),
      ),
    );
  }
}