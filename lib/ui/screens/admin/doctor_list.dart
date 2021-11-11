import 'package:davnor_medicare/constants/app_items.dart';
import 'package:davnor_medicare/core/controllers/admin/doctor_list_controller.dart';
import 'package:davnor_medicare/core/models/user_model.dart';
import 'package:davnor_medicare/helpers/validator.dart';
import 'package:davnor_medicare/routes/app_pages.dart';
import 'package:davnor_medicare/ui/screens/admin/helpers/local_navigator.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/widgets/patient/custom_dropdown.dart';
import 'package:davnor_medicare/ui/widgets/patient/custom_text_form_field.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoctorListScreen extends StatelessWidget {
  static DoctorListController dListController = Get.put(DoctorListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Doctors List',
                textAlign: TextAlign.left, style: title24BoldNeutral80),
            verticalSpace50,
            Wrap(
              runSpacing: 10,
              children: <Widget>[
                SizedBox(
                  width: 450,
                  child: CustomTextFormField(
                    controller: dListController.docFilter,
                    labelText: 'Search doctor name here...',
                    validator: Validator().notEmpty,
                    onChanged: (value) {
                      return;
                    },
                    onSaved: (value) => dListController.docFilter.text = value!,
                  ),
                ),
                horizontalSpace18,
                SizedBox(
                  width: 250,
                  child: CustomDropdown(
                    hintText: 'Select doctor title',
                    dropdownItems: titleDropdown,
                    onChanged: (Item? item) {
                      dListController.title.value = item!.name;
                    },
                    onSaved: (Item? item) =>
                        dListController.title.value = item!.name,
                  ),
                ),
                horizontalSpace18,
                SizedBox(
                  width: 300,
                  child: CustomDropdown(
                    hintText: 'Select doctor department',
                    dropdownItems: deptDropdown,
                    onChanged: (Item? item) {
                      dListController.department.value = item!.name;
                    },
                    onSaved: (Item? item) =>
                        dListController.department.value = item!.name,
                  ),
                ),
                horizontalSpace18,
                SizedBox(
                    height: 52,
                    child: ElevatedButton(
                      child: Text('Search'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue[900],
                      ),
                      onPressed: () {
                        dListController.filter(
                            name: dListController.docFilter.text,
                            title: dListController.title.value,
                            dept: dListController.department.value);
                      },
                    )),
                horizontalSpace10,
                SizedBox(
                    height: 52,
                    child: ElevatedButton(
                      child: Text('Remove Filter'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue[900],
                      ),
                      onPressed: () {
                        dListController.docFilter.clear();
                        dListController.title.value = '';
                        dListController.department.value = '';
                        dListController.doctorList
                            .assignAll(dListController.filteredDoctorList);
                      },
                    )),
                //IconButton(onPressed: (){}, icon: Ico)
              ],
            ),
            verticalSpace25,
            header(),
            Obx(() => requestList(context))
          ],
        ),
      ),
    );
  }

  Widget requestList(BuildContext context) {
    if (dListController.isLoading.value) {
      return const SizedBox(
          height: 24, width: 24, child: CircularProgressIndicator());
    }
    if (dListController.doctorList.isEmpty &&
        !dListController.isLoading.value) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: const Text(
          'No doctors',
          textAlign: TextAlign.center,
        ),
      );
    }
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: dListController.doctorList.length,
          itemBuilder: (context, index) {
            return customTableRow(dListController.doctorList[index]);
          }),
    );
  }

  Widget header() {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFF063373),
      ),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text('FULLNAME',
                    style: body16Bold.copyWith(color: Colors.white)),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text('TITLE',
                    style: body16Bold.copyWith(color: Colors.white)),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text('DEPARTMENT',
                    style: body16Bold.copyWith(color: Colors.white)),
              ),
            ),
            Expanded(
              child: Text('ACTION',
                  style: body16Bold.copyWith(color: Colors.white)),
            )
          ]),
    );
  }

  Widget customTableRow(DoctorModel model) {
    return SizedBox(
      width: Get.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  '${model.lastName!}, ${model.firstName!}',
                  style: body16Medium,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  model.title!,
                  style: body16Medium,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  model.department!,
                  style: body16Medium,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Wrap(
                  runSpacing: 8,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        navigationController.navigateToWithArgs(
                            Routes.EDIT_DOCTOR,
                            arguments: model);
                      },
                      child: Text(
                        'View',
                        style: body16RegularUnderlineBlue,
                      ),
                    ),
                    horizontalSpace15,
                    InkWell(
                      onTap: () {
                        dListController.enableEditing.value = true;
                        navigationController.navigateToWithArgs(
                            Routes.EDIT_DOCTOR,
                            arguments: model);
                      },
                      child: Text(
                        'Edit',
                        style: body16RegularUnderlineBlue,
                      ),
                    ),
                    horizontalSpace15,
                    InkWell(
                      onTap: () {
                        //TO DO: ADD DIALOG CONFIRMATION MUNA
                        //onTapYes -> function
                        dListController.disableDoctor(model.userID!);
                        //onTapNo -> dismissdialog();
                      },
                      child: Text(
                        'Disable',
                        style: body16RegularUnderlineBlue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
