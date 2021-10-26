import 'package:davnor_medicare/constants/app_items.dart';
import 'package:davnor_medicare/core/controllers/pswd/ma_req_list_controller.dart';
import 'package:davnor_medicare/core/controllers/pswd/menu_controller.dart';
import 'package:davnor_medicare/core/models/med_assistance_model.dart';
import 'package:davnor_medicare/helpers/validator.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/widgets/patient/custom_dropdown.dart';
import 'package:davnor_medicare/ui/widgets/patient/custom_text_form_field.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MARequestListScreen extends StatelessWidget {
  static MAReqListController maController = Get.put(MAReqListController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        verticalSpace20,
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            MenuController.to.activeItem.value,
            style: title32Regular,
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
              width: 250,
              child: CustomDropdown(
                hintText: 'Filter patient type',
                dropdownItems: type,
                onChanged: (Item? item) => maController.type.value = item!.name,
                onSaved: (Item? item) => maController.type.value = item!.name,
              ),
            ),
            //IconButton(onPressed: (){}, icon: Ico)
          ],
        ),
        verticalSpace25,
        header(),
        requestList(context)
      ],
    );
  }

  Widget requestList(BuildContext context) {
    return StreamBuilder(
        stream: maController.getCollection(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (maController.maRequests.isNotEmpty) {
              return MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: Expanded(
                  child: SingleChildScrollView(
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: maController.maRequests.length,
                        itemBuilder: (context, index) {
                          return customTableRow(maController.maRequests[index]);
                        }),
                  ),
                ),
              );
            } else {
              return const Center(
                  child: Padding(
                padding: EdgeInsets.all(20),
                child: Text('No MA request at the moment'),
              ));
            }
          }
          return const Center(
              child: SizedBox(
                  width: 24, height: 24, child: CircularProgressIndicator()));
        });
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
                  '${model.date_rqstd}',
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
                onTap: () {},
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
