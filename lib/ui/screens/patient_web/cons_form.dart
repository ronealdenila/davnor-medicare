import 'dart:io';
import 'package:davnor_medicare/constants/app_items.dart';
import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/core/controllers/navigation_controller.dart';
import 'package:davnor_medicare/core/controllers/patient/cons_req_controller.dart';
import 'package:davnor_medicare/helpers/validator.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/widgets/custom_button.dart';
import 'package:davnor_medicare/ui/widgets/patient/custom_dropdown.dart';
import 'package:davnor_medicare/ui/widgets/patient/custom_text_form_field.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_responsive.dart';

class ConsFormWebScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          margin: EdgeInsets.only(top: 30, bottom: 20),
          child: ResponsiveBody(context)),
    );
  }
}

class ResponsiveBody extends GetResponsiveView {
  ResponsiveBody(this.context);
  final BuildContext context;
  final ConsRequestController consController = Get.find();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final NavigationController navigationController = Get.find();

  @override
  Widget? builder() {
    return SingleChildScrollView(
        child: Column(
      children: [
        verticalSpace50,
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
              child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            width: Get.width * .5,
            child: Obx(
              () => Form(
                key: _formKey,
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
                    verticalSpace25,
                    Text(
                      'consform'.tr,
                      style: title32Regular,
                    ),
                    verticalSpace18,
                    DiscomfortCategoryWidget(),
                    verticalSpace35,
                    Text(
                      'consform1'.tr,
                      style: subtitle20Medium,
                    ),
                    verticalSpace10,
                    Wrap(
                      runSpacing: 8,
                      children: [
                        SizedBox(
                          width: 300,
                          child: RadioListTile<bool>(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              'consformii'.tr,
                              style: body16Regular,
                            ),
                            value: true,
                            groupValue: consController.isFollowUp.value,
                            onChanged: (bool? value) =>
                                consController.isFollowUp.value = value!,
                          ),
                        ),
                        SizedBox(
                          width: 300,
                          child: RadioListTile<bool>(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              'consformi'.tr,
                              style: body16Regular,
                            ),
                            value: false,
                            groupValue: consController.isFollowUp.value,
                            onChanged: (bool? value) =>
                                consController.isFollowUp.value = value!,
                          ),
                        ),
                      ],
                    ),
                    verticalSpace18,
                    Text(
                      'consform2'.tr,
                      style: subtitle20Medium,
                    ),
                    verticalSpace10,
                    Visibility(
                      visible: !consController.isConsultForYou.value,
                      child: CustomTextFormField(
                        controller: consController.firstNameController,
                        labelText: 'consform8'.tr,
                        validator: Validator().notEmpty,
                        onChanged: (value) {
                          return;
                        },
                        onSaved: (value) =>
                            consController.firstNameController.text = value!,
                      ),
                    ),
                    verticalSpace10,
                    Visibility(
                      visible: !consController.isConsultForYou.value,
                      child: CustomTextFormField(
                        controller: consController.lastNameController,
                        labelText: 'consform9'.tr,
                        validator: Validator().notEmpty,
                        onChanged: (value) {
                          return;
                        },
                        onSaved: (value) =>
                            consController.lastNameController.text = value!,
                      ),
                    ),
                    verticalSpace10,
                    Row(
                      children: [
                        SizedBox(
                          width: 160,
                          child: CustomTextFormField(
                            controller: consController.ageController,
                            labelText: 'consform3'.tr,
                            validator: Validator().number,
                            keyboardType: TextInputType.number,
                            //* for improvement: pwede ta pag click sa done
                            //* magsubmit na ang form
                            textInputAction: TextInputAction.done,
                            onChanged: (value) {
                              return;
                            },
                            onSaved: (value) =>
                                consController.ageController.text = value!,
                          ),
                        ),
                        horizontalSpace10,
                        SizedBox(
                          width: 160,
                          child: CustomDropdown(
                            hintText: 'Type', //TRANSLATE
                            dropdownItems: cSenior,
                            onChanged: (Item? item) =>
                                consController.typeP.value = item!.name,
                            onSaved: (Item? item) =>
                                consController.typeP.value = item!.name,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        verticalSpace35,
                        Text(
                          'consform13'.tr,
                          style: subtitle18Regular,
                        ),
                        verticalSpace18,
                        TextFormField(
                            controller: consController.descriptionController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'This is a required field';
                              }
                            },
                            decoration: InputDecoration(
                              labelText: 'consformlabel'.tr,
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
                              consController.descriptionController.text =
                                  value!;
                            }),
                        verticalSpace18,
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )),
          Obx(forFollowUp)
        ]),
        verticalSpace25,
        Align(
          alignment: FractionalOffset.bottomRight,
          child: Container(
            margin: EdgeInsets.only(right: 30),
            width: 300,
            child: SizedBox(
              width: 211,
              child: CustomButton(
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    await consController.submitConsultRequestWeb();
                  }
                },
                text: 'consform19'.tr,
                buttonColor: verySoftBlueColor,
              ),
            ),
          ),
        ),
      ],
    ));
  }

  Widget forFollowUp() {
    if (consController.isFollowUp.value) {
      return Container(
        width: 0,
        height: 0,
      );
    }
    return Expanded(
      child: Container(
        width: Get.width * .5,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'consform16'.tr,
                    style: title32Regular,
                  ),
                  verticalSpace50,
                  Text(
                    'consform17'.tr,
                    style: subtitle18Regular,
                  ),
                  verticalSpace20,
                  DottedBorder(
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(12),
                    padding: const EdgeInsets.all(12),
                    dashPattern: const [8, 8, 8, 8],
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      child: LayoutBuilder(builder:
                          (BuildContext context, BoxConstraints constraints) {
                        return Container(
                          width: Get.width,
                          color: neutralColor[10],
                          child: Obx(getPrescriptionAndLabResults),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getPrescriptionAndLabResults() {
    final images = consController.images;
    if (images.isEmpty) {
      return InkWell(
        onTap: consController.pickForFollowUpImagess,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
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
                'consform18'.tr,
                style: subtitle18RegularNeutral,
              )
            ],
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(8),
      child: GridView.count(
        shrinkWrap: true,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        crossAxisCount: 3,
        children: List.generate(images.length + 1, (index) {
          if (index == consController.images.length) {
            return Center(
              child: IconButton(
                icon: const Icon(
                  Icons.add_circle_outline_rounded,
                ),
                color: verySoftBlueColor[100],
                iconSize: 45,
                onPressed: consController.pickForFollowUpImagess,
              ),
            );
          }
          return Stack(
            children: [
              kIsWeb
                  ? Image.network(images[index].path)
                  : Image.file(
                      File(images[index].path),
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
                    consController.images.remove(images[index]);
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
    );
  }
}

class DiscomfortCategoryWidget extends GetView<ConsRequestController> {
  final ConsRequestController consController = Get.find();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: discomfortData.length,
        itemBuilder: (ctx, index) {
          return Obx(
            () => Card(
              color: consController.selectedIndex.value == index
                  ? verySoftBlueColor[10]
                  : Colors.white,
              child: InkWell(
                onTap: () => consController.toggleSingleCardSelection(index),
                child: SizedBox(
                  height: 130,
                  width: 130,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 55,
                          width: 55,
                          child: Image.asset(
                            discomfortData[index].iconPath!,
                          ),
                        ),
                        verticalSpace5,
                        Text(
                          '${discomfortData[index].title!}'.tr,
                          style: body16Regular,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
