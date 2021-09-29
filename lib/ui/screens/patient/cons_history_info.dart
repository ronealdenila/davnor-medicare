import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
//import 'package:davnor_medicare/core/controllers/auth_controller.dart';
//import 'package:get/get.dart';

class PatientConsHistoryInfoScreen extends StatelessWidget {
  // static AuthController authController = Get.find();

  //final fetchedData = authController.doctorModel.value;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: ListView(children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .3,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFCBD4E1),
                ),
              ),
            ),
            child: Column(children: <Widget>[
              const SizedBox(
                height: 10,
              ),

              const SizedBox(
                height: 10,
              ),
              CircleAvatar(
                backgroundImage: AssetImage(authHeader),
                radius: 50,
              ),
              const SizedBox(
                height: 20,
              ),
              //  Text(
              //       'Dr. ${fetchedData!.firstName} ${fetchedData!.lastName}',
              //       style: const TextStyle(
              //         fontWeight: FontWeight.bold,
              //        fontSize: 24,
              //          color: Colors.white,
              //       )),
            ]),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Consultation Info',
                              textAlign: TextAlign.left,
                              style: title20Regular.copyWith(
                                  color: const Color(0xFF727F8D)),
                            ),
                            verticalSpace15,
                          const  Text('Patient',
                                textAlign: TextAlign.left, 
                                style: body14SemiBold),
                            verticalSpace15,
                          const  Text('Age of Patient',
                                textAlign: TextAlign.left, 
                                style: body14SemiBold),
                            verticalSpace15,
                          const  Text('Date Requested',
                                textAlign: TextAlign.left, 
                                style: body14SemiBold),
                            verticalSpace15,
                          const  Text('Consultation Started',
                                textAlign: TextAlign.left, 
                                style: body14SemiBold),
                            verticalSpace15,
                          const  Text('Consultation Ended',
                                textAlign: TextAlign.left, 
                                style: body14SemiBold),
                          ]),

                      Padding(
                      padding: const EdgeInsets.fromLTRB(20, 30, 0, 0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const <Widget>[
                            verticalSpace25,
                            Text('Bernadette Wolowitz',
                                textAlign: TextAlign.left,
                                style: caption12Regular),
                             verticalSpace20,
                            Text('35',
                                textAlign: TextAlign.left,
                                style: caption12Regular),
                              verticalSpace15,
                            Text('July 27, 2021 (9:00 am)',
                                textAlign: TextAlign.left,
                                style: caption12Regular),
                              verticalSpace18,
                            Text('July 27, 2021 (10:00 am)',
                                textAlign: TextAlign.left,
                                style: caption12Regular),
                              verticalSpace18,
                            Text('July 27, 2021 (11:00 am)',
                                textAlign: TextAlign.left,
                                style: caption12Regular),
                          ]),
                    ),
                    ],
                  ),
                ],
              )),
        ]),
      ),
    );
  }
}
