import 'package:davnor_medicare/constants/app_items.dart';
import 'package:davnor_medicare/core/controllers/admin/pswd_staff_list_controller.dart';
import 'package:davnor_medicare/core/models/user_model.dart';
import 'package:davnor_medicare/helpers/validator.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/widgets/patient/custom_dropdown.dart';
import 'package:davnor_medicare/ui/widgets/patient/custom_text_form_field.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PSWDStaffListScreen extends StatelessWidget {
  static PSWDStaffListController pListController =
      Get.put(PSWDStaffListController());

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
            Text('PSWD Staff List',
                textAlign: TextAlign.left, style: title24BoldNeutral80),
            verticalSpace50,
            Wrap(
              runSpacing: 10,
              children: <Widget>[
                SizedBox(
                  width: 450,
                  child: CustomTextFormField(
                    controller: pListController.pswdFilter,
                    labelText: 'Search name here...',
                    validator: Validator().notEmpty,
                    onChanged: (value) {
                      if (pListController.pswdFilter.text.isEmpty) {
                        pListController.pswdList
                            .assignAll(pListController.filteredPswdList);
                      }
                    },
                    onSaved: (value) =>
                        pListController.pswdFilter.text = value!,
                  ),
                ),
                horizontalSpace18,
                SizedBox(
                  width: 250,
                  child: CustomDropdown(
                    hintText: 'Select position',
                    dropdownItems: position,
                    onChanged: (item) {
                      pListController.position.value = item!.name;
                      if (pListController.position.value == '') {
                        pListController.pswdList
                            .assignAll(pListController.filteredPswdList);
                        pListController.pswdFilter.clear();
                      }
                    },
                    onSaved: (Item? item) =>
                        pListController.position.value = item!.name,
                  ),
                ),
                horizontalSpace18,
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.10,
                    width: 100,
                    child: ElevatedButton(
                      child: Text('Search'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue[900],
                      ),
                      onPressed: () {
                        if (pListController.pswdFilter.text.isEmpty &&
                            pListController.position.value == '') {
                        } else {
                          pListController.filter(
                              name: pListController.pswdFilter.text,
                              title: pListController.position.value);
                        }
                      },
                    ))
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
    if (pListController.isLoading.value) {
      return const SizedBox(
          height: 24, width: 24, child: CircularProgressIndicator());
    }
    if (pListController.pswdList.isEmpty && pListController.isLoading.value) {
      return const Text('No PSWD Staff');
    }
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: pListController.pswdList.length,
          itemBuilder: (context, index) {
            return customTableRow(pListController.pswdList[index]);
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text('FULLNAME',
                    style: body16Bold.copyWith(color: Colors.white)),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text('POSITION',
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

  Widget customTableRow(PswdModel model) {
    return SizedBox(
      width: Get.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  '${model.lastName!}, ${model.firstName!}',
                  style: body16Medium,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  model.position!,
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
                      onTap: () {},
                      child: Text(
                        'View',
                        style: body16RegularUnderlineBlue,
                      ),
                    ),
                    horizontalSpace15,
                    InkWell(
                      onTap: () {},
                      child: Text(
                        'Edit',
                        style: body16RegularUnderlineBlue,
                      ),
                    ),
                    horizontalSpace15,
                    InkWell(
                      onTap: () {
                        pListController.disablePSWDStaff(model.email!);
                        //Change to userID instead of email
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
