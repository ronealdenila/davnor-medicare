import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:flutter/material.dart';

class ActionCard extends StatelessWidget {
  const ActionCard({
    Key? key,
    required this.text,
    required this.color,
    required this.secondaryColor,
    required this.onTap,
    //required this.width,
    this.height = 107,
    this.secondaryWidth = 99,
    this.secondaryHeight = 25,
    this.textStyle = body14SemiBoldWhite,
  }) : super(key: key);

  final String text;
  final Color? color;
  final Color? secondaryColor;
  final Function()? onTap;
  //final double width;
  final double? height;
  final double? secondaryWidth;
  final double? secondaryHeight;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          height: height,
          //width: width,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                child: Text(text, style: textStyle),
              ),
              Align(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  height: secondaryHeight,
                  width: secondaryWidth,
                  decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(100),
                        topRight: Radius.circular(100),
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
