import 'package:davnor_medicare/core/controllers/cons_history_controller.dart';
import 'package:davnor_medicare/core/models/consultation_model.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:flutter/cupertino.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:get/get.dart';

class PatientConsHistoryInfoScreen extends StatelessWidget {
  static ConsHistoryController consHCont = Get.find();
  final ConsultationHistoryModel consData =
      Get.arguments as ConsultationHistoryModel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        backgroundColor: Colors.white,
        body: ListView(children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color(0xFFCBD4E1),
                ),
              ),
            ),
            child: Column(children: <Widget>[
              verticalSpace15,
              Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: getPhoto(consData)),
              verticalSpace20,
              Text(
                'Dr. ${consHCont.getDoctorFullName(consData)}',
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: subtitle18Medium,
                textAlign: TextAlign.center,
              ),
              verticalSpace5,
              Text(
                consData.doc.value!.title!,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: body14Regular.copyWith(color: const Color(0xFF727F8D)),
              ),
              verticalSpace25
            ]),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace35,
                Text('Consultation Info',
                    textAlign: TextAlign.left,
                    style:
                        body16Regular.copyWith(color: const Color(0xFF727F8D))),
                verticalSpace20,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 170,
                      child: Text('Patient',
                          textAlign: TextAlign.left, style: body14SemiBold),
                    ),
                    SizedBox(
                      width: Get.width - 230,
                      child: Text(consData.fullName!,
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: body14Regular),
                    ),
                  ],
                ),
                verticalSpace15,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 170,
                      child: Text('Age of Patient',
                          textAlign: TextAlign.left, style: body14SemiBold),
                    ),
                    SizedBox(
                      width: Get.width - 230,
                      child: Text(consData.age!,
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: body14Regular),
                    ),
                  ],
                ),
                verticalSpace15,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 170,
                      child: Text('Date Requested',
                          textAlign: TextAlign.left, style: body14SemiBold),
                    ),
                    SizedBox(
                      width: Get.width - 230,
                      child: Text(consHCont.convertDate(consData.dateRqstd!),
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: body14Regular),
                    ),
                  ],
                ),
                verticalSpace15,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 170,
                      child: Text('Consultation Started',
                          textAlign: TextAlign.left, style: body14SemiBold),
                    ),
                    SizedBox(
                      width: Get.width - 230,
                      child: Text(
                          consHCont.convertDate(consData.dateConsStart!),
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: body14Regular),
                    ),
                  ],
                ),
                verticalSpace15,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 170,
                      child: Text('Consultation Ended',
                          textAlign: TextAlign.left, style: body14SemiBold),
                    ),
                    SizedBox(
                      width: Get.width - 230,
                      child: Text(consHCont.convertDate(consData.dateConsEnd!),
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: body14Regular),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Widget getPhoto(ConsultationHistoryModel model) {
    if (consHCont.getDoctorProfile(model) == '') {
      return CircleAvatar(
        radius: 50,
        backgroundImage: AssetImage(blankProfile),
      );
    }
    return CircleAvatar(
      radius: 50,
      backgroundImage: NetworkImage(consHCont.getDoctorProfile(model)),
    );
  }
}
