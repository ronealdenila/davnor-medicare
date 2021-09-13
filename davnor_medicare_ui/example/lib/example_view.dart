import 'package:davnor_medicare_ui/davnor_medicare_ui.dart';
import 'package:flutter/material.dart';

class ExampleView extends StatelessWidget {
  const ExampleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 30,
        ),
        children: [
          DmText.title58Regular('Design System'),
          verticalSpace15,
          Divider(),
          verticalSpace15,
          ...textWidgets,
          ...buttonWidgets,
          ...inputFields,
        ],
      ),
    );
  }

  List<Widget> get textWidgets => [
        DmText.title90Bold('Title 90 Bold'),
        verticalSpace18,
        DmText.title58Regular('Title 58 Regular'),
        verticalSpace18,
        DmText.title32Bold('Title 32 Bold'),
        verticalSpace18,
        DmText.subtitle20Bold('Subtitle 20 Bold'),
        verticalSpace18,
        DmText.subtitle20Medium('Subtitle 20 Medium'),
        verticalSpace18,
        DmText.body16Bold('Body 16 Bold'),
        verticalSpace18,
        DmText.body16Regular('Body 16 Regular'),
        verticalSpace18,
        DmText.body14SemiBold('Body 14 Semi Bold'),
        verticalSpace18,
      ];

  List<Widget> get buttonWidgets => [
        DmText.body16Regular('Buttons'),
        verticalSpace18,
        DmText.body('Normal'),
        verticalSpace10,
        DmButton(
          title: 'SIGN IN',
        ),
        verticalSpace10,
        DmText.body('Disabled'),
        verticalSpace10,
        DmButton(
          title: 'SIGN IN',
          disabled: true,
        ),
        verticalSpace10,
        DmText.body('Busy'),
        verticalSpace10,
        DmButton(
          title: 'SIGN IN',
          busy: true,
        ),
        verticalSpace10,
        DmText.body('Outline'),
        verticalSpace10,
        DmButton.outline(
          title: 'Select location',
          leading: Icon(
            Icons.send,
            color: kcVerySoftBlueColor,
          ),
        ),
        verticalSpace18,
      ];

  List<Widget> get inputFields => [
        DmText.body16Regular('Input Field'),
        verticalSpace10,
        DmText.body('Normal'),
        verticalSpace10,
        DmInputField(
          controller: TextEditingController(),
          placeholder: 'Enter Password',
          isRequired: true,
        ),
        verticalSpace10,
        DmText.body('Leading Icon'),
        verticalSpace10,
        DmInputField(
          controller: TextEditingController(),
          leading: Icon(Icons.reset_tv),
          placeholder: 'Enter TV Code',
        ),
        verticalSpace10,
        DmText.body('Trailing Icon'),
        verticalSpace10,
        DmInputField(
          controller: TextEditingController(),
          trailing: Icon(Icons.clear_outlined),
          placeholder: 'Search for things',
        ),
      ];
}
