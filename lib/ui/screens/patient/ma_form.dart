import 'dart:io';
import 'package:davnor_medicare/constants/app_strings.dart';
//import 'package:davnor_medicare/ui/screens/patient/home.dart';
// import 'package:davnor_medicare/ui/screens/patient/ma_description.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/widgets/custom_button.dart';
import 'package:davnor_medicare/ui/widgets/patient/custom_dropdown.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:get/get.dart';
import 'package:davnor_medicare/constants/app_items.dart';
import 'package:davnor_medicare/core/controllers/patient/ma_req_controller.dart';

class MAFormScreen extends StatelessWidget {
  static MARequestController ma = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const CupertinoNavigationBarBackButton(
          color: Colors.black,
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
                  SizedBox(
                    width: 255,
                    child: Text(
                      'details'.tr,
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
              visible: !ma.isMAForYou.value,
              //CustomFormField was created for patient global widget
              //please utilize it.
              child: TextFormField(
                controller: ma.firstNameController,
                decoration: InputDecoration(
                  labelText: 'maform4'.tr,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                onChanged: (value) {
                  return;
                },
                onSaved: (value) => ma.firstNameController.text = value!,
              ),
            ),
            verticalSpace10,
            Visibility(
              visible: !ma.isMAForYou.value,
              child: TextFormField(
                controller: ma.lastNameController,
                decoration: InputDecoration(
                  labelText: 'maform2'.tr,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
                onChanged: (value) {
                  return;
                },
                onSaved: (value) => ma.lastNameController.text = value!,
              ),
            ),
            verticalSpace10,
            TextFormField(
              controller: ma.addressController,
              decoration: InputDecoration(
                labelText: 'maform3'.tr,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
              onChanged: (value) {
                return;
              },
              onSaved: (value) => ma.addressController.text = value!,
            ),
            verticalSpace10,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  width: 145,
                  child: TextFormField(
                    controller: ma.ageController,
                    decoration:  InputDecoration(
                      labelText: 'maform4'.tr,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      return;
                    },
                    onSaved: (value) => ma.ageController.text = value!,
                  ),
                ),
                verticalSpace10,
                SizedBox(
                  width: 180,
                  height: 70,
                  child: CustomDropdown(
                    hintText: 'maform5'.tr,
                    dropdownItems: gender,
                    onChanged: (Item? item) => ma.gender.value = item!.name,
                    onSaved: (Item? item) => ma.gender.value = item!.name,
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
                  hintText: 'maform6'.tr,
                  dropdownItems: type,
                  onChanged: (Item? item) => ma.type.value = item!.name,
                  onSaved: (Item? item) => ma.type.value = item!.name,
                ),
              ),
            ),
            verticalSpace15,
            Visibility(
              visible: !ma.isMAForYou.value,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'maform7'.tr,
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
                        child: Obx(getValidID),
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
                  onTap: ma.nextButton,
                  text: 'maform9'.tr,
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

  Widget getValidID() {
    if (ma.imgOfValidID.value == '') {
      return InkWell(
        onTap: ma.pickSingleImage,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.file_upload_outlined,
              size: 67,
              color: neutralColor[60],
            ),
            verticalSpace10,
            Text(
              'maform12'.tr,
              style: subtitle18RegularNeutral,
            )
          ],
        ),
      );
    }
    return InkWell(
      onTap: ma.pickSingleImage,
      child: Stack(
        children: [
          kIsWeb
              ? Image.network(ma.imgOfValidID.value)
              : Image.file(
                  File(ma.imgOfValidID.value),
                  width: Get.width,
                  height: Get.height,
                  fit: BoxFit.fill,
                ),
          Positioned(
            right: 5,
            top: 5,
            child: InkWell(
              onTap: () {
                ma.imgOfValidID.value = '';
              },
              child: const Icon(
                Icons.remove_circle,
                size: 30,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
