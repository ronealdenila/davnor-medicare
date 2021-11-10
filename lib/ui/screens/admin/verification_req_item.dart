import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/widgets/admin/custom_button.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:davnor_medicare/core/models/verification_req_model.dart';
import 'package:davnor_medicare/core/controllers/admin/for_verification_controller.dart';
import 'package:get/get.dart';

class VerificationReqItemScreen extends StatelessWidget {
  VerificationReqItemScreen({Key? key, required this.passedData})
      : super(key: key);
  final VerificationReqModel passedData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
          child: SingleChildScrollView(
              child: ResponsiveView(context, passedData))),
    );
  }
}

class ResponsiveView extends GetResponsiveView {
  ResponsiveView(this.context, this.vfModel) : super(alwaysUseBuilder: false);
  final BuildContext context;
  final VerificationReqModel vfModel;
  final ForVerificationController vf = Get.find();

  @override
  Widget phone() => Column(
        children: [
          SizedBox(
            width: Get.width,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              userInfo(),
              Column(
                children: <Widget>[
                  validID(),
                  verticalSpace35,
                  validIDWithSelfie(),
                ],
              ),
              verticalSpace35,
              screenButtons(context)
            ]),
          )
        ],
      );

  @override
  Widget tablet() => Column(
        children: [
          SizedBox(
            width: Get.width,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              userInfo(),
              Column(
                children: <Widget>[
                  validID(),
                  verticalSpace35,
                  validIDWithSelfie(),
                ],
              ),
              verticalSpace35,
              screenButtons(context),
              verticalSpace15
            ]),
          )
        ],
      );

  @override
  Widget desktop() => Column(
        children: [
          SizedBox(
            width: screen.width,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              userInfo(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  validID(),
                  horizontalSpace50,
                  validIDWithSelfie(),
                ],
              ),
              verticalSpace35,
              screenButtons(context),
              verticalSpace15
            ]),
          ),
        ],
      );

  Widget screenButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AdminButton(onItemTap: confirmationDialog, buttonText: 'Verify'),
        horizontalSpace40,
        AdminButton(
            onItemTap: () => showDialog(
                context: context, builder: (context) => declineDialog()),
            buttonText: 'Decline'),
      ],
    );
  }

  void confirmationDialog() {
    return showConfirmationDialog(
      dialogTitle: 'Are you sure?',
      dialogCaption:
          'Select YES if you want to verify this user. Otherwise, select NO',
      onYesTap: () => vf.acceptUserVerification(vfModel),
      onNoTap: () {
        dismissDialog();
      },
    );
  }

  Widget declineDialog() {
    return SimpleDialog(
      contentPadding: const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
      children: [
        SizedBox(
          width: Get.width * .45,
          child: Column(
            children: [
              const Text(
                'To inform the patient',
                style: title32Regular,
              ),
              verticalSpace10,
              const Text(
                'Please specify the reason',
                style: title20Regular,
              ),
              verticalSpace50,
              TextFormField(
                  controller: vf.reason,
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
                    vf.reason.text = value!;
                  }),
              verticalSpace25,
              Align(
                  alignment: Alignment.bottomCenter,
                  child: AdminButton(
                      onItemTap: () => vf.desclineUserVerification(vfModel),
                      buttonText: 'Submit')),
            ],
          ),
        )
      ],
    );
  }

  Widget validID() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Valid ID',
          style: caption12RegularNeutral,
        ),
        verticalSpace15,
        DottedBorder(
          color: customNeutralColor,
          borderType: BorderType.RRect,
          radius: const Radius.circular(5),
          padding: const EdgeInsets.all(5),
          dashPattern: const [7, 7, 7, 7],
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            child: InkWell(
              onTap: () => showDialog(
                  context: context,
                  builder: (context) =>
                      attachedPhotosDialog(vf.getValidID(vfModel))),
              child: Container(
                width: 250,
                height: 150,
                color: neutralColor[10],
                child: Image.network(
                  vf.getValidID(vfModel),
                  height: 106,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget validIDWithSelfie() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Valid ID with Selfie',
          style: caption12RegularNeutral,
        ),
        verticalSpace15,
        DottedBorder(
          color: customNeutralColor,
          borderType: BorderType.RRect,
          radius: const Radius.circular(5),
          padding: const EdgeInsets.all(5),
          dashPattern: const [7, 7, 7, 7],
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            child: InkWell(
              onTap: () => showDialog(
                  context: context,
                  builder: (context) =>
                      attachedPhotosDialog(vf.getValidIDWithSelfie(vfModel))),
              child: Container(
                width: 250,
                height: 150,
                color: neutralColor[10],
                child: Image.network(
                  vf.getValidIDWithSelfie(vfModel),
                  height: 106,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget userInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('FOR ACCOUNT VERIFICATION',
            textAlign: TextAlign.left, style: title24Bold),
        verticalSpace35,
        Row(
          children: [
            getPhoto(vfModel),
            horizontalSpace15,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      'First Name:',
                      style: body14Medium,
                    ),
                    horizontalSpace25,
                    Text(
                      vf.getFirstName(vfModel),
                      style: subtitle18Bold,
                    ),
                  ],
                ),
                verticalSpace5,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      'Last Name:',
                      style: body14Medium,
                    ),
                    horizontalSpace25,
                    Text(
                      vf.getLastName(vfModel),
                      style: subtitle18Bold,
                    ),
                  ],
                ),
                verticalSpace10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      'Date Requested',
                      style: caption12Regular,
                    ),
                    horizontalSpace10,
                    Text(
                      vf.getDateTime(vfModel),
                      style: caption12RegularNeutral,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        verticalSpace50,
        const Text(
          'Attached Photos ',
          style: body14SemiBold,
        ),
        verticalSpace10,
      ],
    );
  }

  Widget attachedPhotosDialog(String imgURL) {
    return SimpleDialog(
      contentPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      children: [
        Container(
          decoration: const BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.all(
                Radius.circular(40),
              )),
          padding: const EdgeInsets.symmetric(vertical: 10),
          height: Get.height * .8,
          child: Container(
            color: Colors.white,
            child: Image.network(
              imgURL,
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
      ],
    );
  }

  Widget getPhoto(VerificationReqModel model) {
    if (vf.getProfilePhoto(model) == '') {
      return CircleAvatar(
        radius: 40,
        backgroundImage: AssetImage(blankProfile),
      );
    }
    return CircleAvatar(
      radius: 40,
      backgroundImage: NetworkImage(vf.getProfilePhoto(model)),
    );
  }

  // Future downloadFile(Reference ref) async {
  //   final dir = await getApplicationDocumentsDirectory();
  //   final file = File('${dir.path}/${ref.name}');

  //   await ref.writeToFile(file);
  // }
}
