import 'package:davnor_medicare/core/controllers/patient/cons_req_controller.dart';
import 'package:davnor_medicare/ui/screens/patient/cons_form3.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/widgets/custom_button.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConsForm2Screen extends GetView<ConsRequestController> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: const CupertinoNavigationBarBackButton(
          color: Colors.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Almost there!',
                style: title40Regular,
              ),
              verticalSpace50,
              const Text(
                'Tell us more about the discomfort',
                style: subtitle18Regular,
              ),
              verticalSpace18,
              TextFormField(
                  controller: controller.descriptionController,
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
                    labelText: 'Enter your description here',
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                  ),
                  maxLines: 6,
                  keyboardType: TextInputType.multiline,
                  onChanged: (value) {
                    return;
                  },
                  onSaved: (value) {
                    controller.descriptionController.text = value!;
                  }),
              verticalSpace18,
              Visibility(
                visible: !controller.isFollowUp.value,
                child: Align(
                  child: SizedBox(
                    width: 211,
                    child: CustomButton(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          await controller.submitConsultRequest();
                        }
                      },
                      text: 'Consult Now',
                      buttonColor: verySoftBlueColor,
                    ),
                  ),
                ),
              ),
              verticalSpace25,
              Visibility(
                visible: controller.isFollowUp.value,
                child: Expanded(
                  child: Align(
                    alignment: FractionalOffset.bottomRight,
                    child: SizedBox(
                      width: 162,
                      child: CustomButton(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            await Get.to(() => ConsForm3Screen());
                          }
                        },
                        text: 'Next',
                        buttonColor: verySoftBlueColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
