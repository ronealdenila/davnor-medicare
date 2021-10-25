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

class MobileDoctorListScreen extends StatelessWidget {
  static DoctorListController dListController = Get.put(DoctorListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Doctors List',
                    textAlign: TextAlign.left, style: title24BoldNeutral80),
                verticalSpace25,
                SizedBox(
                  width: Get.width * .7,
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
                verticalSpace10,
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
                verticalSpace25,
                header(),
                Obx(() => requestList(context))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget requestList(BuildContext context) {
    if (dListController.isLoading.value) {
      return const SizedBox(
          height: 24, width: 24, child: CircularProgressIndicator());
    }
    if (dListController.doctorList.isEmpty && dListController.isLoading.value) {
      return const Text('No doctors');
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
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xFF063373),
      ),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Expanded(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text('FULLNAME', style: body14SemiBoldWhite),
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text('TITLE', style: body14SemiBoldWhite),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text('ACTION', style: body14SemiBoldWhite),
            )
          ]),
    );
  }

  Widget customTableRow(DoctorModel model) {
    return SizedBox(
      width: Get.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  '${model.lastName!}, ${model.firstName!}',
                  style: body16Medium,
                ),
              ),
            ),
            Expanded(
              flex: 4,
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
              child: InkWell(
                onTap: () {},
                child: Text(
                  'Delete',
                  style: body16RegularUnderlineBlue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
