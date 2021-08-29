import 'package:flutter/material.dart';

class Item {
  const Item(this.name);
  final String name;
}
class CustomDropdown extends StatefulWidget {
  State createState() =>  CustomDropdownState();
}
class CustomDropdownState extends State<CustomDropdown> {
  Item? selectedUser;
  List<Item> users = <Item>[
    const Item('Female'),
    const Item('Male'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:  Center(
          child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5 ),
          decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
           borderRadius: BorderRadius.all(
              Radius.circular(10)),
              ),
          child:  DropdownButton<Item>(
             underline:Container(),
            isExpanded: true,
            hint:  Text('Select Gender'),
            value: selectedUser,
            onChanged: ( Value) {
              setState(() {
                selectedUser = Value;
              });
            },
            items: users.map((Item user) {
              return  DropdownMenuItem<Item>(
                value: user,
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 1,),
                    Text(
                      user.name,
                      style:  TextStyle(color: Colors.black),
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