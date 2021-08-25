import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:get/get.dart';

class HistoryInfoScreen extends StatelessWidget {
  const HistoryInfoScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
            children: <Widget> [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .4,
                decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(
                  width: 2, color: Color(0xFFCBD4E1),),),
                ),

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
                const SizedBox(
                       height: 10,
                         ),
                    CircleAvatar(
                    backgroundImage: AssetImage(authHeader),
                    radius: 50,
                  ),
              const    SizedBox(
                    height: 20,
                  ),

              //    Text(
              //   'Dr. ${authController.doctorModel.value!.firstName} ${authController.doctorModel.value!.lastName}',
              //      style: TextStyle(
              //        fontWeight: FontWeight.bold,
              //        fontSize: 24,
              //        color: Colors.white,
              //      ),
              //    ),
              //    SizedBox(
              //      height: 3,
              //    ),
              //    Text(
              //      '${authController.doctorModel.value!.email}',
              //      style: TextStyle(
              //          fontWeight: FontWeight.w400,
              //          fontSize: 18,
              //          color: Colors.white),
              //    ),
              //  ]),
             // ),
              ],
              ),
            ),

            Padding(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 30),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: const[
                 Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'Consultation Info',
                textAlign: TextAlign.left,
                style: caption18Regular,
                ),
              ),

               Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Patients Name',
                textAlign: TextAlign.left,
                style: body16SemiBold,
                ),
              ),

               Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Patients Age',
                textAlign: TextAlign.left,
                style: body16SemiBold,
                ),
              ),

               Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Consultation Started',
                textAlign: TextAlign.left,
                style: body16SemiBold,
                ),
              ),

               Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Consultation Ended',
                textAlign: TextAlign.left,
                style: body16SemiBold,
                ),
              ),

               Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Patients Age',
                textAlign: TextAlign.left,
                style: body16SemiBold,
                ),
              ),

            ],
            ),
            ),
            
  
          ]),
        ),
      );
  }
}
