import 'package:davnor_medicare/constants/app_strings.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/widgets/custom_button.dart';
import 'package:davnor_medicare/ui/widgets/patient/custom_dropdown.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
//import 'package:dropdown_below/dropdown_below.dart';

class MAFormScreen extends StatelessWidget {
  const MAFormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    width: 255,
                    child: Text(
                      ' Patients Information',
                      style: subtitle20Medium,
                    ),
                  ),
                  SizedBox(
                    width: 40,
                    child: SizedBox(
                      child: InkWell(
                        onTap: () {},
                        child: Icon(
                          Icons.info,
                          size: 30,
                          color: verySoftBlueColor[10],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              verticalSpace10,
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
              verticalSpace10,
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
              verticalSpace10,
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
              verticalSpace10,
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                SizedBox(
                  width: 145,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Age',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
                verticalSpace10,
              ]),
              verticalSpace10,
              const Text(
                maFormScreen,
                style: subtitle20Medium,
              ),
              verticalSpace10,
              DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(12),
                padding: const EdgeInsets.all(12),
                dashPattern: const [8, 8, 8, 8],
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  child: Container(
                    width: screenWidth(context),
                    height: 186,
                    color: neutralColor[10],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Icon(
                            Icons.file_upload_outlined,
                            size: 67,
                            color: neutralColor[60],
                          ),
                        ),
                        verticalSpace10,
                        Text(
                          'Upload here',
                          style: subtitle18RegularNeutral,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              verticalSpace20,
              SizedBox(
                width: 5,
                child: DropDown(),
              ),
              Align(
                alignment: FractionalOffset.bottomRight,
                child: SizedBox(
                  width: 160,
                  child: CustomButton(
                    onTap: () {},
                    text: 'Next',
                    buttonColor: verySoftBlueColor,
                  ),
                ),
              ),
              verticalSpace10,
            ],
          ),
        ),
      ),
    );
  }
}
