import 'package:davnor_medicare/ui/shared/styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ActionCard extends StatelessWidget {
  const ActionCard({
    Key? key,
    required this.text,
    required this.color,
    required this.secondaryColor,
    required this.onTap,
  }) : super(key: key);

  final String text;
  final Color? color;
  final Color? secondaryColor;
  final Function()? onTap;

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
          height: kIsWeb ? 123 : 107,
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
                child: Text(
                  text,
                  style: kIsWeb ? body14SemiBoldWhite : body14SemiBoldWhite,
                ),
              ),
              Align(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  height: kIsWeb ? 29 : 25,
                  //wala ko kabalo asa na value ang basehan ani sa figma
                  width: kIsWeb ? 440 : 99,
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
