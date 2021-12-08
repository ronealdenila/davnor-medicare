import 'package:davnor_medicare/constants/app_items.dart';
import 'package:davnor_medicare/core/controllers/ma_history_controller.dart';
import 'package:davnor_medicare/core/controllers/pswd/menu_controller.dart';
import 'package:davnor_medicare/core/controllers/navigation_controller.dart';
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

class MAHistoryList extends StatelessWidget {
  final MAHistoryController hController = Get.put(MAHistoryController());
  final NavigationController navigationController = Get.find();
  final MenuController menuController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        verticalSpace25,
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            menuController.activeItem.value,
            style: title29BoldNeutral80,
          ),
        ),
        verticalSpace50,
        Wrap(
          runSpacing: 10,
          children: <Widget>[
            SizedBox(
              width: 400,
              child: CustomTextFormField(
                controller: hController.searchKeyword,
                labelText: 'Search here...',
                validator: Validator().notEmpty,
                onChanged: (value) {
                  return;
                },
                onSaved: (value) => hController.searchKeyword.text = value!,
              ),
            ),
            horizontalSpace18,
            SizedBox(
              width: 150,
              child: CustomDropdown(
                hintText: 'All',
                dropdownItems: pswdfilterDropdown,
                onChanged: (Item? item) {
                  hController.last30DaysDropDown.value = item!.name;
                },
                onSaved: (Item? item) =>
                    hController.last30DaysDropDown.value = item!.name,
              ),
            ),
            horizontalSpace18,
            SizedBox(
                height: 50,
                child: ElevatedButton(
                  child: Text('Search'),
                  style: ElevatedButton.styleFrom(
                    primary: verySoftBlueColor,
                  ),
                  onPressed: () {
                    hController.filter(
                        name: hController.searchKeyword.text,
                        last30days:
                            hController.last30DaysDropDown.value == 'All' ||
                                    hController.last30DaysDropDown.value == ''
                                ? false
                                : true);
                  },
                )),
            horizontalSpace18,
            SizedBox(
                height: 50,
                child: ElevatedButton(
                  child: Text('Remove Filter'),
                  style: ElevatedButton.styleFrom(
                    primary: verySoftBlueColor,
                  ),
                  onPressed: () {
                    hController.searchKeyword.clear();
                    hController.last30DaysDropDown.value = 'All';
                    hController.maHistoryList
                        .assignAll(hController.filteredListforPSWD);
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
                    primary: verySoftBlueColor,
                  ),
                  onPressed: () {
                    hController.refreshPSWD();
                  },
                )),
            horizontalSpace18,
            Container(
              child: IconButton(
                icon: Icon(Icons.calendar_today),
                iconSize: 48,
                onPressed: () {
                  hController.showDialogPSWD(context);
                },
              ),
            )
          ],
        ),
        verticalSpace25,
        header(),
        Flexible(child: Obx(() => requestList(context)))
      ],
    );
  }

  Widget requestList(BuildContext context) {
    if (hController.isLoading.value) {
      return Center(
        child: const SizedBox(
            height: 24, width: 24, child: CircularProgressIndicator()),
      );
    }
    if (hController.maHistoryList.isEmpty && hController.isLoading.value) {
      return Center(
        child: const Text(
          'No Record of MA History',
          style: body14Medium,
        ),
      );
    }
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: hController.maHistoryList.length,
          itemBuilder: (context, index) {
            return customTableRow(hController.maHistoryList[index]);
          }),
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
                child: Text('DATE CLAIMED',
                    style: body16Bold.copyWith(color: Colors.white)),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text('TYPE',
                    style: body16Bold.copyWith(color: Colors.white)),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text('MEDICINE WORTH',
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

  Widget customTableRow(MAHistoryModel model) {
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
                  hController.convertTimeStamp(model.dateClaimed!),
                  style: body16Medium,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  '${model.type}',
                  style: body16Medium,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'Php ${model.medWorth}',
                  style: body16Medium,
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  navigationController.navigateToWithArgs(
                      Routes.MA_HISTORY_ITEM,
                      arguments: model);
                },
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
