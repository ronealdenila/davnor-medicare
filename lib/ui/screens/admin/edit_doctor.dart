import 'package:davnor_medicare/constants/app_items.dart';
import 'package:davnor_medicare/core/controllers/admin/doctor_list_controller.dart';
import 'package:davnor_medicare/core/controllers/app_controller.dart';
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

class EditDoctorScrenn extends StatelessWidget {
  EditDoctorScrenn({Key? key, required this.passedData}) : super(key: key);
  final DoctorModel passedData;
  final AppController appController = Get.find();

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
  final DoctorModel model;
  final RxBool errorPhoto = false.obs;
  final NavigationController navigationController = Get.find();
  final GlobalKey<FormFieldState> eddpKey1 = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> eddpKey2 = GlobalKey<FormFieldState>();
  final DoctorListController dListController = Get.find();

  @override
  Widget phone() =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        textTitle(),
        verticalSpace25,
        Column(
          children: <Widget>[
            userDoctorImage(),
            horizontalSpace25,
            editInfoDoc(),
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
            userDoctorImage(),
            horizontalSpace25,
            editInfoDoc(),
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
            userDoctorImage(),
            horizontalSpace25,
            editInfoDoc(),
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
            await dListController.updateDoctor(model);
          },
          buttonText: 'Save',
        ),
        horizontalSpace40,
        AdminButton(
          onItemTap: () async {
            dListController.enableEditing.value = false;
          },
          buttonText: 'Cancel',
        ),
      ],
    );
  }

  Widget userDoctorImage() {
    return CircleAvatar(
      radius: 40,
      foregroundImage: NetworkImage(dListController.getProfilePhoto(model)),
      onForegroundImageError: (_, __) {
        errorPhoto.value = true;
      },
      backgroundColor: verySoftBlueColor[100],
      child: Obx(
        () => errorPhoto.value
            ? Text(
                '${model.firstName![0]}',
                style: title24Regular.copyWith(color: Colors.white),
              )
            : SizedBox(
                height: 0,
                width: 0,
              ),
      ),
    );
  }

  Widget editInfoDoc() {
    dListController.editFirstName.text = model.firstName!;
    dListController.editLastName.text = model.lastName!;
    dListController.editClinicHours.text = model.clinicHours!;
    dListController.editTitle.value = model.title!;
    dListController.editDepartment.value = model.department!;

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
            controller: dListController.editLastName,
            enabled: dListController.enableEditing.value,
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
            onSaved: (value) => dListController.editLastName.text = value!,
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
            controller: dListController.editFirstName,
            enabled: dListController.enableEditing.value,
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
            onSaved: (value) => dListController.editFirstName.text = value!,
          ),
        ),
      ),
      const Text(
        'Title',
        style: body14Medium,
      ),
      Obx(
        () => SizedBox(
          width: dListController.enableEditing.value ? 0 : 340,
          height: dListController.enableEditing.value ? 0 : 90,
          child: Visibility(
            visible: !dListController.enableEditing.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace10,
                TextFormField(
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
              ],
            ),
          ),
        ),
      ),
      Obx(
        () => Visibility(
          visible: dListController.enableEditing.value,
          child: SizedBox(
            width: 340,
            height: 90,
            child: CustomDropdown(
              givenKey: eddpKey1,
              hintText: 'Select title',
              dropdownItems: title,
              onChanged: (item) {
                dListController.editTitle.value = item!.name;
              },
              onSaved: (Item? item) =>
                  dListController.editTitle.value = item!.name,
            ),
          ),
        ),
      ),
      const Text(
        'Department',
        style: body14Medium,
      ),
      Obx(
        () => SizedBox(
          width: dListController.enableEditing.value ? 0 : 340,
          height: dListController.enableEditing.value ? 0 : 90,
          child: Visibility(
            visible: !dListController.enableEditing.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace10,
                TextFormField(
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
              ],
            ),
          ),
        ),
      ),
      Obx(
        () => Visibility(
          visible: dListController.enableEditing.value,
          child: SizedBox(
            width: 340,
            height: 90,
            child: CustomDropdown(
              givenKey: eddpKey2,
              hintText: 'Select department',
              dropdownItems: department,
              onChanged: (item) {
                dListController.editDepartment.value = item!.name;
              },
              onSaved: (Item? item) =>
                  dListController.editDepartment.value = item!.name,
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
            controller: dListController.editClinicHours,
            enabled: dListController.enableEditing.value,
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
            onSaved: (value) => dListController.editClinicHours.text = value!,
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
              Text('Edit Doctor Details',
                  textAlign: TextAlign.left, style: title29BoldNeutral80),
              horizontalSpace10,
              Obx(
                () => IconButton(
                    iconSize: 30,
                    onPressed: () {
                      dListController.enableEditing.value =
                          !dListController.enableEditing.value;
                    },
                    icon: dListController.enableEditing.value
                        ? Icon(Icons.cancel_outlined)
                        : Icon(Icons.edit_outlined)),
              )
            ]),
      ]),
    );
  }
}
