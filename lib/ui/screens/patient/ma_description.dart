import 'package:davnor_medicare/constants/app_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/widgets/custom_button.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';

class MADescriptionScreen extends StatelessWidget {
  const MADescriptionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //appBar: AppBar(),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Text(
                      'Medical Assistance (MA)',
                      style: title24Medium,
                    ),
                    Text(madescriptionParagraph1, style: body16Regular),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text(madescriptionParagraph2,
                      textAlign: TextAlign.justify, style: body14Regular),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: screenWidthPercentage(context, percentage: .4),
                      child: const Text(
                        'REQUIREMENTS',
                        style: body14SemiBold,
                      ),
                    ),
                    SizedBox(
                      width: screenWidthPercentage(context, percentage: .4),
                      child: const Text(
                        'WHERE TO SECURE',
                        style: body14SemiBold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: screenWidthPercentage(context, percentage: .4),
                      child: const Text(madescriptionParagraph3,
                          textAlign: TextAlign.justify,
                          style: caption12Regular),
                    ),
                    SizedBox(
                      width: screenWidthPercentage(context, percentage: .4),
                      child: const Text(madescriptionParagraph4,
                          textAlign: TextAlign.justify,
                          style: caption12Regular),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: screenWidthPercentage(context, percentage: .4),
                      child: const Text(madescriptionParagraph5,
                          textAlign: TextAlign.justify,
                          style: caption12Regular),
                    ),
                    SizedBox(
                      width: screenWidthPercentage(context, percentage: .4),
                      child: const Text(madescriptionParagraph6,
                          textAlign: TextAlign.justify,
                          style: caption12Regular),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text('SCHEDULE',
                      textAlign: TextAlign.justify, style: body14SemiBold),
                ),
                Row(
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const <Widget>[
                          Text('Morning',
                              textAlign: TextAlign.left,
                              style: caption12SemiBold),
                          SizedBox(
                            height: 5,
                          ),
                          Text('Afternoon',
                              textAlign: TextAlign.left,
                              style: caption12SemiBold),
                        ]),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const <Widget>[
                            Text('Cut-off: 9:30 am & Releasing: 12:30 pm',
                                textAlign: TextAlign.left,
                                style: caption12Regular),
                            SizedBox(
                              height: 5,
                            ),
                            Text('Cut-off: 1:30 pm & Releasing: 4:30 pm',
                                textAlign: TextAlign.left,
                                style: caption12Regular),
                          ]),
                    ),
                  ],
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                Align(
                  child: CustomButton(
                    onTap: () async {
                      //Go to MADetailsFill
                    },
                    text: 'Avail Medical Assistance',
                    buttonColor: verySoftBlueColor,
                    fontSize: 20,
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
