import 'package:davnor_medicare/constants/app_items.dart';
import 'package:davnor_medicare/core/controllers/auth_controller.dart';
import 'package:davnor_medicare/core/controllers/pswd/menu_controller.dart';
import 'package:davnor_medicare/core/controllers/pswd/on_progress_req_controller.dart';
import 'package:davnor_medicare/core/models/med_assistance_model.dart';
import 'package:davnor_medicare/routes/app_pages.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/widgets/patient/custom_dropdown.dart';
import 'package:davnor_medicare/ui/widgets/pswd/pswd_custom_button.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:davnor_medicare/ui/screens/pswd_p/helpers/local_navigator.dart';

class OnProgressReqListScreen extends GetView<OnProgressReqController> {
  final OnProgressReqController opController =
      Get.put(OnProgressReqController());
  final AuthController authController = Get.find();
  final RxBool firedOnce = false.obs;

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
                    opController.type.value = 'All';
                    opController.filteredList
                        .assignAll(opController.onProgressList);
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
    } else if (opController.onProgressList.isEmpty &&
        !opController.isLoading.value) {
      return Align(
        alignment: Alignment.center,
        child: const Text(
          'No on progress MA request at the moment',
          style: body14Medium,
        ),
      );
    }
    firedOnce.value
        ? null
        : opController.filteredList.assignAll(opController.onProgressList);
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
                return customTableRow(
                    opController.filteredList[index], context);
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

  Widget customTableRow(OnProgressMAModel model, BuildContext context) {
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
                          Routes.ON_PROGRESS_REQ_ITEM,
                          arguments: model);
                    },
                    child: Text(
                      'View',
                      style: body16RegularUnderlineBlue,
                    ),
                  ),
                  horizontalSpace15,
                  Visibility(
                    visible: authController.userRole == 'pswd-p',
                    child: InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => detailsDialogMA(model));
                      },
                      child: Text(
                        'Medicine Ready',
                        style: body16RegularUnderlineBlue,
                      ),
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

  Widget detailsDialogMA(OnProgressMAModel model) {
    final _pharmacyController = TextEditingController();
    final _worthController = TextEditingController();
    return SimpleDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
        children: [
          SizedBox(
              width: 590,
              child: Column(
                children: [
                  const Text(
                    'To Complete the Details for the Medical Assistance',
                    textAlign: TextAlign.center,
                    style: title32Regular,
                  ),
                  verticalSpace50,
                  SizedBox(
                    width: 360,
                    height: 60,
                    child: TextFormField(
                      controller: _pharmacyController,
                      decoration: const InputDecoration(
                        labelText: 'Name of Pharmacy',
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                      ),
                      maxLines: 10,
                      keyboardType: TextInputType.multiline,
                    ),
                  ),
                  verticalSpace25,
                  SizedBox(
                    width: 360,
                    height: 60,
                    child: TextFormField(
                      controller: _worthController,
                      decoration: const InputDecoration(
                        labelText: 'Worth of Medicine',
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                      ),
                      maxLines: 10,
                      keyboardType: TextInputType.multiline,
                    ),
                  ),
                  verticalSpace25,
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: PSWDButton(
                          onItemTap: () async {
                            await opController.toBeReleased(
                                model.maID!, model.requesterID!);
                          },
                          buttonText: 'Submit')),
                ],
              ))
        ]);
  }
}
