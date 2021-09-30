import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';

class HistoryInfoScreen extends StatelessWidget {
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
              const Text('Lalisa Wolski',
                textAlign: TextAlign.center, 
                style: subtitle18Medium),
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
                          children:  <Widget>[
                            verticalSpace15,
                            Text('Consultation Info',
                                textAlign: TextAlign.left,
                                style: body16Regular.copyWith(
                                  color: const Color(0xFF727F8D)),),
                            verticalSpace15,
                            const Text('Patient',
                                textAlign: TextAlign.left, 
                                style: body14SemiBold),
                            verticalSpace15,
                            Text('Patients Name',
                                textAlign: TextAlign.left,
                                style: body14SemiBold),
                            verticalSpace15,
                            Text('Age of Patient',
                                textAlign: TextAlign.left,
                                style: body14SemiBold),
                            verticalSpace15,
                            Text('Consultation Started',
                                textAlign: TextAlign.left,
                                style: body14SemiBold),
                            verticalSpace15,
                            Text('Consultation Ended',
                                textAlign: TextAlign.left,
                                style: body14SemiBold),
                            verticalSpace15,
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
                              verticalSpace15,
                              Text('35',
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
