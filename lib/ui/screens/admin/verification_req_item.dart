import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/core/controllers/navigation_controller.dart';
import 'package:davnor_medicare/core/services/url_launcher_service.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/widgets/admin/custom_button.dart';
import 'package:davnor_medicare/ui/widgets/patient/dialog_button.dart';
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
  final NavigationController navigationController = Get.find();
  final UrlLauncherService _urlLauncherService = UrlLauncherService();

  @override
  Widget phone() => Column(
        children: [
          SizedBox(
            width: Get.width,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              verticalSpace50,
              IconButton(
                  onPressed: () {
                    navigationController.goBack();
                  },
                  icon: Icon(
                    Icons.arrow_back_outlined,
                    size: 30,
                  )),
              verticalSpace20,
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
              verticalSpace50,
              IconButton(
                  onPressed: () {
                    navigationController.goBack();
                  },
                  icon: Icon(
                    Icons.arrow_back_outlined,
                    size: 30,
                  )),
              verticalSpace20,
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
              verticalSpace50,
              IconButton(
                  onPressed: () {
                    navigationController.goBack();
                  },
                  icon: Icon(
                    Icons.arrow_back_outlined,
                    size: 30,
                  )),
              verticalSpace20,
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(grayBlank, fit: BoxFit.cover);
                  },
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
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(grayBlank, fit: BoxFit.cover);
                  },
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      contentPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: SizedBox(
              width: 130,
              child: ErrorDialogButton(
                buttonText: 'Open Image',
                onTap: () async {
                  _urlLauncherService.launchURL(imgURL);
                },
              ),
            ),
          ),
        ),
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
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(grayBlank, fit: BoxFit.cover);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget getPhoto(VerificationReqModel model) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(80),
      child: Image.network(
        vf.getProfilePhoto(model),
        fit: BoxFit.fitWidth,
        height: 80,
        width: 80,
        errorBuilder: (context, error, stackTrace) {
          return Container(
              height: 80,
              width: 80,
              color: verySoftBlueColor[100],
              child: Center(
                child: Text(
                  '${vf.getFirstName(model)[0]}',
                  style: title36Regular.copyWith(color: Colors.white),
                ),
              ));
        },
      ),
    );
  }
}
