import 'package:davnor_medicare/core/controllers/live_cons_controller.dart';
import 'package:davnor_medicare/core/models/consultation_model.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/widgets/custom_button.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:flutter/cupertino.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:get/get.dart';

class LiveConsInfoScreen extends StatelessWidget {
  final LiveConsultationModel consData = Get.arguments as LiveConsultationModel;
  static LiveConsController liveCont = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        backgroundColor: Colors.white,
        body: Column(children: <Widget>[
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
              verticalSpace15,
              Text(
                liveCont.getPatientName(consData),
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: subtitle18Medium,
                textAlign: TextAlign.center,
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
                const Text('Actions',
                    textAlign: TextAlign.left, style: body16Regular),
                verticalSpace20,
                InkWell(
                  onTap: () {
                    confirmationDialog();
                  },
                  child: const Text('End Consultation',
                      textAlign: TextAlign.left, style: subtitle18Medium),
                ),
                verticalSpace15,
                InkWell(
                  onTap: () {
                    print('clicked');
                    showDialog(
                        context: context,
                        builder: (context) => skipDialog(consData));
                  },
                  child: SizedBox(
                    width: Get.width,
                    child: const Text('Skip Consultation',
                        textAlign: TextAlign.left, style: subtitle18Medium),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
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
                      child: Text(
                          liveCont.convertTimeStamp(consData.dateRqstd!),
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
                          liveCont.convertTimeStamp(consData.dateConsStart!),
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

  void confirmationDialog() {
    return showConfirmationDialog(
      dialogTitle: 'Is the consultation done?',
      dialogCaption:
          'Select YES if you want to end the consultation. Otherwise, select NO',
      onYesTap: () {
        liveCont.endConsultation(consData);
      },
      onNoTap: () => dismissDialog(),
    );
  }

  Widget skipDialog(LiveConsultationModel consData) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      clipBehavior: Clip.antiAlias,
      contentPadding: const EdgeInsets.symmetric(
          vertical: kIsWeb ? 30 : 20, horizontal: kIsWeb ? 50 : 25),
      children: [
        SizedBox(
          width: kIsWeb ? Get.width * .45 : Get.width * .7,
          child: Column(
            children: [
              Text(
                'To inform the patient',
                style: kIsWeb ? title32Regular : title20Regular,
              ),
              verticalSpace10,
              const Text(
                'Please specify the reason',
                style: body14Regular,
              ),
              kIsWeb ? verticalSpace50 : verticalSpace25,
              TextFormField(
                  controller: liveCont.reason,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'This is a required field';
                    }
                    //! if we want to validate na dapat taas ang words
                    // if (value.length < 10) {
                    //   return 'Description must be at least 10 words';
                    // }
                  },
                  decoration: const InputDecoration(
                    labelText: 'Enter the reason here',
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                  ),
                  maxLines: 10,
                  keyboardType: TextInputType.multiline,
                  onChanged: (value) {
                    return;
                  },
                  onSaved: (value) {
                    liveCont.reason.text = value!;
                  }),
              kIsWeb ? verticalSpace25 : verticalSpace15,
              Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomButton(
                      buttonColor: verySoftBlueColor,
                      onTap: () => liveCont.skipConsultation(
                            consData.consID!,
                            consData.patientID!,
                          ),
                      //'Cons_Request/${consData.patientID!}/cons_req/${consData.consID!}/'),
                      text: 'Submit')),
            ],
          ),
        )
      ],
    );
  }

  Widget getPhoto(LiveConsultationModel model) {
    if (liveCont.getPatientProfile(model) == '') {
      return CircleAvatar(
        radius: 50,
        backgroundImage: AssetImage(blankProfile),
      );
    }
    return CircleAvatar(
      radius: 50,
      foregroundImage: NetworkImage(liveCont.getPatientProfile(model)),
      backgroundImage: AssetImage(blankProfile),
    );
  }
}
