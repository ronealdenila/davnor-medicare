import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:flutter/cupertino.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';

class LiveConsInfoScreen extends StatelessWidget {
  const LiveConsInfoScreen({Key? key}) : super(key: key);

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
              verticalSpace15,
              CircleAvatar(
                backgroundImage: AssetImage(authHeader),
                radius: 50,
              ),
              verticalSpace15,
              //  Text(
              //       'Dr. ${fetchedData!.firstName} ${fetchedData!.lastName}',
              //       style: const TextStyle(
              //         fontWeight: FontWeight.bold,
              //        fontSize: 24,
              //          color: Colors.white,
              //       )),
              verticalSpace15,
              //      Text(
              //        authController.doctorModel.value!.email!,
              //        style: const TextStyle(
              //            fontWeight: FontWeight.w400,
              //            fontSize: 18,
              //            color: Colors.white),
              //      ),
            ]),
          ),
          verticalSpace25,
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
                        const Text('Actions',
                            textAlign: TextAlign.left, style: title20Regular),
                        verticalSpace10,
                        InkWell(
                          onTap: () {},
                          child: const Text('End Consultation',
                              textAlign: TextAlign.left, style: body16Bold),
                        ),
                        verticalSpace10,
                        InkWell(
                          onTap: () {},
                          child: const Text('Skip Consultation',
                              textAlign: TextAlign.left, style: body16Bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          verticalSpace35,
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
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
                            verticalSpace15,
                            Text('Patients Name',
                                textAlign: TextAlign.left, style: body16Bold),
                            verticalSpace15,
                            Text('Age of Patient',
                                textAlign: TextAlign.left, style: body16Bold),
                            verticalSpace15,
                            Text('Consultation Started',
                                textAlign: TextAlign.left, style: body16Bold),
                            verticalSpace15,
                            Text('Consultation Ended',
                                textAlign: TextAlign.left, style: body16Bold),
                            verticalSpace15,
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