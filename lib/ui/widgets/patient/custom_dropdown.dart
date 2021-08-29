import 'package:flutter/material.dart';

class DropDown extends StatefulWidget {
  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  bool isStrechedDropDown = false;
  late int groupValue;
  String title = 'Select Animals';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: double.infinity,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 2),
      child: SafeArea(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xffbbbbbb)),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: Column(
                    children: [
                      Container(
                          // height: 45,
                          width: double.infinity,
                          padding: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xffbbbbbb),
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          constraints: const BoxConstraints(
                            minHeight: 5,
                            minWidth: double.infinity,
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 2, vertical: 5),
                                  child: Text(
                                    title,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isStrechedDropDown = !isStrechedDropDown;
                                    });
                                  },
                                  child: Icon(isStrechedDropDown
                                      ? Icons.arrow_upward
                                      : Icons.arrow_downward))
                            ],
                          )),
                    ],
                  ),
                )),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
