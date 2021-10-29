import 'package:davnor_medicare/constants/app_strings.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/widgets/custom_button.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PSWDStaffRegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(child: ResponsiveView())),
    );
  }
}

class ResponsiveView extends GetResponsiveView {
  ResponsiveView() : super(alwaysUseBuilder: false);

  //TODO(R): Try to achieve phone and tablet must have same view
  @override
  Widget phone() => Column(
        children: [
          SizedBox(
            height: Get.height,
            width: Get.width,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              pswdInfo(),
              verticalSpace35,
              Column(
                children: <Widget>[
                  regPSWDInfo(),
                  verticalSpace35,
                  regPSWDInfop(),
                ],
              ),
              verticalSpace35,
              screenButtons()
            ]),
          )
        ],
      );

  @override
  Widget tablet() => Column(
        children: [
          SizedBox(
            height: Get.height,
            width: Get.width,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              pswdInfo(),
              verticalSpace35,
              Column(
                children: <Widget>[
                  regPSWDInfo(),
                  verticalSpace35,
                  regPSWDInfop(),
                ],
              ),
              verticalSpace35,
              screenButtons()
            ]),
          )
        ],
      );

  @override
  Widget desktop() => Column(
        children: [
          SizedBox(
            height: Get.height,
            width: screen.width,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              pswdInfo(),
              verticalSpace35,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  regPSWDInfo(),
                  horizontalSpace80,
                  regPSWDInfop(),
                ],
              ),
              verticalSpace35,
              screenButtons()
            ]),
          ),
        ],
      );

  Widget screenButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CustomButton(
          onTap: () async {},
          text: 'ADD',
          buttonColor: Colors.blue[900],
          fontSize: 15,
        ),
        horizontalSpace40,
        CustomButton(
          onTap: () async {},
          text: 'Cancel',
          buttonColor: Colors.blue[900],
          fontSize: 15,
        ),
      ],
    );
  }

  Widget regPSWDInfo() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text(
        'Last Name',
        style: body14Medium,
      ),
      verticalSpace15,
      SizedBox(
        width: 340,
        height: 90,
        child: TextFormField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
        ),
      ),
      const Text(
        'First Name',
        style: body14Medium,
      ),
      verticalSpace15,
      SizedBox(
        width: 340,
        height: 90,
        child: TextFormField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
        ),
      ),
      const Text(
        'Email Address',
        style: body14Medium,
      ),
      verticalSpace15,
      SizedBox(
        width: 340,
        height: 90,
        child: TextFormField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
        ),
      ),
    ]);
  }

  Widget regPSWDInfop() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text(
        'Position',
        style: body14Medium,
      ),
      verticalSpace15,
      SizedBox(
        width: 340,
        height: 90,
        child: TextFormField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
        ),
      ),
    ]);
  }

  Widget pswdInfo() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('PSWD Staff Registration Form ',
              textAlign: TextAlign.left, style: title24Bold),
          verticalSpace10,
          Text(pswdStaffRegister,
              textAlign: TextAlign.left, style: body16SemiBold),
        ]);
  }
}
