import 'dart:io';
import 'package:davnor_medicare/constants/app_items.dart';
import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/core/controllers/app_controller.dart';
import 'package:davnor_medicare/core/controllers/navigation_controller.dart';
import 'package:davnor_medicare/core/controllers/patient/ma_req_controller.dart';
import 'package:davnor_medicare/helpers/validator.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/widgets/custom_button.dart';
import 'package:davnor_medicare/ui/widgets/patient/custom_dropdown.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_responsive.dart';

class MAFormWebScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveBody(context),
    );
  }
}

class ResponsiveBody extends GetResponsiveView {
  ResponsiveBody(this.context);
  final BuildContext context;
  final MARequestController ma =
      Get.put(MARequestController(), permanent: true);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final NavigationController navigationController = Get.find();
  final AppController appController = Get.find();
  final GlobalKey<FormFieldState> mafdpKey1 = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> mafdpKey2 = GlobalKey<FormFieldState>();

  @override
  Widget? builder() {
    return SingleChildScrollView(
        child: Form(
      key: _formKey,
      child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              verticalSpace50,
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Expanded(
                    child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  width: Get.width * .5,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () {
                              navigationController.goBack();
                            },
                            icon: Icon(
                              Icons.arrow_back_outlined,
                              size: 30,
                            )),
                        verticalSpace5,
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Flexible(
                                child: SizedBox(
                                  child: Text(
                                    'details'.tr,
                                    style: subtitle20Medium,
                                  ),
                                ),
                              ),
                            ]),
                        verticalSpace10,
                        Visibility(
                          visible: !ma.isMAForYou.value,
                          child: TextFormField(
                            controller: ma.firstNameController,
                            decoration: InputDecoration(
                              labelText: 'maform1'.tr,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              return;
                            },
                            onSaved: (value) =>
                                ma.firstNameController.text = value!,
                            validator: Validator().notEmpty,
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
                            onSaved: (value) =>
                                ma.lastNameController.text = value!,
                            validator: Validator().notEmpty,
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
                          onSaved: (value) =>
                              ma.addressController.text = value!,
                          validator: Validator().notEmpty,
                        ),
                        verticalSpace10,
                        Align(
                          alignment: FractionalOffset.centerLeft,
                          child: CustomDropdown(
                            givenKey: mafdpKey1,
                            hintText: 'maform6'.tr,
                            dropdownItems: type,
                            onChanged: (Item? item) =>
                                ma.type.value = item!.name,
                            onSaved: (Item? item) => ma.type.value = item!.name,
                          ),
                        ),
                        verticalSpace10,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: SizedBox(
                                child: TextFormField(
                                  controller: ma.ageController,
                                  decoration: InputDecoration(
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
                                  onSaved: (value) =>
                                      ma.ageController.text = value!,
                                  validator: Validator().number,
                                ),
                              ),
                            ),
                            horizontalSpace10,
                            Expanded(
                              child: SizedBox(
                                height: 70,
                                child: CustomDropdown(
                                  givenKey: mafdpKey2,
                                  hintText: 'maform5'.tr,
                                  dropdownItems: gender,
                                  onChanged: (Item? item) =>
                                      ma.gender.value = item!.name,
                                  onSaved: (Item? item) =>
                                      ma.gender.value = item!.name,
                                ),
                              ),
                            ),
                          ],
                        ),
                        verticalSpace20,
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
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12)),
                                  child: Container(
                                    width: Get.width,
                                    color: neutralColor[10],
                                    child: Obx(getValidID),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                )),
                Expanded(
                  child: Container(
                    width: Get.width * .5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'maform10'.tr,
                            style: title32Regular,
                          ),
                          verticalSpace20,
                          Text(
                            'maform11'.tr,
                            style: subtitle18Regular,
                          ),
                          verticalSpace25,
                          DottedBorder(
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(12),
                            padding: const EdgeInsets.all(12),
                            dashPattern: const [8, 8, 8, 8],
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                              child: LayoutBuilder(builder:
                                  (BuildContext context,
                                      BoxConstraints constraints) {
                                return Container(
                                  width: Get.width,
                                  color: neutralColor[10],
                                  child: Obx(getPrescription),
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ]),
              verticalSpace25,
              Align(
                alignment: FractionalOffset.bottomRight,
                child: Container(
                  margin: EdgeInsets.only(right: 30),
                  width: 300,
                  child: CustomButton(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        await ma.webMARequest();
                        appController.resetDropDown(mafdpKey1);
                        appController.resetDropDown(mafdpKey2);
                      }
                    },
                    text: 'maform13'.tr,
                    buttonColor: verySoftBlueColor,
                  ),
                ),
              ),
            ],
          )),
    ));
  }

  Widget getValidID() {
    if (ma.imgOfValidID.value == '') {
      return InkWell(
        onTap: ma.pickSingleImage,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 80),
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
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(grayBlank, fit: BoxFit.cover);
                  },
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

  Widget getPrescription() {
    if (ma.images.isEmpty) {
      return InkWell(
        onTap: ma.pickMultiImageS,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 80),
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
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Obx(
        () => GridView.count(
          shrinkWrap: true,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          crossAxisCount: 3,
          children: List.generate(ma.images.length + 1, (index) {
            if (index == ma.images.length) {
              return Center(
                child: IconButton(
                  icon: const Icon(
                    Icons.add_circle_outline_rounded,
                  ),
                  color: verySoftBlueColor[100],
                  iconSize: 45,
                  onPressed: ma.pickMultiImageS,
                ),
              );
            }
            return Stack(
              children: [
                kIsWeb
                    ? Image.network(ma.images[index].path)
                    : Image.file(
                        File(ma.images[index].path),
                        width: 140,
                        height: 140,
                        fit: BoxFit.fill,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(grayBlank, fit: BoxFit.cover);
                        },
                      ),
                Positioned(
                  right: 5,
                  top: 5,
                  child: InkWell(
                    onTap: () {
                      ma.images.removeAt(index);
                    },
                    child: const Icon(
                      Icons.remove_circle,
                      size: 25,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
