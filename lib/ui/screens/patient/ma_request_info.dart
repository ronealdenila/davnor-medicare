import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:davnor_medicare/ui/widgets/custom_button.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MARequestInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      Text(
                        'Patient Information',
                        style: title20Regular,
                        textAlign: TextAlign.justify,
                      ),
                    ]),
                verticalSpace20,
                Row(
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const <Widget>[
                          Text('Patients Name',
                              textAlign: TextAlign.left, style: body16Bold),
                          verticalSpace20,
                          Text('Patients Age',
                              textAlign: TextAlign.left, style: body16Bold),
                          verticalSpace20,
                          Text('Address',
                              textAlign: TextAlign.left, style: body16Bold),
                          verticalSpace20,
                          Text('Gender',
                              textAlign: TextAlign.left, style: body16Bold),
                          verticalSpace20,
                          Text('Patients Type',
                              textAlign: TextAlign.left, style: body16Bold),
                          verticalSpace20,
                        ]),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  child: Text('MA Request Information',
                      textAlign: TextAlign.justify, style: title20Regular),
                ),
                Row(
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const <Widget>[
                          Text('Received by',
                              textAlign: TextAlign.left, style: body16Bold),
                          verticalSpace20,
                          Text('Pharmacy',
                              textAlign: TextAlign.left, style: body16Bold),
                          verticalSpace20,
                          Text('Medecine Worth',
                              textAlign: TextAlign.left, style: body16Bold),
                          verticalSpace20,
                          Text('Date Requested',
                              textAlign: TextAlign.left, style: body16Bold),
                          verticalSpace20,
                          Text('Date MA Claimed',
                              textAlign: TextAlign.left, style: body16Bold),
                          verticalSpace20,
                        ]),
                  ],
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 35)),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: CustomButton(
                    onTap: () async {
                      //
                    },
                    text: 'See Attached Photos',
                    buttonColor: verySoftBlueColor,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
