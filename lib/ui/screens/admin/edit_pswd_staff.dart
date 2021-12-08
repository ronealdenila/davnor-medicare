import 'package:davnor_medicare/constants/app_items.dart';
import 'package:davnor_medicare/core/controllers/admin/pswd_staff_list_controller.dart';
import 'package:davnor_medicare/core/controllers/navigation_controller.dart';
import 'package:davnor_medicare/core/models/user_model.dart';
import 'package:davnor_medicare/helpers/validator.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/widgets/admin/custom_button.dart';
import 'package:davnor_medicare/ui/widgets/patient/custom_dropdown.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class EditPSWDStaffScrenn extends StatelessWidget {
  EditPSWDStaffScrenn({Key? key, required this.passedData}) : super(key: key);
  final PswdModel passedData;
  final PSWDStaffListController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(child: ResponsiveView(passedData))),
    );
  }
}

class ResponsiveView extends GetResponsiveView {
  ResponsiveView(this.model) : super(alwaysUseBuilder: false);
  final PswdModel model;
  final RxBool errorPhoto = false.obs;
  final NavigationController navigationController = Get.find();

  @override
  Widget phone() =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        textTitle(),
        verticalSpace25,
        Column(
          children: <Widget>[
            userPSWDImage(),
            horizontalSpace25,
            editInfoofPSWDStaff(),
          ],
        ),
        verticalSpace25,
        screenButtons(),
      ]);

  @override
  Widget tablet() =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        textTitle(),
        verticalSpace25,
        Column(
          children: <Widget>[
            userPSWDImage(),
            horizontalSpace25,
            editInfoofPSWDStaff(),
          ],
        ),
        verticalSpace25,
        screenButtons(),
      ]);

  @override
  Widget desktop() =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        textTitle(),
        verticalSpace25,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            userPSWDImage(),
            horizontalSpace25,
            editInfoofPSWDStaff(),
          ],
        ),
        verticalSpace15,
        screenButtons(),
      ]);

  Widget screenButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AdminButton(
          onItemTap: () async {
            await controller.updatePSWD(model);
          },
          buttonText: 'Save',
        ),
        horizontalSpace40,
        AdminButton(
          onItemTap: () async {
            controller.enableEditing.value = false;
          },
          buttonText: 'Cancel',
        ),
      ],
    );
  }

  Widget userPSWDImage() {
    return CircleAvatar(
      radius: 40,
      foregroundImage: NetworkImage(controller.getProfilePhoto(model)),
      onForegroundImageError: (_, __) {
        errorPhoto.value = true;
      },
      backgroundColor: Colors.grey,
      child: Obx(
        () => errorPhoto.value
            ? Text(
                '${model.firstName![0]}',
                style: subtitle18Bold,
              )
            : SizedBox(
                height: 0,
                width: 0,
              ),
      ),
    );
  }

  Widget editInfoofPSWDStaff() {
    controller.editLastName.text = model.lastName!;
    controller.editFirstName.text = model.firstName!;
    controller.editPosition.value = model.position!;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      verticalSpace15,
      const Text(
        'Last Name',
        style: body14Medium,
      ),
      verticalSpace10,
      SizedBox(
        width: 340,
        height: 90,
        child: Obx(
          () => TextFormField(
            controller: controller.editLastName,
            enabled: controller.enableEditing.value,
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
            validator: Validator().notEmpty,
            onChanged: (value) {
              return;
            },
            onSaved: (value) => controller.editLastName.text = value!,
          ),
        ),
      ),
      const Text(
        'First Name',
        style: body14Medium,
      ),
      verticalSpace10,
      SizedBox(
        width: 340,
        height: 90,
        child: Obx(
          () => TextFormField(
            controller: controller.editFirstName,
            enabled: controller.enableEditing.value,
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
            validator: Validator().notEmpty,
            onChanged: (value) {
              return;
            },
            onSaved: (value) => controller.editFirstName.text = value!,
          ),
        ),
      ),
      const Text(
        'Position',
        style: body14Medium,
      ),
      verticalSpace10,
      Obx(
        () => SizedBox(
          width: controller.enableEditing.value ? 0 : 340,
          height: controller.enableEditing.value ? 0 : 90,
          child: Visibility(
            visible: !controller.enableEditing.value,
            child: TextFormField(
              initialValue: model.position,
              enabled: false,
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      Obx(
        () => Visibility(
          visible: controller.enableEditing.value,
          child: SizedBox(
            width: 340,
            height: 90,
            child: CustomDropdown(
              hintText: 'Select position',
              dropdownItems: position,
              onChanged: (item) {
                controller.editPosition.value = item!.name;
              },
              onSaved: (Item? item) =>
                  controller.editPosition.value = item!.name,
            ),
          ),
        ),
      ),
    ]);
  }

  Widget textTitle() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          IconButton(
              onPressed: () {
                navigationController.goBack();
              },
              icon: Icon(
                Icons.arrow_back_outlined,
                size: 30,
              )),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Edit PSWD Staff Details',
                    textAlign: TextAlign.left, style: title29BoldNeutral80),
                horizontalSpace80,
                IconButton(
                    iconSize: 30,
                    onPressed: () {
                      controller.enableEditing.value = true;
                    },
                    icon: const Icon(Icons.edit_outlined))
              ]),
        ]));
  }
}
