import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
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
                         Text('Actions',
                            textAlign: TextAlign.left, 
                            style: body16Regular.copyWith(
                            color: const Color(0xFF727F8D)),),
                        verticalSpace10,
                        InkWell(
                          onTap: () {},
                          child: const Text('End Consultation',
                              textAlign: TextAlign.left, 
                              style: subtitle18Medium),
                        ),
                        verticalSpace10,
                        InkWell(
                          onTap: () {},
                          child: const Text('Skip Consultation',
                              textAlign: TextAlign.left, 
                              style: subtitle18Medium),
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
                          children: <Widget>[
                            Text('Consultation Info',
                                textAlign: TextAlign.left,
                                style: body16Regular.copyWith(
                                  color: const Color(0xFF727F8D)),),
                            verticalSpace15,
                            const Text('Patients Name',
                                textAlign: TextAlign.left, 
                                style: body14SemiBold),
                            verticalSpace15,
                            const Text('Age of Patient',
                                textAlign: TextAlign.left, 
                                style: body14SemiBold),
                            verticalSpace15,
                            const Text('Consultation Started',
                                textAlign: TextAlign.left, 
                                style: body14SemiBold),
                            verticalSpace15,
                            
                          ]),
                      
                      Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 0, 0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const <Widget>[
                            verticalSpace20,
                            Text('Bernadette Wolowitz',
                                textAlign: TextAlign.left,
                                style: body14Regular),
                             verticalSpace15,
                            Text('35',
                                textAlign: TextAlign.left,
                                style: body14Regular),
                              verticalSpace15,
                            Text('July 27, 2021 (10:00 am))',
                                textAlign: TextAlign.left,
                                style: body14Regular),
                              verticalSpace15,
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
