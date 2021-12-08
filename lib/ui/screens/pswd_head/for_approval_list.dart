import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:davnor_medicare/constants/app_items.dart';
import 'package:davnor_medicare/constants/app_strings.dart';
import 'package:davnor_medicare/constants/firebase.dart';
import 'package:davnor_medicare/core/controllers/app_controller.dart';
import 'package:davnor_medicare/core/controllers/pswd/for_approval_controller.dart';
import 'package:davnor_medicare/core/controllers/pswd/menu_controller.dart';
import 'package:davnor_medicare/core/models/med_assistance_model.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:davnor_medicare/routes/app_pages.dart';
import 'package:davnor_medicare/ui/screens/pswd_head/helpers/local_navigator.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/widgets/patient/custom_dropdown.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForApprovalListScreen extends GetView<ForApprovalController> {
  final ForApprovalController faController = Get.find();
  final RxBool firedOnce = false.obs;
  final AppController appController = Get.find();

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
                onChanged: (Item? item) => faController.type.value = item!.name,
                onSaved: (Item? item) => faController.type.value = item!.name,
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
                    faController.filter(
                      type: faController.type.value,
                    );
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
                    faController.type.value = 'All';
                    faController.filteredList
                        .assignAll(faController.forApprovalList);
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
                    faController.refresh();
                  },
                )),
          ],
        ),
        verticalSpace25,
        header(),
        Flexible(child: Obx(() => requestList(context)))
      ],
    );
  }

  Widget requestList(BuildContext context) {
    if (faController.isLoading.value) {
      return Center(
        child: const SizedBox(
            height: 24, width: 24, child: CircularProgressIndicator()),
      );
    }
    if (faController.forApprovalList.isEmpty && !faController.isLoading.value) {
      return Center(
        child: const Text(
          'No for approval request at the moment',
          style: body14Medium,
        ),
      );
    }
    firedOnce.value
        ? null
        : faController.filteredList.assignAll(faController.forApprovalList);
    firedOnce.value = true;
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Expanded(
        child: SingleChildScrollView(
          child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: faController.filteredList.length,
              itemBuilder: (context, index) {
                return customTableRow(faController.filteredList[index]);
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
              child: Text('ACTION',
                  style: body16Bold.copyWith(color: Colors.white)),
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
                      confirmationDialog(model.maID!, model.requesterID!);
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

  void confirmationDialog(String maID, String uid) {
    return showConfirmationDialog(
      dialogTitle: 'Are you sure?',
      dialogCaption:
          'Select YES if you want to approve this MA Request. Otherwise, select NO',
      onYesTap: () async {
        await firestore
            .collection('on_progress_ma')
            .doc(maID)
            .update({'isApproved': true, 'isTransferred': false}).then((value) {
          sendNotification(uid);
          faController.refresh();
          dismissDialog();
        });
      },
      onNoTap: () {
        dismissDialog();
      },
    );
  }

  Future<void> sendNotification(String uid) async {
    final action = ' has approved your ';
    final title = 'The pswd head${action}Medical Assistance(MA) Request';
    final message =
        'We are now processing your MA request and will notify you when you can claim the assistance. Thank you';

    await firestore
        .collection('patients')
        .doc(uid)
        .collection('notifications')
        .add({
      'photo': maLogoURL,
      'from': 'The pswd personnel',
      'action': action,
      'subject': 'MA Request',
      'message': message,
      'createdAt': FieldValue.serverTimestamp(),
    });

    await appController.sendNotificationViaFCM(title, message, uid);

    await firestore
        .collection('patients')
        .doc(uid)
        .collection('status')
        .doc('value')
        .update({
      'notifBadge': FieldValue.increment(1),
    });
  }
}
