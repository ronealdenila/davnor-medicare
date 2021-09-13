import 'package:davnor_medicare/constants/app_items.dart';
import 'package:davnor_medicare/ui/shared/app_colors.dart';
import 'package:flutter/material.dart';

class CustomDropdown2 extends StatefulWidget {
  const CustomDropdown2({
    required this.hintText,
    required this.dropdownItems,
  });
  final String? hintText;
  final List<Item>? dropdownItems;

  @override
  State createState() => CustomDropdownState2();
}

class CustomDropdownState2 extends State<CustomDropdown2> {
  Item? selectedItem;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: DropdownButton<Item>(
            underline: Container(),
            isExpanded: true,
            hint: Text(widget.hintText!),
            value: selectedItem,
            onChanged: (value) {
              setState(() {
                selectedItem = value;
              });
            },
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
                      style: TextStyle(color: neutralColor[60]),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
