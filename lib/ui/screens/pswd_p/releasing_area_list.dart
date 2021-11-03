import 'package:davnor_medicare/core/controllers/pswd/menu_controller.dart';
import 'package:davnor_medicare/core/controllers/pswd/releasing_ma_controller.dart';
import 'package:davnor_medicare/core/models/med_assistance_model.dart';
import 'package:davnor_medicare/helpers/validator.dart';
import 'package:davnor_medicare/ui/screens/pswd_p/releasing_area_item.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/widgets/patient/custom_text_form_field.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final ReleasingMAController rlsController = Get.put(ReleasingMAController());

class ReleasingAreaListScreen extends StatelessWidget {
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
                controller: rlsController.rlsFilter,
                labelText: 'Search here...',
                validator: Validator().notEmpty,
                onChanged: (value) {
                  return;
                },
                onSaved: (value) => rlsController.rlsFilter.text = value!,
              ),
            ),
            horizontalSpace18,
            //IconButton(onPressed: (){}, icon: Ico)
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
  if (rlsController.isLoading.value) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: const SizedBox(
            height: 24, width: 24, child: CircularProgressIndicator()),
      ),
    );
  }
  if (rlsController.toRelease.isEmpty && !rlsController.isLoading.value) {
    return const Text(
      'No MA request for releasing at the moment',
      textAlign: TextAlign.center,
      style: body14Medium,
    );
  }
  return MediaQuery.removePadding(
    context: context,
    removeTop: true,
    child: Expanded(
      child: SingleChildScrollView(
        child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: rlsController.toRelease.length,
            itemBuilder: (context, index) {
              return customTableRow(rlsController.toRelease[index]);
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
              child:
                  Text('DATE', style: body16Bold.copyWith(color: Colors.white)),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text('PHARMACY',
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
                rlsController.convertTimeStamp(model.dateRqstd!),
                style: body16Medium,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                '${model.pharmacy}',
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
            child: Wrap(
              runSpacing: 8,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Get.to(
                      () => ReleasingAreaItemScreen(),
                      arguments: model,
                    );
                  },
                  child: Text(
                    'View',
                    style: body16RegularUnderlineBlue,
                  ),
                ),
                horizontalSpace15,
                InkWell(
                  onTap: () {
                    //open dialog
                  },
                  child: Text(
                    'Claimed',
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
