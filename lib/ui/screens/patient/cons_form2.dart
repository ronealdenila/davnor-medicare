import 'package:davnor_medicare/core/controllers/cons_controller.dart';
import 'package:davnor_medicare/helpers/validator.dart';
import 'package:davnor_medicare/ui/screens/patient/cons_form3.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:davnor_medicare/ui/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:very_good_analysis/very_good_analysis.dart';

class ConsForm2Screen extends StatelessWidget {
  final ConsController consController = Get.put(ConsController());

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
                  controller: consController.descriptionController,
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
                    consController.descriptionController.text = value!;
                  }),
              verticalSpace18,
              Visibility(
                visible: !consController.isFollowUp.value,
                child: Align(
                  child: SizedBox(
                    width: 211,
                    child: CustomButton(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          await consController.submitNewConsult();
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
                visible: consController.isFollowUp.value,
                child: Expanded(
                  child: Align(
                    alignment: FractionalOffset.bottomRight,
                    child: SizedBox(
                      width: 162,
                      child: CustomButton(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            await Get.to(ConsForm3Screen());
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
