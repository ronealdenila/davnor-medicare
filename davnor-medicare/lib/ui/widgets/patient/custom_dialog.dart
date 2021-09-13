import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:davnor_medicare/ui/widgets/patient/dialog_button.dart';
import 'package:flutter/material.dart';
//import 'package:get/get.dart';

class CustomDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  Widget dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 284,
          width: 343,
          padding: const EdgeInsets.only(
            top: 18,
          ),
          margin: const EdgeInsets.only(top: 13, right: 8),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Colors.black26,
                ),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(30),
                child: Text(
                  'Is the Consultation for you?',
                  style: title24Bold,
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                  style: body16SemiBold.copyWith(color: neutralColor[60]),
                  textAlign: TextAlign.center,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  DialogButton(
                    buttonText: 'Yes',
                    onTap: () {},
                  ),
                  DialogButton(
                    buttonText: 'No',
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          right: 20,
          top: 20,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Align(
              alignment: Alignment.topRight,
              child: CircleAvatar(
                radius: 14,
                //TO BE REGISTERED ON APP COLOR
                backgroundColor: const Color(0xFFE3E6E8),
                child: Icon(Icons.close, color: neutralColor[100]),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
