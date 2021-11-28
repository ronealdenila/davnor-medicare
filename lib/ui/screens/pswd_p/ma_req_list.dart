import 'package:davnor_medicare/constants/app_items.dart';
import 'package:davnor_medicare/core/controllers/navigation_controller.dart';
import 'package:davnor_medicare/core/controllers/pswd/ma_req_list_controller.dart';
import 'package:davnor_medicare/core/controllers/pswd/menu_controller.dart';
import 'package:davnor_medicare/core/models/med_assistance_model.dart';
import 'package:davnor_medicare/helpers/validator.dart';
import 'package:davnor_medicare/routes/app_pages.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/widgets/patient/custom_dropdown.dart';
import 'package:davnor_medicare/ui/widgets/patient/custom_text_form_field.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MARequestListScreen extends StatelessWidget {
  final MAReqListController maController = Get.find();
  final RxBool firedOnce = false.obs;
  final NavigationController navigationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        verticalSpace25,
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            MenuController.to.activeItem.value,
            style: title29BoldNeutral80,
          ),
        ),
        verticalSpace50,
        Wrap(
          runSpacing: 10,
          children: <Widget>[
            SizedBox(
              width: 450,
              child: CustomTextFormField(
                controller: maController.maFilter,
                labelText: 'Search here...',
                validator: Validator().notEmpty,
                onChanged: (value) {
                  return;
                },
                onSaved: (value) => maController.maFilter.text = value!,
              ),
            ),
            horizontalSpace18,
            SizedBox(
              width: 280,
              child: CustomDropdown(
                hintText: 'Filter patient type',
                dropdownItems: typeDropdown,
                onChanged: (Item? item) => maController.type.value = item!.name,
                onSaved: (Item? item) => maController.type.value = item!.name,
              ),
            ),
            horizontalSpace18,
            SizedBox(
                height: 50,
                child: ElevatedButton(
                  child: Text('Search'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue[900],
                  ),
                  onPressed: () {
                    maController.filter(
                      name: maController.maFilter.text,
                      type: maController.type.value,
                    );
                  },
                )),
            horizontalSpace18,
            SizedBox(
                height: 50,
                child: ElevatedButton(
                  child: Text('Remove Filter'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue[900],
                  ),
                  onPressed: () {
                    maController.maFilter.clear();
                    maController.type.value = 'All';
                    maController.filteredList
                        .assignAll(maController.maRequests);
                  },
                )),
            horizontalSpace18,
            SizedBox(
                height: 50,
                child: ElevatedButton(
                  child: Icon(
                    Icons.refresh,
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue[900],
                  ),
                  onPressed: () {
                    maController.refresh();
                  },
                )),
          ],
        ),
        verticalSpace25,
        header(),
        Obx(() => requestList(context))
      ],
    );
  }

  requestList(BuildContext context) {
    if (maController.isLoading.value) {
      return Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: const SizedBox(
              height: 24, width: 24, child: CircularProgressIndicator()),
        ),
      );
    }
    if (maController.maRequests.isEmpty && !maController.isLoading.value) {
      return const Text(
        'No on progress MA request at the moment',
        textAlign: TextAlign.center,
        style: body14Medium,
      );
    }
    firedOnce.value
        ? null
        : maController.filteredList.assignAll(maController.maRequests);
    firedOnce.value = true;
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Expanded(
        child: SingleChildScrollView(
          child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: maController.filteredList.length,
              itemBuilder: (context, index) {
                return customTableRow(maController.filteredList[index]);
              }),
        ),
      ),
    );
  }

  Widget header() {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: verySoftBlueColor,
      ),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text('PATIENT NAME',
                    style: body16Bold.copyWith(color: Colors.white)),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text('ADDRESS',
                    style: body16Bold.copyWith(color: Colors.white)),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text('DATE',
                    style: body16Bold.copyWith(color: Colors.white)),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text('PATIENT TYPE',
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

  Widget customTableRow(MARequestModel model) {
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
                  model.fullName!,
                  style: body16Medium,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  model.address!,
                  style: body16Medium,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  maController.convertTimeStamp(model.date_rqstd!),
                  style: body16Medium,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  model.type!,
                  style: body16Medium,
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () => navigationController
                    .navigateToWithArgs(Routes.MA_REQ_ITEM, arguments: model),
                child: Text(
                  'View',
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
