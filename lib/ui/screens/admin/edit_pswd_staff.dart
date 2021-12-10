import 'package:davnor_medicare/constants/app_items.dart';
import 'package:davnor_medicare/core/controllers/admin/pswd_staff_list_controller.dart';
import 'package:davnor_medicare/core/controllers/navigation_controller.dart';
import 'package:davnor_medicare/core/models/user_model.dart';
import 'package:davnor_medicare/helpers/validator.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
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
  ResponsiveView(this.model);
  final PswdModel model;
  final RxBool errorPhoto = false.obs;
  final NavigationController navigationController = Get.find();
  final GlobalKey<FormFieldState> epdpKey1 = GlobalKey<FormFieldState>();
  final PSWDStaffListController pListController = Get.find();

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
          onItemTap: () {
            pListController.updatePSWD(model);
          },
          buttonText: 'Save',
        ),
        horizontalSpace40,
        AdminButton(
          onItemTap: () {
            pListController.enableEditing.value = false;
          },
          buttonText: 'Cancel',
        ),
      ],
    );
  }

  Widget userPSWDImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(90),
      child: Image.network(
        pListController.getProfilePhoto(model),
        fit: BoxFit.cover,
        height: 90,
        width: 90,
        errorBuilder: (context, error, stackTrace) {
          return Container(
              height: 90,
              width: 90,
              color: verySoftBlueColor[100],
              child: Center(
                child: Text(
                  '${model.firstName![0]}',
                  style: title36Regular.copyWith(color: Colors.white),
                ),
              ));
        },
      ),
    );
  }

  Widget editInfoofPSWDStaff() {
    pListController.editLastName.text = model.lastName!;
    pListController.editFirstName.text = model.firstName!;
    pListController.editPosition.value = model.position!;

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
            controller: pListController.editLastName,
            enabled: pListController.enableEditing.value,
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
            onSaved: (value) => pListController.editLastName.text = value!,
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
            controller: pListController.editFirstName,
            enabled: pListController.enableEditing.value,
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
            onSaved: (value) => pListController.editFirstName.text = value!,
          ),
        ),
      ),
      const Text(
        'Position',
        style: body14Medium,
      ),
      Obx(
        () => SizedBox(
          width: pListController.enableEditing.value ? 0 : 340,
          height: pListController.enableEditing.value ? 0 : 90,
          child: Visibility(
            visible: !pListController.enableEditing.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace10,
                TextFormField(
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
              ],
            ),
          ),
        ),
      ),
      Obx(
        () => Visibility(
          visible: pListController.enableEditing.value,
          child: SizedBox(
            width: 340,
            height: 90,
            child: CustomDropdown(
              givenKey: epdpKey1,
              hintText: 'Select position',
              dropdownItems: position,
              onChanged: (item) {
                pListController.editPosition.value = item!.name;
              },
              onSaved: (Item? item) =>
                  pListController.editPosition.value = item!.name,
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
          verticalSpace35,
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Edit PSWD Staff Details',
                    textAlign: TextAlign.left, style: title29BoldNeutral80),
                horizontalSpace10,
                Obx(
                  () => IconButton(
                      iconSize: 30,
                      onPressed: () {
                        pListController.enableEditing.value =
                            !pListController.enableEditing.value;
                      },
                      icon: pListController.enableEditing.value
                          ? Icon(Icons.cancel_outlined)
                          : Icon(Icons.edit_outlined)),
                )
              ]),
        ]));
  }
}
