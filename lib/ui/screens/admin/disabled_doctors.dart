import 'package:davnor_medicare/core/controllers/admin/disabled_doctors_controller.dart';
import 'package:davnor_medicare/core/models/user_model.dart';
import 'package:davnor_medicare/helpers/dialogs.dart';
import 'package:davnor_medicare/helpers/validator.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/widgets/patient/custom_text_form_field.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DisabledDoctorListScreen extends StatelessWidget {
  static DisabledDoctorsController dListController =
      Get.put(DisabledDoctorsController());

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
            Text('Disabled Doctors',
                textAlign: TextAlign.left, style: title24BoldNeutral80),
            verticalSpace50,
            Wrap(
              runSpacing: 10,
              children: <Widget>[
                SizedBox(
                  width: 450,
                  child: CustomTextFormField(
                    controller: dListController.filterKey,
                    labelText: 'Search doctor name here...',
                    validator: Validator().notEmpty,
                    onChanged: (value) {
                      return;
                    },
                    onSaved: (value) => dListController.filterKey.text = value!,
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
                          name: dListController.filterKey.text,
                        );
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
                        dListController.filterKey.clear();
                        dListController.disabledList
                            .assignAll(dListController.filteredDisabledList);
                      },
                    )),
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
    if (dListController.disabledList.isEmpty &&
        !dListController.isLoading.value) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: const Text(
            'No disabled doctor',
          ),
        ),
      );
    }
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: dListController.disabledList.length,
          itemBuilder: (context, index) {
            return customTableRow(dListController.disabledList[index], context);
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
                child:
                    Text('ID', style: body16Bold.copyWith(color: Colors.white)),
              ),
            ),
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
              child: Text('ACTION',
                  style: body16Bold.copyWith(color: Colors.white)),
            )
          ]),
    );
  }

  Widget customTableRow(DoctorModel model, BuildContext context) {
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
                  model.userID!,
                  style: body16Medium,
                ),
              ),
            ),
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Wrap(
                  runSpacing: 8,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => confirmProcess(model));
                      },
                      child: Text(
                        'Remove',
                        style: body16RegularUnderlineBlue,
                      ),
                    ),
                    horizontalSpace15,
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

Widget confirmProcess(DoctorModel model) {
  return SimpleDialog(
      contentPadding: EdgeInsets.symmetric(
        vertical: 30,
        horizontal: 50,
      ),
      children: [
        SizedBox(
            width: Get.width * .7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'REMINDER: Follow our proper process',
                  textAlign: TextAlign.center,
                  style: title32Regular,
                ),
                verticalSpace15,
                Text(
                  'Make sure the following data is already deleted in the authentication database:\nID - ${model.userID}\nEmail - ${model.email}',
                  textAlign: TextAlign.center,
                  style: title32Regular,
                ),
                verticalSpace25,
                Align(
                    alignment: Alignment.bottomCenter,
                    child: TextButton(
                        onPressed: () async {
                          //DELETION sa users collection ug doctors collection
                        },
                        child: Text('Got it!'))),
                verticalSpace15,
                Text(
                  'By clicking this button, you are indicating that you have followed the process',
                  textAlign: TextAlign.center,
                  style: title32Regular,
                ),
              ],
            ))
      ]);
}
