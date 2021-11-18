import 'package:davnor_medicare/constants/app_items.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/pswd/for_approval_controller.dart';
import 'package:davnor_medicare/core/controllers/pswd/menu_controller.dart';
import 'package:davnor_medicare/core/models/med_assistance_model.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:davnor_medicare/routes/app_pages.dart';
import 'package:davnor_medicare/ui/screens/pswd_head/for_approval_item.dart';
import 'package:davnor_medicare/ui/screens/pswd_head/helpers/local_navigator.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/widgets/patient/custom_dropdown.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final ForApprovalController opController = Get.put(ForApprovalController());
final RxBool firedOnce = false.obs;

class ForApprovalListScreen extends GetView<ForApprovalController> {
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
          children: [
            SizedBox(
              width: 280,
              child: CustomDropdown(
                hintText: 'Filter patient type',
                dropdownItems: typeDropdown,
                onChanged: (Item? item) => opController.type.value = item!.name,
                onSaved: (Item? item) => opController.type.value = item!.name,
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
                    opController.filter(
                      type: opController.type.value,
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
                    opController.filteredList
                        .assignAll(opController.forApprovalList);
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
                    opController.refresh();
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
}

Widget requestList(BuildContext context) {
  if (opController.isLoading.value) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: const SizedBox(
            height: 24, width: 24, child: CircularProgressIndicator()),
      ),
    );
  }
  if (opController.forApprovalList.isEmpty && !opController.isLoading.value) {
    return const Text(
      'No MA request for approval at the moment',
      textAlign: TextAlign.center,
      style: body14Medium,
    );
  }
  firedOnce.value
      ? null
      : opController.filteredList.assignAll(opController.forApprovalList);
  firedOnce.value = true;
  return MediaQuery.removePadding(
    context: context,
    removeTop: true,
    child: Expanded(
      child: SingleChildScrollView(
        child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: opController.filteredList.length,
            itemBuilder: (context, index) {
              return customTableRow(opController.filteredList[index]);
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
              child: Text('PATIENT TYPE',
                  style: body16Bold.copyWith(color: Colors.white)),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text('RECEIVED BY',
                  style: body16Bold.copyWith(color: Colors.white)),
            ),
          ),
          Expanded(
            child:
                Text('ACTION', style: body16Bold.copyWith(color: Colors.white)),
          )
        ]),
  );
}

Widget customTableRow(OnProgressMAModel model) {
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
                model.type!,
                style: body16Medium,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                model.receivedBy!,
                style: body16Medium,
              ),
            ),
          ),
          Expanded(
            child: Wrap(
              runSpacing: 8,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    navigationController.navigateToWithArgs(
                        Routes.FOR_APPROVAL_ITEM,
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
                    confirmationDialog(model.maID!);
                  },
                  child: Text(
                    'Approve',
                    style: body16RegularUnderlineBlue,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

void confirmationDialog(String maID) {
  return showConfirmationDialog(
    dialogTitle: 'Are you sure?',
    dialogCaption:
        'Select YES if you want to approve this MA Request. Otherwise, select NO',
    onYesTap: () async {
      await firestore
          .collection('on_progress_ma')
          .doc(maID)
          .update({'isApproved': true, 'isTransferred': false}).then((value) {
        opController.refresh();
      });
    },
    onNoTap: () {
      dismissDialog();
    },
  );
}
