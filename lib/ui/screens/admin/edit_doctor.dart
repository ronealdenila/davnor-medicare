import 'package:davnor_medicare/constants/app_items.dart';
import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/admin/doctor_list_controller.dart';
import 'package:davnor_medicare/core/models/user_model.dart';
import 'package:davnor_medicare/helpers/validator.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/widgets/admin/custom_button.dart';
import 'package:davnor_medicare/ui/widgets/patient/custom_dropdown.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

final DoctorListController controller = Get.find();

class EditDoctorScrenn extends StatelessWidget {
  EditDoctorScrenn({Key? key, required this.passedData}) : super(key: key);
  final DoctorModel passedData;
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
  final DoctorModel model;

  @override
  Widget phone() => Column(
        children: [
          SizedBox(
            height: Get.height,
            width: Get.width,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              textTitle(),
              Column(
                children: <Widget>[
                  horizontalSpace20,
                  editInfoofPSWDStaff(),
                ],
              ),
              verticalSpace25,
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
            ]),
          ),
        ],
      );

  Widget screenButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AdminButton(
          onItemTap: () async {
            controller.updateDoctor(model);
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
    if (controller.getProfilePhoto(model) == '') {
      return CircleAvatar(
        radius: 40,
        backgroundImage: AssetImage(blankProfile),
      );
    }
    return CircleAvatar(
      radius: 40,
      foregroundImage: NetworkImage(controller.getProfilePhoto(model)),
      backgroundImage: AssetImage(blankProfile),
    );
  }

  Widget editInfoofPSWDStaff() {
    controller.editFirstName.text = model.firstName!;
    controller.editLastName.text = model.lastName!;
    controller.editClinicHours.text = model.clinicHours!;
    controller.editTitle.value = model.title!;
    controller.editDepartment.value = model.department!;
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
        'Title',
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
              initialValue: model.title,
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
              hintText: 'Select title',
              dropdownItems: title,
              onChanged: (item) {
                controller.editTitle.value = item!.name;
              },
              onSaved: (Item? item) => controller.editTitle.value = item!.name,
            ),
          ),
        ),
      ),
      const Text(
        'Department',
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
              initialValue: model.department,
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
              hintText: 'Select department',
              dropdownItems: department,
              onChanged: (item) {
                controller.editDepartment.value = item!.name;
              },
              onSaved: (Item? item) =>
                  controller.editDepartment.value = item!.name,
            ),
          ),
        ),
      ),
      const Text(
        'Clinic Hours',
        style: body14Medium,
      ),
      verticalSpace10,
      SizedBox(
        width: 340,
        height: 90,
        child: Obx(
          () => TextFormField(
            controller: controller.editClinicHours,
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
            onSaved: (value) => controller.editClinicHours.text = value!,
          ),
        ),
      ),
    ]);
  }

  Widget textTitle() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Edit Doctor Details',
                textAlign: TextAlign.left, style: title24Bold),
            horizontalSpace80,
            IconButton(
                iconSize: 30,
                onPressed: () {
                  controller.enableEditing.value = true;
                },
                icon: const Icon(Icons.edit_outlined))
          ]),
    );
  }
}
