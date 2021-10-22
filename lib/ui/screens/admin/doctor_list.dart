import 'package:davnor_medicare/constants/app_items.dart';
import 'package:davnor_medicare/core/controllers/admin/doctor_list_controller.dart';
import 'package:davnor_medicare/core/models/user_model.dart';
import 'package:davnor_medicare/helpers/validator.dart';
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
            Row(
              children: [
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
                    dropdownItems: title,
                    onChanged: (Item? item) =>
                        dListController.title.value = item!.name,
                    onSaved: (Item? item) =>
                        dListController.title.value = item!.name,
                  ),
                ),
                //IconButton(onPressed: (){}, icon: Ico)
              ],
            ),
            header(),
            Obx(requestList)
          ],
        ),
      ),
    );
  }

  Widget requestList() {
    if (dListController.isLoading.value) {
      return const SizedBox(
          height: 24, width: 24, child: CircularProgressIndicator());
    }
    if (dListController.doctorList.isEmpty) {
      return const Text('No doctors');
    }
    return ListView.builder(
        shrinkWrap: true,
        itemCount: dListController.doctorList.length,
        itemBuilder: (context, index) {
          return customTableRow(dListController.doctorList[index]);
        });
  }

  Widget header() {
    return Container(
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFF063373),
      ),
      child: Row(children: const [
        Text('FULLNAME', style: subtitle18BoldWhite),
        Text('TITLE', style: subtitle18BoldWhite),
        Text('DEPARTMENT', style: subtitle18BoldWhite),
        Text('ACTION', style: subtitle18BoldWhite)
      ]),
    );
  }

  Widget customTableRow(DoctorModel model) {
    return Row(
      children: [
        //Text('${model.lastName!}, ${model.firstName!}'),
        //Text(model.department!),
        Expanded(
          child: Text(
            'Rosello, Courtney Love Queen',
            style: body16Medium,
          ),
        ),
        Expanded(
          child: Text(
            'Internal Medicine Department',
            style: body16Medium,
          ),
        ),
        Expanded(
          child: Text(
            'Otolaryngologist (ENT)',
            style: body16Medium,
          ),
        ),
        //Text(model.title!),
        SizedBox(
          width: 200,
          child: Row(
            children: [
              TextButton(
                  onPressed: () {},
                  child: Text(
                    'View',
                    style: body16RegularUnderlineBlue,
                  )),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    'Edit',
                    style: body16RegularUnderlineBlue,
                  )),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    'Delete',
                    style: body16RegularUnderlineBlue,
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
