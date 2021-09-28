import 'package:davnor_medicare/core/controllers/ma_history_controller.dart';
import 'package:davnor_medicare/core/models/med_assistance_model.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/widgets/custom_button.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MAHistoryInfoScreen extends StatelessWidget {
  final MAHistoryController maHController = Get.find();
  final MAHistoryModel maHistoryItem = Get.arguments as MAHistoryModel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Patient's Information",
                          textAlign: TextAlign.justify,
                          style: subtitle20Medium.copyWith(
                              color: const Color(0xFF64748B))),
                    ]),
                verticalSpace20,
                Row(
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 160,
                                child: Text('Patient Name',
                                    textAlign: TextAlign.left,
                                    style: body16SemiBold),
                              ),
                              SizedBox(
                                width: Get.width - 220,
                                child: Text(maHistoryItem.fullName!,
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: body16Regular.copyWith(
                                        color: const Color(0xFF64748B))),
                              ),
                            ],
                          ),
                          verticalSpace20,
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 160,
                                child: Text('Patient Age',
                                    textAlign: TextAlign.left,
                                    style: body16SemiBold),
                              ),
                              SizedBox(
                                width: Get.width - 220,
                                child: Text(maHistoryItem.age!,
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: body16Regular.copyWith(
                                        color: const Color(0xFF64748B))),
                              ),
                            ],
                          ),
                          verticalSpace20,
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 160,
                                child: Text('Address',
                                    textAlign: TextAlign.left,
                                    style: body16SemiBold),
                              ),
                              SizedBox(
                                width: Get.width - 220,
                                child: Text(maHistoryItem.address!,
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: body16Regular.copyWith(
                                        color: const Color(0xFF64748B))),
                              ),
                            ],
                          ),
                          verticalSpace20,
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 160,
                                child: Text('Gender',
                                    textAlign: TextAlign.left,
                                    style: body16SemiBold),
                              ),
                              SizedBox(
                                width: Get.width - 220,
                                child: Text(maHistoryItem.gender!,
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: body16Regular.copyWith(
                                        color: const Color(0xFF64748B))),
                              ),
                            ],
                          ),
                          verticalSpace20,
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 160,
                                child: Text('Patient Type',
                                    textAlign: TextAlign.left,
                                    style: body16SemiBold),
                              ),
                              SizedBox(
                                width: Get.width - 220,
                                child: Text(maHistoryItem.type!,
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: body16Regular.copyWith(
                                        color: const Color(0xFF64748B))),
                              ),
                            ],
                          ),
                        ]),
                  ],
                ),
                verticalSpace35,
                Text('MA Request Information',
                    textAlign: TextAlign.justify,
                    style: subtitle20Medium.copyWith(
                        color: const Color(0xFF64748B))),
                verticalSpace20,
                Row(
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 160,
                                child: Text('Received by',
                                    textAlign: TextAlign.left,
                                    style: body16SemiBold),
                              ),
                              SizedBox(
                                width: Get.width - 220,
                                child: Text('Maam ${maHistoryItem.receivedBy}',
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: body16Regular.copyWith(
                                        color: const Color(0xFF64748B))),
                              ),
                            ],
                          ),
                          verticalSpace20,
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 160,
                                child: Text('Pharmacy',
                                    textAlign: TextAlign.left,
                                    style: body16SemiBold),
                              ),
                              SizedBox(
                                width: Get.width - 220,
                                child: Text(maHistoryItem.pharmacy!,
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: body16Regular.copyWith(
                                        color: const Color(0xFF64748B))),
                              ),
                            ],
                          ),
                          verticalSpace20,
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 160,
                                child: Text('Medicine Worth',
                                    textAlign: TextAlign.left,
                                    style: body16SemiBold),
                              ),
                              SizedBox(
                                width: Get.width - 220,
                                child: Text('Php ${maHistoryItem.medWorth}',
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: body16Regular.copyWith(
                                        color: const Color(0xFF64748B))),
                              ),
                            ],
                          ),
                          verticalSpace20,
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 160,
                                child: Text('Date Requested',
                                    textAlign: TextAlign.left,
                                    style: body16SemiBold),
                              ),
                              SizedBox(
                                width: Get.width - 220,
                                child: Text(
                                    maHController.convertTimeStamp(
                                        maHistoryItem.dateRqstd!),
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: body16Regular.copyWith(
                                        color: const Color(0xFF64748B))),
                              ),
                            ],
                          ),
                          verticalSpace20,
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 160,
                                child: Text('Date MA Claimed',
                                    textAlign: TextAlign.left,
                                    style: body16SemiBold),
                              ),
                              SizedBox(
                                width: Get.width - 220,
                                child: Text(
                                    maHController.convertTimeStamp(
                                        maHistoryItem.dateClaimed!),
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: body16Regular.copyWith(
                                        color: const Color(0xFF64748B))),
                              ),
                            ],
                          ),
                        ]),
                  ],
                ),
                verticalSpace25,
                Align(
                  alignment: FractionalOffset.bottomLeft,
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
