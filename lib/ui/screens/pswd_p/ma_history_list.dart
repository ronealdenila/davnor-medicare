import 'package:davnor_medicare/core/controllers/ma_history_controller.dart';
import 'package:davnor_medicare/core/controllers/pswd/menu_controller.dart';
import 'package:davnor_medicare/core/models/med_assistance_model.dart';
import 'package:davnor_medicare/helpers/validator.dart';
import 'package:davnor_medicare/ui/screens/pswd_p/ma_history_item.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/widgets/patient/custom_text_form_field.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final MAHistoryController hController = Get.put(MAHistoryController());

class MAHistoryList extends StatelessWidget {
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
                controller: hController.maFilter,
                labelText: 'Search here...',
                validator: Validator().notEmpty,
                onChanged: (value) {
                  return;
                },
                onSaved: (value) => hController.maFilter.text = value!,
              ),
            ),
            horizontalSpace18,
            //IconButton(onPressed: (){}, icon: Ico)
          ],
        ),
        verticalSpace25,
        header(),
        requestList(context)
      ],
    );
  }
}

Widget requestList(BuildContext context) {
  return FutureBuilder(
      future: hController.getMAHistoryForPSWD(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          return const Center(
              child: SizedBox(
                  width: 24, height: 24, child: CircularProgressIndicator()));
        }
        if (snapshot.connectionState == ConnectionState.done) {
          if (hController.maList.isNotEmpty) {
            return MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: Expanded(
                child: SingleChildScrollView(
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: hController.maList.length,
                      itemBuilder: (context, index) {
                        return customTableRow(hController.maList[index]);
                      }),
                ),
              ),
            );
          } else {
            return const Center(
                child: Padding(
              padding: EdgeInsets.all(20),
              child: Text('No MA request for releasing at the moment'),
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
                hController.convertTimeStamp(model.dateRqstd!),
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
            child: InkWell(
              onTap: () {
                Get.to(
                  () => MAHistoryItemScreen(),
                  arguments: model,
                );
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
