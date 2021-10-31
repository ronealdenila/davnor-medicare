import 'package:davnor_medicare/constants/app_items.dart';
import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/core/controllers/admin/pswd_staff_list_controller.dart';
import 'package:davnor_medicare/core/models/user_model.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/widgets/admin/custom_button.dart';
import 'package:davnor_medicare/ui/widgets/patient/custom_dropdown.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

final PSWDStaffListController controller = Get.find();

class EditPSWDStaffScrenn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: SingleChildScrollView(child: ResponsiveView())),
      ),
    );
  }
}

class ResponsiveView extends GetResponsiveView {
  ResponsiveView() : super(alwaysUseBuilder: false);
  final PswdModel model = Get.arguments as PswdModel;

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
            //update data of PSWD
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
      backgroundImage: NetworkImage(controller.getProfilePhoto(model)),
    );
  }

  Widget editInfoofPSWDStaff() {
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
            enabled: controller.enableEditing.value,
            initialValue: model.lastName,
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
            enabled: controller.enableEditing.value,
            initialValue: model.firstName,
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
              enabled: false,
              initialValue: model.position,
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
      padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Edit PSWD Staff Details',
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
