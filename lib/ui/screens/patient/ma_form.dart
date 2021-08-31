import 'package:davnor_medicare/constants/app_strings.dart';
import 'package:davnor_medicare/core/controllers/app_controller.dart';
import 'package:davnor_medicare/core/models/category_model.dart';
import 'package:davnor_medicare/ui/screens/patient/home.dart';
import 'package:davnor_medicare/ui/screens/patient/ma_description.dart';
import 'package:davnor_medicare/ui/screens/patient/ma_form2.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/widgets/custom_button.dart';
import 'package:davnor_medicare/ui/widgets/patient/custom_dropdown.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:get/get.dart';
import 'package:davnor_medicare/constants/app_items.dart';
//import 'package:dropdown_below/dropdown_below.dart';

class MAFormScreen extends StatelessWidget {
  final AppController appController = AppController.to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: CupertinoNavigationBarBackButton(
          color: Colors.black,
          onPressed: () => Get.to(
            () => MADescriptionScreen(),
            transition: Transition.cupertino,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    width: 255,
                    child: Text(
                      'Patients Information',
                      style: subtitle20Medium,
                    ),
                  ),
                  SizedBox(
                    width: 40,
                    child: InkWell(
                      onTap: () {},
                      child: Icon(
                        Icons.info,
                        size: 28,
                        color: verySoftBlueColor[10],
                      ),
                    ),
                  ),
                ]),
            verticalSpace10,
            Visibility(
              visible: !appController.isMedicalAssistForYou.value,
              //CustomFormField was created for patient global widget
              //please utilize it.
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
            verticalSpace10,
            Visibility(
              visible: !appController.isMedicalAssistForYou.value,
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
            verticalSpace10,
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
            verticalSpace10,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  width: 145,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Age',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
                verticalSpace10,
                SizedBox(
                  width: 180,
                  height: 70,
                  child: CustomDropdown(
                    hintText: 'Select Gender',
                    dropdownItems: gender,
                  ),
                ),
              ],
            ),
            verticalSpace10,
            Align(
              alignment: FractionalOffset.centerLeft,
              child: SizedBox(
                width: screenWidth(context),
                height: 60,
                child: CustomDropdown(
                  hintText: 'Select Type',
                  dropdownItems: type,
                ),
              ),
            ),
            verticalSpace15,
            Visibility(
              visible: !appController.isMedicalAssistForYou.value,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    maFormScreen,
                    style: subtitle20Medium,
                  ),
                  verticalSpace10,
                  DottedBorder(
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(12),
                    padding: const EdgeInsets.all(12),
                    dashPattern: const [8, 8, 8, 8],
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      child: Container(
                        width: screenWidth(context),
                        height: 150,
                        color: neutralColor[10],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {},
                              child: Icon(
                                Icons.file_upload_outlined,
                                size: 67,
                                color: neutralColor[60],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            verticalSpace10,
            //To be achieved: next button must be pinned on bottom right
            //sa current code wala siya na pin
            Align(
              alignment: FractionalOffset.bottomRight,
              child: SizedBox(
                width: 160,
                child: CustomButton(
                  onTap: () {
                    Get.to(() => MAForm2Screen());
                  },
                  text: 'Next',
                  buttonColor: verySoftBlueColor,
                ),
              ),
            ),
            verticalSpace10,
          ]),
        ),
      ),
    );
  }
}