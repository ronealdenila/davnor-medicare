import 'package:davnor_medicare/constants/app_items.dart';
import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  const CustomDropdown({
    required this.hintText,
    required this.dropdownItems,
    required this.onChanged,
    required this.onSaved,
  });
  final String? hintText;
  final List<Item>? dropdownItems;
  final void Function(Item?)? onChanged;
  final void Function(Item?)? onSaved;

  @override
  State createState() => CustomDropdownState();
}

class CustomDropdownState extends State<CustomDropdown> {
  Item? selectedItem;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: DropdownButtonFormField<Item>(
          decoration: const InputDecoration(enabledBorder: InputBorder.none),
          isExpanded: true,
          value: selectedItem,
          hint: Text(widget.hintText!),
          onChanged: widget.onChanged,
          onSaved: widget.onSaved,
          items: widget.dropdownItems!.map((user) {
            return DropdownMenuItem<Item>(
              value: user,
              child: Row(
                children: <Widget>[
                  const SizedBox(
                    width: 1,
                  ),
                  Text(
                    user.name,
                    style: const TextStyle(color: Colors.black),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class CustomDropdown2 extends StatefulWidget {
  const CustomDropdown2({
    required this.hintText,
    required this.dropdownItems,
  });
  final String? hintText;
  final List<Item>? dropdownItems;

  @override
  State createState() => CustomDropdownState();
}
