import 'package:flutter/material.dart';

//Note(R): nganong gilahi ni nga naa namay form input field with icon?
//walay border radius to nga field.
//pero pwede to siya gamiton mag gamit lang og bool hasBorder property
class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {required this.controller,
      required this.labelText,
      required this.validator,
      this.keyboardType = TextInputType.text,
      this.textInputAction = TextInputAction.next,
      this.minLines = 1,
      this.maxLines,
      required this.onChanged,
      required this.onSaved});

  final TextEditingController controller;
  final String? labelText;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final int minLines;
  final int? maxLines;
  final void Function(String) onChanged;
  final void Function(String?)? onSaved;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
      ),
      textInputAction: textInputAction,
      controller: controller,
      onSaved: onSaved,
      onChanged: onChanged,
      keyboardType: keyboardType,
      maxLines: maxLines,
      minLines: minLines,
      validator: validator,
    );
  }
}
