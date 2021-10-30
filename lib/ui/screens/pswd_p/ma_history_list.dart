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
// import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class MAHistoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MAHistoryController hController = Get.put(MAHistoryController());
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
                  if (hController.maFilter.text.isEmpty) {
                    hController.maListPSWD
                        .assignAll(hController.maListmasterPSWD);
                  }
                },
                onSaved: (value) => hController.maFilter.text = value!,
              ),
            ),
            horizontalSpace18,
            Obx(
              () => Checkbox(
                value: hController.enabledPastDays.value,
                checkColor: Colors.blue,
                onChanged: (value) {
                  if (hController.enabledPastDays.value == true) {
                    hController.enabledPastDays.value = false;
                  } else {
                    hController.enabledPastDays.value = true;
                  }
                  hController.filterPastDays();
                  print(hController.enabledPastDays.value);
                },
              ),
            ),
            horizontalSpace18,
            Container(
              child: Text("Enable 30 days past"),
            ),
            horizontalSpace18,
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.10,
                width: 350,
                child: ElevatedButton(
                  child: Text('Search'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue[900],
                  ),
                  onPressed: () {
                    // print(hController.maList[0].dateClaimed?.seconds);
                    hController.filter(name: hController.maFilter.text);
                    // var date = new DateTime.fromMillisecondsSinceEpoch();
                    // hController.readTimestamp(
                    //     hController.maList[0].dateClaimed?.seconds);
                    // hController.ago(t: hController.maList[0].dateClaimed?.seconds);
                  },
                )),
            horizontalSpace18,
            Container(
              child: IconButton(
                icon: Icon(Icons.calendar_today),
                iconSize: 48,
                onPressed: () {
                  hController.showDialog(context);
                },
              ),
            )

            //IconButton(onPressed: (){}, icon: Ico)
          ],
        ),
        verticalSpace25,
        header(),
        requestList(context, hController)
      ],
    );
  }
}

Widget requestList(BuildContext context, hController) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height * .40,
    child: Obx(
      () => ListView.builder(
        itemCount: hController.maListPSWD.length,
        itemBuilder: (BuildContext context, int index) {
          return MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: Expanded(
              child: SingleChildScrollView(
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: hController.maListPSWD.length,
                    itemBuilder: (context, index) {
                      return customTableRow(
                          hController.maListPSWD[index], hController);
                    }),
              ),
            ),
          );
        },
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

Widget customTableRow(MAHistoryModel model, hController) {
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
