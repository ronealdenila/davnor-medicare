import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/widgets/custom_button.dart';
import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class EditPSWDStaffScrenn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(child: ResponsiveView())),
    );
  }
}

class ResponsiveView extends GetResponsiveView {
  ResponsiveView() : super(alwaysUseBuilder: false);

  @override
  Widget phone() => Column(
        children: [
          SizedBox(
            height: Get.height,
            width: Get.width,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              textTitle(),
              Column(
                children: <Widget>[
                  horizontalSpace20,
                  editInfoofPSWDStaff(),
                ],
              ),
              verticalSpace25,
              screenButtons()
            ]),
          )
        ],
      );

  @override
  Widget tablet() => Column(
        children: [
          SizedBox(
            height: Get.height,
            width: Get.width,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              textTitle(),
              verticalSpace25,
              Column(
                children: <Widget>[
                  userPSWDImage(),
                  horizontalSpace25,
                  editInfoofPSWDStaff(),
                ],
              ),
              verticalSpace25,
              screenButtons(),
            ]),
          )
        ],
      );

  @override
  Widget desktop() => Column(
        children: [
          SizedBox(
            height: Get.height,
            width: screen.width,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              textTitle(),
              verticalSpace25,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  userPSWDImage(),
                  horizontalSpace25,
                  editInfoofPSWDStaff(),
                ],
              ),
              verticalSpace15,
              screenButtons(),
            ]),
          ),
        ],
      );

  Widget screenButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CustomButton(
          onTap: () async {},
          text: 'Save',
          buttonColor: Colors.blue[900],
          fontSize: 15,
        ),
        horizontalSpace40,
        CustomButton(
          onTap: () async {},
          text: 'Cancel',
          buttonColor: Colors.blue[900],
          fontSize: 15,
        ),
      ],
    );
  }

  Widget userPSWDImage() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        CircleAvatar(
          backgroundImage: AssetImage(
            authHeader,
          ),
          radius: 40,
        ),
      ])
    ]);
  }

  Widget editInfoofPSWDStaff() {
    //bool _isEditable = false;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      verticalSpace15,
      const Text(
        'Last Name',
        style: body14Medium,
      ),
      verticalSpace10,
      SizedBox(
        width: 340,
        height: 90,
        child: TextFormField(
          decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.edit),
              iconSize: 20,
            ),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
        ),
      ),
      const Text(
        'First Name',
        style: body14Medium,
      ),
      verticalSpace10,
      SizedBox(
        width: 340,
        height: 90,
        child: TextFormField(
          decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.edit),
              iconSize: 20,
            ),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
        ),
      ),
      const Text(
        'Position',
        style: body14Medium,
      ),
      verticalSpace10,
      SizedBox(
        width: 340,
        height: 90,
        child: TextFormField(
          decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.edit),
              iconSize: 20,
            ),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
        ),
      ),
    ]);
  }

  Widget textTitle() {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Edit PSWD Staff Details',
          textAlign: TextAlign.left, style: title24Bold),
      horizontalSpace80,
      IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.remove_circle_outline_outlined,
          ))
    ]);
  }
}
