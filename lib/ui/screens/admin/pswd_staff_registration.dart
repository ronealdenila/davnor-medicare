import 'package:davnor_medicare/constants/app_strings.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/shared/ui_helpers.dart';
import 'package:davnor_medicare/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class PSWDStaffRegistrationScreen extends StatelessWidget {
  const PSWDStaffRegistrationScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        backgroundColor: Colors.white,
        body:  Container(
          width: 1400,  
          height: 550,  
          padding: const EdgeInsets.symmetric(horizontal: 200),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const <Widget>[
                          Text('PSWD Staff Registration Form ',
                          textAlign: TextAlign.left,
                          style: title24Bold),
                          verticalSpace35,
                            Text(pswdStuffRegister,
                            textAlign: TextAlign.left,
                            style: body16SemiBold),
                         ]
                      )
                  ]),
              verticalSpace10,
                Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                horizontalSpace20,
                SizedBox(
                  width: screenWidthPercentage(context, percentage: .3),
                  child: const Text(
                    'Last Name',
                    style: body14Regular,
                    ),
                  ),
                horizontalSpace20,
                SizedBox(
                    width: screenWidthPercentage(context, percentage: .3),
                    child: const Text(
                      'Position',
                      style: body14Regular,
                      ),
                    ),
                  ],
                ), 
              verticalSpace10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                horizontalSpace20,
                  SizedBox(
                    width: screenWidthPercentage(context, percentage: .3),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      ),
                horizontalSpace20,
                  SizedBox(
                    width: screenWidthPercentage(context, percentage: .3),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      ),
                    ],
                  ),
              verticalSpace10,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    horizontalSpace35,
                    SizedBox(
                      width: screenWidthPercentage(context, percentage: .3),
                      child: const Text(
                        'First Name',
                        style: body14Regular,
                        ),
                      ),
                    horizontalSpace15,
                    ],
                  ),
              verticalSpace10,  
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    horizontalSpace35,
                    SizedBox(
                      width: screenWidthPercentage(context, percentage: .3),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                    horizontalSpace10,
                    ],
                  ),
              verticalSpace10, 
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    horizontalSpace35,
                    SizedBox(
                      width: screenWidthPercentage(context, percentage: .3),
                      child: const Text(
                        'Email Address',
                        style: body14Regular,
                        ),
                      ),
                    horizontalSpace15,
                    ],
                  ),
              verticalSpace10,  
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    horizontalSpace35,
                    SizedBox(
                      width: screenWidthPercentage(context, percentage: .3),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                    horizontalSpace10,
                    ],
                  ),
              verticalSpace35, 
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Align(
                      alignment: FractionalOffset.bottomRight,
                      child: CustomButton(
                        onTap: () async {
                          },
                          text: 'ADD',
                          buttonColor: Colors.blue[900],
                          fontSize: 20,
                          ),
                        ),
                   horizontalSpace40,
                    Align(
                      alignment: FractionalOffset.bottomRight,
                      child: CustomButton(
                        onTap: () async {
                          },
                          text: 'Cancel',
                          buttonColor: Colors.blue[900],
                          fontSize: 20,
                        ),
                      ),
                    ],
              ), 
          ]
        ),
      ),
    );
  }
}