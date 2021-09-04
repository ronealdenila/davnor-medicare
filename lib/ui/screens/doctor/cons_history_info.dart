import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
//import 'package:davnor_medicare/core/controllers/auth_controller.dart';

class HistoryInfoScreen extends StatelessWidget {
  // static AuthController authController = Get.find();

  //final fetchedData = authController.doctorModel.value;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        backgroundColor: Colors.white,
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
             verticalSpace20,
              CircleAvatar(
                backgroundImage: AssetImage(authHeader),
                radius: 50,
              ),
              verticalSpace20,
              //  Text(
              //       'Dr. ${fetchedData!.firstName} ${fetchedData!.lastName}',
              //       style: const TextStyle(
              //         fontWeight: FontWeight.bold,
              //        fontSize: 24,
              //          color: Colors.white,
              //       )),
              const SizedBox(
                height: 5,
              ),
              //      Text(
              //        authController.doctorModel.value!.email!,
              //        style: const TextStyle(
              //            fontWeight: FontWeight.w400,
              //            fontSize: 18,
              //            color: Colors.white),
              //      ),
            ]),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const <Widget>[
                            Text('Consultation Info',
                                textAlign: TextAlign.left,
                                style: title20Regular),
                           verticalSpace20,
                            Text('Patients Name',
                                textAlign: TextAlign.left, style: body16Bold),
                            verticalSpace20,
                            Text('Age of Patient',
                                textAlign: TextAlign.left, style: body16Bold),
                            SizedBox(
                              height: 20,
                            ),
                            Text('Consultation Started',
                                textAlign: TextAlign.left, style: body16Bold),
                           verticalSpace20,
                            Text('Consultation Ended',
                                textAlign: TextAlign.left, style: body16Bold),
                            verticalSpace20,
                          ]),
                    ],
                  ),
                ],
              )),
        ]),
      ),
    );
  }
}
