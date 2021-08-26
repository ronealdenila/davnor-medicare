import 'package:flutter/material.dart';

class ActionCard extends StatelessWidget {
  const ActionCard({
    Key? key,
    required this.text,
    required this.textStyle,
    required this.width,
    required this.height,
    required this.color,
    required this.secondaryColor,
    required this.secondaryWidth,
    required this.secondaryHeight,
    required this.onTap,
  }) : super(key: key);

  final String text;
  final TextStyle textStyle;
  final double width;
  final double height;
  final Color? color;
  final Color? secondaryColor;
  final double secondaryWidth;
  final double secondaryHeight;
  final Function() onTap;

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
          width: width,
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
