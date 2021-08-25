import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MARequestInfoScreen extends StatelessWidget {
  const MARequestInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
            children: <Widget> [
              Container(
                width: MediaQuery.of(context).size.width,

                child: Column(children: <Widget>[
                  const SizedBox(
                    height: 5,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: Get.back,
                      icon: const Icon(
                        Icons.keyboard_arrow_left,
                        color: Colors.black,
                        size: 50,
                      ),
                    ),
                  ),
                ]),
              ),

              Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget> [
            const Text(
                'Patients Information',
                textAlign: TextAlign.left,
                style: subtitle20Medium,
                ),
              
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Patients Name',
                textAlign: TextAlign.left,
                style: body16SemiBold,
                ),
              ),
            
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Patients Age',
                textAlign: TextAlign.left,
                style: body16SemiBold,
                ),
              ),
            
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Address',
                textAlign: TextAlign.left,
                style: body16SemiBold,
                ),
              ),
            
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Gender',
                textAlign: TextAlign.left,
                style: body16SemiBold,
                ),
              ),
            
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Patients Type',
                textAlign: TextAlign.left,
                style: body16SemiBold,
                ),
              ),

               const Padding(
              padding: EdgeInsets.symmetric(vertical: 10)),
            
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 0),
              child: Text(
                'MA Request Information',
                textAlign: TextAlign.left,
                style: subtitle20Medium,
                ),
              ),

            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Received by',
                textAlign: TextAlign.left,
                style: body16SemiBold,
                ),
              ),
            
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Pharmacy',
                textAlign: TextAlign.left,
                style: body16SemiBold,
                ),
              ),
            
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Medecine Worth',
                textAlign: TextAlign.left,
                style: body16SemiBold,
                ),
              ),
            
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Date Requested',
                textAlign: TextAlign.left,
                style: body16SemiBold,
                ),
              ),
            
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Date MA Claimed',
                textAlign: TextAlign.left,
                style: body16SemiBold,
                ),
              ),

             const Padding(
              padding: EdgeInsets.symmetric(vertical: 10)),

            Card(
              color: verySoftBlueColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              elevation: 5,
              child: const Padding(
                padding: EdgeInsets.all(13),
                child: Text(
                  'See attached photos',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
              ],
            )),

        ])
    ));
  }
}
