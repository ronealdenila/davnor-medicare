import 'package:davnor_medicare/constants/asset_paths.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:davnor_medicare/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditDoctorScreen extends StatefulWidget {

  @override
  _EditDoctorScreenState createState() => _EditDoctorScreenState();
}

class _EditDoctorScreenState extends State<EditDoctorScreen> {
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
class ResponsiveView extends GetResponsiveView{
  ResponsiveView() : super (alwaysUseBuilder: false);

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
                  horizontalSpace25,
                  editInfoofDoctor(),
                  
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
                  userImage(),
                  horizontalSpace25,
                  editInfoofDoctor(),
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
                  userImage(),
                  horizontalSpace25,
                  editInfoofDoctor(),
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

  Widget userImage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(
                authHeader,
              ),
              radius: 40,
            ),
      ])
      ]);
  }

   Widget editInfoofDoctor() {
    //bool _isEditable = false;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
            suffixIcon:
              IconButton(
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
            suffixIcon:
              IconButton(
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
          'Title',
          style: body14Medium,
        ),
        verticalSpace15,
        SizedBox(
        width: 340,
        height: 90,
        child: TextFormField(
          decoration: InputDecoration(
            suffixIcon:
              IconButton(
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
          'Department',
          style: body14Medium,
        ),
        verticalSpace10,
        SizedBox(
        width: 340,
        height: 90,
        child: TextFormField(
          decoration: InputDecoration(
            suffixIcon:
              IconButton(
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Edit Doctor Details',
        textAlign: TextAlign.left, style: title24Bold),
        
        horizontalSpace200,
        IconButton(
          onPressed: () {}, 
          icon: const Icon(Icons.remove_circle_outline_outlined,
        
          )
       )
       ] );
  }
}